/* 함수
 * 컬럼값 | 지정된 값을 읽어 연산한 결과를 반환하는 것
 * 1. 단일행 함수
 * 	N개의 행에 컬럼값을 전달하여 N개의 결과를 반환
 * 2. 그룹 함수
 * 	N개의 행에 컬럼값을 전달하여 하나의 결과를 반환
 * 
 * 함수는 SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절에서 사용 가능 (FROM절 제외 전부)
 */

/* 단일행 함수
 * 
 * 문자관련 함수
 * LENGTH(컬럼명 | 문자열): 문자열의 길이 반환
 */
SELECT 'HELLO WORLD', LENGTH('HELLO WORLD')
FROM DUAL;

-- EMPLOYEE 테이블에서 이름, 이메일, 이메일 길이를 조회 단, 이메일 길이가 12이하인 사원만 조회하고 이메일 길이 오름차순 조회
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE 
WHERE LENGTH(EMAIL) <= 12
ORDER BY LENGTH(EMAIL) ASC;

/* INSTR(문자열 | 컬럼명, '찾을 문자열'[, 시작 위치[, 순번]])
 * 시작 위치부터 지정된 순번까지 문자열 | 컬럼값에서 '찾을 문자열'의 위치를 반환
 */

-- 처음 B를 찾은 위치를 조회
SELECT 'AABBCCABC', INSTR('AABBCCABC', 'B')
FROM DUAL;

-- 5번째 문자부터 B를 찾은 위치를 조회
SELECT 'AABBCCABC', INSTR('AABBCCABC', 'B', 5)
FROM DUAL;

-- 5번째 문자로부터 세번째로 C를 찾은 위치를 조회
SELECT 'AABBCCABC', INSTR('AABBCCABC', 'C', 5, 3)
FROM DUAL;

/* SUBSTR(문자열, 시작위치[, 길이])
 * 문자열을 시작 위치부터 지정된 길이만큼 잘라서 반환
 * 길이 미작성 시 시작 위치부터 끝까지 잘라서 반환
 */

-- EPLOYEE 테이블에서 사원들의 이름, 이메일 아이디 조회
SELECT EMP_NAME, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') -1)
FROM EMPLOYEE;

/* TRIM(옵션 문자열 FROM 대상문자열)
 * 대상 문자열에 앞 | 뒤 | 양쪽에 존재하는 지정된 문자영 제거
 * 옵션: LEADING(앞), TRAILING(뒤), BOTH(양쪽, 기본값)
 */
SELECT '###기###준###', TRIM(LEADING '#' FROM '###기###준###'), TRIM(TRAILING '#' FROM '###기###준###'), TRIM(BOTH '#' FROM '###기###준###')
FROM DUAL;

/* REPLACE(문자열, 찾을 문자열, 대체 문자열)
 * 문자열에서 원하는 부분을 바꾸는 함수
 */
SELECT NATIONAL_NAME, REPLACE(NATIONAL_NAME, '한국', '대한민국') 변경
FROM "NATIONAL";

-- 모든 사원의 이메일 주소를 or.kr -> gmail.com 변경
SELECT EMAIL || ' -> ' || REPLACE(EMAIL, 'or.kr', 'gmail.com') AS "이메일 변경"
FROM EMPLOYEE;

-- 문자열에서 # 모두 제거
SELECT '###기###준###', REPLACE('###기###준###', '#', '') AS 변경
FROM DUAL;

/* 숫자 관련 함수
 * MOD(숫자, 나눌 값): 결과로 나머지 반환
 * ABS(숫자): 절대값
 * CEIL(실수): 올림해서 정수 형태로 반환
 * FLOOR(실수): 내림해서 정수 형태로 반환
 * 
 * ROUND(실수[, 소수점 위치]): 반올림
 * 1. 소수점 위치 미작성: 소수점 첫째 자리에서 반올림해서 정수 반환
 * 2. 소수점 위치 작성: 지정한 소수점 위치가 표현되도록 반올림해서 숫자 반환
 * 
 * TRUNC(실수[, 소수점 위치]): 버림
 */

-- MOD()
SELECT MOD(7, 4)
FROM DUAL;

-- ABS()
SELECT ABS(-333)
FROM DUAL;

-- CEIL(), FLOOR()
SELECT CEIL(1.1), FLOOR(1.9)
FROM DUAL;

-- ROUND()
SELECT ROUND(123.456), ROUND(123.456, 1), ROUND(123.456, 2), ROUND(123.456, -1)
FROM DUAL;

-- TRUNC()
SELECT TRUNC(123.456), TRUNC(123.456, 1), TRUNC(123.456, 2), TRUNC(123.456, -1)
FROM DUAL;

-- TRUNC()와 FLOOR()의 차이: 버림과 내림의 차이
SELECT TRUNC(-123.5), FLOOR(-123.5)
FROM DUAL;

/* 날짜 관련 함수 */

-- MONTH_BETWEEN(날짜, 날짜): 두 날짜 사이에 개월 수 차이를 반환
SELECT CEIL(MONTHS_BETWEEN(TO_DATE('2025-07-17', 'YYYY-MM-DD'), CURRENT_DATE))
FROM DUAL;

-- 나이 구하기
SELECT FLOOR(MONTHS_BETWEEN(CURRENT_DATE, TO_DATE('2001-03-20', 'YYYY-MM-DD')) / 12) AS "만 나이"
FROM DUAL;

SELECT CEIL(MONTHS_BETWEEN(CURRENT_DATE, TO_DATE('2001-03-20', 'YYYY-MM-DD')) / 12 + 1) AS "한국식 나이"
FROM DUAL;

/* ADD_MONTHS(날짜, 숫자)
 * 날짜에 숫자만큼의 개월 수 추가
 * 달마다 일 수가 다르기 때문에 계산이 쉽지 않아 쉽게 계산할 수 있는 함수 제공
 */
SELECT SYSDATE + 28, ADD_MONTHS(SYSDATE, 1)
FROM DUAL;

SELECT SYSDATE + 28 + 31, ADD_MONTHS(SYSDATE, 2)
FROM DUAL;

/* LAST_DAY(날짜)
 * 해당 월의 마지막 날짜 반환
 * 월 말이나 월 초를 구할 때 사용
 */
SELECT LAST_DAY(SYSDATE), LAST_DAY(SYSDATE) + 1, ADD_MONTHS(LAST_DAY(SYSDATE) + 1, -1)
FROM DUAL;

/* EXTRACT(YEAR | MONTH | DAY FROM 날짜)
 * 날짜에서 년, 월, 일을 추출해서 정수 형태로 반환
 */

-- 2010년대에 입사한 사원의 사번, 이름, 입사일을 입사일 내림차순으로 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE 
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE) BETWEEN 2010 AND 2019
ORDER BY HIRE_DATE DESC;

/* 형변환(Parsing) 함수
 * 문자열(CHAR, VARCHAR2) <-> 숫자(NUMBER)
 * 문자열 <-> 날짜(DATE)
 * 숫자 -> 날짜
 * 
 * TO_DATE(문자열 | 숫자[, Foramt])
 * 문자열 또는 숫자를 날짜로 반환
 * 
 * Format
 * YY: 연도를 짧게 표현
 * YYYY: 연도를 길게 표현
 * RR: 연도를 짧게 표현
 * RRRR: 연도를 길게 표현
 * MM: 월
 * DD: 일
 * AM/PM: 오전/오후 (둘 중 아무거나 작성)
 * HH: 12시간 표기법
 * HH24: 24시간 표기법
 * MI: 분
 * SS: 초
 * DAY: 요일(전체)
 * DY: 요일(약어)
 */

-- 날짜 표기 기호와 기본적인 날짜 작성 순서는 Format 지정을 안해도 해석 가능
SELECT '2025-02-20' AS 문자열, TO_DATE('2025-02-20') AS 날짜 
FROM DUAL;

-- 일반적인 날짜 패턴이 아니거나 영어 외 문자 포함 시 Format 지정이 필수
SELECT '2025-02-21 17:50:00 (금)' AS 문자열, TO_DATE('2025-02-21 17:50:00 (금)', 'YYYY-MM-DD HH24:MI:SS (DY)') AS 날짜 
FROM DUAL;

SELECT '16:20:43 목요일 02-20/2025' AS 문자열, TO_DATE('16:20:43 목요일 02-20/2025', 'HH24:MI:SS DAY MM-DD/YYYY') AS 날짜
FROM DUAL;

SELECT '2025년 02월 20일' AS 문자열, TO_DATE('2025년 02월 20일', 'YYYY"년" MM"월" DD"일"') AS 날짜
FROM DUAL; -- 일반적인 패턴이 아닐 경우 ""로 감싸줌

SELECT 20250220 AS 숫자, TO_DATE(20250220) AS 날짜
FROM DUAL;

/* TO_CHAR(숫자 | 날짜[, Format])
 * 숫자, 날짜를 문자열로 변환
 * 
 * 숫자 -> 문자열
 * 1. 9: 숫자 1칸을 의미, 오른쪽 정렬
 * 2. 0: 숫자 1칸을 의미, 오른쪽 정렬, 빈 칸을 0으로 채움
 * 3. L: 현재 시스템 또는 DB 설정 국가의 화폐 기호
 * 4. ,: 숫자 자릿수 구분
 */

-- 숫자 -> 문자열
SELECT 1234, TO_CHAR(1234)
FROM DUAL;

-- 문자열 9칸 지정하고 오른쪽 정렬
SELECT 1234, TO_CHAR(1234, '999999999')
FROM DUAL;

-- 문자열 9칸 지정하고 오른쪽 정렬 후 빈 칸 0으로 채우기
SELECT 1234, TO_CHAR(1234, '000000000')
FROM DUAL;

-- 변경할 숫자보다 칸 수가 적을 때는 모든 문자가 #으로 변환되어 출력
SELECT 1234, TO_CHAR(1234, '000')
FROM DUAL;

-- ,를 이용한 자릿 수 구분 + 화폐 기호
SELECT 100000000, TRIM(TO_CHAR(100000000, 'L999,999,999')) 
FROM DUAL;

-- 모든 사원의 연봉 조회
SELECT EMP_NAME 이름, TRIM(TO_CHAR(SALARY * 13, 'L999,999,999')) 연봉
FROM EMPLOYEE 
ORDER BY SALARY * 13 DESC;

/* 문자열 정렬 기준은 글자 수, 글자 순서등에 영향이있기 때문에 정렬 시 생각을 잘 해봐야함
 * 숫자, 날짜는 작음의 기준이 단순하고 명확함
 */

-- 차이 X
SELECT TO_DATE('25/02/20', 'YY/MM/DD'), TO_DATE('25/02/20', 'RR/MM/DD')
FROM DUAL;

-- 50년을 기준으로 차이 발생
SELECT TO_DATE('50/02/20', 'YY/MM/DD'), TO_DATE('50/02/20', 'RR/MM/DD')
FROM DUAL;

/* TO_NUMBER()
 * 
 */

SELECT '123456789', TO_NUMBER('123456789')
FROM DUAL;

SELECT '$1,500', TO_NUMBER('$1,500', '$9,999')
FROM DUAL;

/* NULL 처리 연산: IS [NOT] NULL
 * 
 * NULL 처리 함수
 * NVL(컬럼명, 컬럼값이 NULL인 경우 변경할 값): NULL인 경우 다른 값으로 변경
 * NVL2(컬럼명, NULL이 아닌 경우, NULL인 경우): NULL인 경우나 아닌 경우를 나눠서 처리
 */

-- 사번, 이름, 전화번호 조회 단, 전화번호가 없으면 없음으로 조회
SELECT EMP_ID, EMP_NAME, NVL(PHONE, '없음') AS "PHONE" 
FROM EMPLOYEE;

-- 이름, 급여, 보너스, 급여 * 보너스 조회 단, 보너스가 없는 사원은 0으로 조회
SELECT EMP_NAME, SALARY, NVL(BONUS, 0) AS BONUS, NVL(SALARY * BONUS, 0) AS "SALARY * BONUS"
FROM EMPLOYEE;

-- 사번, 이름, 전화번호를 조회 단, 전화번호가 없으면 없음, 전화번호가 있으면 010******** 형식으로 변경해서 조회
SELECT EMP_ID, EMP_NAME, NVL2(PHONE, RPAD(SUBSTR(PHONE, 1, 3), LENGTH(PHONE), '*'), '없음') AS PHONE
FROM EMPLOYEE;

-- RPAD(문자열, 길이, 바꿀문자): 문자열 전체에서 오른쪽을 지정된 길이만큼 바꿀문자로 변경

/* 선택 함수
 * 여러가지 경우에 따라 알맞은 결과를 선택하는 함수 (if, switch와 유사)
 * 
 * DECODE(컬럼명, 조건1, 결과1, 조건2, 결과2, ... [, 아무것도 만족 X])
 * 컬럼값이 일치하는 조건이 있으면 해당 조건 오른쪽에 작성된 결과가 반환되는 함수
 * 
 * switch, case, default와 유사
 */

-- 모든 사원의 이름, 주민등록번호, 성별 조회
SELECT EMP_NAME , EMP_NO, DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남자', 2, '여자') AS 성별  
FROM EMPLOYEE;

/* CASE
 * WHEN 조건1 THEN 결과1
 * WHEN 조건2 THEN 결과2
 * WHEN 조건3 THEN 결과3
 * ...
 * ELSE 나머지 결과
 * END
 * 
 * if, else if, else 와 유사
 * 
 * CASE 함수에 작성되는 조건은 범위로 설정이 가능 (DECODE는 딱 떨어지는 값만 조건으로 설정 가능)
 */

-- 사번, 이름, 급여, 구분을 부서코드 오름차순으로 조회 단, 구분은 부서코드가 D6, D9인 사원만 받는 급여에 따라 
-- 초급, 중급, 고급으로 나눠서 조회 (600만 이상 고급, 400만 이상 600만 미만 중급, 400만 미만 초급)
SELECT EMP_ID AS "사번", EMP_NAME AS "이름", SALARY AS "급여", 
CASE 
	WHEN SALARY >= 6000000 THEN '고급'
	WHEN SALARY < 4000000 THEN '초급'
	ELSE '중급'
END AS "구분"
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6', 'D9')
ORDER BY DEPT_CODE ASC;

-- 이름, 연봉, 세금(연봉 * 세율)을 세금 내림차순으로 조회
SELECT EMP_NAME AS "이름", SALARY * 12 AS "연봉",
CASE 
	WHEN SALARY * 12 <= 12000000 THEN SALARY * 12 * 0.06 
	WHEN SALARY * 12 <= 46000000 THEN SALARY * 12 * 0.15 
	WHEN SALARY * 12 <= 88000000 THEN SALARY * 12 * 0.24 
	WHEN SALARY * 12 <= 150000000 THEN SALARY * 12 * 0.35 
END AS "세금"
FROM EMPLOYEE
ORDER BY 세금 DESC;

/* 그룹 함수
 * N개 행의 컬럼값을 함수로 전달하였을 때, 결과가 1개만 반환되는 함수
 * 
 * 그룹 수가 늘어나면 그룹 함수 결과 개수도 증가 -> GROUP BY
 * 
 * SUM(컬럼명): 그룹의 컬럼값 합계를 반환하는 함수, 숫자가 작성된 컬럼에만 사용 가능
 */

-- 모든 사원의 급여 합 조회
SELECT SUM(SALARY) 
FROM EMPLOYEE; 

-- 부서코드가 D6인 사원의 급여 합을 조회
SELECT SUM(SALARY) 
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6';

/* AVG(컬럼명): 그룹의 평균을 반환하는 함수 */

-- 모든 사원의 급여 평균 조회
SELECT FLOOR(AVG(SALARY)) AS "급여 평균"
FROM EMPLOYEE;

-- 모든 사원의 급여 평균보다 급여가 높은 사원의 이름, 급여를 급여 내림차순 조회
SELECT EMP_NAME AS "이름", SALARY AS "급여" 
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE) -- 서브쿼리
ORDER BY SALARY DESC;
-- 일반적으로 일반 컬럼과 그룹 함수 결과는 같이 사용할 수 없음 따라서 GROUP BY나 서브쿼리를 사용해야 함

/* MAX(컬럼명), MIM(컬럼명): 최대소값 반환 */

-- 부서코드가 D6인 사원 중 제일 높은 급여와 낮은 급여를 받는 사원의 급여를 조회
SELECT MAX(SALARY), MIN(SALARY) 
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D6';

-- 사원을 이름 순으로 오름차순 정렬했을 때 첫번째 사원과 마지막 사원의 이름을 조회
SELECT MIN(EMP_NAME), MAX(EMP_NAME)
FROM EMPLOYEE;

-- 모든 사원 중 입사일이 가장 빠른 사원, 늦은 사원의 입사일 조회
SELECT MIN(HIRE_DATE), MAX(HIRE_DATE)
FROM EMPLOYEE;

/* COUNT(): 조회된 행의 개수를 반환하는 함수
 * 1. COUNT(*): 조회된 모든 행의 개수를 반환 (NULL이 포함된 행도 개수에 포함)
 * 2. COUNT(컬럼명): 지정된 컬럼값이 NULL인 경우를 제외한 개수를 반환
 * 3. COUNT(DISTINCT 컬럼명): 지정된 컬럼값이 중복되는 경우를 제외한 개수를 반환 (중복은 1번만 카운트)
 */

-- 모든 행의 개수 조회
SELECT COUNT(*)
FROM EMPLOYEE;

-- 부서코드가 D5 D6인 사원의 수를 조회
SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D6');

-- 전화번호가 있는 사원의 수 조회
SELECT COUNT(PHONE) 
FROM EMPLOYEE;

-- 테이블에 존재하는 부서코드의 수 조회
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;

-- 테이블에 존재하는 남자, 여자 사원 수를 각각 조회
SELECT COUNT(DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남자')) AS "남자 수", COUNT(DECODE(SUBSTR(EMP_NO, 8, 1), 2, '여자')) AS "여자 수"
FROM EMPLOYEE;