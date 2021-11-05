-- Do not reference this file using 'IMPORT FGL mydatabase'
IMPORT FGL libdbappCore

IMPORT FGL libdbappEvents
IMPORT FGL mydatabase_common

-- Database schema
SCHEMA mydatabase

-- Declare your PUBLIC module variables here.
PUBLIC DEFINE dlgCtrlInstruction libdbappEvents.DlgCtrlInstruction_Type
