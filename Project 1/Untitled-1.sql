select * from TAB;
select * from USER_OBJECTS where OBJECT_TYPE = 'TABLE';
select * from USER_TAB_COLUMNS;

select * from ALL_CONS_COLUMNS where owner = 'HR';

SELECT *
FROM all_constraints cons, all_cons_columns cols
WHERE cons.constraint_type = 'P'
and cons.OWNER = 'HR'
AND cons.constraint_name = cols.constraint_name
ORDER BY cols.table_name, cols.position;

    SELECT
        COLS.COLUMN_NAME
    FROM
        ALL_CONSTRAINTS CONS,
        ALL_CONS_COLUMNS COLS
    WHERE
        CONS.CONSTRAINT_TYPE = 'P'
        AND CONS.OWNER = 'HR'
        AND CONS.CONSTRAINT_NAME = COLS.CONSTRAINT_NAME
        AND COLS.TABLE_NAME = 'EMP_AUDIT';

select * from USER_SEQUENCES;

SELECT NVL(MAX(EMPLOYEE_ID), 0)+1  FROM EMPLOYEES;

SELECT
            COLS.COLUMN_NAME,
            COLS.TABLE_NAME 
        FROM
            ALL_CONSTRAINTS  CONS,
            ALL_CONS_COLUMNS COLS
        WHERE
            CONS.CONSTRAINT_TYPE = 'P'
            AND CONS.OWNER = 'HR'
            AND CONS.CONSTRAINT_NAME = COLS.CONSTRAINT_NAME
            AND COLS.TABLE_NAME = 'EMPLOYEES';