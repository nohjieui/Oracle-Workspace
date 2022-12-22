/*
    VIEW : 가상의 테이블(RESULTSET) SELECT문을 이용해서 실제 테이블에서 데이터를 가져와서 사용
    VIEW ORACLE OBJECT로 DDL구문을 이용해서 생성, 수정, 삭제
    
    INLINE-VIEW : FROM절에 서브쿼리를 사용한 개념(다중열, 다중행 서브쿼리)
    STORED-VIEW : 영구적으로 저장하고 사용하는 VIEW(서브쿼리를 저장시켜놓음)
*/
-- CREAT VIEW VIEW명칭 AS SELECT(서브쿼리)
CREATE VIEW V_EMPLOYEEALL
AS SELECT *
   FROM EMPLOYEE
   JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
   JOIN JOB USING(JOB_CODE);
-- insufficient privileges : 권한이 불충분합니다
-- 아래코드 실행 후 다시 실행
   
-- VIEW를 생성하기 위해서는 권한을 부여해야함(RESOURCE안에 포함되지 않음)
-- 접속계정 변경(SYSTEM 관리자)
GRANT CREATE VIEW TO KH;

-- VIEW는 FROM절에서 테이블인것처럼 사용 가능
SELECT * FROM V_EMPLOYEEALL;

-- 데이터 딕셔너리를 통해 VIEW 확인
SELECT * FROM USER_VIEWS;