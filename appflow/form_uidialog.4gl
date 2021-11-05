{<CODEFILE Path="form.code" Hash="1B2M2Y8AsgTpgAmY7PhCfg==" />}
#+ User Interface - Dialog Management (mydatabase)

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0
--Warning: Enter your changes within a <BLOCK> or <POINT> section, otherwise they will be lost.
{<POINT Name="user.comments">} {</POINT>}
--------------------------------------------------------------------------------
--Importing modules
IMPORT FGL libdbappCore
IMPORT FGL libdbappSql
IMPORT FGL libdbappUI
IMPORT FGL libdbappFormUI
IMPORT FGL libdbappEvents

IMPORT FGL form_common
IMPORT FGL form_events
IMPORT FGL form_uidata
IMPORT FGL form_uidialogdata
{<POINT Name="import">} {</POINT>}
-- Database schema
SCHEMA mydatabase

--------------------------------------------------------------------------------
--Definition of constants, user-types, variables
PUBLIC DEFINE m_subDialog STRING
PUBLIC DEFINE m_dataProcessing BOOLEAN --Used to skip the DVM validation in other subdialogs than the current dialog if a data processing is in progress on the current subdialog
PUBLIC DEFINE m_actionNo SMALLINT
PUBLIC DEFINE m_prevAction SMALLINT
PUBLIC DEFINE m_state SMALLINT
PUBLIC DEFINE m_navigation_direction SMALLINT
PUBLIC DEFINE M_errMsg STRING
PUBLIC DEFINE initializeUI BOOLEAN
PUBLIC DEFINE m_uiSettings UISettings_Type
PUBLIC DEFINE m_record1_where STRING
PUBLIC DEFINE m_nextField STRING
PUBLIC DEFINE m_copy_record1 record1_br_type
{<POINT Name="define">} {</POINT>}

--------------------------------------------------------------------------------
--Dialog Blocks
{<BLOCK Name="dlg.record1.uiDisplay">}
DIALOG form_uidialog_record1_uiDisplay()
    DEFINE l_internalAction SMALLINT

    {<POINT Name="dlg.record1.uiDisplay.define">} {</POINT>}

    DISPLAY ARRAY m_record1_arrRecGrid TO record1.* ATTRIBUTES(COUNT=IIF(m_record1_arrKeyRec.getLength() <= 0, 1, m_record1_arrKeyRec.getLength()))
        BEFORE DISPLAY
            {<POINT Name="dlg.record1.uiDisplay.beforeDisplay">} {</POINT>}
            LET m_subDialog = "record1"
            CALL form_uidialog_record1_setActionStates(DIALOG, C_MODE_DISPLAY)
            --Set the current row with the index of the subdialog, otherwise when you come:
            -- - from another mode
            -- - from a detail in INPUT to the master in DISPLAY (mixed mode)
            -- the index is reset to 1 by 'DIALOG.getCurrentRow'
            CALL DIALOG.setCurrentRow("record1", m_record1_keyIndex)
            IF NOT libdbapp_isMobile() THEN
                IF m_record1_arrKeyRec.getLength() > 1 THEN
                    MESSAGE m_record1_keyIndex, "/", m_record1_arrKeyRec.getLength()
                END IF
            END IF

            INITIALIZE form_events.m_DlgCtrlInstruction TO NULL
            IF form_events.m_DlgEvent_record1_BeforeDisplay IS NOT NULL THEN
                CALL form_events.m_DlgEvent_record1_BeforeDisplay(DIALOG, m_state, form_events.m_DlgCtrlInstruction)
                    RETURNING form_events.m_DlgCtrlInstruction
            END IF

            CASE form_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CANCEL_INSERT
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeDisplay", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
                WHEN libdbappEvents.CONTINUE_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeDisplay", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.EXIT_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeDisplay", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
            END CASE

        BEFORE ROW
            {<POINT Name="dlg.record1.uiDisplay.beforeRow">} {</POINT>}

            CALL form_uidialog_setAllCurrentRow(DIALOG)
            IF NOT libdbapp_isMobile() THEN
                IF m_record1_arrKeyRec.getLength() > 1 THEN
                    MESSAGE m_record1_keyIndex, "/", m_record1_arrKeyRec.getLength()
                END IF
            END IF

            INITIALIZE form_events.m_DlgCtrlInstruction TO NULL
            IF form_events.m_DlgEvent_record1_BeforeRow IS NOT NULL THEN
                CALL form_events.m_DlgEvent_record1_BeforeRow(DIALOG, m_state, form_events.m_DlgCtrlInstruction)
                    RETURNING form_events.m_DlgCtrlInstruction
            END IF

            CASE form_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CANCEL_INSERT
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeRow", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
                WHEN libdbappEvents.CONTINUE_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeRow", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.EXIT_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeRow", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
            END CASE

        ON ACTION append
            {<POINT Name="dlg.record1.uiDisplay.onAction.append">} {</POINT>}
            INITIALIZE form_events.m_DlgCtrlInstruction TO NULL
            IF form_events.m_DlgEvent_record1_BeforeInsert IS NOT NULL THEN
                CALL form_events.m_DlgEvent_record1_BeforeInsert(DIALOG, m_state, form_events.m_DlgCtrlInstruction)
                    RETURNING form_events.m_DlgCtrlInstruction
            END IF
            CASE form_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CANCEL_INSERT
                    CONTINUE DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
                WHEN libdbappEvents.CONTINUE_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeInsert", "C_MODE_DISPLAY"), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.EXIT_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeInsert", "C_MODE_DISPLAY"), libdbapp_canShowDialogBox(), libdbapp_isFatal())
            END CASE

            IF form_events.m_DlgCtrlInstruction IS NULL THEN
                LET m_actionNo = C_ACTION_APPEND
                LET form_events.m_DlgCtrlInstruction = libdbappEvents.ACCEPT_DIALOG
                IF form_events.m_DlgEvent_record1_OnActionAppend IS NOT NULL THEN
                    CALL form_events.m_DlgEvent_record1_OnActionAppend(DIALOG, m_state, form_events.m_DlgCtrlInstruction)
                        RETURNING form_events.m_DlgCtrlInstruction
                END IF

                CASE form_events.m_DlgCtrlInstruction
                    WHEN libdbappEvents.ACCEPT_DIALOG
                        ACCEPT DIALOG
                    WHEN libdbappEvents.CANCEL_INSERT
                        CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "OnActionAppend", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                    WHEN libdbappEvents.CONTINUE_DIALOG
                        CONTINUE DIALOG
                    WHEN libdbappEvents.EXIT_DIALOG
                        EXIT DIALOG
                    WHEN libdbappEvents.CONTINUE_MENU
                        CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "OnActionAppend", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                    WHEN libdbappEvents.EXIT_MENU
                        CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "OnActionAppend", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                END CASE

            END IF
        ON ACTION update
            {<POINT Name="dlg.record1.uiDisplay.onAction.update">} {</POINT>}
            LET m_actionNo = C_ACTION_UPDATE

            LET form_events.m_DlgCtrlInstruction = libdbappEvents.ACCEPT_DIALOG
            IF form_events.m_DlgEvent_record1_OnActionUpdate IS NOT NULL THEN
                CALL form_events.m_DlgEvent_record1_OnActionUpdate(DIALOG, m_state, form_events.m_DlgCtrlInstruction)
                    RETURNING form_events.m_DlgCtrlInstruction
            END IF

            CASE form_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CANCEL_INSERT
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "OnActionUpdate", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
                WHEN libdbappEvents.CONTINUE_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "OnActionUpdate", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.EXIT_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "OnActionUpdate", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
            END CASE

        ON ACTION delete --DISPLAY (record1)
            {<POINT Name="dlg.record1.uiDisplay.onAction.delete">} {</POINT>}
            INITIALIZE form_events.m_DlgCtrlInstruction TO NULL
            IF form_events.m_DlgEvent_record1_BeforeDelete IS NOT NULL THEN
                CALL form_events.m_DlgEvent_record1_BeforeDelete(DIALOG, m_state, form_events.m_DlgCtrlInstruction)
                    RETURNING form_events.m_DlgCtrlInstruction
            END IF

            CASE form_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CANCEL_INSERT
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeDelete", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
                WHEN libdbappEvents.CONTINUE_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeDelete", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.EXIT_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeDelete", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
            END CASE

            CALL form_uidialog_record1_validateCRUDOperation(DIALOG, m_state, C_ACTION_DELETE) RETURNING l_internalAction
            CASE l_internalAction
                WHEN C_INTERNAL_ACTION_NEXT_FIELD_CURRENT --We remain in input mode
                    CONTINUE DIALOG
                WHEN C_INTERNAL_EXIT_DIALOG
                    EXIT DIALOG
                OTHERWISE
            END CASE
            CALL form_uidialog_record1_setActionStates(DIALOG, C_MODE_DISPLAY)
            INITIALIZE form_events.m_DlgCtrlInstruction TO NULL
            IF form_events.m_DlgEvent_record1_AfterDelete IS NOT NULL THEN
                CALL form_events.m_DlgEvent_record1_AfterDelete(DIALOG, m_state, form_events.m_DlgCtrlInstruction)
                    RETURNING form_events.m_DlgCtrlInstruction
            END IF

            CASE form_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CANCEL_INSERT
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "AfterDelete", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
                WHEN libdbappEvents.CONTINUE_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "AfterDelete", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.EXIT_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "AfterDelete", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
            END CASE

        ON FILL BUFFER
            {<POINT Name="dlg.record1.uiDisplay.onFillBuffer">} {</POINT>}
            LET m_record1_keyIndex = DIALOG.getCurrentRow("record1")
            CALL form_uidialog_record1_validateCRUDOperation(DIALOG, m_state, C_ACTION_REFRESH_CURRENT_ROW) RETURNING l_internalAction

        AFTER DISPLAY
            INITIALIZE form_events.m_DlgCtrlInstruction TO NULL
            IF form_events.m_DlgEvent_record1_AfterDisplay IS NOT NULL THEN
                CALL form_events.m_DlgEvent_record1_AfterDisplay(DIALOG, m_state, form_events.m_DlgCtrlInstruction)
                    RETURNING form_events.m_DlgCtrlInstruction
            END IF

            CASE form_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "AfterDisplay", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.CANCEL_INSERT
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "AfterDisplay", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
                WHEN libdbappEvents.CONTINUE_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "AfterDisplay", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.EXIT_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "AfterDisplay", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
            END CASE

        AFTER ROW
            INITIALIZE form_events.m_DlgCtrlInstruction TO NULL
            IF form_events.m_DlgEvent_record1_AfterRow IS NOT NULL THEN
                CALL form_events.m_DlgEvent_record1_AfterRow(DIALOG, m_state, form_events.m_DlgCtrlInstruction)
                    RETURNING form_events.m_DlgCtrlInstruction
            END IF

            CASE form_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CANCEL_INSERT
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "AfterRow", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
                WHEN libdbappEvents.CONTINUE_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "AfterRow", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.EXIT_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "AfterRow", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
            END CASE

        {<POINT Name="dlg.record1.uiDisplay.userControlBlocks">} {</POINT>}
    END DISPLAY
END DIALOG
{</BLOCK>} --dlg.record1.uiDisplay

{<BLOCK Name="dlg.record1.uiInput">}
DIALOG form_uidialog_record1_uiInput()
    DEFINE l_internalAction SMALLINT
    DEFINE errNo INTEGER

    {<POINT Name="dlg.record1.uiInput.define">} {</POINT>}

    INPUT m_record1_arrRecGrid[1].collegamento_utente,
        m_record1_arrRecGrid[1].collegamento_password,
        m_record1_arrRecGrid[1].collegamento_server,
        m_record1_arrRecGrid[1].collegamento_porta,
        m_record1_arrRecGrid[1].collegamento_database,
        m_record1_arrRecGrid[1].collegamento_modulo
    FROM  collegamento.utente,
        collegamento.password,
        collegamento.server,
        collegamento.porta,
        collegamento.database,
        collegamento.modulo
    ATTRIBUTES(WITHOUT DEFAULTS = TRUE)
        BEFORE INPUT
            {<POINT Name="dlg.record1.uiInput.beforeInput">} {</POINT>}

            --Handle the navigation between records if the navigation flag is set (i.e not equal to zero)
            IF m_navigation_direction != 0 THEN
                CALL form_uidialog_record1_navigate(DIALOG, C_MODE_MODIFY, m_navigation_direction)
                LET m_copy_record1.* = m_record1_arrRecGrid[1].* --Keep a local copy
            END IF
            LET m_navigation_direction = 0

            --Automatically set the ADD mode if there is no row in this subdialog
            IF m_state == C_MODE_MODIFY AND m_record1_arrKeyRec.getLength() == 0 THEN
                LET m_state = C_MODE_ADD
            END IF

            --Enter in this subdialog
            LET m_subDialog = "record1"
            IF initializeUI THEN
                CALL form_uidialog_record1_setFieldActive(DIALOG, m_state)
                LET initializeUI = FALSE
            END IF
            IF m_state == C_MODE_MODIFY THEN
                LET m_copy_record1.* = m_record1_arrRecGrid[1].* --Keep a local copy
            END IF

            IF m_state == C_MODE_ADD THEN
                INITIALIZE form_events.m_DlgCtrlInstruction TO NULL
                IF form_events.m_DlgEvent_record1_BeforeInsert IS NOT NULL THEN
                    CALL form_events.m_DlgEvent_record1_BeforeInsert(DIALOG, m_state, form_events.m_DlgCtrlInstruction)
                        RETURNING form_events.m_DlgCtrlInstruction
                END IF
                CASE form_events.m_DlgCtrlInstruction
                    WHEN libdbappEvents.ACCEPT_DIALOG
                        ACCEPT DIALOG
                    WHEN libdbappEvents.CANCEL_INSERT
                        LET m_state = C_MODE_MODIFY
                    WHEN libdbappEvents.CONTINUE_DIALOG
                        CONTINUE DIALOG
                    WHEN libdbappEvents.EXIT_DIALOG
                        EXIT DIALOG
                    WHEN libdbappEvents.CONTINUE_MENU
                        CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeInsert", "C_MODE_ADD"), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                    WHEN libdbappEvents.EXIT_MENU
                        CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeInsert", "C_MODE_ADD"), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                END CASE

                IF m_state == C_MODE_ADD THEN
                    CALL form_uidialog_record1_navigate(DIALOG, C_MODE_ADD, 3)
                    CALL form_uidialogdata_record1_setDefaultValues(DIALOG)
                    CALL form_uidialogdata_record1_fetchDetails()
                END IF
            END IF
            CALL form_uidialog_record1_setFieldActive(DIALOG, m_state)
            CALL form_uidialog_record1_setActionStates(DIALOG, m_state)
            CALL form_uidialog_setAllCurrentRow(DIALOG)
            IF NOT libdbapp_isMobile() THEN
                IF m_record1_arrKeyRec.getLength() > 1 THEN
                    MESSAGE m_record1_keyIndex, "/", m_record1_arrKeyRec.getLength()
                END IF
            END IF

            INITIALIZE form_events.m_DlgCtrlInstruction TO NULL
            IF form_events.m_DlgEvent_record1_BeforeInput IS NOT NULL THEN
                CALL form_events.m_DlgEvent_record1_BeforeInput(DIALOG, m_state, form_events.m_DlgCtrlInstruction)
                    RETURNING form_events.m_DlgCtrlInstruction
            END IF

            CASE form_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CANCEL_INSERT
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeInput", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
                WHEN libdbappEvents.CONTINUE_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeInput", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.EXIT_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeInput", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
            END CASE

        AFTER INPUT
            {<POINT Name="dlg.record1.uiInput.afterInput">} {</POINT>}
            INITIALIZE form_events.m_DlgCtrlInstruction TO NULL
            IF form_events.m_DlgEvent_record1_AfterInput IS NOT NULL THEN
                CALL form_events.m_DlgEvent_record1_AfterInput(DIALOG, m_state, form_events.m_DlgCtrlInstruction)
                    RETURNING form_events.m_DlgCtrlInstruction
            END IF

            CASE form_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "AfterInput", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.CANCEL_INSERT
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "AfterInput", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
                WHEN libdbappEvents.CONTINUE_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "AfterInput", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.EXIT_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "AfterInput", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
            END CASE

            CALL form_uidialog_record1_validateCRUDOperation(DIALOG, m_state, m_actionNo) RETURNING l_internalAction
            CASE l_internalAction
                WHEN C_INTERNAL_ACTION_NEXT_FIELD_CURRENT --We remain in input mode
                    CALL DIALOG.nextField(fgl_dialog_getfieldname())
                    LET m_dataProcessing = FALSE
                    CONTINUE DIALOG
                WHEN C_INTERNAL_EXIT_DIALOG
                    EXIT DIALOG
                OTHERWISE
                    LET m_state = C_MODE_MODIFY
            END CASE
            IF m_dataProcessing THEN --Skip the DVM validation because a data processing is in progress in an other subdialog
                LET form_events.m_DlgCtrlInstruction = libdbappEvents.EXIT_DIALOG
            END IF
        ON ACTION delete --MODIFY (record1)
            {<POINT Name="dlg.record1.uiInput.onAction.delete">} {</POINT>}
            INITIALIZE form_events.m_DlgCtrlInstruction TO NULL
            IF form_events.m_DlgEvent_record1_BeforeDelete IS NOT NULL THEN
                CALL form_events.m_DlgEvent_record1_BeforeDelete(DIALOG, m_state, form_events.m_DlgCtrlInstruction)
                    RETURNING form_events.m_DlgCtrlInstruction
            END IF

            CASE form_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CANCEL_INSERT
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeDelete", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
                WHEN libdbappEvents.CONTINUE_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeDelete", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.EXIT_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeDelete", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
            END CASE

            CALL form_uidialog_record1_validateCRUDOperation(DIALOG, C_MODE_MODIFY, C_ACTION_DELETE) RETURNING l_internalAction
            CASE l_internalAction
                WHEN C_INTERNAL_ACTION_NEXT_FIELD_CURRENT --We remain in input mode
                    CALL DIALOG.nextField(fgl_dialog_getfieldname())
                    LET m_dataProcessing = FALSE
                    CONTINUE DIALOG
                WHEN C_INTERNAL_EXIT_DIALOG
                    EXIT DIALOG
                OTHERWISE
                    LET m_state = C_MODE_MODIFY
            END CASE

            --Automatically set the ADD mode if there is no row in this subdialog
            IF m_state == C_MODE_MODIFY AND m_record1_arrKeyRec.getLength() == 0 THEN
                LET m_state = C_MODE_ADD
            END IF

            INITIALIZE form_events.m_DlgCtrlInstruction TO NULL
            IF form_events.m_DlgEvent_record1_AfterDelete IS NOT NULL THEN
                CALL form_events.m_DlgEvent_record1_AfterDelete(DIALOG, m_state, form_events.m_DlgCtrlInstruction)
                    RETURNING form_events.m_DlgCtrlInstruction
            END IF

            CASE form_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CANCEL_INSERT
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "AfterDelete", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
                WHEN libdbappEvents.CONTINUE_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "AfterDelete", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.EXIT_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "AfterDelete", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
            END CASE

            IF m_state == C_MODE_MODIFY THEN
                LET m_copy_record1.* = m_record1_arrRecGrid[1].* --Keep a local copy
            END IF

            IF m_state == C_MODE_ADD THEN
                CALL form_uidialog_record1_navigate(DIALOG, C_MODE_ADD, 3)
                CALL form_uidialogdata_record1_setDefaultValues(DIALOG)
                CALL form_uidialogdata_record1_fetchDetails()
            END IF
            CALL form_uidialog_record1_setFieldActive(DIALOG, m_state)
            CALL form_uidialog_record1_setActionStates(DIALOG, m_state)
            CALL form_uidialog_setAllCurrentRow(DIALOG)
            IF NOT libdbapp_isMobile() THEN
                IF m_record1_arrKeyRec.getLength() > 1 THEN
                    MESSAGE m_record1_keyIndex, "/", m_record1_arrKeyRec.getLength()
                END IF
            END IF

        ON ACTION append
            {<POINT Name="dlg.record1.uiInput.onAction.append">} {</POINT>}
            INITIALIZE form_events.m_DlgCtrlInstruction TO NULL
            IF form_events.m_DlgEvent_record1_BeforeInsert IS NOT NULL THEN
                CALL form_events.m_DlgEvent_record1_BeforeInsert(DIALOG, m_state, form_events.m_DlgCtrlInstruction)
                    RETURNING form_events.m_DlgCtrlInstruction
            END IF
            CASE form_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CANCEL_INSERT
                    CONTINUE DIALOG
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
                WHEN libdbappEvents.CONTINUE_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeInsert", "C_MODE_MODIFY"), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.EXIT_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeInsert", "C_MODE_MODIFY"), libdbapp_canShowDialogBox(), libdbapp_isFatal())
            END CASE

            IF form_events.m_DlgCtrlInstruction IS NULL THEN
                LET m_actionNo = C_ACTION_APPEND
                LET form_events.m_DlgCtrlInstruction = libdbappEvents.ACCEPT_DIALOG
                IF form_events.m_DlgEvent_record1_OnActionAppend IS NOT NULL THEN
                    CALL form_events.m_DlgEvent_record1_OnActionAppend(DIALOG, m_state, form_events.m_DlgCtrlInstruction)
                        RETURNING form_events.m_DlgCtrlInstruction
                END IF

                CASE form_events.m_DlgCtrlInstruction
                    WHEN libdbappEvents.ACCEPT_DIALOG
                        ACCEPT DIALOG
                    WHEN libdbappEvents.CANCEL_INSERT
                        CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "OnActionAppend", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                    WHEN libdbappEvents.CONTINUE_DIALOG
                        CONTINUE DIALOG
                    WHEN libdbappEvents.EXIT_DIALOG
                        EXIT DIALOG
                    WHEN libdbappEvents.CONTINUE_MENU
                        CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "OnActionAppend", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                    WHEN libdbappEvents.EXIT_MENU
                        CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "OnActionAppend", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                END CASE

            END IF

        ON ACTION dialogtouched --INPUT (record1)
            {<POINT Name="dlg.record1.uiInput.onAction.dialogtouched">} {</POINT>}
            IF m_state == C_MODE_MODIFY THEN
                CALL form_uidialog_record1_validateCRUDOperation(DIALOG, C_MODE_MODIFY, C_ACTION_DIALOGTOUCHED) RETURNING l_internalAction
                CASE l_internalAction
                    WHEN C_INTERNAL_ACTION_NEXT_FIELD_CURRENT --We remain in input mode
                        CALL DIALOG.nextField(fgl_dialog_getfieldname())
                        CONTINUE DIALOG
                    WHEN C_INTERNAL_EXIT_DIALOG
                        EXIT DIALOG
                    OTHERWISE
                        --Do nothing
                END CASE
            END IF
            CALL DIALOG.setActionActive('dialogtouched', FALSE) --disable the dialogtouched action
            CALL DIALOG.setActionActive('delete', FALSE) --disable the delete action in order to force to deletion of data that are not being modified
            IF libdbapp_isMobile() THEN
                CALL DIALOG.setActionHidden('delete', TRUE)
            END IF

        ON ACTION firstrow
            {<POINT Name="dlg.record1.uiInput.onAction.firstrow">} {</POINT>}
            LET m_actionNo = C_ACTION_UPDATE
            LET m_dataProcessing = TRUE
            LET m_navigation_direction = -2
            ACCEPT DIALOG
        ON ACTION prevrow
            {<POINT Name="dlg.record1.uiInput.onAction.prevrow">} {</POINT>}
            LET m_actionNo = C_ACTION_UPDATE
            LET m_dataProcessing = TRUE
            LET m_navigation_direction = -1
            ACCEPT DIALOG
        ON ACTION nextrow
            {<POINT Name="dlg.record1.uiInput.onAction.nextrow">} {</POINT>}
            LET m_actionNo = C_ACTION_UPDATE
            LET m_dataProcessing = TRUE
            LET m_navigation_direction = 1
            ACCEPT DIALOG
        ON ACTION lastrow
            {<POINT Name="dlg.record1.uiInput.onAction.lastrow">} {</POINT>}
            LET m_actionNo = C_ACTION_UPDATE
            LET m_dataProcessing = TRUE
            LET m_navigation_direction = 2
            ACCEPT DIALOG

        {<POINT Name="dlg.record1.uiInput.userControlBlocks">} {</POINT>}
    END INPUT
END DIALOG
{</BLOCK>} --dlg.record1.uiInput

{<BLOCK Name="dlg.record1.uiConstruct">}
DIALOG form_uidialog_record1_uiConstruct()

    {<POINT Name="dlg.record1.uiConstruct.define">} {</POINT>}

    CONSTRUCT m_record1_where
                 ON collegamento.utente,
                    collegamento.password,
                    collegamento.server,
                    collegamento.porta,
                    collegamento.database,
                    collegamento.modulo
             FROM collegamento.utente,
                    collegamento.password,
                    collegamento.server,
                    collegamento.porta,
                    collegamento.database,
                    collegamento.modulo

        BEFORE CONSTRUCT
            CALL form_uidialog_record1_setActionStates(DIALOG, C_MODE_SEARCH)
            INITIALIZE form_events.m_DlgCtrlInstruction TO NULL
            IF form_events.m_DlgEvent_record1_BeforeConstruct IS NOT NULL THEN
                CALL form_events.m_DlgEvent_record1_BeforeConstruct(DIALOG, m_state, form_events.m_DlgCtrlInstruction)
                    RETURNING form_events.m_DlgCtrlInstruction
            END IF

            CASE form_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    ACCEPT DIALOG
                WHEN libdbappEvents.CANCEL_INSERT
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeConstruct", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
                WHEN libdbappEvents.CONTINUE_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeConstruct", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.EXIT_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "BeforeConstruct", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
            END CASE

        AFTER CONSTRUCT
            INITIALIZE form_events.m_DlgCtrlInstruction TO NULL
            IF form_events.m_DlgEvent_record1_AfterConstruct IS NOT NULL THEN
                CALL form_events.m_DlgEvent_record1_AfterConstruct(DIALOG, m_state, form_events.m_DlgCtrlInstruction)
                    RETURNING form_events.m_DlgCtrlInstruction
            END IF

            CASE form_events.m_DlgCtrlInstruction
                WHEN libdbappEvents.ACCEPT_DIALOG
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "AfterConstruct", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.CANCEL_INSERT
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "AfterConstruct", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.CONTINUE_DIALOG
                    CONTINUE DIALOG
                WHEN libdbappEvents.EXIT_DIALOG
                    EXIT DIALOG
                WHEN libdbappEvents.CONTINUE_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "AfterConstruct", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
                WHEN libdbappEvents.EXIT_MENU
                    CALL libdbapp_showError(__FILE__, __LINE__, "GS-13173", libdbapp_makeMessage(form_events.m_DlgCtrlInstruction, "AfterConstruct", NULL), libdbapp_canShowDialogBox(), libdbapp_isFatal())
            END CASE

        {<POINT Name="dlg.record1.uiConstruct.userControlBlocks">} {</POINT>}
    END CONSTRUCT
END DIALOG
{</BLOCK>} --dlg.record1.uiConstruct

--------------------------------------------------------------------------------
--Functions
{<BLOCK Name="fct.record1_validateCRUDOperation">}
#+ Validate a CRUD operation for 'record1' (INSERT, UPDATE, DELETE)
#+
#+ @param p_dialog The current DIALOG
#+ @param p_state The current state
#+ @param p_action The action which triggered the CRUD operation
#+
#+ @returnType SMALLINT
#+ @return The internal action
FUNCTION form_uidialog_record1_validateCRUDOperation(p_dialog, p_state, p_action)
    DEFINE p_dialog ui.Dialog
    DEFINE p_state SMALLINT
    DEFINE p_action SMALLINT
    DEFINE l_rec_br_uk record1_br_uk_type --key returned by INSERT operation
    DEFINE l_recordTouched BOOLEAN --TRUE if at least one field of the record was touched, else FALSE
    DEFINE l_requestConfirmation BOOLEAN
    DEFINE l_internalAction SMALLINT
    DEFINE l_action SMALLINT
    {<POINT Name="fct.record1_validateCRUDOperation.define">} {</POINT>}
    INITIALIZE l_rec_br_uk.* TO NULL
    LET l_requestConfirmation = IIF((p_action == C_ACTION_ACCEPT) || (p_action == C_ACTION_DIALOGTOUCHED) || (p_action == C_ACTION_REFRESH_CURRENT_ROW) || (p_action == C_ACTION_REFRESH_ALL_ROWS), FALSE, TRUE)
    CASE p_action
        WHEN C_ACTION_REFRESH_CURRENT_ROW
            LET l_internalAction = C_INTERNAL_ACTION_REFRESH_CURRENT_ROW
        WHEN C_ACTION_REFRESH_ALL_ROWS
            LET l_internalAction = C_INTERNAL_ACTION_REFRESH_ALL_ROWS
        OTHERWISE
            LET l_internalAction = C_INTERNAL_ACTION_PROCESS_OPERATION
    END CASE
    LET l_recordTouched = form_uidialog_hasFieldTouched(p_dialog, "record1", p_state)
    {<POINT Name="fct.record1_validateCRUDOperation.init">} {</POINT>}

    IF p_action == C_ACTION_CANCEL THEN
        LET l_requestConfirmation = FALSE
        IF p_state == C_MODE_MODIFY THEN
            LET l_internalAction = C_INTERNAL_ACTION_RESTORE_DATA
        END IF
        IF p_state == C_MODE_ADD THEN
            LET l_internalAction = C_INTERNAL_ACTION_CANCEL_ROW_CREATION --Only for the grid container and on row creation, data of the current index are re-fetched because this index still references the previous record
        END IF
    END IF

    --Check if the user has not started to modify the current record and he didn't want to delete the current record
    IF NOT l_recordTouched AND p_action != C_ACTION_DELETE THEN
        LET l_requestConfirmation = FALSE
        LET l_internalAction = C_INTERNAL_ACTION_SYNC_UI_COMPONENTS
        IF p_state == C_MODE_ADD THEN
            LET l_internalAction = C_INTERNAL_ACTION_CANCEL_ROW_CREATION --Only for the grid container and on row creation, if the user didn't started to modify data, then data of the current index are re-fetched because this index still references the previous record
        END IF
        IF p_state == C_MODE_DISPLAY OR p_state == C_MODE_MODIFY THEN
            IF p_action == C_ACTION_REFRESH_CURRENT_ROW THEN
                LET l_internalAction = C_INTERNAL_ACTION_REFRESH_CURRENT_ROW
            END IF
            IF p_action == C_ACTION_REFRESH_ALL_ROWS THEN
                LET l_internalAction = C_INTERNAL_ACTION_REFRESH_ALL_ROWS
            END IF
        END IF
    END IF
    --Check if an user confirmation is requested
    IF l_requestConfirmation THEN
        CALL libdbapp_utilConfirmCRUDOperation(p_action) RETURNING l_internalAction
    END IF
    --Check if the operation must be performed
    IF l_internalAction == C_INTERNAL_ACTION_PROCESS_OPERATION THEN
        LET l_action = p_action
        IF l_action != C_ACTION_DELETE AND l_action != C_ACTION_DIALOGTOUCHED THEN
            IF p_state == C_MODE_ADD THEN
                LET l_action = C_ACTION_APPEND
            END IF
            IF p_state == C_MODE_MODIFY THEN
                LET l_action = C_ACTION_UPDATE
            END IF
        END IF
        CALL form_uidialog_record1_processCRUDOperation(l_action) RETURNING l_internalAction, l_rec_br_uk.*
    END IF
    IF l_internalAction != C_INTERNAL_ACTION_NEXT_FIELD_CURRENT AND l_internalAction != C_INTERNAL_EXIT_DIALOG THEN
        --call synchronize
        IF l_internalAction != C_INTERNAL_ACTION_NO_SYNC THEN
            CALL form_uidialog_record1_synchronizeUI(p_dialog, p_state, l_internalAction, l_rec_br_uk.*) RETURNING m_copy_record1.*
        END IF
        IF p_action == C_ACTION_DIALOGTOUCHED AND (l_internalAction == C_INTERNAL_ACTION_REFRESH_DATA OR l_internalAction == C_INTERNAL_ACTION_DELETE_DATA) THEN
            LET l_internalAction = C_INTERNAL_ACTION_NEXT_FIELD_CURRENT
        ELSE
            LET l_internalAction = C_INTERNAL_ACTION_SUCCESS
            IF p_action == C_ACTION_EXIT_APP THEN
                LET l_internalAction = C_INTERNAL_EXIT_DIALOG
            END IF
        END IF
    END IF
    RETURN l_internalAction
END FUNCTION
{</BLOCK>} --fct.record1_validateCRUDOperation

{<BLOCK Name="fct.record1_processCRUDOperation">}
#+ Process a CRUD operation for 'record1' (INSERT, UPDATE, DELETE, Check the concurrent access)
#+
#+ @param p_action The action which triggered the CRUD operation
#+
#+ @returnType SMALLINT, record1_br_uk_type
#+ @return The internal action
#+ @return The Business Record (BR) Unique Key (UK)
FUNCTION form_uidialog_record1_processCRUDOperation(p_action)
    DEFINE p_action SMALLINT
    DEFINE l_internalAction SMALLINT
    DEFINE l_rec_br_uk record1_br_uk_type --key returned by INSERT operation
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.record1_processCRUDOperation.define">} {</POINT>}
    {<POINT Name="fct.record1_processCRUDOperation.init">} {</POINT>}
    INITIALIZE l_rec_br_uk.* TO NULL
    --The input of the current row is going to be save
    CASE p_action
        WHEN C_ACTION_APPEND --Insert the row in the database
            CALL form_uidata.form_uidata_record1_insertRow(m_record1_arrRecGrid[1].*) RETURNING errNo, errMsg, l_rec_br_uk.*
        WHEN C_ACTION_UPDATE --Update the row in the database
            CALL form_uidata.form_uidata_record1_updateRow(m_record1_arrRecGrid[1].*, m_record1_arrRecDB[1].*) RETURNING errNo, errMsg
        WHEN C_ACTION_DIALOGTOUCHED --Check the row in the database
            CALL form_uidata.form_uidata_record1_checkRowConcurrentAccess(m_record1_arrRecDB[1].*) RETURNING errNo, errMsg

        WHEN C_ACTION_DELETE --Delete the row in the database
            CALL form_uidata.form_uidata_record1_deleteRowWithConcurrentAccess(m_record1_arrRecDB[1].*) RETURNING errNo, errMsg
        OTHERWISE
         -- unexpected error
    END CASE
    --Treat the result of the saving
    CASE errNo
        WHEN ERROR_SUCCESS
            CASE p_action
                WHEN C_ACTION_APPEND
                    LET l_internalAction = C_INTERNAL_ACTION_SUCCESS
                WHEN C_ACTION_UPDATE
                    LET l_internalAction = C_INTERNAL_ACTION_SUCCESS
                WHEN C_ACTION_DIALOGTOUCHED
                    LET l_internalAction = C_INTERNAL_ACTION_NO_SYNC
                WHEN C_ACTION_DELETE
                    LET l_internalAction = C_INTERNAL_ACTION_DELETE_DATA
                OTHERWISE
                    --unexpected error
            END CASE
            CALL libdbapp_utilMsgStatusBar(errNo, errMsg)
        WHEN ERROR_FAILURE
            LET l_internalAction = C_INTERNAL_ACTION_NEXT_FIELD_CURRENT --We remain in input mode
            CALL libdbapp_utilMsgStatusBar(errNo, errMsg)
        WHEN ERROR_CONCURRENT_ACCESS_FAILURE
            LET l_internalAction = C_INTERNAL_ACTION_NEXT_FIELD_CURRENT --We remain in input mode
            IF libdbapp_utilMsgBox(C_TXT_WARNING_TITLE, errMsg, C_BTN_OK_CANCEL, C_OK, C_ICON_WARNING) == C_OK THEN
                LET l_internalAction = C_INTERNAL_ACTION_REFRESH_DATA
            END IF
        WHEN ERROR_CONCURRENT_ACCESS_NOTFOUND
            LET l_internalAction = C_INTERNAL_ACTION_NEXT_FIELD_CURRENT --We remain in input mode
            IF libdbapp_utilMsgBox(C_TXT_WARNING_TITLE, errMsg, C_BTN_OK_CANCEL, C_OK, C_ICON_WARNING) == C_OK THEN
                LET l_internalAction = C_INTERNAL_ACTION_DELETE_DATA
            END IF
        WHEN ERROR_DELETE_CASCADE_ROW_USED
            LET l_internalAction = C_INTERNAL_ACTION_NEXT_FIELD_CURRENT --We remain in input mode
            CALL libdbapp_utilMsgStatusBar(errNo, errMsg)
        OTHERWISE --Unexpected error
    END CASE

    RETURN l_internalAction, l_rec_br_uk.*
END FUNCTION
{</BLOCK>} --fct.record1_processCRUDOperation

{<BLOCK Name="fct.record1_synchronizeUI">}
#+ Synchronize the UI according an internal action returned by a CRUD operation for 'record1'
#+
#+ @param p_dialog The current DIALOG
#+ @param p_state The current state
#+ @param p_internalAction A internal action
#+ @param p_rec_br_uk The Business Record (BR) Unique Key (UK)
#+
#+ @returnType record1_br_type
#+ @return The local copy of the current row
FUNCTION form_uidialog_record1_synchronizeUI(p_dialog, p_state, p_internalAction, p_rec_br_uk)
    DEFINE p_dialog ui.Dialog
    DEFINE p_state SMALLINT
    DEFINE p_internalAction SMALLINT
    DEFINE p_rec_br_uk record1_br_uk_type
    DEFINE l_internalAction SMALLINT
    DEFINE l_continue BOOLEAN
    DEFINE errNo INTEGER
    {<POINT Name="fct.record1_synchronizeUI.define">} {</POINT>}
    {<POINT Name="fct.record1_synchronizeUI.init">} {</POINT>}

    --Synchronize UI data
    LET l_internalAction = p_internalAction
    LET l_continue = TRUE
    WHILE l_continue
        LET l_continue = FALSE
        CASE l_internalAction
            WHEN C_INTERNAL_ACTION_SUCCESS
                IF p_state == C_MODE_ADD THEN
                    LET m_record1_arrKeyRec[m_record1_keyIndex].* = p_rec_br_uk.* --Update key values in the new item in the array of keys
                    LET m_record1_arrRecGrid[1].collegamento_utente = p_rec_br_uk.collegamento_utente --Refresh the inserted key value in the UI (may be a composite key) (Useful in the case of SERIALS which are known after the INSERT sql statement)
                END IF
                CALL form_uidialogdata_record1_fetchRowAndDetails() RETURNING errNo --Done to update the m_record1_arrRecDB
                IF errNo == ERROR_NOTFOUND THEN
                    LET l_internalAction = C_INTERNAL_ACTION_DELETE_DATA
                    LET l_continue = TRUE
                    CONTINUE WHILE
                END IF

            WHEN C_INTERNAL_ACTION_REFRESH_DATA
                CALL form_uidialogdata_record1_fetchRowAndDetails() RETURNING errNo --Done to update the m_record1_arrRecDB
                IF errNo == ERROR_NOTFOUND THEN
                    LET l_internalAction = C_INTERNAL_ACTION_DELETE_DATA
                    LET l_continue = TRUE
                    CONTINUE WHILE
                END IF

            WHEN C_INTERNAL_ACTION_REFRESH_CURRENT_ROW
                CALL form_uidialogdata_record1_fetchRowAndDetails() RETURNING errNo
                IF errNo == ERROR_NOTFOUND THEN
                    LET l_internalAction = C_INTERNAL_ACTION_DELETE_DATA
                    LET l_continue = TRUE
                    CONTINUE WHILE
                END IF

            WHEN C_INTERNAL_ACTION_REFRESH_ALL_ROWS
                CALL form_uidialogdata_record1_fetchAll(m_where, m_detailList)

            WHEN C_INTERNAL_ACTION_RESTORE_DATA
                IF p_state == C_MODE_MODIFY THEN
                    LET m_record1_arrRecGrid[1].* = m_copy_record1.* --Restore a local copy
                    LET M_errMsg = C_TXT_DATA_RESTORED
                END IF
                IF p_state == C_MODE_ADD THEN
                    CALL m_record1_arrKeyRec.deleteElement(m_record1_keyIndex) --Delete the key in the array of keys
                    LET m_record1_keyIndex = libdbapp_setRowIndex(m_record1_keyIndex, m_record1_arrKeyRec.getLength())
                    --As the current item has been removed, the next item took its place,
                    --therefore just fetch data for the current index which points now to the next item
                    CALL form_uidialog_record1_validateCRUDOperation(p_dialog, p_state, C_ACTION_REFRESH_CURRENT_ROW) RETURNING l_internalAction
                END IF

            WHEN C_INTERNAL_ACTION_DELETE_DATA
                CALL m_record1_arrKeyRec.deleteElement(m_record1_keyIndex) --Delete the key in the array of keys
                LET m_record1_keyIndex = libdbapp_setRowIndex(m_record1_keyIndex, m_record1_arrKeyRec.getLength())
                --As the current item has been removed, the next item took its place,
                --therefore just fetch data for the current index which points now to the next item
                IF p_state == C_MODE_DISPLAY THEN
                    CALL p_dialog.setArrayLength("record1", m_record1_arrKeyRec.getLength())
                    IF NOT libdbapp_isMobile() THEN
                        IF m_record1_arrKeyRec.getLength() > 1 THEN
                            MESSAGE m_record1_keyIndex, "/", m_record1_arrKeyRec.getLength()
                        END IF
                    END IF
                ELSE
                    CALL form_uidialogdata_record1_fetchRowAndDetails() RETURNING errNo
                    IF errNo == ERROR_NOTFOUND THEN
                        LET l_internalAction = C_INTERNAL_ACTION_DELETE_DATA
                        LET l_continue = TRUE
                        CONTINUE WHILE
                    END IF
                END IF

            WHEN C_INTERNAL_ACTION_CANCEL_ROW_CREATION
                CALL m_record1_arrKeyRec.deleteElement(m_record1_keyIndex) --Delete the key in the array of keys
                LET m_record1_keyIndex = libdbapp_setRowIndex(m_record1_keyIndex, m_record1_arrKeyRec.getLength())
                --As the current item has been removed, the next item took its place,
                --therefore just fetch data for the current index which points now to the next item
                CALL form_uidialogdata_record1_fetchRowAndDetails() RETURNING errNo
                IF errNo == ERROR_NOTFOUND THEN
                    LET l_internalAction = C_INTERNAL_ACTION_DELETE_DATA
                    LET l_continue = TRUE
                    CONTINUE WHILE
                END IF
            OTHERWISE
                --Unexpected error
        END CASE
    END WHILE
    --Synchronize UI components
    IF p_state != C_MODE_DISPLAY THEN
        LET p_state = C_MODE_MODIFY
        CALL p_dialog.setActionActive('dialogtouched', TRUE) --Reset 'touched' flag
        CALL form_uidialog_resetFieldTouched(p_dialog, "record1")
        CALL form_uidialog_record1_setFieldActive(p_dialog, p_state)
    END IF
    IF (p_state != C_MODE_DISPLAY) THEN
        CALL form_uidialog_record1_setActionStates(p_dialog, p_state)
    END IF
    LET m_copy_record1.* = m_record1_arrRecGrid[1].* --Keep a local copy
    RETURN m_copy_record1.*
END FUNCTION
{</BLOCK>} --fct.record1_synchronizeUI

{<BLOCK Name="fct.setActionStates">}
#+ Sets the state of the dialog actions to active or inactive according to the mode
#+
#+ @param p_dialog      The current DIALOG
#+ @param p_mode        The current mode
FUNCTION form_uidialog_setActionStates(p_dialog, p_mode)
    DEFINE p_dialog ui.Dialog
    DEFINE p_mode SMALLINT
    {<POINT Name="fct.setActionStates.define">} {</POINT>}
    {<POINT Name="fct.setActionStates.init">} {</POINT>}

    CASE p_mode
        WHEN C_MODE_DISPLAY
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionActive('new', FALSE)
                CALL p_dialog.setActionHidden('new', TRUE)
            ELSE
                CALL p_dialog.setActionActive('new', NOT m_uiSettings.disableAdd)
                CALL p_dialog.setActionHidden('new', m_uiSettings.disableAdd)
            END IF
            CALL p_dialog.setActionActive('query', NOT m_uiSettings.disableSearch)
            CALL p_dialog.setActionHidden('query', m_uiSettings.disableSearch)
            CALL p_dialog.setActionActive('accept', FALSE)
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionHidden('accept', TRUE)
            END IF
            CALL p_dialog.setActionActive('cancel', FALSE)
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionHidden('cancel', TRUE)
            END IF
            {<POINT Name="fct.setActionStates.initDisplay">} {</POINT>}
        WHEN C_MODE_MODIFY
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionActive('new', FALSE)
                CALL p_dialog.setActionHidden('new', TRUE)
            ELSE
                CALL p_dialog.setActionActive('new', NOT m_uiSettings.disableAdd)
                CALL p_dialog.setActionHidden('new', m_uiSettings.disableAdd)
            END IF
            CALL p_dialog.setActionActive('accept', TRUE)
            CALL p_dialog.setActionActive('cancel', TRUE)
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionHidden('accept', FALSE)
                CALL p_dialog.setActionHidden('cancel', FALSE)
            END IF
            {<POINT Name="fct.setActionStates.initModify">} {</POINT>}
        WHEN C_MODE_ADD
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionActive('new', FALSE)
                CALL p_dialog.setActionHidden('new', TRUE)
            ELSE
                CALL p_dialog.setActionActive('new', FALSE)
                CALL p_dialog.setActionHidden('new', m_uiSettings.disableAdd)
            END IF
            CALL p_dialog.setActionActive('accept', TRUE)
            CALL p_dialog.setActionActive('cancel', TRUE)
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionHidden('accept', FALSE)
                CALL p_dialog.setActionHidden('cancel', FALSE)
            END IF
            {<POINT Name="fct.setActionStates.initAdd">} {</POINT>}
        WHEN C_MODE_SEARCH
            {<POINT Name="fct.setActionStates.initSearch">} {</POINT>}
        WHEN C_MODE_EMPTY
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionActive('new', FALSE)
                CALL p_dialog.setActionHidden('new', TRUE)
            ELSE
                CALL p_dialog.setActionActive('new', NOT m_uiSettings.disableAdd)
                CALL p_dialog.setActionHidden('new', m_uiSettings.disableAdd)
            END IF
            CALL p_dialog.setActionActive('query', NOT m_uiSettings.disableSearch)
            CALL p_dialog.setActionHidden('query', m_uiSettings.disableSearch)
            {<POINT Name="fct.setActionStates.initEmpty">} {</POINT>}
        OTHERWISE
            DISPLAY "unknown mode  ", p_mode
    END CASE

    IF form_events.m_DlgEvent_OnActionStatesChange IS NOT NULL THEN
        CALL form_events.m_DlgEvent_OnActionStatesChange(p_dialog, p_mode)
    END IF
END FUNCTION
{</BLOCK>} --fct.setActionStates

{<BLOCK Name="fct.record1_setActionStates">}
#+ Sets for 'record1' the state of the actions to active or inactive
#+
#+ @param p_dialog      The current DIALOG
#+ @param p_mode        The current mode
FUNCTION form_uidialog_record1_setActionStates(p_dialog, p_mode)
    DEFINE p_dialog ui.Dialog
    DEFINE p_mode SMALLINT
    {<POINT Name="fct.record1_setActionStates.define">} {</POINT>}

    --Sets the state of the DIALOG actions
    CALL form_uidialog_setActionStates(p_dialog, p_mode)
    {<POINT Name="fct.record1_setActionStates.init">} {</POINT>}
    --Sets the state of the subDialog actions
    CASE p_mode
        WHEN C_MODE_DISPLAY
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionActive('append', NOT m_uiSettings.disableAdd)
                CALL p_dialog.setActionHidden('append', m_uiSettings.disableAdd)
            ELSE
                CALL p_dialog.setActionActive('append', FALSE)
                CALL p_dialog.setActionHidden('append', TRUE)
            END IF
            CALL p_dialog.setActionActive('update', m_record1_arrKeyRec.getLength() > 0 AND NOT m_uiSettings.disableModify)
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionHidden('update', NOT (m_record1_arrKeyRec.getLength() > 0 AND NOT m_uiSettings.disableModify))
            ELSE
                CALL p_dialog.setActionHidden('update', m_uiSettings.disableModify)
            END IF
            CALL p_dialog.setActionActive('delete', m_record1_arrKeyRec.getLength() > 0 AND NOT m_uiSettings.disableDelete)
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionHidden('delete', NOT (m_record1_arrKeyRec.getLength() > 0 AND NOT m_uiSettings.disableDelete))
            ELSE
                CALL p_dialog.setActionHidden('delete', m_uiSettings.disableDelete)
            END IF
            IF m_record1_arrKeyRec.getLength() <= 1 THEN
                CALL p_dialog.setActionActive('firstrow', FALSE)
                CALL p_dialog.setActionHidden('firstrow', TRUE)
                CALL p_dialog.setActionActive('prevrow', FALSE)
                CALL p_dialog.setActionHidden('prevrow', TRUE)
                CALL p_dialog.setActionActive('nextrow', FALSE)
                CALL p_dialog.setActionHidden('nextrow', TRUE)
                CALL p_dialog.setActionActive('lastrow', FALSE)
                CALL p_dialog.setActionHidden('lastrow', TRUE)
            END IF
            {<POINT Name="fct.record1_setActionStates.initDisplay">} {</POINT>}
        WHEN C_MODE_MODIFY
            --Sets the state of the navigation actions
            CALL libdbapp_setNavigationActionStates(p_dialog, m_record1_keyIndex, m_record1_arrKeyRec.getLength())
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionActive('append', NOT m_uiSettings.disableAdd)
                CALL p_dialog.setActionHidden('append', m_uiSettings.disableAdd)
            ELSE
                CALL p_dialog.setActionActive('append', FALSE)
                CALL p_dialog.setActionHidden('append', TRUE)
            END IF
            CALL p_dialog.setActionActive('delete', m_record1_arrKeyRec.getLength() > 0 AND NOT m_uiSettings.disableDelete)
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionHidden('delete', NOT (m_record1_arrKeyRec.getLength() > 0 AND NOT m_uiSettings.disableDelete))
            ELSE
                CALL p_dialog.setActionHidden('delete', m_uiSettings.disableDelete)
            END IF
            CALL p_dialog.setActionActive('query', NOT m_uiSettings.disableSearch)
            CALL p_dialog.setActionHidden('query', m_uiSettings.disableSearch)
            IF m_record1_arrKeyRec.getLength() <= 1 THEN
                CALL p_dialog.setActionActive('firstrow', FALSE)
                CALL p_dialog.setActionHidden('firstrow', TRUE)
                CALL p_dialog.setActionActive('prevrow', FALSE)
                CALL p_dialog.setActionHidden('prevrow', TRUE)
                CALL p_dialog.setActionActive('nextrow', FALSE)
                CALL p_dialog.setActionHidden('nextrow', TRUE)
                CALL p_dialog.setActionActive('lastrow', FALSE)
                CALL p_dialog.setActionHidden('lastrow', TRUE)
            END IF
            {<POINT Name="fct.record1_setActionStates.initModify">} {</POINT>}
        WHEN C_MODE_ADD
            --Sets the state of the navigation actions
            CALL libdbapp_setNavigationActionStates(p_dialog, 0, 0)
            CALL p_dialog.setActionHidden('firstrow', TRUE)
            CALL p_dialog.setActionHidden('prevrow', TRUE)
            CALL p_dialog.setActionHidden('nextrow', TRUE)
            CALL p_dialog.setActionHidden('lastrow', TRUE)
            CALL p_dialog.setActionActive('append', FALSE)
            CALL p_dialog.setActionHidden('append', TRUE)
            CALL p_dialog.setActionActive('delete', FALSE)
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionHidden('delete', TRUE)
            ELSE
                CALL p_dialog.setActionHidden('delete', m_uiSettings.disableDelete)
            END IF
            CALL p_dialog.setActionActive('query', NOT m_uiSettings.disableSearch)
            CALL p_dialog.setActionHidden('query', m_uiSettings.disableSearch)
            {<POINT Name="fct.record1_setActionStates.initAdd">} {</POINT>}
        WHEN C_MODE_SEARCH
            {<POINT Name="fct.record1_setActionStates.initSearch">} {</POINT>}
        WHEN C_MODE_EMPTY
            IF libdbapp_isMobile() THEN
                CALL p_dialog.setActionActive('append', NOT m_uiSettings.disableAdd)
                CALL p_dialog.setActionHidden('append', m_uiSettings.disableAdd)
            ELSE
                CALL p_dialog.setActionActive('append', FALSE)
                CALL p_dialog.setActionHidden('append', TRUE)
            END IF
            {<POINT Name="fct.record1_setActionStates.initEmpty">} {</POINT>}
        OTHERWISE
            DISPLAY "unknown mode  ", p_mode
    END CASE

    IF form_events.m_DlgEvent_record1_OnActionStatesChange IS NOT NULL THEN
        CALL form_events.m_DlgEvent_record1_OnActionStatesChange(p_dialog, p_mode)
    END IF
END FUNCTION
{</BLOCK>} --fct.record1_setActionStates

{<BLOCK Name="fct.record1_setFieldActive">}
#+ Initialize fields state of 'record1' according to startup state
#+
#+ All 'noEntry' fields are not enabled/disabled by programming
#+
#+ The fields that satisfy at least one of the following conditions are ALWAYS disabled:
#+  o fields that are not on the master table and which do not trigger ascending lookups
#+  o formonly fields
#+  o BR relation fields (foreignFields) of details
#+  o DB foreignKey fields of details
#+  o fields which trigger ascending lookups and update BR relation fields (foreignFields) of details
#+  o fields which trigger ascending lookups and update DB foreignKey fields of details
#+
#+ The fields that satisfy at least one of the following conditions are disabled in MODIFY mode:
#+  o fields that are unique keys
#+  o fields that are primary keys
#+  o fields which trigger ascending lookups and update unique keys
#+  o fields which trigger ascending lookups and update primary keys
#+
#+ @param p_dialog     The current DIALOG
#+ @param p_state      The startup state
PUBLIC FUNCTION form_uidialog_record1_setFieldActive(p_dialog, p_state)
    DEFINE p_dialog ui.Dialog
    DEFINE p_state SMALLINT
    {<POINT Name="fct.record1_setFieldActive.define">} {</POINT>}
    {<POINT Name="fct.record1_setFieldActive.init">} {</POINT>}

    CALL p_dialog.setFieldActive("collegamento.utente", p_state == C_MODE_ADD)

    {<POINT Name="fct.record1_setFieldActive.user">} {</POINT>}
    IF form_events.m_DlgEvent_record1_OnFieldsActivation IS NOT NULL THEN
        CALL form_events.m_DlgEvent_record1_OnFieldsActivation(p_dialog, p_state)
    END IF
END FUNCTION
{</BLOCK>} --fct.record1_setFieldActive

{<BLOCK Name="fct.hasFieldTouched">}
#+ Return true if a field has been touched in the given DIALOG, FALSE otherwise
#+
#+ @param p_dialog The current DIALOG
#+ @param p_subDialog  The subDialog name
#+ @param p_mode       A mode
#+ @returnType         BOOLEAN
#+ @return             TRUE is a field has been touched, FALSE otherwise
PUBLIC FUNCTION form_uidialog_hasFieldTouched(p_dialog, p_subDialog, p_mode)
    DEFINE p_dialog ui.Dialog
    DEFINE p_subDialog STRING
    DEFINE p_mode SMALLINT
    {<POINT Name="fct.hasFieldTouched.define">} {</POINT>}
    {<POINT Name="fct.hasFieldTouched.init">} {</POINT>}

    IF p_mode == C_MODE_DISPLAY THEN
        RETURN FALSE
    END IF
    CASE p_subDialog
        WHEN "record1"
            RETURN p_dialog.getFieldTouched("collegamento.utente") OR p_dialog.getFieldTouched("collegamento.password") OR p_dialog.getFieldTouched("collegamento.server") OR p_dialog.getFieldTouched("collegamento.porta") OR p_dialog.getFieldTouched("collegamento.database") OR p_dialog.getFieldTouched("collegamento.modulo")
    END CASE
    RETURN FALSE
END FUNCTION
{</BLOCK>} --fct.hasFieldTouched

{<BLOCK Name="fct.resetFieldTouched">}
#+ Return true if a field has been touched in the given DIALOG, FALSE otherwise
#+
#+ @param p_dialog The current DIALOG
#+ @param p_subDialog  The subDialog name
PUBLIC FUNCTION form_uidialog_resetFieldTouched(p_dialog, p_subDialog)
    DEFINE p_dialog ui.Dialog
    DEFINE p_subDialog STRING
    {<POINT Name="fct.resetFieldTouched.define">} {</POINT>}
    {<POINT Name="fct.resetFieldTouched.init">} {</POINT>}

    CASE p_subDialog
        WHEN "record1"
            CALL p_dialog.setFieldTouched("collegamento.utente", FALSE)
            CALL p_dialog.setFieldTouched("collegamento.password", FALSE)
            CALL p_dialog.setFieldTouched("collegamento.server", FALSE)
            CALL p_dialog.setFieldTouched("collegamento.porta", FALSE)
            CALL p_dialog.setFieldTouched("collegamento.database", FALSE)
            CALL p_dialog.setFieldTouched("collegamento.modulo", FALSE)
    END CASE
END FUNCTION
{</BLOCK>} --fct.resetFieldTouched

{<BLOCK Name="fct.record1_navigate">}
#+ Navigation for 'record1'
#+
#+ @param p_dialog    The current DIALOG
#+ @param p_state     The current state
#+ @param p_direction The direction
#+                    0 (otherwise) to fetch the current index
#+                    1 or -1 for next/previous respectively
#+                    2 or -2 for lastrow/firstrow respectively
#+                    3 to add a row
FUNCTION form_uidialog_record1_navigate(p_dialog, p_state, p_direction)
    DEFINE p_dialog ui.Dialog
    DEFINE p_state SMALLINT
    DEFINE p_direction SMALLINT
    DEFINE l_internalAction SMALLINT
    {<POINT Name="fct.record1_navigate.define">} {</POINT>}
    {<POINT Name="fct.record1_navigate.init">} {</POINT>}
    CASE p_direction
        WHEN -2 --firstrow
                LET m_record1_keyIndex = libdbapp_setRowIndex(1, m_record1_arrKeyRec.getLength())
        WHEN -1 --prevrow
                LET m_record1_keyIndex = libdbapp_setRowIndex(m_record1_keyIndex - 1, m_record1_arrKeyRec.getLength())
        WHEN 1 --nextrow
                LET m_record1_keyIndex = libdbapp_setRowIndex(m_record1_keyIndex + 1, m_record1_arrKeyRec.getLength())
        WHEN 2 --lastrow
                LET m_record1_keyIndex = libdbapp_setRowIndex(m_record1_arrKeyRec.getLength(), m_record1_arrKeyRec.getLength())
        WHEN 3 --add a row
                LET m_record1_keyIndex = libdbapp_setRowIndex(m_record1_arrKeyRec.getLength() + 1, m_record1_arrKeyRec.getLength() + 1)
                CALL m_record1_arrKeyRec.insertElement(m_record1_keyIndex) --Add an item in the array of keys with the new index
    END CASE
    IF p_direction != 3 THEN
        CALL form_uidialog_record1_validateCRUDOperation(p_dialog, p_state, C_ACTION_REFRESH_CURRENT_ROW) RETURNING l_internalAction
    END IF
    CALL form_uidialog_record1_setFieldActive(p_dialog, p_state)
    CALL form_uidialog_record1_setActionStates(p_dialog, p_state)
    IF NOT libdbapp_isMobile() THEN
        IF m_record1_arrKeyRec.getLength() > 1 THEN
            MESSAGE m_record1_keyIndex, "/", m_record1_arrKeyRec.getLength()
        END IF
    END IF
END FUNCTION
{</BLOCK>} --fct.record1_navigate

{<BLOCK Name="fct.setAllCurrentRow">}
#+ Set the current row on all subdialogs whose container is a 'table' to restore the context
#+
#+ @param p_dialog The current DIALOG
PUBLIC FUNCTION form_uidialog_setAllCurrentRow(p_dialog)
    DEFINE p_dialog ui.Dialog
    {<POINT Name="fct.setAllCurrentRow.define">} {</POINT>}
    {<POINT Name="fct.setAllCurrentRow.init">} {</POINT>}

    IF m_state == C_MODE_DISPLAY THEN
        CALL p_dialog.setCurrentRow("record1", m_record1_keyIndex)
    END IF
END FUNCTION
{</BLOCK>} --fct.setAllCurrentRow

#+ Empty function used to load module
PUBLIC FUNCTION form_uidialog_preloadModule()
END FUNCTION
--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions">} {</POINT>}