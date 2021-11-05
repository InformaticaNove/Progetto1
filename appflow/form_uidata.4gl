{<CODEFILE Path="form.code" Hash="1B2M2Y8AsgTpgAmY7PhCfg==" />}
#+ User Interface - Data Management

--------------------------------------------------------------------------------
--This code is generated with the template dbapp5.0
--Warning: Enter your changes within a <BLOCK> or <POINT> section, otherwise they will be lost.
{<POINT Name="user.comments">} {</POINT>}

--------------------------------------------------------------------------------
--Importing modules
IMPORT FGL libdbappCore
IMPORT FGL libdbappSql
IMPORT FGL libdbappEvents

IMPORT FGL mydatabase_dbxdata
IMPORT FGL form_common
IMPORT FGL form_events
{<POINT Name="import">} {</POINT>}

-- Database schema
SCHEMA mydatabase

--------------------------------------------------------------------------------
--Definition of constants, user-types, variables

{<POINT Name="define">} {</POINT>}

--------------------------------------------------------------------------------
--Functions

{<BLOCK Name="fct.record1_getKeys">}
#+ Create and fill a dynamic array of Business Record(BR) Unique Keys (UK) for record1
#+
#+ @param p_arr_br_uk The array of Business Record(BR) Unique Keys (UK)
#+ @param p_where The where clause of the query
#+ @param p_detailList List of details on whom a CONSTRUCT was done
#+ @returnType INTEGER, record1_br_uk_type
#+ @return Error number, 0-success, other-error
#+ @return p_arr_br_uk
PUBLIC FUNCTION form_uidata_record1_getKeys(p_arr_br_uk, p_where, p_detailList)
    --Declaration of parameters
    DEFINE p_arr_br_uk DYNAMIC ARRAY OF record1_br_uk_type
    DEFINE p_where STRING
    DEFINE p_detailList STRING
    --Declaration of local types, variables, constants
    DEFINE l_select, l_from, l_where, l_orderBy STRING
    DEFINE l_sqlQuery STRING --The SELECT SQL statement to retrieve keys of records
    DEFINE l_rec_data record1_br_uk_type
    DEFINE l_distinct STRING
    DEFINE l_detailListTok base.StringTokenizer
    DEFINE l_tokValue STRING
    {<POINT Name="fct.record1_getKeys.define">} {</POINT>}

    CALL p_arr_br_uk.clear()
    LET l_from = ' FROM
    collegamento
    '
    LET l_distinct = ''
    LET l_detailListTok = base.StringTokenizer.create(p_detailList, '|')
    WHILE l_detailListTok.hasMoreTokens()
        LET l_tokValue = l_detailListTok.nextToken()
    END WHILE
    LET l_select = 'SELECT ', l_distinct
        , ' collegamento.utente'
    LET l_where = p_where
        , ''
    LET l_orderBy = ''
    LET l_sqlQuery = l_select
        , l_from
        , l_where
        , l_orderBy
    {<POINT Name="fct.record1_getKeys.init">} {</POINT>}
    IF form_events.m_DataEvent_record1_OnSelectRows IS NOT NULL THEN
        CALL form_events.m_DataEvent_record1_OnSelectRows(l_select, l_from, l_where, l_orderBy)
            RETURNING l_sqlQuery
    END IF

    WHENEVER ERROR CONTINUE
        DECLARE getKeys_cursqlsid_form_record1 CURSOR FROM l_sqlQuery
    WHENEVER ERROR STOP
    IF sqlca.sqlcode != 0 THEN
        RETURN sqlca.sqlcode
    END IF
    WHENEVER ERROR CONTINUE
        FOREACH getKeys_cursqlsid_form_record1 INTO l_rec_data.*
            LET p_arr_br_uk[p_arr_br_uk.getLength() + 1].* = l_rec_data.*
        END FOREACH
        FREE getKeys_cursqlsid_form_record1
    WHENEVER ERROR STOP
    IF sqlca.sqlcode != 0 THEN
        CALL p_arr_br_uk.clear()
    END IF
    RETURN sqlca.sqlcode
END FUNCTION
{</BLOCK>} --fct.record1_getKeys
{<BLOCK Name="fct.record1_getDataByKey">}
#+ Get data from a given Business Record (BR) Unique Key (UK) (may be a composite key)
#+
#+ @param p_rec_br_uk The Business Record (BR) Unique Key (UK) for which to get data
#+
#+ @returnType INTEGER, record1_br_type, collegamento.*
#+ @return Error number, 0-success, other-error
#+ @return Data for the given Business Record (BR) Unique Key (UK)
PUBLIC FUNCTION form_uidata_record1_getDataByKey(p_rec_br_uk)
    --Declaration of parameters
    DEFINE p_rec_br_uk record1_br_uk_type
    --Declaration of local types, variables, constants
    DEFINE l_rec_BRdata record1_br_type
    DEFINE l_rec_DBdata RECORD LIKE collegamento.*
    {<POINT Name="fct.record1_getDataByKey.define">} {</POINT>}

    {<POINT Name="fct.record1_getDataByKey.init">} {</POINT>}
    WHENEVER ERROR CONTINUE
        SELECT @collegamento.utente,
            @collegamento.password,
            @collegamento.server,
            @collegamento.porta,
            @collegamento.database,
            @collegamento.modulo,
            collegamento.*
        INTO l_rec_BRdata.collegamento_utente,
            l_rec_BRdata.collegamento_password,
            l_rec_BRdata.collegamento_server,
            l_rec_BRdata.collegamento_porta,
            l_rec_BRdata.collegamento_database,
            l_rec_BRdata.collegamento_modulo,
            l_rec_DBdata.*
        FROM collegamento
        WHERE @collegamento.utente = p_rec_br_uk.collegamento_utente
        IF sqlca.sqlcode != 0 THEN
            INITIALIZE l_rec_BRdata.* TO NULL
            INITIALIZE l_rec_DBdata.* TO NULL
        END IF

        IF form_events.m_DataEvent_record1_OnComputedFields IS NOT NULL THEN
            CALL form_events.m_DataEvent_record1_OnComputedFields(l_rec_BRdata)
        END IF
        {<POINT Name="fct.record1_getDataByKey.computeFieldsAddOn">} {</POINT>}
    WHENEVER ERROR STOP
    {<POINT Name="fct.record1_getDataByKey.user">} {</POINT>}
    RETURN sqlca.sqlcode, l_rec_BRdata.*, l_rec_DBdata.*
END FUNCTION
{</BLOCK>} --fct.record1_getDataByKey

{<BLOCK Name="fct.record1_insertRow">}
#+ Insert a row in the database
#+
#+ @param p_rec_br Business record values to insert
#+
#+ @returnType INTEGER, STRING, RECORD
#+ @return     ERROR_SUCCESS|ERROR_FAILURE, error message, Business Record unique keys
PUBLIC FUNCTION form_uidata_record1_insertRow(p_rec_br)
    DEFINE p_rec_br record1_br_type
    DEFINE dataInsert RECORD LIKE collegamento.*
    DEFINE ret record1_br_uk_type
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.record1_insertRow.define">} {</POINT>}

    --Init local data with default values from the DB schema
    CALL mydatabase_dbxdata.mydatabase_dbxdata_collegamento_setDefaultValuesFromDBSchema() RETURNING dataInsert.*
    --Set local data with form field values
    LET dataInsert.utente = p_rec_br.collegamento_utente
    LET dataInsert.password = p_rec_br.collegamento_password
    LET dataInsert.server = p_rec_br.collegamento_server
    LET dataInsert.porta = p_rec_br.collegamento_porta
    LET dataInsert.database = p_rec_br.collegamento_database
    LET dataInsert.modulo = p_rec_br.collegamento_modulo
    {<POINT Name="fct.record1_insertRow.init">} {</POINT>}

    IF form_events.m_DataEvent_record1_BeforeInsertRow IS NOT NULL THEN
        CALL form_events.m_DataEvent_record1_BeforeInsertRow(dataInsert.*)
            RETURNING errNo, errMsg, dataInsert.*
    END IF
    IF errNo == ERROR_SUCCESS THEN
        --Call the database insert row
        CALL mydatabase_dbxdata.mydatabase_dbxdata_collegamento_PK_collegamento_1_insertRowByKey(dataInsert.*) RETURNING errNo, errMsg, ret.collegamento_utente
        IF errNo == ERROR_SUCCESS THEN
            IF form_events.m_DataEvent_record1_AfterInsertRow IS NOT NULL THEN
                CALL form_events.m_DataEvent_record1_AfterInsertRow(errNo, errMsg, ret.*)
                    RETURNING errNo, errMsg
            END IF
        END IF
    END IF

    LET errMsg = IIF(errNo = ERROR_SUCCESS, C_TXT_INSERT_SUCCESS_MSG, C_TXT_INSERT_FAIL_MSG), errMsg

    {<POINT Name="fct.record1_insertRow.user">} {</POINT>}
    RETURN errNo, errMsg, ret.*
END FUNCTION
{</BLOCK>} --fct.record1_insertRow

{<BLOCK Name="fct.record1_updateRow">}
#+ Update a row in the database
#+
#+ @param p_rec_br Business record values to update
#+ @param p_dataT0 - a row data LIKE collegamento.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION form_uidata_record1_updateRow(p_rec_br, p_dataT0)
    DEFINE p_rec_br record1_br_type
    DEFINE p_dataT0 RECORD LIKE collegamento.*
    DEFINE l_dataT1 RECORD LIKE collegamento.*
    DEFINE l_rec_br_uk record1_br_uk_type
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.record1_updateRow.define">} {</POINT>}

    --Init local data with values from the DB array
    LET l_dataT1.* = p_dataT0.*
    --Set local data with form field values
    LET l_dataT1.utente = p_rec_br.collegamento_utente
    LET l_dataT1.password = p_rec_br.collegamento_password
    LET l_dataT1.server = p_rec_br.collegamento_server
    LET l_dataT1.porta = p_rec_br.collegamento_porta
    LET l_dataT1.database = p_rec_br.collegamento_database
    LET l_dataT1.modulo = p_rec_br.collegamento_modulo
    --Set local Business Record Key data
    LET l_rec_br_uk.collegamento_utente = p_dataT0.utente
    {<POINT Name="fct.record1_updateRow.init">} {</POINT>}

    IF form_events.m_DataEvent_record1_BeforeUpdateRow IS NOT NULL THEN
        CALL form_events.m_DataEvent_record1_BeforeUpdateRow(p_dataT0.*, l_dataT1.*)
            RETURNING errNo, errMsg, p_dataT0.*, l_dataT1.*
    END IF
    IF errNo == ERROR_SUCCESS THEN
        --Call the database update row
        CALL mydatabase_dbxdata.mydatabase_dbxdata_collegamento_PK_collegamento_1_updateRowByKey(p_dataT0.*, l_dataT1.*) RETURNING errNo, errMsg
        IF errNo == ERROR_SUCCESS THEN
            IF form_events.m_DataEvent_record1_AfterUpdateRow IS NOT NULL THEN
                CALL form_events.m_DataEvent_record1_AfterUpdateRow(errNo, errMsg, l_rec_br_uk.*)
                    RETURNING errNo, errMsg
            END IF
        END IF
    END IF

    CASE errNo
        WHEN ERROR_SUCCESS
            LET errMsg = C_TXT_UPDATE_SUCCESS_MSG
        WHEN ERROR_CONCURRENT_ACCESS_FAILURE
            LET errMsg = C_TXT_UPDATE_OVERWRITE
        WHEN ERROR_CONCURRENT_ACCESS_NOTFOUND
            LET errMsg = C_TXT_UPDATE_DATA_MISSING
        OTHERWISE
            LET errMsg = C_TXT_UPDATE_FAIL_MSG, errMsg
    END CASE

    {<POINT Name="fct.record1_updateRow.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.record1_updateRow

{<BLOCK Name="fct.record1_deleteRowWithConcurrentAccess">}
#+ Delete a row in the database
#+
#+ @param p_dataT0 - a row data LIKE collegamento.*
#+
#+ @returnType       INTEGER, STRING
#+ @return           0-success|Other-Error, error message
PUBLIC FUNCTION form_uidata_record1_deleteRowWithConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE collegamento.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.record1_deleteRowWithConcurrentAccess.define">} {</POINT>}
    {<POINT Name="fct.record1_deleteRowWithConcurrentAccess.init">} {</POINT>}

    IF form_events.m_DataEvent_record1_BeforeDeleteRowWithConcurrentAccess IS NOT NULL THEN
        CALL form_events.m_DataEvent_record1_BeforeDeleteRowWithConcurrentAccess(p_dataT0.*)
            RETURNING errNo, errMsg, p_dataT0.*
    END IF
    IF errNo == ERROR_SUCCESS THEN
        --Call the database update row
        CALL mydatabase_dbxdata.mydatabase_dbxdata_collegamento_PK_collegamento_1_deleteRowByKeyWithConcurrentAccess(p_dataT0.*) RETURNING errNo
        IF errNo == ERROR_SUCCESS THEN
            IF form_events.m_DataEvent_record1_AfterDeleteRowWithConcurrentAccess IS NOT NULL THEN
                CALL form_events.m_DataEvent_record1_AfterDeleteRowWithConcurrentAccess(errNo, errMsg, p_dataT0.*)
                    RETURNING errNo, errMsg
            END IF
        END IF
    END IF

    CASE errNo
        WHEN ERROR_SUCCESS
            LET errMsg = C_TXT_DELETE_SUCCESS_MSG
        WHEN ERROR_CONCURRENT_ACCESS_FAILURE
            LET errMsg = C_TXT_DELETE_OVERWRITE
        WHEN ERROR_CONCURRENT_ACCESS_NOTFOUND
            LET errMsg = C_TXT_DELETE_DATA_MISSING
        WHEN ERROR_DELETE_CASCADE_ROW_USED
            LET errMsg = C_TXT_DELETE_FAIL_ROW_USED_MSG
        OTHERWISE
            LET errMsg = C_TXT_DELETE_FAIL_MSG
    END CASE

    {<POINT Name="fct.record1_deleteRowWithConcurrentAccess.user">} {</POINT>}
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.record1_deleteRowWithConcurrentAccess

{<BLOCK Name="fct.record1_checkRowConcurrentAccess">}
#+ Check a row in the database
#+
#+ @param p_dataT0 - a row data LIKE collegamento.*
#+
#+ @returnType INTEGER, STRING
#+ @return     ERROR_SUCCESS|ERROR_FAILURE|ERROR_CONCURRENT_ACCESS_NOTFOUND|ERROR_CONCURRENT_ACCESS_FAILURE, error message
PUBLIC FUNCTION form_uidata_record1_checkRowConcurrentAccess(p_dataT0)
    DEFINE p_dataT0 RECORD LIKE collegamento.*
    DEFINE errNo INTEGER
    DEFINE errMsg STRING
    {<POINT Name="fct.record1_checkRowConcurrentAccess.define">} {</POINT>}
    {<POINT Name="fct.record1_checkRowConcurrentAccess.init">} {</POINT>}

    CALL mydatabase_dbxdata.mydatabase_dbxdata_collegamento_PK_collegamento_1_checkRowByKeyWithConcurrentAccess(p_dataT0.*, FALSE) RETURNING errNo
    CASE errNo
        WHEN ERROR_SUCCESS
        WHEN ERROR_CONCURRENT_ACCESS_FAILURE
            LET errMsg = C_TXT_UPDATE_OVERWRITE
        WHEN ERROR_CONCURRENT_ACCESS_NOTFOUND
            LET errMsg = C_TXT_UPDATE_DATA_MISSING
        OTHERWISE
            LET errMsg = C_TXT_DELETE_FAIL_MSG, errMsg
    END CASE
    RETURN errNo, errMsg
END FUNCTION
{</BLOCK>} --fct.record1_checkRowConcurrentAccess

--------------------------------------------------------------------------------
--Add user functions
{<POINT Name="user.functions">} {</POINT>}