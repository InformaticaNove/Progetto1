#+ User Interface - Common

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0

--------------------------------------------------------------------------------
--Importing modules

-- Database schema
SCHEMA mydatabase

--------------------------------------------------------------------------------
--Definition of constants, user-types, variables
PUBLIC TYPE record1_br_type
    RECORD
        collegamento_utente LIKE collegamento.utente,
        collegamento_password LIKE collegamento.password,
        collegamento_server LIKE collegamento.server,
        collegamento_porta LIKE collegamento.porta,
        collegamento_database LIKE collegamento.database,
        collegamento_modulo LIKE collegamento.modulo
    END RECORD

PUBLIC TYPE record1_br_uk_type
    RECORD
        collegamento_utente LIKE collegamento.utente
    END RECORD

PUBLIC DEFINE m_where STRING --The WHERE clause to fetch the data set
PUBLIC DEFINE m_detailList STRING --The list of details to fetch the data set
PUBLIC DEFINE m_whereRelation STRING --The part of the WHERE clause defined by entity relations in the BA
PUBLIC DEFINE m_record1_arrKeyRec DYNAMIC ARRAY OF record1_br_uk_type
PUBLIC DEFINE m_record1_arrRecGrid DYNAMIC ARRAY OF record1_br_type
PUBLIC DEFINE m_record1_arrRecDB DYNAMIC ARRAY OF RECORD LIKE collegamento.*
PUBLIC DEFINE m_record1_keyIndex INTEGER