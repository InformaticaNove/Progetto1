#+ Database creation script for SQLite
#+
#+ Note: This script is a helper script to create an empty database schema
#+       Adapt it to fit your needs

MAIN
    DATABASE mydatabase

    CALL db_drop_tables()
    CALL db_create_tables()
END MAIN

#+ Create all tables in database.
FUNCTION db_create_tables()
    WHENEVER ERROR STOP

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

#+ Drop all tables from database.
FUNCTION db_drop_tables()
    WHENEVER ERROR CONTINUE

    EXECUTE IMMEDIATE "DROP TABLE seqreg"
    EXECUTE IMMEDIATE "DROP TABLE collegamento"

END FUNCTION


