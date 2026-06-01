procedure nombre is
   TASK nombret1 IS 
      ENTRY e1;
   END nombret1;

   TASK BODY nombret1 IS 
      variables : Integer := 0;
   BEGIN 
      -- cuerpo de la tarea
   END nombret1;

   TASK TYPE nombret2 IS 
      ENTRY e2;
   END nombret2;

   vec: array (1..n) of nombret2;
   
   TASK BODY nombret2 is
   BEGIN 
      -- cuerpo de la tarea
   END nombret2;


BEGIN
   null;
END nombre;