#+ User Interface - Events Management

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0
IMPORT FGL libdbappExt
IMPORT FGL libdbappFormUI
IMPORT FGL form_menu
IMPORT FGL VCard

-- EVENTS
-- EVENT FUNCTION TYPES - FORM LEVEL
PUBLIC TYPE T_DlgEvent_OnExec FUNCTION(p_whereRelation STRING, p_uiSettings UISettings_Type) RETURNS (INTEGER, SMALLINT)

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

-- EVENT FUNCTION VARIABLES - FORM LEVEL
PUBLIC DEFINE m_DlgEvent_OnExec T_DlgEvent_OnExec

-- EVENT FUNCTION VARIABLES - BA RELATION LEVEL

-- MOBILE EVENT FUNCTION VARIABLES - BA RELATION LEVEL

-- REGISTER EVENT FUNCTIONS
PUBLIC FUNCTION form_menu_registerDlgEvents()
    -- REGISTER EVENT FUNCTIONS - FORM LEVEL

    -- REGISTER EVENT FUNCTIONS - BA RELATION LEVEL

    -- REGISTER MOBILE EVENT FUNCTIONS - BA RELATION LEVEL

END FUNCTION
