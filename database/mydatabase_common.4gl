#+ DB schema - Common (mydatabase)

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0

-- Database schema
SCHEMA mydatabase

-- PRIMARY KEY TYPES - TABLE LEVEL

PUBLIC TYPE seqreg_pk
    RECORD
        seqreg_sr_name LIKE seqreg.sr_name
    END RECORD

PUBLIC TYPE collegamento_pk
    RECORD
        collegamento_utente LIKE collegamento.utente
    END RECORD
