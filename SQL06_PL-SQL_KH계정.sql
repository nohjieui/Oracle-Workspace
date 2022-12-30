SET SERVEROUTPUT ON;
-- 1. 사원의 연봉을 구하는 PL/SQL 블럭작성, 보너스가 있는 사원은 보너스도 포함하여 계산
DECLARE
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
    INCOME NUMBER;
BEGIN
    SELECT EMP_NAME, SALARY, NVL(BONUS, 0)
      INTO ENAME, SAL, BONUS
      FROM EMPLOYEE
     WHERE EMP_ID = &사번;
     
     INCOME := (SAL + SAL * NVL(BONUS, 0)) * 12;
     
     DBMS_OUTPUT.PUT_LINE(ENAME || ' 사원의 연봉은 ' || INCOME || '원 입니다.');
     
END;
/

-- 2. 구구단 짝수 출력
-- 2-1) FOR LOOP
BEGIN
    FOR I IN 2..9
    LOOP
        FOR J IN 1..9
        LOOP           
            DBMS_OUTPUT.PUT_LINE(I || ' X ' || J || ' = ' || J*I);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/


-- 2-2) WHILE LOOP
DECLARE
    I NUMBER := 2;
    J NUMBER := 1;
BEGIN
    WHILE I < 10
    LOOP
        I := I + 1;
        WHILE J < 10
        LOOP
        J := J + 1;
        DBMS_OUTPUT.PUT_LINE(I || ' X ' || J || ' = ' || J*I);
        END LOOP;
    END LOOP;
END;
/

DECLARE
    RESULT NUMBER;
    DAN NUMBER := 2;
    SU NUMBER;
BEGIN
    WHILE DAN <= 9
    LOOP
        SU := 1;
        IF MOD(DAN,2) = 0
            THEN
                WHILE SU <= 9
                LOOP
                    RESULT := DAN * SU;
                    DBMS_OUTPUT.PUT_LINE(DAN || ' X ' || SU || ' = ' || RESULT);
                    SU := SU +1;
                END LOOP;
                DBMS_OUTPUT.PUT_LINE('');
        END IF;
        DAN := DAN + 1;
    END LOOP;
END;
/
