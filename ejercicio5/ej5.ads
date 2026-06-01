-- En una clínica existe un médico de guardia que recibe continuamente peticiones de atención de las 
--  E enfermeras que trabajan en su piso y de las P personas que llegan a la clínica ser atendidos.
--  Cuando una persona necesita que la atiendan espera a lo sumo 5 minutos a que el médico lo haga, 
--  si pasado ese tiempo no lo hace, espera 10 minutos y vuelve a requerir la atención del médico. 
--  Si no es atendida tres veces, se enoja y se retira de la clínica.
--  Cuando una enfermera requiere la atención del médico, si este no lo atiende inmediatamente le 
--  hace una nota y se la deja en el consultorio para que esta resuelva su pedido en el momento que 
--  pueda (el pedido puede ser que el médico le firme algún papel). Cuando la petición ha sido 
--  recibida por el médico o la nota ha sido dejada en el escritorio, continúa trabajando y haciendo 
--  más peticiones.
--  El médico atiende los pedidos dándole prioridad a los enfermos que llegan para ser atendidos. 
--  Cuando atiende un pedido, recibe la solicitud y la procesa durante un cierto tiempo. Cuando está 
--  libre aprovecha a procesar las notas dejadas por las enfermeras.

procedure guardia is
   TASK medico IS 
      ENTRY pedidoEnfermera;
      ENTRY notaEnfermera;
      ENTRY pedidoPersona;
   END medico;

   TASK BODY medico IS 
      variables : Integer := 0;
   BEGIN 
      LOOP 
         SELECT 
            ACCEPT pedidoPersona;
            
            WHEN(pedidoPersona'COUNT = 0) => 
               SELECT 
                  ACCEPT pedidoEnfermera;
               ELSE 
                  ACCEPT notaEnfermera;
               END SELECT;
         END SELECT; 
      END LOOP;
            

   END medico;

   TASK TYPE enfermera;

   enfermeras: array (1..E) of enfermera;
   
   -- requiere la atención del médico, si este no lo atiende inmediatamente le 
   --  hace una nota y se la deja en el consultorio para que esta resuelva su pedido en el momento que 
   --  pueda (el pedido puede ser que el médico le firme algún papel). Cuando la petición ha sido 
   --  recibida por el médico o la nota ha sido dejada en el escritorio, continúa trabajando y haciendo 
   --  más peticiones.

   TASK BODY enfermera is
   BEGIN 
      LOOP
         SELECT
            medico.pedidoEnfermera;
         ELSE 
            medico.notaEnfermera;
         END SELECT; 
      END LOOP;

   END enfermera;

   TASK TYPE persona;

   personas: array (1..P) of persona;
   
   -- necesita que la atiendan espera a lo sumo 5 minutos a que el médico lo haga, 
   --  si pasado ese tiempo no lo hace, espera 10 minutos y vuelve a requerir la atención del médico. 
   --  Si no es atendida tres veces, se enoja y se retira

   TASK BODY persona is
      intentos: Integer:= 0;
      sigo : boolean:= true;
   BEGIN 
      SELECT 
         medico.pedidoPersona;
      OR DELAY 300.0;
         while(intentos < 3) and (sigo) LOOP 
            SELECT
               medico.pedidoPersona; 
               sigo := false;
            OR DELAY 600.0; -- esta mal ya que una vez que llegó a los tres intentos y no lo atendieron, igual espera 10 min
               intentos := intentos + 1;
            END SELECT; 
         END LOOP; 
      END SELECT;

   END persona;


BEGIN
   null;
END guardia;