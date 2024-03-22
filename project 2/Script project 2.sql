
set SERVEROUTPUT on;
DECLARE
  CURSOR new_emp_cursor IS
    select * from EMPLOYEES_TEMP;
    V_newjob_id VARCHAR2(60);
    V_job_id VARCHAR2(60);
    V_job_count number (3);
    V_City_count number(3);
    V_Dept_count number(3);
    V_location_id NUMBER(4);
    V_hire_date DATE;
    V_Dept_id NUMBER(4);
    V_EMP_COUNT NUMBER(4);
    V_EMAIL_LEN NUMBER(4);
BEGIN
    for Emp_record in new_emp_cursor LOOP
      if REGEXP_LIKE(Emp_record.EMAIL, '@') THEN
        select count(*) into V_job_count from jobs where JOB_TITLE = Emp_record.job_title;
         IF V_job_count = 0 THEN
              V_newjob_id := SUBSTR(Emp_record.job_title, 1, 3);
            INSERT into JOBS (job_id, JOB_TITLE) VALUES (V_newjob_id ,Emp_record.job_title);
                dbms_output.PUT_LINE('JOB was not present and inserted-> '|| Emp_record.job_title);
          end if;  
        SELECT job_id into V_job_id from JOBS WHERE JOB_TITLE = Emp_record.job_title;

        SELECT COUNT(*) into V_City_count from LOCATIONS where city = Emp_record.city;      
         IF V_City_count = 0 THEN
            INSERT into LOCATIONS (City) VALUES (Emp_record.city);
            dbms_output.PUT_LINE('City was not present and inserted-> '|| Emp_record.city);
          END IF;
        SELECT location_id into V_location_id from LOCATIONS WHERE CITY = Emp_record.city;

        SELECT COUNT(*) into V_Dept_count from DEPARTMENTS WHERE department_name = Emp_record.department_name;
        IF V_Dept_count = 0 THEN
            INSERT into DEPARTMENTS (department_name, LOCATION_ID) VALUES (Emp_record.department_name, V_location_id);
            dbms_output.PUT_LINE('Department was not present and inserted-> '|| Emp_record.department_name);
          END IF;
        SELECT DEPARTMENT_ID into V_Dept_id from DEPARTMENTS WHERE department_name = Emp_record.department_name;

        SELECT COUNT(*) into V_EMP_COUNT from EMPLOYEES where email = Emp_record.EMAIL;
        if V_EMP_COUNT = 0 THEN
            V_EMAIL_LEN := LENGTH(Emp_record.EMAIL);
            if V_EMAIL_LEN > 25 THEN
                EXECUTE IMMEDIATE 'ALTER TABLE EMPLOYEES MODIFY EMAIL VARCHAR2('||V_EMAIL_LEN||')';
            END IF;
            V_hire_date := TO_DATE(Emp_record.HIRE_DATE, 'DD/MM/YYYY');
            dbms_output.PUT_LINE('Employee '||Emp_record.FIRST_NAME||' '||Emp_record.LAST_NAME||' has been added');
            INSERT into EMPLOYEES (FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID, SALARY, DEPARTMENT_ID, RETIRED)
              VALUES(Emp_record.FIRST_NAME, Emp_record.LAST_NAME, Emp_record.EMAIL, V_hire_date, V_job_id, Emp_record.SALARY, V_Dept_id, 0);
        else
            dbms_output.PUT_LINE('Employee is already in the table');
        END IF;
      else
        dbms_output.PUT_LINE('Email is invalid');
      end if;
    end loop;
end;



