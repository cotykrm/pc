-- En una competencia de programadores hay P participantes y UN coordinador. 
--  El coordinador entrega el problema a resolver a los participantes y recibe 
--  las resoluciones para corregir. Cada participante debe conocer el resultado 
--  de su trabajo y el orden en que entregó su resolución. Nota: maximizar la 
--  concurrencia.

procedure competencia IS 

TASK TYPE participante;

TASK coordinador IS 
   ENTRY resolucion(resolucion : IN text; resultado : OUT Integer);
   ENTRY solicitarProblema(problema : OUT text);
END coordinador;

participantes : array (1..P) of participante;

TASK BODY coordinador IS 
   pro : text; -- ya asignado
BEGIN
   for I in 1..P*2 LOOP 
      SELECT 
         ACCEPT solicitarProblema(problema : OUT text) DO
            problema := prob;
         END;
      OR 
         ACCEPT resolucion (resolucion : IN text; resultado : OUT Float)DO 
            resultado := corregirResolucion(resolucion);
         END resolucion;
      END SELECT;
   END LOOP; 
END coordinador;

TASK BODY participante IS 
   resultado : Float;
   resolucion,problema : text;
BEGIN
   coordionador.solicitarProblema(problema);
   resolucion := resolverProblema(problema);
   coordinador.resolucion(resolucion, resultado);
END participante;

BEGIN 
   null;
END;