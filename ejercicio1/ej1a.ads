--Se requiere modelar un puente de un único sentido que soporta hasta 5 unidades de peso. 
--El peso de los vehículos depende del tipo: cada auto pesa 1 unidad, cada camioneta pesa 
--2 unidades y cada camión 3 unidades. Suponga que hay una cantidad innumerable de vehículos 
--(A autos, B camionetas y C camiones). Analice el problema y defina qué tareas, recursos y 
--sincronizaciones serán necesarios/convenientes para resolver el problema.
--a. Realice la solución suponiendo que no se tiene ningún orden ni prioridad entre los diferentes tipos de vehículos.
--b. Modifique la solución de (a) para que tengan mayor prioridad los camiones que el resto de los vehículos.

-- Hay tareas vehiculos, cada vehiculo sabe su peso, o hay un tipo de tarea por tipo de vehiculo
-- Cada vehiculo puede avisar cuando llega, con su peso, y el puente lo deja pasar si sumando los pesos,
-- no supera el max, una vez que el vehiuclo sale, se descuetna el peso. se permite entrar a otro 
-- vehiculo mientras no supere el peso max
-- Hay una tarea que maneja el acceso
-- El recurso es el puente
-- tengo que hacer un ENTRY por cada tipo de vehiculo para que acceda, porque debo saber saber su peso
-- de antemano, ya que si se lo mando como parámetro, solo lo voy a saber una vez hecho el ACCEPT y 
-- sería incorrecto

--B

procedure puente is
   TASK acceso IS 
      ENTRY accederAuto;
      ENTRY accederCamioneta;
      ENTRY accederCamion;
      ENTRY salirVehiculo(peso : IN Integer);
   END acceso;

   TASK TYPE auto;

   autos: array (0..A-1) of auto;

   TASK BODY auto IS
   BEGIN
      acceso.accederAuto;
      --cruzarPuente
      acceso.salirVehiculo(1);
   END auto;
    
   TASK TYPE camioneta;

   camionetas: array (0..B-1) of camioneta;

   TASK BODY camioneta IS
   BEGIN
      acceso.accederCamioneta;
      --cruzarPuente
      acceso.salirVehiculo(2);
   END camioneta;

   TASK TYPE camion;

   camiones: array (0..C-1) of camion;

   TASK BODY camion IS
   BEGIN
      acceso.accederCamion;
      --cruzarPuente
      acceso.salirVehiculo(3);
   END camion;

   TASK BODY acceso IS
      peso: Integer := 0; aux: Integer;
   BEGIN 
      LOOP 
         SELECT 
            WHEN (peso < 5)=>
               ACCEPT accederAuto do
                  peso := peso + 1;
               END accederAuto;
            OR 
               WHEN (peso < 4)=>
                  ACCEPT accederCamioneta do
                     peso := peso + 2;
                  END;
            OR  
               WHEN (peso < 3)=>
                  ACCEPT accederCamion do
                     peso := peso + 3;
                  END;
            OR 
               WHEN (peso > 0)=>
                  ACCEPT salirVehiculo (pesoS : IN Integer) do
                     peso := peso - pesoS;
                  END salirVehiculo;
         END SELECT;
      END LOOP;
   END acceso;
BEGIN 
    null;
END puente;