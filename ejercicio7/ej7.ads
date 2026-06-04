-- En una playa hay 5 equipos de 4 personas cada uno (en total son 20 personas donde cada 
--  una conoce previamente a que equipo pertenece). Cuando las personas van llegando esperan 
--  con los de su equipo hasta que el mismo esté completo (hayan llegado los 4 integrantes), 
--  a partir de ese momento el equipo comienza a jugar. El juego consiste en que cada 
--  integrante del grupo junta 15 monedas de a una en una playa (las monedas pueden ser de 1, 
--  2 o 5 pesos) y se suman los montos de las 60 monedas conseguidas en el grupo. Al finalizar 
--  cada persona debe conocer el grupo que más dinero junto. Nota: maximizar la concurrencia. 
--  Suponga que para simular la búsqueda de una moneda por parte de una persona existe una 
--  función Moneda() que retorna el valor de la moneda encontrada.

procedure playa is 
   TASK juego IS 
      ENTRY equipoGanador( monedas : IN Integer; nroEquipo : IN Integer; ganador : OUT Integer);
   END juego;


   TASK equipo IS 
      ENTRY comenzarJuego;
   END equipo;

   equipos : array (1..20) of equipo;

   -- Si espero a que haya 4 jugadores para hacer el accept y aprovechar la bidireccionalidad del canal, 
   -- se produce busy waiting.
   -- tengo que hacer que los jugadores lleguen, aceptarlos mientras lleguen y cuando hayan llegado todos
   -- enviarles otro mensaje para que comiencen?
   -- o tengo que hacer un ACCEPT DO? no se como

   TASK BODY equipo IS 
      sigo : boolean := true;
   BEGIN
      while(sigo) LOOP
      -- SELECT 
      --   WHEN (comenzarJuego'COUNT = 4) =>
      --       ACCEPT
      -- imaginemos que ya llegaron y que ya inicio el juego
      
      END LOOP;  

   END equipo;

   TASK jugador IS 
      
   END jugador;

   jugadores : array (1..20) of jugador;

   TASK BODY jugador IS 
      nroEquipo : Integer; --ya asignado
      monedas : Integer := 0;
   BEGIN 
      equipo.comenzarJuego;
      -- imaginemos que ya llegaron y que ya inicio el juego
      for I in 1 .. 10 LOOP
         monedas := monedas + Moneda();
      END LOOP;
      -- aca es lo mismo, debería mandar mis monedas con mi grupo, que el juego calcule el ganador
      -- cuando ya hayan llegado todos y recién ahí puedo contestar.


   END jugador;


BEGIN
   null;
END playa;