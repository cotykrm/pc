-- En un sistema para acreditar carreras universitarias, hay UN Servidor que atiende pedidos 
--  de U Usuarios de a uno a la vez y de acuerdo con el orden en que se hacen los pedidos. 
--  Cada usuario trabaja en el documento a presentar, y luego lo envía al servidor; espera 
--  la respuesta de este que le indica si está todo bien o hay algún error. Mientras haya algún 
--  error, vuelve a trabajar con el documento y a enviarlo al servidor. Cuando el servidor le 
--  responde que está todo bien, el usuario se retira. Cuando un usuario envía un pedido espera 
--  a lo sumo 2 minutos a que sea recibido por el servidor, pasado ese tiempo espera un minuto 
--  y vuelve a intentarlo (usando el mismo documento).



procedure sistema is
   TASK servidor IS 
      ENTRY recibirDocumento(documento : IN text; hayErrores : OUT boolean);
   END servidor;

   TASK BODY servidor IS
   BEGIN
      LOOP 
         ACCEPT recibirDocumento (documento : IN text; hayErrores : OUT boolean) DO 
            hayErrores := revisarDocumento(documento);
         END recibirDocumento;
      END LOOP;
   END servidor;

   TASK usuario;

   usuarios: array 

   TASK BODY usuario is
      doucmento: text; 
      hayErrores : boolean := true;
   BEGIN 
      doumento := crearDocumento;
      while(hayErrores) LOOP 
         SELECT 
            servidor.recibirDocumento(doucmento,hayErrores);
            if(hayErrores)
               documento := trabajarDoucmento(documento);
         OR DELAY 120.0;
            DELAY 60.0;
         END SELECT;

      END LOOP;
   END usuario;

BEGIN
   null;
END sistema;
