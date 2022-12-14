-- 1
SELECT STUDENT_NO AS "학번" ,STUDENT_NAME AS "이름" , ENTRANCE_DATE AS "입학년도"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE ASC;

--2
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';

--3 ★다른방법으로 다시 풀어보기
SELECT PROFESSOR_NAME AS "교수이름", TO_CHAR(SYSDATE, 'YYYY')-CONCAT(19, SUBSTR(PROFESSOR_SSN, 1, 2)) AS "나이"
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN , 8, 1) LIKE 1
ORDER BY PROFESSOR_SSN DESC;

--4
SELECT SUBSTR(PROFESSOR_NAME ,2, 2) AS "이름"
FROM TB_PROFESSOR;

--5
-- 입학날짜 - 주민번호 > 19살 ★이렇게 다시 풀어보기

-- 현재나이 - (현재년도 - 입학년도) > 19살
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE TO_CHAR(SYSDATE, 'YYYY') - CONCAT(19,SUBSTR(STUDENT_SSN, 1, 2)) 
- (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM ENTRANCE_DATE)) > 19;
-- 입학 년도
SELECT EXTRACT(YEAR FROM ENTRANCE_DATE)
FROM TB_STUDENT;
-- 현재 년도
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM TB_STUDENT;
-- 현재 나이
SELECT TO_CHAR(SYSDATE, 'YYYY') - CONCAT(19,SUBSTR(STUDENT_SSN, 1, 2))
FROM TB_STUDENT;

--6
SELECT TO_CHAR(TO_DATE(201225), 'DAY') AS "2020년 크리스마스"
FROM DUAL;

--7
--2099, 2049년
SELECT TO_DATE('99/10/11', 'YY/MM/DD'), TO_DATE('49/10/11', 'YY/MM/DD') 
FROM DUAL;

--1999, 2049년
SELECT TO_DATE('99/10/11', 'RR/MM/DD'), TO_DATE('49/10/11', 'RR/MM/DD') 
FROM DUAL;

--8
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_NO, 1, 1) NOT LIKE 'A%';

--9
SELECT ROUND(AVG(POINT), 1) AS "평점"
FROM TB_GRADE
WHERE STUDENT_NO IN ('A517178');

--10
SELECT DEPARTMENT_NO AS "학과번호", COUNT(*) AS "학생수(명)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO ASC;

-- 11
SELECT COUNT(*)
FROM TB_STUDENT
GROUP BY COACH_PROFESSOR_NO
HAVING COACH_PROFESSOR_NO IS NULL;

SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12
SELECT SUBSTR(TERM_NO, 1, 4) AS 년도, ROUND(AVG(POINT),1) AS "년도 별 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4);

-- 13 ★혼자 풀어보기
SELECT DEPARTMENT_NO AS 학과코드명, COUNT(DECODE(ABSENCE_YN, 'Y', 1, NULL)) AS "휴학생 수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO ASC;

-- 14 X
SELECT STUDENT_NAME AS "동일이름", COUNT(STUDENT_NAME = STUDENT_NAME) AS "동명인 수"
FROM TB_STUDENT
GROUP BY STUDENT_NAME;

-- 15
SELECT
