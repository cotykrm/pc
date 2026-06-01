--Se dispone de un sistema compuesto por 1 central y 2 procesos periféricos, que se 
-- comunican continuamente.
--  Se requiere modelar su funcionamiento considerando las siguientes condiciones:
--  - La central siempre comienza su ejecución tomando una señal del proceso 1; luego 
--  toma aleatoriamente señales de cualquiera de los dos indefinidamente. Al recibir 
--  una señal de proceso 2, recibe señales del mismo proceso durante 3 minutos.
--  - Los procesos periféricos envían señales continuamente a la central. La señal del 
--  proceso 1 será considerada vieja (se deshecha) si en 2 minutos no fue recibida. 
--  Si la señal del proceso 2 no puede ser recibida inmediatamente, entonces espera 
--  1 minuto y vuelve a mandarla (no se deshecha).


procedure sistema is
    TASK central IS 
        ENTRY signalP1(signal: IN text);
        ENTRY signalP2(signal: IN text);
        ENTRY finTimer;
    END central;

    TASK timer IS 
        ENTRY inicioTimer;
    END timer;

    TASK BODY timer IS
    BEGIN 
        ACCEPT inicioTimer;
        DELAY 180.0;
        central.finTimer;
    END timer;

    TASK proceso1;

    TASK BODY proceso1 IS 
    BEGIN   
        LOOP 
            SELECT
                central.signalP1(signal);
            OR DELAY 120.0;
                NULL;
            END SELECT;
        END LOOP;

    END proceso1;

    TASK proceso2;

    TASK BODY proceso2 IS 
    BEGIN 
        LOOP 
            SELECT 
                central.signalP2(signal);
            OR DELAY 60.0;
            END SELECT;
        END LOOP;

    END proceso2;

    TASK BODY central IS 
        sigo : Boolean;
        signal : text;
    BEGIN 
        ACCEPT signalP1;
        LOOP 
            SELECT 
                ACCEPT signalP1(signal: IN text);
            OR -- Acepto cualquiera de las dos aleatoriamente,
                ACCEPT signalP2(signal: IN text); -- debe estar adentro de un accept do?
                timer.inicioTimer; -- Si acepto del p2 inicio un timer de 3 min
                sigo := true;
                while(sigo) LOOP
                    SELECT 
                        ACCEPT finTimer DO -- me manda que paso el tiempo
                            sigo := false; -- corto el loop
                        END finTimer; 
                    OR WHEN (finTimer'COUNT = 0)=> -- mientras no me mande que pasaron los 3min
                        ACCEPT signalP2(signal: IN text); -- acepto las seniales de p2
                    END SELECT; 
                END LOOP; 
            END SELECT; 
        END LOOP;                         
    END central;

begin
    null;
END sistema;