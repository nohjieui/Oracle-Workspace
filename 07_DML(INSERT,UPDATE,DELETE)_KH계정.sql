/*
    DML(DATA MANIPULATION LANGUAGE)
    
    데이터 조작 언어
    
    테이블에 새로운 데이터를 삽입(INSERT)하거나
    기존의 데이터를 수정(UPDATE)하거나
    삭제(DELETE)하는 구문   
*/

/*
    1. INSERT : 테이블에 새로운 행을 추가하는 구문.
    
    [표현법]
    INSERT INTO ~~
    
    1)INSERT INTO 테이블명 VALUES(값1, 값2, 값3....);
    => 해당 테이블에 "모든"칼럼에 대해 추가하고자 하는 값을 내가 직접 제시해서 "한 행"씩 INSERT할때 쓰는 방법.
      *주의사항 : 컬럼의 순서, 자료형, 갯수를 맞춰서 VALUES괄호() 안에 값을 나열해야함
      -> 만약 값을 부족하게 제시했을 경우 에러발생(칼럼의 갯수가 부족)
      -> 만약 값을 더 많이 제시했을 경우 에러발생(TOO MANY VALUES)
*/
--EMPLOYEE 테이블에 사원 정보 추가
INSERT INTO EMPLOYEE
VALUES (900,'홍길동','001213-3155674','hong@kh.or.kr','01099999999','D1','J7','S6','2200000',NULL,NULL,SYSDATE,NULL,'N');
--내가 넣으려고 하는 값의 순서, 자료형, 갯수를 반드시 동일하게 넣어야함.

INSERT INTO EMPLOYEE
VALUES (901,'홍길동','001213-3155674','hong@kh.or.kr','01099999999','D1','J7','S6','2200000',NULL,NULL,SYSDATE,NULL,DEFAULT);
--DEFAULT 설정값 추가

SELECT *
FROM EMPLOYEE;


/*
    2) INSERT INTO 테이블명(컬럼명1, 컬럼명2, 컬럼명3) VLAUES(값1, 값2, 값3);
    => 해당 테이블에 특정 칼럼만 선택해서 그 칼럼에 추가할 값만 제시하고자 할 때 사용
    
    *그래도 한 행 단위로 추가되기 때문에 선택이 안된 칼럼은 기본적으로 NULL OR DEFAULT값이 들어간다.
    *주의사항 : NOT NULL 제약조건 혹은 PRIMARY KEY제약조건이 걸려있는 칼럼은 반드시 직접 값을 넣어줘야 한다.
    -> 예외사항으로 NOT NULL+DEFAULT는 예외
    
*/
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO,JOB_CODE,SAL_LEVEL)
VALUES (902,'노지의','990505-1111111','J7','S6');
--> NOT NULL의 제약조건이 제시된 칼럼만 필수적으로 값을 지정해줘도 문제 없이 행이 삽입됨

/*
    3) INSERT INTO 테이블명(서브쿼리);
    => VALUES()로 값을 직접기술하는게 아니라, 서브쿼리로 조회한 결과값을 통째로 INSERT하는 구문.
    *장점 : 여러행을 한번에 INSERT할 수 있음
    
    -> 한번에 첨부하고자 하는 데이터가 여러가지일 경우 자주 사용함.
*/
--새로운 테이블
CREATE TABLE BOARD_IMAGE(
    BOARD_IMAGE_NO NUMBER PRIMARY KEY,
    ORIGIN_NAME VARCHAR2(100)NOT NULL,
    CHANGE_NAME VARCHAR2(100) NOT NULL
);

INSERT INTO BOARD_IMAGE
(
    SELECT 2 AS BOARD_IMAGE_NO, 'abc.jpg' AS ORIGIN_NAME,'2022122012346.jpg' AS CHANG_NAME
    FROM DUAL
    UNION
    SELECT 3 AS BOARD_IMAGE_NO, 'abc.jpg' AS ORIGIN_NAME,'2022122012347.jpg' AS CHANG_NAME
    FROM DUAL
    UNION
    SELECT 4 AS BOARD_IMAGE_NO, 'abc.jpg' AS ORIGIN_NAME,'2022122012348.jpg' AS CHANG_NAME
    FROM DUAL
    UNION
    SELECT 5 AS BOARD_IMAGE_NO, 'abc.jpg' AS ORIGIN_NAME,'2022122012349.jpg' AS CHANG_NAME
    FROM DUAL
);
SELECT *
FROM BOARD_IMAGE;

/*
    INSERT ALL 계열
    두 개 이상의 테이블에 각각 INSERT할때 사용
    조건 : 그 때 사용되는 서브쿼리가 동일해야한다.
    
    1)INSERT ALL
      INTO 테이블1 VALUES(값들 나열)
      INTO 테이블2 VALUES(값들 나열)   
*/
--새로운 테이블 만들기
--첫번째 테이블 : 급여가 300만원 이상인 사원들의 사번, 사원명, 직급명을 보관할 테이블
--테이블명 EMP_JOB / EMP_ID, EMP_NAME, JOB_NAME
CREATE TABLE EMP_JOB(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    JOB_NAME VARCHAR2(20)
);

--두번째 테이블: 급여가 300만원 이상인 사원들의 사번, 사원명, 부서명을 보관할 테이블
--테이블명 EMP_DEPT / EMP_ID, EMP_NAME, DEPT_TITLE
CREATE TABLE EMP_DEPT(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
);

--서브쿼리문 : 급여가 300만원 이상인 사원들의 사번, 이름, 직급명, 부서명을 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY >= 3000000;


INSERT ALL
INTO EMP_JOB VALUES(EMP_ID, EMP_NAME, JOB_NAME)
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_TITLE)
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY >= 3000000;


SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;

DELETE FROM EMP_JOB;
DELETE FROM EMP_DEPT;

/*
    2)INSERT ALL
     WHEN 조건1 THEN INTO 테이블명1 VALUES(컬럼명)
     WHEN 조건2 THEN INTO 테이블명2 VALUES(컬럼명)
     서브쿼리
     => 조건에 맞는 값만 넣고 싶을때 사용
*/
--테스트용 새로운 테이블 생성
--2010년도 기준으로 이전에 입사한 사원들의 사번, 사원명, 입사일, 급여를 담은 테이블(EMP_OLD)
--데이터는 비우고 틀만 가져오기
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE
WHERE 1=0;


--2010년도 기준으로 이후에 입사한 사원들의 사번, 사원명, 입사일, 급여을 담은 테이블(EMP_NEW)
CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE
WHERE 1=0;

--1. 서브쿼리 부분 만들기
--2010년 이후 입사자 10명 출력
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE
WHERE HIRE_DATE >= '2010/01/01';

INSERT ALL
WHEN HIRE_DATE < '2010/01/01' 
THEN INTO EMP_OLD(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2010/01/01' 
THEN INTO EMP_NEW(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

DELETE FROM EMP_OLD;
DELETE FROM EMP_NEW;

/*
    UPDATE
    
    테이블에 기록된 기존의 데이터를 수정하는 구문.
    [표현법]
    UPDATE 테이블명
    SET 칼럼명 = 바꿀값
       ,컬럼명 = 바꿀값
       ,컬럼명 = 바꿀값 -- 여러개의 값을 동시에 변경가능.(,로 변경할 값들을 나열해야함 / AND아님)
        ...
    WHERE 조건; -- WHERE 생략가능, 다만 생략을 하게되면 해당테이블의 "모든"행의 데이터가 바뀜
*/
-- 복사본 테이블을 만든 후 작업하기
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- 카피테이블에 D9부서의 부서명을 전략기획팀으로 수정
UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀'; -- 9개행의 데이터가 모두 바뀜.
-- 전체 행의 모든 DEPT_TITLE칼럼이 전략기획팀으로 수정됨.

-- 참고 ) 변경사항에 대해서 되돌리는 명령어 : ROLLBACK
ROLLBACK;

UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀'
WHERE DEPT_ID = 'D9';

COMMIT;

-- 복사본
-- 테이블명 : EMP_SALARY / 칼럼 : EMPLOYEE테이블에서 EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS(값도 함께)
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE;

SELECT * FROM EMP_SALARY;

UPDATE EMP_SALARY
SET SALARY = 10000000
WHERE EMP_NAME = '노옹철';

UPDATE EMP_SALARY
SET SALARY = 7000000,
    BONUS = NULL
WHERE EMP_NAME = '선동일';

-- 전체사원 급여를 기존급여에 25%인상해주기. 기존급여 * 1.25 OR 기존급여 + 기존급여 * 0.25
UPDATE EMP_SALARY
SET SALARY = SALARY * 1.25;

SELECT * FROM EMP_SALARY;

/*
    UPDATE 시에도 서브쿼리 사용 가능.
    서브쿼리를 수생한 결과값으로 기존의 값으로부터 변경하겠다.
    
    - CREATE시에 서브쿼리 사용함 : 서브쿼리를 수행한 결과를 테이블 만들 때 넣어버리겠다.
    - INSERT시에 서브쿼리 사용함 : 서브쿼리를 수행한 결과를 해당 테이블에 삽입하겠다.

    [표현법]
    UPDATE 테이블명
    SET 컬럼명 = (서브쿼리)
    WHERE 조건; //생략가능
*/

-- EMP_SALARY 테이블에 홍길동 사원의 부서코드를 선동일 사원의 부서코드로 변경.
-- 홍길동부서코드 D1 , 선동일 부서코드 D9
-- 1) 선동일 사원의 부서코드를 알아내는 쿼리문
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '선동일';

-- 2) 홍길동 부서코드를 D9으로 변경
UPDATE EMP_SALARY
SET DEPT_CODE = (SELECT DEPT_CODE
                 FROM EMPLOYEE
                 WHERE EMP_NAME = '선동일')
WHERE EMP_NAME = '홍길동';

SELECT * FROM EMP_SALARY;

-- 방명수 사원의 급여와 보너스를 유재식 사원의 급여와 보너스값으로 변경
-- EMP_SALARY에서 작업
UPDATE EMP_SALARY
SET (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_SALARY WHERE EMP_NAME = '유재식')
--SET SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '유재식')
--   ,BONUS = (SELECT BONUS FROM EMPLOYEE WHERE EMP_NAME = '유재식')
WHERE EMP_NAME = '방명수';

-- 송중기 직원의 사번을 200으로 바꾸기.
UPDATE EMPLOYEE
SET EMP_ID = 200
WHERE EMP_NAME = '송종기';

UPDATE EMPLOYEE
SET EMP_ID = 905
WHERE EMP_NAME = '선동일';

ROLLBACK;

/*
    4. DELETE
    
    테이블에 기록된 데이터를 "행"단위로 삭제하는 구문.
    [표현법]
    DELETE FROM 테이블명
    WHERE 조건; --WHERE절 생략가능. 생략시에는 테이블의 모든 행 삭제.
*/

-- EMPLOYEE테이블의 모든 행 삭제
DELETE FROM EMPLOYEE;

SELECT * FROM EMPLOYEE;
-- 테이블이 삭제된건 아님

ROLLBACK; -- ROLLBACK시 마지막으로 커밋한 시점으로 돌아감.

-- DELETE문으로 EMPLOYEE테이블안의 홍길동, 노지의 정보를 지우기.
DELETE FROM EMPLOYEE
WHERE EMP_NAME IN ('홍길동','노지의');

-- WHERE절의 조건에 따라 1개 이상의 행 OR 0개행이 변경이 될 수 있다.
COMMIT;

-- DEPARTMENT테이블로부터 DEPT_ID가 D1인 부서 삭제
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
-- 만약에 EMPLOYEE테이블의 DEPT_CODE컬럼에서 외래키로 DEPT_ID칼럼을 참조하고 있을 경우
-- 삭제가 되지 않았을것.

ROLLBACK;

/*
    TRUNCATE : 테이블의 전체행을 모두 삭제할 때 사용하는 구문
               DELETE구문보다 수행속도가 매우 빠름
               별도의 조건을 제시 불가
               ROLLBACK이 불가.

    [표현법]
    TRUNCATE TABLE 테이블명;
    
        TRUNCATE TABLE 테이블명;        |           DELETE FROM 테이블명;
    ===========================================================================
        별도의 조건 제시 불가                         특정조건 제시 가능
        수행속도 빠름                                수행속도 느림
        ROLLBACK 불가                               ROLLBACK 가능
*/
SELECT * FROM EMP_SALARY;

DELETE FROM EMP_SALARY;

ROLLBACK;

TRUNCATE TABLE EMP_SALARY;
