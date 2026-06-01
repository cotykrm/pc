--Se quiere modelar el funcionamiento de un banco, al cual llegan clientes que deben realizar 
-- un pago y retirar un comprobante. Existe un único empleado en el banco, el cual atiende de 
-- acuerdo con el orden de llegada.
-- c. Implemente una solución donde los clientes se retiran si no son atendidos inmediatamente

procedure banco is
   TASK empelado IS 
      ENTRY atender(pago : IN texto; comprobante : OUT texto);
   END empelado;

   TASK TYPE cliente;

   clientes: array (0..C-1) of cliente;

   TASK BODY cliente IS 
      pago, comprobante : texto;
   BEGIN 
      SELECT
         empelado.atender(pago, comprobante);
      OR ELSE
         NULL;
      END SELECT;
   END cliente;

   TASK BODY empelado IS 
      pago, comprobante : texto;
   BEGIN
      LOOP 
         ACCEPT atender (pago : IN texto; comprobante : OUT texto) do
            comprobante := generarComprobante(pago);
         END atender;
      END LOOP;
   END empleado;

BEGIN 
   null;
END banco;
