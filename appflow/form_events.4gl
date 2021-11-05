#+ User Interface - Events Management

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0

IMPORT FGL libdbappEvents
IMPORT FGL libdbappExt
IMPORT FGL form_common
IMPORT FGL form
IMPORT FGL VCard

-- Database schema
SCHEMA mydatabase

-- EVENTS
PUBLIC DEFINE m_DlgCtrlInstruction libdbappEvents.DlgCtrlInstruction_Type

PUBLIC TYPE T_DlgEvent_Default FUNCTION(dlg ui.Dialog, uiMode SMALLINT, dlgCtrlInstruction libdbappEvents.DlgCtrlInstruction_Type) RETURNS (libdbappEvents.DlgCtrlInstruction_Type)

-- EVENT FUNCTION TYPES
-- EVENT FUNCTION TYPES - FORM LEVEL
PUBLIC TYPE T_DlgEvent_OnOpenForm FUNCTION(currentForm ui.Form)
PUBLIC TYPE T_DlgEvent_OnActionStatesChange FUNCTION(dlg ui.Dialog, uiMode SMALLINT)
PUBLIC TYPE T_DlgEvent_OnFieldsActivation FUNCTION(dlg ui.Dialog, uiMode SMALLINT)
PUBLIC TYPE T_DlgEvent_Before_BrowseDialog FUNCTION(dlg ui.Dialog, uiMode SMALLINT, dlgCtrlInstruction libdbappEvents.DlgCtrlInstruction_Type, nextField STRING) RETURNS (libdbappEvents.DlgCtrlInstruction_Type, STRING)
PUBLIC TYPE T_DlgEvent_Before_EditDialog FUNCTION(dlg ui.Dialog, uiMode SMALLINT, dlgCtrlInstruction libdbappEvents.DlgCtrlInstruction_Type, nextField STRING) RETURNS (libdbappEvents.DlgCtrlInstruction_Type, STRING)
PUBLIC TYPE T_DlgEvent_Before_SearchDialog FUNCTION(dlg ui.Dialog, uiMode SMALLINT, dlgCtrlInstruction libdbappEvents.DlgCtrlInstruction_Type) RETURNS (libdbappEvents.DlgCtrlInstruction_Type)

PUBLIC TYPE T_DlgEvent_After_BrowseDialog FUNCTION(dlg ui.Dialog, uiMode SMALLINT, dlgCtrlInstruction libdbappEvents.DlgCtrlInstruction_Type) RETURNS (libdbappEvents.DlgCtrlInstruction_Type)
PUBLIC TYPE T_DlgEvent_After_EditDialog FUNCTION(dlg ui.Dialog, uiMode SMALLINT, dlgCtrlInstruction libdbappEvents.DlgCtrlInstruction_Type) RETURNS (libdbappEvents.DlgCtrlInstruction_Type)
PUBLIC TYPE T_DlgEvent_After_SearchDialog FUNCTION(dlg ui.Dialog, uiMode SMALLINT, dlgCtrlInstruction libdbappEvents.DlgCtrlInstruction_Type, whereClause STRING, detailList STRING) RETURNS (libdbappEvents.DlgCtrlInstruction_Type, STRING, STRING)

-- EVENT FUNCTION TYPES - FIELD LEVEL
PUBLIC TYPE T_DlgEvent_FieldLevel FUNCTION(dlg ui.Dialog, uiMode SMALLINT, dlgCtrlInstruction libdbappEvents.DlgCtrlInstruction_Type) RETURNS (libdbappEvents.DlgCtrlInstruction_Type)

-- EVENT FUNCTION TYPES - BA RELATION LEVEL
PUBLIC TYPE T_DlgEvent_BeforeOpeningTheForm FUNCTION(uiMode SMALLINT)
PUBLIC TYPE T_DlgEvent_AfterClosingTheForm FUNCTION(uiMode SMALLINT, errNo INTEGER, actionNo SMALLINT)

-- MOBILE EVENT FUNCTION TYPES - BA RELATION LEVEL
PUBLIC TYPE T_DlgEvent_AfterPhoto FUNCTION(dlg ui.Dialog, errNo INTEGER, errMsg STRING, photoPath STRING)
PUBLIC TYPE T_DlgEvent_AfterGallery FUNCTION(dlg ui.Dialog, errNo INTEGER, errMsg STRING, photoPath STRING)
PUBLIC TYPE T_DlgEvent_AfterPhone FUNCTION(dlg ui.Dialog, errNo INTEGER, errMsg STRING, phoneNumber STRING)
PUBLIC TYPE T_DlgEvent_AfterMail FUNCTION(dlg ui.Dialog, errNo INTEGER, errMsg STRING, mail MailSettings_Type)
PUBLIC TYPE T_DlgEvent_AfterSMS FUNCTION(dlg ui.Dialog, errNo INTEGER, errMsg STRING, sms SmsSettings_Type)
PUBLIC TYPE T_DlgEvent_AfterVCard FUNCTION(dlg ui.Dialog, errNo INTEGER, errMsg STRING, vcard STRING, person VCPerson, vcAddress VCAddress_Type, phone VCPhone_Type, email VCEmail_Type)
PUBLIC TYPE T_DlgEvent_AfterBarcode FUNCTION(dlg ui.Dialog, errNo INTEGER, errMsg STRING, barcode STRING)
PUBLIC TYPE T_DlgEvent_AfterMapQuery FUNCTION(dlg ui.Dialog, errNo INTEGER, errMsg STRING, mapQuery STRING)

-- DATA EVENT FUNCTION TYPES
-- DATA EVENT FUNCTION TYPES - ROW LEVEL
PUBLIC TYPE T_DataEvent_record1_OnSelectRows FUNCTION(sqlSelect STRING, sqlFrom STRING, sqlWhere STRING, sqlOrderBy STRING) RETURNS (STRING)
PUBLIC TYPE T_DataEvent_record1_OnComputedFields FUNCTION(currentRow record1_br_type INOUT)

PUBLIC TYPE T_DataEvent_record1_BeforeInsertRow FUNCTION(dataInsert RECORD LIKE collegamento.*) RETURNS (INTEGER, STRING, RECORD LIKE collegamento.*)
PUBLIC TYPE T_DataEvent_record1_AfterInsertRow FUNCTION(errNo INTEGER, errMsg STRING, uniqueKey record1_br_uk_type) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DataEvent_record1_BeforeUpdateRow FUNCTION(p_dataT0 RECORD LIKE collegamento.*, p_dataT1 RECORD LIKE collegamento.*) RETURNS (INTEGER, STRING, RECORD LIKE collegamento.*, RECORD LIKE collegamento.*)
PUBLIC TYPE T_DataEvent_record1_AfterUpdateRow FUNCTION(errNo INTEGER, errMsg STRING, uniqueKey record1_br_uk_type) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DataEvent_record1_BeforeDeleteRowWithConcurrentAccess FUNCTION(p_dataT0 RECORD LIKE collegamento.*) RETURNS (INTEGER, STRING, RECORD LIKE collegamento.*)
PUBLIC TYPE T_DataEvent_record1_AfterDeleteRowWithConcurrentAccess FUNCTION(errNo INTEGER, errMsg STRING, p_dataT0 RECORD LIKE collegamento.*) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DataEvent_record1_BeforeDeleteRow FUNCTION(uniqueKey record1_br_uk_type) RETURNS (INTEGER, STRING, record1_br_uk_type)
PUBLIC TYPE T_DataEvent_record1_AfterDeleteRow FUNCTION(errNo INTEGER, errMsg STRING, uniqueKey record1_br_uk_type) RETURNS (INTEGER, STRING)

PUBLIC TYPE T_DataEvent_record1_OnDefaultValues FUNCTION(currentRow record1_br_type) RETURNS (record1_br_type)

-- EVENT FUNCTION VARIABLES
-- EVENT FUNCTION VARIABLES - FORM LEVEL
PUBLIC DEFINE m_DlgEvent_OnOpenForm T_DlgEvent_OnOpenForm
PUBLIC DEFINE m_DlgEvent_OnActionStatesChange T_DlgEvent_OnActionStatesChange

PUBLIC DEFINE m_DlgEvent_Before_BrowseDialog T_DlgEvent_Before_BrowseDialog
PUBLIC DEFINE m_DlgEvent_Before_EditDialog T_DlgEvent_Before_EditDialog
PUBLIC DEFINE m_DlgEvent_Before_SearchDialog T_DlgEvent_Before_SearchDialog
PUBLIC DEFINE m_DlgEvent_Before_EmptyDialog T_DlgEvent_Default

PUBLIC DEFINE m_DlgEvent_After_BrowseDialog T_DlgEvent_After_BrowseDialog
PUBLIC DEFINE m_DlgEvent_After_EditDialog T_DlgEvent_After_EditDialog
PUBLIC DEFINE m_DlgEvent_After_SearchDialog T_DlgEvent_After_SearchDialog

PUBLIC DEFINE m_DlgEvent_OnActionAccept T_DlgEvent_Default
PUBLIC DEFINE m_DlgEvent_OnActionCancel T_DlgEvent_Default
PUBLIC DEFINE m_DlgEvent_OnActionClose T_DlgEvent_Default
PUBLIC DEFINE m_DlgEvent_OnActionExit T_DlgEvent_Default
PUBLIC DEFINE m_DlgEvent_OnActionNew T_DlgEvent_Default
PUBLIC DEFINE m_DlgEvent_OnActionQuery T_DlgEvent_Default

-- EVENT FUNCTION VARIABLES - RECORD LEVEL
PUBLIC DEFINE m_DlgEvent_record1_OnActionStatesChange T_DlgEvent_OnActionStatesChange
PUBLIC DEFINE m_DlgEvent_record1_OnFieldsActivation T_DlgEvent_OnFieldsActivation

PUBLIC DEFINE m_DlgEvent_record1_BeforeDisplay T_DlgEvent_Default
PUBLIC DEFINE m_DlgEvent_record1_BeforeInput T_DlgEvent_Default
PUBLIC DEFINE m_DlgEvent_record1_BeforeConstruct T_DlgEvent_Default

PUBLIC DEFINE m_DlgEvent_record1_AfterDisplay T_DlgEvent_Default
PUBLIC DEFINE m_DlgEvent_record1_AfterInput T_DlgEvent_Default
PUBLIC DEFINE m_DlgEvent_record1_AfterConstruct T_DlgEvent_Default

-- EVENT FUNCTION VARIABLES - ROW LEVEL

PUBLIC DEFINE m_DlgEvent_record1_BeforeRow T_DlgEvent_Default
PUBLIC DEFINE m_DlgEvent_record1_AfterRow T_DlgEvent_Default
PUBLIC DEFINE m_DlgEvent_record1_BeforeInsert T_DlgEvent_Default
PUBLIC DEFINE m_DlgEvent_record1_AfterInsert T_DlgEvent_Default
PUBLIC DEFINE m_DlgEvent_record1_BeforeDelete T_DlgEvent_Default
PUBLIC DEFINE m_DlgEvent_record1_AfterDelete T_DlgEvent_Default

PUBLIC DEFINE m_DlgEvent_record1_OnActionAppend T_DlgEvent_Default
PUBLIC DEFINE m_DlgEvent_record1_OnActionInsert T_DlgEvent_Default
PUBLIC DEFINE m_DlgEvent_record1_OnActionUpdate T_DlgEvent_Default

-- EVENT FUNCTION VARIABLES - FIELD LEVEL
PUBLIC DEFINE m_DlgEvent_record1_BeforeField_collegamento_utente T_DlgEvent_FieldLevel
PUBLIC DEFINE m_DlgEvent_record1_AfterField_collegamento_utente T_DlgEvent_FieldLevel
PUBLIC DEFINE m_DlgEvent_record1_OnChange_collegamento_utente T_DlgEvent_FieldLevel
PUBLIC DEFINE m_DlgEvent_record1_BeforeField_collegamento_password T_DlgEvent_FieldLevel
PUBLIC DEFINE m_DlgEvent_record1_AfterField_collegamento_password T_DlgEvent_FieldLevel
PUBLIC DEFINE m_DlgEvent_record1_OnChange_collegamento_password T_DlgEvent_FieldLevel
PUBLIC DEFINE m_DlgEvent_record1_BeforeField_collegamento_server T_DlgEvent_FieldLevel
PUBLIC DEFINE m_DlgEvent_record1_AfterField_collegamento_server T_DlgEvent_FieldLevel
PUBLIC DEFINE m_DlgEvent_record1_OnChange_collegamento_server T_DlgEvent_FieldLevel
PUBLIC DEFINE m_DlgEvent_record1_BeforeField_collegamento_porta T_DlgEvent_FieldLevel
PUBLIC DEFINE m_DlgEvent_record1_AfterField_collegamento_porta T_DlgEvent_FieldLevel
PUBLIC DEFINE m_DlgEvent_record1_OnChange_collegamento_porta T_DlgEvent_FieldLevel
PUBLIC DEFINE m_DlgEvent_record1_BeforeField_collegamento_database T_DlgEvent_FieldLevel
PUBLIC DEFINE m_DlgEvent_record1_AfterField_collegamento_database T_DlgEvent_FieldLevel
PUBLIC DEFINE m_DlgEvent_record1_OnChange_collegamento_database T_DlgEvent_FieldLevel
PUBLIC DEFINE m_DlgEvent_record1_BeforeField_collegamento_modulo T_DlgEvent_FieldLevel
PUBLIC DEFINE m_DlgEvent_record1_AfterField_collegamento_modulo T_DlgEvent_FieldLevel
PUBLIC DEFINE m_DlgEvent_record1_OnChange_collegamento_modulo T_DlgEvent_FieldLevel

-- EVENT FUNCTION VARIABLES - BA RELATION LEVEL

-- MOBILE EVENT FUNCTION VARIABLES - BA RELATION LEVEL

-- DATA EVENT FUNCTION VARIABLES
-- DATA EVENT FUNCTION VARIABLES - ROW LEVEL

PUBLIC DEFINE m_DataEvent_record1_OnSelectRows T_DataEvent_record1_OnSelectRows
PUBLIC DEFINE m_DataEvent_record1_OnComputedFields T_DataEvent_record1_OnComputedFields

PUBLIC DEFINE m_DataEvent_record1_BeforeInsertRow T_DataEvent_record1_BeforeInsertRow
PUBLIC DEFINE m_DataEvent_record1_AfterInsertRow T_DataEvent_record1_AfterInsertRow

PUBLIC DEFINE m_DataEvent_record1_BeforeUpdateRow T_DataEvent_record1_BeforeUpdateRow
PUBLIC DEFINE m_DataEvent_record1_AfterUpdateRow T_DataEvent_record1_AfterUpdateRow

PUBLIC DEFINE m_DataEvent_record1_BeforeDeleteRowWithConcurrentAccess T_DataEvent_record1_BeforeDeleteRowWithConcurrentAccess
PUBLIC DEFINE m_DataEvent_record1_AfterDeleteRowWithConcurrentAccess T_DataEvent_record1_AfterDeleteRowWithConcurrentAccess

PUBLIC DEFINE m_DataEvent_record1_BeforeDeleteRow T_DataEvent_record1_BeforeDeleteRow
PUBLIC DEFINE m_DataEvent_record1_AfterDeleteRow T_DataEvent_record1_AfterDeleteRow

PUBLIC DEFINE m_DataEvent_record1_OnDefaultValues T_DataEvent_record1_OnDefaultValues

-- REGISTER EVENT FUNCTIONS
PUBLIC FUNCTION form_registerDlgEvents()
    -- REGISTER EVENT FUNCTIONS - FORM LEVEL

    -- REGISTER EVENT FUNCTIONS - RECORD LEVEL

    -- REGISTER EVENT FUNCTIONS - ROW LEVEL

    -- REGISTER EVENT FUNCTIONS - FIELD LEVEL

    -- REGISTER EVENT FUNCTIONS - BA RELATION LEVEL

    -- REGISTER MOBILE EVENT FUNCTIONS - BA RELATION LEVEL

    -- REGISTER DATA EVENT FUNCTIONS - ROW LEVEL

END FUNCTION