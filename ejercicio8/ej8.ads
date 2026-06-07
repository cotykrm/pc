-- Hay un sistema de reconocimiento de huellas dactilares de la policía que tiene 8 
--  Servidores para realizar el reconocimiento, cada uno de ellos trabajando con una 
--  Base de Datos propia; a su vez hay un Especialista que utiliza indefinidamente. 
--  El sistema funciona de la siguiente manera: el Especialista toma una imagen de 
--  una huella (TEST) y se la envía a los servidores para que cada uno de ellos le 
--  devuelva el código y el valor de similitud de la huella que más se asemeja a TEST 
--  en su BD; al final del procesamiento, el especialista debe conocer el código de la
--  huella con mayor valor de similitud entre las devueltas por los 8 servidores. 
--  Cuando ha terminado de procesar una huella comienza nuevamente todo el ciclo. 
--  Nota: suponga que existe una función Buscar(test, código, valor) que utiliza cada 
--  Servidor donde recibe como parámetro de entrada la huella test, y devuelve como 
--  parámetros de salida el código y el valor de similitud de la huella más parecida 
--  a test en la BD correspondiente. Maximizar la concurrencia y no generar demora 
--  innecesaria.

-- para maximizar la concurrencia tengo que hacer que los servidores le pidan un 
-- test al especializta, porque si no, el especialista tiene que esperar que se 
-- haga el ACCEPT de cada servidor al que se le envia la imagen para poder mandarsela
-- al siguiente servidor, ademas, como especialista tengo que, para maximizar la
-- concurrencia, poder recibir resultados, coo pedidos a la vez, entonces
-- los servidores deben solicitar, para poder elegir entre accepts

-- al final, los servidores no necesitan su id, proque todo pasa dentro del accept 
-- del pedido de imagen, usando la variable test : OUT

procedure sistema is

TASK servidor;

TASK especialista IS 
   ENTRY enviarImagen(test : OUT text);
   ENTRY resultado(codigo : IN Integer; valor : IN Float);
END especialista;

servidores : array (1..8) of servidor;

TASK BODY servidor IS 
   id : Integer; valor : Float; codigo : Integer; 
BEGIN 
   LOOP 
      especialista.enviarImagen(test);
      Buscar(test, codigo, valor);
      especialista.resultado (codigo, valor);
   END LOOP; 
END; 

TASK BODY especialista IS 
   test : text; codigoMax: Integer; max : Integer := -1;
BEGIN 
   LOOP 
      for I in 1 .. 16 LOOP
         SELECT 
            ACCEPT enviarImagen(test : OUT text) DO
               test := tomarImagen;
            END enviarImagen;
         OR      
            ACCEPT resultado (codigo : IN Integer; valor : IN Float) DO
               IF(valor > max)THEN 
                  max := valor;
                  codigoMax := codigo;
               END IF;
            END resultado;
         END SELECT;
      END LOOP;
   END LOOP;

END;

BEGIN
   null;
END sistema;