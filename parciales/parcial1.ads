-- En la farmacia de un hospital hay una única ventanilla para dispensar medicamentos. 
--  Los pacientes internados deben retirar sus medicamentos presentando una receta (un 
--  único retiro por persona). Los pacientes son atendidos en el orden de llegada, pero 
--  con prioridad de atención: los pacientes de urgencia tienen prioridad sobre los de 
--  internación general, y ambos tienen prioridad sobre los pacientes ambulatorios. Cada 
--  paciente entrega su receta y recibe la medicación correspondiente. Notas: la función 
--  obtenerPrioridad() le permite al paciente conocer su prioridad (retorna 0 si el 
--  paciente es de urgencia, 1 si es internado general, o 2 si es ambulatorio). La función 
--  obtenerReceta() retorna la receta para el paciente que la invoca mientras que 
--  dispensarMedicamento(receta) le retorna al empleado el medicamento para la receta 
--  indicada. El empleado atiende de a un paciente por vez, según la prioridad indicada. 
--  Todas las tareas deben finalizar.

procedure farmacia is

TASK TYPE paciente;

TASK empleado IS 
   ENTRY atenderUrgencia(receta : IN text ; medicamento : OUT text);
   ENTRY atenderInternacion(receta : IN text ; medicamento : OUT text);
   ENTRY atenderAmbulatorio(receta : IN text ; medicamento : OUT text);
END empleado;

pacientes : array (1..P) of paciente;

TASK BODY paciente IS
   prioridad : int; 
   receta : text; 
   medicamento : text;
BEGIN 
   prioridad := obtenerPrioridad;
   receta := obtenerReceta;
   IF (prioridad = 0) THEN 
      empleado.atenderUrgencia(receta,medicamento);
   ELSE IF (prioridad = 1) THEN
      empleado.atenderInternacion(receta,medicamento);
   ELSE
      empleado.atenderAmbulatorio(receta,medicamento);
   END IF;
END paciente;

TASK BODY empleado IS
BEGIN
   for I in 1..P LOOP 
      SELECT 
         ACCEPT atenderUrgencia(receta : IN text; medicamento : OUT text) DO 
            medicamento := dispensarMedicamento(receta);
         END atenderUrgencia;
      OR    
         WHEN (atenderUrgencia'COUNT = 0) =>
            ACCEPT atenderInternacion(receta : IN text; medicamento : OUT text) DO 
               medicamento := dispensarMedicamento(receta);
            END atenderInternacion;
      OR 
         WHEN (atenderUrgencia'COUNT = 0) AND (atenderInternacion'COUNT = 0) =>
            ACCEPT atenderAmbulatorio(receta : IN text; medicamento : OUT text) DO
               medicamento := dispensarMedicamento(receta);
            END atenderAmbulatorio;
      END SELECT;
   END LOOP;
END empleado;
BEGIN 
   null;
END;