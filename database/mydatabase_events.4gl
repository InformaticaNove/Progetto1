#+ DB schema - Events Management (mydatabase)

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0

IMPORT FGL libdbappEvents
IMPORT FGL mydatabase_common
IMPORT FGL mydatabase

-- Database schema
SCHEMA mydatabase

-- DATABASE EVENT FUNCTION TYPES - TABLE LEVEL
PUBLIC TYPE T_DbxDataEvent_seqreg_CheckTableConstraints FUNCTION(p_forUpdate BOOLEAN, p_data RECORD LIKE seqreg.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_seqreg_BeforeInsertRowByKey FUNCTION(p_data RECORD LIKE seqreg.*) RETURNS (INTEGER, STRING, RECORD LIKE seqreg.*)
PUBLIC TYPE T_DbxDataEvent_seqreg_AfterInsertRowByKey FUNCTION(p_data RECORD LIKE seqreg.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_seqreg_BeforeDeleteRowByKey FUNCTION(p_key seqreg_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_seqreg_AfterDeleteRowByKey FUNCTION(p_key seqreg_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_seqreg_BeforeUpdateRowByKey FUNCTION(p_data RECORD LIKE seqreg.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_seqreg_AfterUpdateRowByKey FUNCTION(p_data RECORD LIKE seqreg.*) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DbxDataEvent_seqreg_SetDefaultValues FUNCTION(p_data RECORD LIKE seqreg.*) RETURNS (RECORD LIKE seqreg.*)

PUBLIC TYPE T_DbxDataEvent_collegamento_CheckTableConstraints FUNCTION(p_forUpdate BOOLEAN, p_data RECORD LIKE collegamento.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_collegamento_BeforeInsertRowByKey FUNCTION(p_data RECORD LIKE collegamento.*) RETURNS (INTEGER, STRING, RECORD LIKE collegamento.*)
PUBLIC TYPE T_DbxDataEvent_collegamento_AfterInsertRowByKey FUNCTION(p_data RECORD LIKE collegamento.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_collegamento_BeforeDeleteRowByKey FUNCTION(p_key collegamento_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_collegamento_AfterDeleteRowByKey FUNCTION(p_key collegamento_pk) RETURNS (INTEGER)
PUBLIC TYPE T_DbxDataEvent_collegamento_BeforeUpdateRowByKey FUNCTION(p_data RECORD LIKE collegamento.*) RETURNS (INTEGER, STRING)
PUBLIC TYPE T_DbxDataEvent_collegamento_AfterUpdateRowByKey FUNCTION(p_data RECORD LIKE collegamento.*) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DbxDataEvent_collegamento_SetDefaultValues FUNCTION(p_data RECORD LIKE collegamento.*) RETURNS (RECORD LIKE collegamento.*)

-- DATABASE EVENT FUNCTION VARIABLES - TABLE LEVEL

PUBLIC DEFINE m_DbxDataEvent_seqreg_CheckTableConstraints T_DbxDataEvent_seqreg_CheckTableConstraints
PUBLIC DEFINE m_DbxDataEvent_seqreg_BeforeInsertRowByKey T_DbxDataEvent_seqreg_BeforeInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_seqreg_AfterInsertRowByKey T_DbxDataEvent_seqreg_AfterInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_seqreg_BeforeDeleteRowByKey T_DbxDataEvent_seqreg_BeforeDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_seqreg_AfterDeleteRowByKey T_DbxDataEvent_seqreg_AfterDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_seqreg_BeforeUpdateRowByKey T_DbxDataEvent_seqreg_BeforeUpdateRowByKey
PUBLIC DEFINE m_DbxDataEvent_seqreg_AfterUpdateRowByKey T_DbxDataEvent_seqreg_AfterUpdateRowByKey

PUBLIC DEFINE m_DbxDataEvent_seqreg_SetDefaultValues T_DbxDataEvent_seqreg_SetDefaultValues

PUBLIC DEFINE m_DbxDataEvent_collegamento_CheckTableConstraints T_DbxDataEvent_collegamento_CheckTableConstraints
PUBLIC DEFINE m_DbxDataEvent_collegamento_BeforeInsertRowByKey T_DbxDataEvent_collegamento_BeforeInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_collegamento_AfterInsertRowByKey T_DbxDataEvent_collegamento_AfterInsertRowByKey
PUBLIC DEFINE m_DbxDataEvent_collegamento_BeforeDeleteRowByKey T_DbxDataEvent_collegamento_BeforeDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_collegamento_AfterDeleteRowByKey T_DbxDataEvent_collegamento_AfterDeleteRowByKey
PUBLIC DEFINE m_DbxDataEvent_collegamento_BeforeUpdateRowByKey T_DbxDataEvent_collegamento_BeforeUpdateRowByKey
PUBLIC DEFINE m_DbxDataEvent_collegamento_AfterUpdateRowByKey T_DbxDataEvent_collegamento_AfterUpdateRowByKey

PUBLIC DEFINE m_DbxDataEvent_collegamento_SetDefaultValues T_DbxDataEvent_collegamento_SetDefaultValues

-- REGISTER EVENT FUNCTIONS
PUBLIC FUNCTION mydatabase_registerDbxEvents()
    -- REGISTER DATABASE EVENT FUNCTIONS - TABLE LEVEL

END FUNCTION
