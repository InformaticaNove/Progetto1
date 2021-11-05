{<CODEFILE Path="form_menu.code" Hash="1B2M2Y8AsgTpgAmY7PhCfg==" />}
#+ User Interface

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0
--Warning: Enter your changes within a <BLOCK> or <POINT> section, otherwise they will be lost.
{<POINT Name="user.comments">} {</POINT>}
--------------------------------------------------------------------------------
--Importing modules
IMPORT FGL libdbappCore
IMPORT FGL libdbappFormUI
IMPORT FGL form_menu_common
IMPORT FGL form_menu_events
{<POINT Name="import">} {</POINT>}
{<POINT Name="define">} {</POINT>}

--------------------------------------------------------------------------------
--Functions

{<BLOCK Name="fct.uiOpenForm">}
#+ Launch the module
#+
#+ @param p_whereRelation   Part of the WHERE clause defined by entity relations in the BA
#+ @param p_uiSettings      UI Settings defined on the relation
PUBLIC FUNCTION form_menu_ui_uiOpenForm(p_whereRelation, p_uiSettings)
    DEFINE p_whereRelation STRING
    DEFINE p_uiSettings UISettings_Type
    DEFINE errNo INTEGER
    DEFINE actionNo SMALLINT
    {<POINT Name="fct.uiOpenForm.define">} {</POINT>}

    CALL form_menu_events.form_menu_registerDlgEvents()
    IF form_menu_events.m_DlgEvent_OnExec IS NOT NULL THEN
            CALL form_menu_events.m_DlgEvent_OnExec(p_whereRelation, p_uiSettings.*)
                RETURNING errNo, actionNo
        END IF

    {<POINT Name="fct.uiOpenForm.user">} {</POINT>}
    RETURN errNo, actionNo
END FUNCTION
{</BLOCK>} --fct.uiOpenForm

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions">} {</POINT>}
