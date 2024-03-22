set serveroutput ON
DECLARE
    V_PK_NUM NUMBER(2);     V_PK_NAME VARCHAR2(40);     V_I NUMBER(1) := 1;     V_START_SEQ NUMBER(7);
    V_TABLE_NAME VARCHAR2(20);           V_TRIGGER_NAME VARCHAR2(30);           V_SEQ_NAME VARCHAR2(30);
    CURSOR V_TABLES IS
        SELECT OBJECT_NAME FROM USER_OBJECTS where OBJECT_TYPE = 'TABLE'; 
BEGIN
    DROP_SEQ_PROCEDURE;
    FOR V_TABLE_RECORD in V_TABLES LOOP
        V_TABLE_NAME := V_TABLE_RECORD.OBJECT_NAME;
        V_PK_NUM := CHECK_PK_NO(V_PK_NAME, V_TABLE_NAME, 'HR');
        --EXECUTE IMMEDIATE 'DROP TRIGGER '||V_TRIGGER_NAME||'';
        DBMS_OUTPUT.PUT_LINE('Number of primary keys: '||V_PK_NUM||', name of the column: '||V_PK_NAME||', table name: '||V_TABLE_NAME);
        if V_PK_NUM = 1 THEN
            CREATE_SEQ(V_PK_NAME, V_TABLE_NAME);
            V_TRIGGER_NAME := V_TABLE_NAME||'_TRG';
            V_SEQ_NAME := V_TABLE_NAME||'_SEQ';
            EXECUTE IMMEDIATE 'CREATE OR REPLACE TRIGGER '||V_TRIGGER_NAME||
            ' BEFORE INSERT ON '||V_TABLE_NAME||
            ' FOR EACH ROW '||
            ' BEGIN
                :NEW.'||V_PK_NAME ||' := '||V_SEQ_NAME||'.nextval;
            END;';
           DBMS_OUTPUT.PUT_LINE('---Sequence: '|| V_SEQ_NAME||' Created with trigger: '||V_TRIGGER_NAME);
        else 
            DBMS_OUTPUT.PUT_LINE('X-Trigger and sequence can not be created for this table');
        end IF;
    END LOOP;
end;