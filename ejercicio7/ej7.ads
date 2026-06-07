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
      ENTRY calcularGanador(monedas : IN Integer; nroEquipo : IN Integer);
   END juego;

   TASK BODY juego IS
      max : Integer := -1;
      equipoMax : Integer := 0;
   BEGIN
      for I in 1 .. 5 LOOP
         ACCEPT calcularGanador(monedas : IN Integer; nroEquipo : IN Integer) DO
            if(monedas > max)then
               max := monedas;
               equipoMax := nroEquipo;
            END if;
         END calcularGanador;
      END LOOP;

      for I in 1 .. 20 LOOP
         jugador(I).equipoGanador(equipoMax);
      END LOOP;

   END juego;

   TASK equipo IS 
      ENTRY llegoJugador;
      ENTRY terminoJugador(monedas : IN Integer);
      ENTRY ident(pos : IN Integer);
   END equipo;

   equipos : array (1..4) of equipo;

   TASK BODY equipo IS 
      id : Integer; 
      totalMonedas : Integer := 0;
   BEGIN
      ACCEPT ident(pos : IN Integer) DO
         id := pos;
      END ident;

      for I in 1 .. 4 LOOP
         ACCEPT llegoJugador;
      END LOOP;
      for I in 1 .. 4 LOOP
         jugadores(I).comenzarJuego; -- debe ser el id del jugador
      END LOOP;
      for I in 1 .. 4 LOOP
         ACCEPT terminoJugador(monedas : IN Integer) DO
            totalMonedas := totalMonedas + monedas;
         END terminoJugador;
      END LOOP;

      juego.calcularGanador(totalMonedas, id);
   END equipo;

   TASK jugador IS 
      ENTRY comenzarJuego;
      ENTRY equipoGanador(jugadorGanador : IN Integer);
   END jugador;

   jugadores : array (1..20) of jugador;

   TASK BODY jugador IS 
      nroEquipo : Integer; --ya asignado
      monedas : Integer := 0;
      ganador : Integer;
   BEGIN 
      equipo(nroEquipo).llegoJugador;
      ACCEPT comenzarJuego;
      for I in 1 .. 15 LOOP
         monedas := monedas + Moneda;
      END LOOP;
      equipo(nroEquipo).terminoJugador(monedas);
      ACCEPT equipoGanador(eGanador : IN Integer) DO
         ganador := eGanador;
      END equipoGanador;

   END jugador;


BEGIN
   for I in 1 .. 5 LOOP
      equipos(I).ident(I);
   END LOOP;
END playa;