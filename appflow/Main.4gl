-- Do not reference this file using 'IMPORT FGL Main'

--Importing modules
IMPORT FGL libdbappCore
IMPORT FGL libdbappExt
IMPORT FGL libdbappFormUI
IMPORT FGL libdbappReportCore
IMPORT FGL libdbappReportUI
IMPORT FGL libdbappSql
IMPORT FGL libdbappUI
IMPORT FGL libdbappEvents
IMPORT FGL libdbappWS
IMPORT FGL libdbappWSClient
IMPORT FGL libdbappWSCore
IMPORT os
IMPORT security
IMPORT FGL mydatabase_dbxdata
IMPORT FGL fgldialog

-- Database schema
SCHEMA mydatabase

-- Declare your PUBLIC module variables here.
GLOBALS 

    DEFINE  p_Login          RECORD LIKE collegamento.*,
            p_Verifica       RECORD LIKE collegamento.*,
            stop_n           SMALLINT,
            l_style          STRING,
            l_actionDefaults STRING,
            l_flag_uscita    SMALLINT,
            cancella         STRING,
            dati             STRING  

END GLOBALS 

MAIN
    {<POINT Name="MAIN.define">} {</POINT>}
    
    {<BLOCK Name="MAIN.options">}
    OPTIONS INPUT WRAP
    {</BLOCK>} --MAIN.options
    CLOSE WINDOW SCREEN

    {<BLOCK Name="MAIN.loadResources" Status="MODIFIED">}

    --Cambia il tipo interfaccia e scritta del bottone
    IF libdbapp_isMobile() THEN
        CALL ui.Interface.loadActionDefaults(NVL(l_actionDefaults, "mobile_dbapp"))
    ELSE
        CALL ui.Interface.loadActionDefaults(NVL(l_actionDefaults, "dbapp"))
    END IF
    CALL ui.Interface.loadStyles(NVL(l_style, "dbapp"))
    {</BLOCK>} --MAIN.loadResources

    {<POINT Name="MAIN.init">} {</POINT>}

    
    CALL main_install()
    CONNECT TO "mydatabase.db"
    CALL  db_create_tables()
    LET stop_n = FALSE 
    INITIALIZE p_Login.* TO NULL 
    
    CALL primo_accesso()
   
    IF (stop_n = FALSE) THEN 
LABEL menu_s:
        OPEN WINDOW menu_n WITH FORM "form_menu"
        MENU ""
            COMMAND "conferimenti"
                LET l_flag_uscita = FALSE  
            COMMAND "btSitContratti"
                LET l_flag_uscita = FALSE 
            COMMAND "btSitMagazzino"  
                LET l_flag_uscita = FALSE
            COMMAND "btUscita"
                LET l_flag_uscita = TRUE
                EXIT MENU 
            ON ACTION UPDATE
                CALL modifica_accesso()
                IF ( stop_n = TRUE ) THEN 
                    EXIT MENU 
                END IF
        END MENU 
        CLOSE WINDOW menu_n
    END IF 
END MAIN

{<BLOCK Name="fct.install">}
#+ Copy read-only files to the writable document area
PUBLIC FUNCTION main_install()
    DEFINE src STRING
    DEFINE dest STRING
    DEFINE dbFilename STRING
    DEFINE dbDestFilename STRING
    DEFINE ret BOOLEAN
    {<POINT Name="fct.install.define">} {</POINT>}
    {<POINT Name="fct.install.init">} {</POINT>}

    --Copy read-only database file (nothing to do for GMa)
    IF ui.Interface.getFrontEndName() == "GMI" AND base.Application.isMobile() THEN
        LET dbFilename = base.Application.getResourceEntry("dbi.database.mydatabase.source")
        IF dbFilename IS NULL THEN
            LET dbFilename = "mydatabase.db"
            LET dbDestFilename = "mydatabase"
        ELSE
            LET dbDestFilename = dbFilename
        END if
        LET dest = os.Path.fullPath(os.Path.join(os.Path.pwd(), dbDestFilename))
        IF NOT os.Path.exists(dest) THEN
            --Copy to writable directory
            LET src = os.Path.fullPath(os.Path.join(base.Application.getProgramDir(), dbFilename))
            CALL os.Path.copy(src, dest) RETURNING ret
        END IF
    END IF
    {<POINT Name="fct.install.user">} {</POINT>}
END FUNCTION
{</BLOCK>} --fct.install

FUNCTION db_create_tables()

    WHENEVER ERROR CONTINUE

    EXECUTE IMMEDIATE "CREATE TABLE seqreg (
        sr_name VARCHAR(30) NOT NULL,
        sr_last INTEGER NOT NULL,
        CONSTRAINT pk_seqreg PRIMARY KEY(sr_name))"

    EXECUTE IMMEDIATE "CREATE TABLE collegamento (
        utente VARCHAR(30),
        password VARCHAR(30),
        server VARCHAR(30),
        porta INTEGER,
        database VARCHAR(30),
        modulo VARCHAR(30),
        CONSTRAINT pk_collegamento_1 PRIMARY KEY(utente))"
        
END FUNCTION 

FUNCTION primo_accesso()

    LET stop_n = FALSE 
    OPEN WINDOW w_login WITH FORM  "form"
    
        INPUT BY NAME p_Login.* 
            ON KEY (INTERRUPT)
                LET stop_n = TRUE
                EXIT INPUT
            AFTER FIELD utente
                IF(p_Login.utente IS NULL) THEN 
                    call fgl_winMessage("Errore", "Utente non valido", "Avanti")
                    NEXT FIELD utente
                END IF 
            NEXT FIELD password
            AFTER FIELD password 
                IF(p_Login.password IS NULL) THEN 
                    call fgl_winMessage("Errore", "Password non valida", "Avanti")
                    NEXT FIELD password
                END IF 
            NEXT FIELD server
            AFTER FIELD server 
                IF(p_Login.server IS NULL) THEN 
                    call fgl_winMessage("Errore", "Server non valido", "Avanti")
                    NEXT FIELD server
                END IF 
            NEXT FIELD porta
            AFTER FIELD porta 
                IF(p_Login.porta IS NULL) THEN 
                    call fgl_winMessage("Errore", "Porta non valida", "Avanti")
                    NEXT FIELD porta
                END IF 
            NEXT FIELD database
            AFTER FIELD database 
                IF(p_Login.database IS NULL) THEN 
                    call fgl_winMessage("Errore", "Database non valido", "Avanti")
                    NEXT FIELD database
                END IF 
            NEXT FIELD modulo
            AFTER FIELD modulo 
                IF(p_Login.modulo IS NULL) THEN 
                    call fgl_winMessage("Errore", "Modulo non valido", "Avanti")
                    NEXT FIELD modulo
                END IF 
        END INPUT 

        SELECT *
            INTO p_Verifica.*
            FROM collegamento
            WHERE ((utente = p_Login.utente) AND (password = p_Login.password) AND (server = p_Login.server) 
                    AND (porta = p_Login.porta) AND (database = p_Login.database) AND (modulo = p_Login.modulo))

        IF (p_Verifica.* = p_Login.*) THEN
            CALL fgl_winMessage("Info","Autenticazione riuscita","Ok") 
        ELSE
            INSERT 
                INTO collegamento
                VALUES( p_Login.* )
            IF ( status != 0 ) THEN
                CALL fgl_winMessage("Info","Errore inserimento dati.","Ok")
                LET stop_n = TRUE
            ELSE
                CALL fgl_winMessage("Info","Inserimento riuscito","Ok") 
            END IF 
        END IF 
    
    CLOSE WINDOW w_login

END FUNCTION

FUNCTION modifica_accesso()

    LET stop_n = FALSE 
    OPEN WINDOW w_login_modif WITH FORM  "form"
    
    DISPLAY BY NAME p_Login.*
         SELECT *
            INTO p_Verifica.*
            FROM collegamento
        INPUT BY NAME p_Login.* WITHOUT DEFAULTS 
            ON KEY (INTERRUPT)
                LET stop_n = TRUE
                EXIT INPUT
            AFTER FIELD utente
                IF(p_Login.utente IS NULL) THEN 
                    call fgl_winMessage("Errore", "Utente non valido", "Avanti")
                    NEXT FIELD utente
                END IF 
            NEXT FIELD password
            AFTER FIELD password 
                IF(p_Login.password IS NULL) THEN 
                    call fgl_winMessage("Errore", "Password non valida", "Avanti")
                    NEXT FIELD password
                END IF 
            NEXT FIELD server
            AFTER FIELD server 
                IF(p_Login.server IS NULL) THEN 
                    call fgl_winMessage("Errore", "Server non valido", "Avanti")
                    NEXT FIELD server
                END IF 
            NEXT FIELD porta
            AFTER FIELD porta 
                IF(p_Login.porta IS NULL) THEN 
                    call fgl_winMessage("Errore", "Porta non valida", "Avanti")
                    NEXT FIELD porta
                END IF 
            NEXT FIELD database
            AFTER FIELD database 
                IF(p_Login.database IS NULL) THEN 
                    call fgl_winMessage("Errore", "Database non valido", "Avanti")
                    NEXT FIELD database
                END IF 
            NEXT FIELD modulo
            AFTER FIELD modulo 
                IF(p_Login.modulo IS NULL) THEN 
                    call fgl_winMessage("Errore", "Modulo non valido", "Avanti")
                    NEXT FIELD modulo
                END IF 
        END INPUT 
        
        UPDATE collegamento SET 
            utente = p_Login.utente,
            porta = p_Login.porta,
            modulo = p_Login.modulo,
            database = p_Login.database,
            password = p_Login.password,
            server = p_Login.server
        WHERE (utente = p_Verifica.utente AND porta = p_Verifica.porta AND modulo = p_Verifica.modulo AND DATABASE = p_Verifica.database AND password = p_Verifica.password AND server = p_Verifica.server)

        IF ( status != 0 ) THEN
            CALL fgl_winMessage("Info","Modifica non riuscita","Ok")
            LET stop_n = TRUE
        ELSE
            CALL fgl_winMessage("Info","Modifica riuscita","Ok") 
        END IF 
            
   CLOSE WINDOW w_login_modif 

END FUNCTION