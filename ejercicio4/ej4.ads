procedure calcularPromedio is
   TASK coordinador IS 
      ENTRY iniciar;
      ENTRY obtenerSuma(suma: IN Integer);
   END coordinador;

   TASK TYPE worker IS 
      ENTRY comenzar;
   END worker;

   workers: array(0..9) of worker;

   TASK BODY worker IS 
      vec: array (1..100000) of Integer := InicializarVector;
      suma: Integer := 0;
   BEGIN 
      coordinador.iniciar;
      FOR i IN 1..100000 LOOP
         suma := suma + vec(i);
      END LOOP;
      coordinador.obtenerSuma(suma);
   END worker;

   TASK BODY coordinador IS 
      total: Integer := 0;
      promedio: Real;
   BEGIN
      FOR i IN 1..20 LOOP
         SELECT 
            ACCEPT iniciar;
         OR 
            ACCEPT obtenerSuma (suma : IN Integer) DO
               total:= total + suma;
            END obtenerSuma;
         END SELECT; 
      END LOOP;
      promedio:= total / 100000;
   END coordinador;

begin
   null;
END calcularPromedio;
