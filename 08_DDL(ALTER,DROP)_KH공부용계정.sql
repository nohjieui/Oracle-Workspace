/*
    DDL(ALTER,DROP)
    
    객체들을 새롭게 생성(CREATE), 수정(ALTER), 삭제(DROP)하는 구문
    
    1. ALTER
    객체 구조를 수정하는 구문.
    
    <테이블 수정>
    [표현법]
    ALTER TABLE 테이블명 수정할 내용;

    - 수정할 내용
    1) 칼럼 추가 / 수정 / 삭제
    2) 제약조건 추가 / 삭제 -> 수정은 불가(수정하고자한다면 기존의 제약조건을 삭제 후 새롭게 추가)
    3) 테이블명 /  칼럼명 /  제약조건명 수정
*/
-- 1) 칼럼추가 / 수정 / 삭제
-- 1_1) 칼럼추가 (ADD) : ADD 추가할칼럼명 자료형 DEFAULT 기본값. 단, DEFAULT 기본값은 생략가능

SELECT * FROM DEPT_COPY;

-- CNAME 칼럼 추가.
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
-- 새로운 칼럼이 만들어지고, 기본값으로 NULL값이 추가됨.

-- LNAME 칼럼추가 DEFAULT 지정해서
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '한국';
-- 새로운 칼럼이 만들어지고 NULL값이 아닌 DEFAULT값으로 채워짐.

-- 1_2) 칼럼수정(MODIFY)
--      컬럼의 자료형 수정 : MODIFY 수정할칼럼명 바꾸고자하는자료형
--      DEFAULT 값 수정 : MODIFY 수정할 컬럼명 DEFAULT 바꾸고자하는 기본값

-- DEPT_COPY 테이블로 DEPT_ID컬럼의 자료형을 CHAR(3)로 변경
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);

-- 현재 변경하고자하는 컬럼에 이미 문자열로 담겨있는 값을 완전 다른 타입으로 변경이 불가능함.
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER(3);

-- 현재 변경하고자하는 칼럼에 담겨있는 값보다 "작게"는 변경이 불가능함.
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(1);

-- 한번에 여러개의 컬럼 변경 가능
-- DEPT_TITLE컬럼의 데이터타입을 VARCHAR2(40)
-- LOCATION_ID 칼럼의 데이터타입을 VARCHAR2(2)
-- LNAME 컬럼의 기본값을 '미국'으로
ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR(2)
MODIFY LNAME DEFAULT '미국';

-- 1_3) 칼럼 삭제(DROP COLUMN) : DROP COLUMN 삭제하고자하는칼럼명
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

-- DEPT_ID 칼럼 지우기.
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;

-- DML문만 롤백가능 : DDL문은 롤백이 안됨.(DEPT_ID 복구 X)
ROLLBACK;

ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
-- 테이블에 최소 1개의 칼럼은 존재해야함

-- 2) 제약조건 추가 / 삭제
/*
    2_2) 제약조건 추가
    
    - PRIMARY KEY : ADD PRIMARY KEY(칼럼명);
    - FOREIGN KEY : ADD FOREIGN KEY(칼럼명) REFERENCES 참조할테이블[(참조할칼럼)]
    
    - UNIQUE : ADD UNIQUE(컬럼);
    - CHECK : ADD CHECK(컬럼에 대한 조건);
    - NOT NULL : MODIFY 컬럼명 NOT NULL;
    
    나만의 제약조건명 부여하고자 할 때 : CONSTRAINT 제약조건명을 제약조건 앞에다가 추가.
    -> CONSTRAINT 제약조건명은 생략가능하다.(임의의 이름이 붙음)
    -> 주의사항 : 현재 계정 내에 고유한 이름으로 부여해야함.
*/
-- DEPT_COPY 테이블로부터
-- DEPT_ID 칼럼에 PRIMARY KEY 제약조건 추가
-- DEPT_TITLE 칼럼에 UNIQUE 제약조건 추가
-- LNAME 칼럼에 NOT NULL 제약조건 추가
ALTER TABLE DEPT_COPY
ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)
ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;

/*
    2_2) 제약조건 삭제
    
    PRIMARY KEY, FOREING KEY, UNIQUE, CHECK : DROP CONSTRAINT 제약조건명
    NOT NULL : MODIFY 칼럼명 NULL;
*/

-- DEPT_COPY 테이블에 DCOPY_PK 제약조건 지우기.
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;

-- DEPT_COPY 테이블에 DCOPY_UQ, DCOPY_NN 제약조건 지우기
ALTER TABLE DEPT_COPY
DROP CONSTRAINT DCOPY_UQ
MODIFY LNAME NULL;

-- 3) 칼럼명, 제약조건명, 테이블명 변경 (RENAME)

SELECT * FROM DEPT_TEST;
-- 3_1) 컬럼명 변경 : RENAME COLUMN 기존칼럼명 TO 바꿀칼럼명
-- DEPT_COPY 테이블에서 DEPT_TITLE 칼럼을 DEPT_NAME 으로 바꾸기
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;
-- 3_2) 제약조건명 변경 : RENAME CONSTRAINT 기존제약명 TO 바꿀제약명
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C0011122 TO DCOPY_DID_NN;
-- 3_3) 테이블명 변경 : RENAME 기존테이블명 TO 바꿀테이블명 -> RENAME TO 바꿀테이블명
-- 기존테이블명이 제시되어있기 때문에 생략가능
-- DEPT_COPY 테이블이름을 DEPT_TEST로 변경.
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;

--------------------------------------------------------------------------------
/*
    2. DROP
    객체를 삭제하는 구문
    [표현법]
    DROP 객체[TABLE, USER, VIEW 등등] 삭제하고자하는객체이름;
*/
-- DEPT_COPY2 테이블 삭제
DROP TABLE DEPT_COPY2;

-- 부모테이블을 만들고, 부모테이블 삭제해보기.
ALTER TABLE DEPT_TEST
ADD PRIMARY KEY(DEPT_ID); -- PK 제약조건 추가

-- EMPLOYEE_COPY3 테이블에 외래키 제약조건추가
-- 이때 부모테이블은 DEPT_TEST테이블의 DEPT_ID를 참조.
ALTER TABLE EMPLOYEE_COPY3
ADD CONSTRAINT ECOPY_FK FOREIGN KEY(DEPT_CODE) REFERENCES DEPT_TEST(DEPT_ID);

-- 부모테이블 삭제
DROP TABLE DEPT_TEST;
-- 오류 : 자식테이블에서 참조되고 있어서 삭제할 수 없음.

-- 단, 어딘가에서 참조되고 있는 부모테이블은 삭제되지 않음.
-- 부모테이블 삭제하고 싶다면
-- 방법1) 자식테이블을 먼저 삭제하고, 그 후에 부모테이블을 삭제
DROP TABLE EMPLOYEE_COPY3;
DROP TABLE DEPT_TEST;

-- 방법2) 부모테이블만 삭제하되 맞물려있는 외래키 제약조건도 함께 삭제해준다.
DROP TABLE DEPT_TEST CASCADE CONSTRAINT;









