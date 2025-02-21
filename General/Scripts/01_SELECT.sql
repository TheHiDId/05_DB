/* SELECT
 * 지정된 테이블에서 원하는 데이터가 존재하는 행, 열을 선택해서 조회하는 SQL(구조적 질의 언어)
 * 선택된 데이터 == 조회 결과 묶음 == RESULT SET
 * 조회 결과는 0행 이상(조건에 맞는 행이 없을 수 있음!)
 * 
 * [작성법]
 * SELECT * \\ 컬럼명, ...
 * FROM 테이블명;
 * 
 * 지정된 테이블의 모든 행에서 특정 열(컬럼)만 조회
 */

-- EMPLOYEE 테이블에서 모든 행의 이름(EMP_NAME), 급여(SALARY) 컬럼 조회
SELECT EMP_NAME, SALARY 
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 모든 행(== 모든 사원)의 사번, 이름, 급여, 입사일 조회
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 모든 행, 모든 열(컬럼) 조회
SELECT *
FROM EMPLOYEE;

-- DEPARTMENT 테이블에서 부서코드, 부서명 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- EMPLOYEE 테이블에서 이름, 이메일, 전화번호 조회
SELECT EMP_NAME, EMAIL, PHONE
FROM EMPLOYEE;


/* 컬럼 값 산술 연산
 * 컬럼 값: 행과 열이 교차하는 한 칸에 작성된 값
 * SELECT절 컬럼명에 산술 연산을 작성하면 조회 결과에서 모든 행의 산술 연산이 적용된 컬럼 값이 조회 됨
 */

-- EMPLOYEE 테이블에서 모든 사원의 이름, 급여, 급여 + 100만 조회
SELECT EMP_NAME, SALARY, SALARY + 1000000
FROM EMPLOYEE;

-- 모든 사원의 이름, 급여, 연봉 조회
SELECT EMP_NAME, SALARY, SALARY * 12
FROM EMPLOYEE; 


/* SYSDATE / CURRENT_DATE
 * SYSTIMESTAMP / CURRENT_TIMESTAMP
 * 
 * DB는 날짜나 시간 관련 데이터를 다룰 수 있도록 하는 자료형을 제공
 * DATE 타입: 년, 월, 일, 시, 분, 초, 요일 저장 가능
 * TIMESTAMP 타입: 년, 월, 일, 시, 분, 초, MS, 요일, 지역 저장 가능
 * 
 * SYS: 시스템에 설정된 시간 기반
 * CURRENT: 접속한 세션(사용자)의 시간 기반
 */

SELECT SYSDATE, CURRENT_DATE 
FROM DUAL;

SELECT SYSTIMESTAMP, CURRENT_TIMESTAMP 
FROM DUAL;

/* DUAL(DUmmy tAbLe)
 * 조회하려는 데이터가 실제 테이블에 저장된 데이터가 아닌 경우 사용하는 임시 테이블
 */

/* 날짜 데이터 연산(+, -)
 * 날짜 + 정수: 정수만큼 "일" 수 증가
 * 날짜 - 정수: 정수만큼 "일" 수 감소
 */

-- 어제, 오늘, 내일, 모래 조회
SELECT CURRENT_DATE - 1, CURRENT_DATE, CURRENT_DATE + 1, CURRENT_DATE + 2
FROM DUAL;

-- 시간 연산 응용
SELECT CURRENT_DATE, CURRENT_DATE + 1/24, CURRENT_DATE + 1/24/60, CURRENT_DATE + 1/24/60/60, CURRENT_DATE + 1/24/60/60 * 30
FROM DUAL;

/* 날짜끼리 - 연산
 * 두 날짜 사이에 차이를 표시
 * 
 * TO_DATE('날짜모양문자열', '인식패턴')
 * -> '날짜모양문자열'을 '인식패턴'을 이용해 해석하여 DATE 타입으로 변환
 */
SELECT TO_DATE('2025-02-19', 'YYYY-MM-DD'), '2025-02-19'
FROM DUAL;

-- 오늘(2/19)부터 2월 28일 까지 남은 일 수
SELECT TO_DATE('2025-02-28', 'YYYY-MM-DD') - TO_DATE('2025-02-19', 'YYYY-MM-DD')
FROM DUAL;

-- 종강일 D-DAY
SELECT TO_DATE('2025-07-17', 'YYYY-MM-DD') - TO_DATE('2025-02-19', 'YYYY-MM-DD')
FROM DUAL;

-- 퇴근 시간까지 남은 시간
SELECT (TO_DATE('2025-02-19 17:50:00', 'YYYY-MM-DD HH24-MI-SS') - CURRENT_DATE) * 24 * 60
FROM DUAL;

-- EMPLOYEE 테이블에서 모든 사원의 사번, 이름, 입사일, 현재까지 근무일수, 연차 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, FLOOR(CURRENT_DATE - HIRE_DATE), CEIL((CURRENT_DATE - HIRE_DATE) / 365)
FROM EMPLOYEE;


/* 컬럼명 별칭(Alias) 지정
 * 1. 컬럼명 AS 별칭: 문자 O, 띄어쓰기 X, 특수문자 X
 * 2. 컬럼명 AS "별칭": 문자 O, 띄어쓰기 O, 특수문자 O
 * AS 구문은 생략 가능
 * 
 * ORACLE에서 ""의 의미
 * "" 내부에 작성된 글자 모양 그대로를 인식
 * Ex) 문자열 ORACLE 인식 
 * 			abc -> ABC, abc (대소문자 구분 없음)
 * 		 "abc"-> 	 abc		("" 내부에 작성된 모양으로만 인식)
 */

-- EMPLOYEE 테이블에서 모든 사원의 사번, 이름, 입사일, 현재까지 근무일수, 연차 조회하고 별칭 지정
SELECT EMP_ID AS "사번", EMP_NAME AS "이름", HIRE_DATE "입사한 날짜", FLOOR(CURRENT_DATE - HIRE_DATE) "근무일수", CEIL((CURRENT_DATE - HIRE_DATE) / 365) "연차"
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 모든 사원의 사번, 이름, 급여(원), 연봉(급여 * 12) 조회하고 별칭 지정
SELECT EMP_ID "사번", EMP_NAME "이름", SALARY "급여(원)", SALARY * 12 "연봉(원)"
FROM EMPLOYEE;


/* 연결 연산자(||)
 * 두 컬럼값 또는 리터럴을 하나의 문자열로 연결할 때 사용
 */ 
SELECT EMP_ID, EMP_NAME, EMP_ID || EMP_NAME
FROM EMPLOYEE;


/* 리터럴: 데이터를 표기하는 방식(문법)
 * NUMBER 타입: 20, 1.12, -44 (정수, 실수 표기)
 * CHAR, VARCHAR2 타입: 'AB', '가나다' ('' 홑따옴표)
 * 
 * SELECT절에 리터럴을 작성하면 조회 결과 모든 행에 리터럴이 추가됨
 */
SELECT SALARY, '원', SALARY || '원' AS "급여"
FROM EMPLOYEE;


/* DISTINCT (별개의, 전혀 다른)
 * 조회 결과 집합에서 DISTINCT가 지정된 컬럼에 중복된 값이 존재할 경우, 중복을 제거하고 한 번만 표기
 */

-- EMPLOYEE 테이블에서 모든 사원의 부서 코드(DEPT_CODE) 중복 제거하고 조회
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

/* SELECT 해석 순서
 * 3) SELECT 컬럼명 || 리터럴, ...
 * 1) FROM 테이블명 -- 테이블 선택
 * 2) WHERE 조건식; -- 행 선택
 * 
 * WHERE절
 * 테이블에서 조건을 충족하는 행을 조회할 때 사용
 * WHERE절에는 조건식(결과가 참 또는 거짓)만 작성이 가능
 * 비교 연산자: >, <, >=, <=, =(같음), !=, <>(같지 않음)
 * 논리 연산자: AND, OR, NOT
 */ 

-- EMPLOYEE TABLE에서 급여가 400만원을 초과하는 사원의 사번, 이름, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE 
WHERE SALARY > 4000000;

-- EMPLOYEE TABLE에서 급여가 500만원 이하인 사원의 사번, 이름, 급여, 부서코드, 직급코드 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE 
WHERE SALARY <= 4000000;

-- EMPLOYEE 테이블에서 연봉이 5천만원 이하인 사원의 이름, 연봉 조회
SELECT EMP_NAME, SALARY * 12 AS 연봉
FROM EMPLOYEE 
WHERE SALARY * 12 < 50000000;

-- 이름이 노옹철인 사원의 사번, 이름, 전화번호 조회
SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE 
WHERE EMP_NAME = '노옹철';

-- 부서코드가 D9이 아닌 사원의 이름, 부서코드 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE 
WHERE DEPT_CODE != 'D9';

-- 부서코드가 D9인 사원의 이름, 부서코드 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D9';

/* NULL
 * DB에서 NULL은 빈칸 즉, 저장된 값이 없다는 의미
 * NULL은 비교 대상이 없기 때문에 비교 연산의 결과가 무조건 FALSE
 * 
 * NULL 비교 연산
 * 1. 컬럼명 IS NULL: 해당 컬럼값이 NULL이면 TRUE 반환
 * 2. 컬럼명 IS NOT NULL: 해당 컬럼값이 NULL이 아니면 TRUE 반환
 */

-- EMPLOYEE 테이블에서 부서코드가 없는 사원의 사번, 이름, 부서코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE 
WHERE DEPT_CODE IS NULL;

-- BONUS가 존재하는 사원의 이름, 보너스 조회
SELECT EMP_NAME, BONUS 
FROM EMPLOYEE 
WHERE BONUS IS NOT NULL;

/* 논리 연산자
 * 두 조건식의 결과에 따라 새로운 결과를 만드는 연산
 *
 * AND(그리고): 두 연산자의 결과가 TRUE일 때만 최종 결과가 TRUE
 * OR(또는): 두 연산의 결과가 FALSE일 때만 최종 결과가 FALSE
 * 
 * 우선 순위: AND > OR
 */

-- EMPLOYEE 테이블에서 부서코드가 D6인 사원 중 급여가 400만원을 초과하는 사원의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D6' AND SALARY > 4000000;

-- EMPLOYEE 테이블에서 급여가 300만 이상 500만 미만인 사원의 사번, 이름, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY 
FROM EMPLOYEE 
WHERE SALARY >= 3000000 AND SALARY < 5000000;

/* 컬럼명 [NOT] BETWEEN (A) AND (B)
 * 컬럼값이 (A) 이상 (B) 이하인 경우 참(조회)
 */

-- EMPLOYEE 테이블에서 급여가 400만 ~ 600만인 사원의 이름, 급여 조회
SELECT EMP_NAME, SALARY 
FROM EMPLOYEE 
WHERE SALARY BETWEEN 4000000 AND 6000000;

-- EMPLOYEE 테이블에서 급여가 400만 미만, 600만 초과인 사원의 이름, 급여 조회
SELECT EMP_NAME, SALARY 
FROM EMPLOYEE 
WHERE SALARY NOT BETWEEN 4000000 AND 6000000;

-- EMPLOYEE 테이블에서 2010년 대에 입사한 사원의 이름, 입사일 조회
SELECT EMP_NAME, HIRE_DATE 
FROM EMPLOYEE 
WHERE HIRE_DATE BETWEEN TO_DATE('2010.01.01','YYYY.MM.DD') AND TO_DATE('2019.12.31','YYYY.MM.DD');

-- 부서코드가 'D5', 'D6', 'D9'인 사원의 사번, 이름, 부서코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE 
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D6' OR DEPT_CODE = 'D9';

/* 컬럼명 [NOT] IN (값1, 값2, 값3 ...)
 * 컬럼값이 IN () 안에 존재한다면 참
 * 연속으로 OR 연산을 작성한 것과 같은 효과
 */

-- 부서코드가 'D5', 'D6', 'D9'인 사원의 사번, 이름, 부서코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE 
FROM EMPLOYEE 
WHERE DEPT_CODE IN ('D5', 'D6', 'D9');

-- 부서코드가 'D5', 'D6', 'D9'가 아닌 사원의 사번, 이름, 부서코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE 
FROM EMPLOYEE 
WHERE DEPT_CODE NOT IN ('D5', 'D6', 'D9');
-- NULL도 조건을 만족하긴 하지만 결과에는 포함이 되지 않음

-- 위 질의문에 NULL인 사원도 포함
SELECT EMP_ID, EMP_NAME, DEPT_CODE 
FROM EMPLOYEE 
WHERE DEPT_CODE NOT IN ('D5', 'D6', 'D9') OR DEPT_CODE IS NULL;

/* LIKE
 * 비교하려는 값이 특정한 패턴을 만족하면 조회
 * 
 * 작성법
 * WHERE 컬럼명 LIKE '패턴'
 * 
 * 패턴에 사용되는 기호(와일드카드)
 * 1. %: 포함
 * 		'%A': A로 끝나는 문자열인 경우 참
 * 		'A%': A로 시작하는 문자열인 경우 참
 * 		'%A%': A를 중간에 포함하는 문자열인 경우 참
 * 2. _: 글자 수
 * 		_ 하나 당 한 글자를 뜻 함
 * 		A___: A로 시작하고 뒤에 3글자인 경우 참
 * 		___A: 앞에 3글자고 마지막은 A로 끝나는 경우 참
 */

-- EMPLOYEE 테이블에서 성이 전 씨인 사원 찾아서 조회
SELECT EMP_NAME 
FROM EMPLOYEE 
WHERE EMP_NAME LIKE '전%';

-- 이름이 수 로 끝나는 사원 찾아 조회
SELECT EMP_NAME 
FROM EMPLOYEE 
WHERE EMP_NAME LIKE '%수';

-- 이름에 하 가 포함된 사원 찾아 조회
SELECT EMP_NAME 
FROM EMPLOYEE 
WHERE EMP_NAME LIKE '%하%';

-- 전화번호가 010으로 시작하는 사원의 이름과 전화번호 조회
SELECT EMP_NAME, PHONE 
FROM EMPLOYEE 
WHERE PHONE LIKE '010%';

SELECT EMP_NAME, PHONE 
FROM EMPLOYEE 
WHERE PHONE LIKE '010________';

-- EMAIL 컬럼에서 @ 앞에 아이디 글자 수가 5글자인 사원의 사번, 이름, 이메일 조회
SELECT EMP_ID , EMP_NAME, EMAIL 
FROM EMPLOYEE 
WHERE EMAIL LIKE '_____@%';

-- EMAIL 아이디 중 _ 앞 글자 수가 3글자인 사원의 사번, 이름, 이메일 조회
SELECT EMP_ID, EMP_NAME, EMAIL 
FROM EMPLOYEE 
WHERE EMAIL LIKE '___#_%' ESCAPE '#'; -- LIKE ESCAPE

/* ORDER BY절
 * SELECT의 조회 결과 집합(RESULT SET)을
 * 원하는 순서로 정렬할 때 사용하는 구문
 *
 * 3) SELECT -- 열 선택
 * 1) FROM -- 테이블 선택
 * 2) WHERE -- 행 선택
 * 4) ORDER BY -- 조회 결과 정렬
 * 
 * 작성법
 * ORDER BY 컬럼명 | 별칭 | 컬럼 순서 | 함수 [ASC / DESC] [NULLS FIRST / NULLS LAST]
 * 
 * 중요!
 * ORDER BY절은 해당 SELECT문 제일 마지막에만 수행
 */

-- EMPLOYEE 테이블의 모든 사원을 이름 오름차순으로 정렬하여 조회
SELECT EMP_NAME 
FROM EMPLOYEE 
ORDER BY EMP_NAME ASC; -- 기본 값이 ASC이므로 생략 가능

-- 급여 내림차순으로 이름, 급여 조회
SELECT EMP_NAME, SALARY 
FROM EMPLOYEE 
ORDER BY SALARY DESC;

-- 부서코드가 D5, D6, D9인 사원의 사번, 이름, 급여, 부서코드를 급여 내림차순으로 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE 
FROM EMPLOYEE 
WHERE DEPT_CODE IN ('D5', 'D6', 'D9')
ORDER BY SALARY DESC;

-- 부서코드가 D5, D6, D9인 사원의 사번, 이름, 급여, 부서코드를 부서코드 오름차순으로 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE 
FROM EMPLOYEE 
WHERE DEPT_CODE IN ('D5', 'D6', 'D9')
ORDER BY DEPT_CODE ASC;

/* 별칭을 이용하여 정렬 
 * ORDER BY절은 제일 마지막에 해석
 * ORDER BY절보다 먼저 해석된 SELECT절의 별칭을 ORDER BY절에서 인식 가능
 * 이에 따르면 SELECT절보다 WHERE절이 먼저 해석되기 때문에 WHERE절에서는 별칭 사용 불가
 */

-- 사번, 이름, 연봉을 연봉 오름차순으로 정렬
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY * 12 연봉
FROM EMPLOYEE 
ORDER BY 연봉 ASC;

-- 연봉이 5천만 이상인 사원의 사번, 이름, 연봉을 연봉 오름차순으로 정렬
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY * 12 연봉
FROM EMPLOYEE 
WHERE SALARY * 12 >= 50000000
ORDER BY 연봉 ASC;

/* 컬럼 순서를 이용하여 정렬
 * SELECT절이 해석되면 조회하려는 컬럼이 지정되면서 컬럼의 순서도 같이 지정
 * ORDER BY에서 이용할 수 있음 단, 권장하는 방법은 아님
 */

-- 급여가 400만 이상 600만 이하인 사원의 사번, 이름, 급여를 급여 내림차순으로 조회
SELECT EMP_ID, EMP_NAME, SALARY 
FROM EMPLOYEE 
WHERE SALARY BETWEEN 4000000 AND 6000000
ORDER BY 3 DESC; -- SELECT절에서 지정된 순서로 정렬 기준 지정

/* SELECT절에 작성되지 않은 컬럼을 이용해 정렬 */

-- 모든 사원의 사번, 이름을 부서코드 오름차순으로 조회
SELECT EMP_ID, EMP_NAME 
FROM EMPLOYEE 
ORDER BY DEPT_CODE ASC;

-- NULLS FIRST, NULLS LAST 확인
SELECT EMP_NAME, BONUS 
FROM EMPLOYEE 
ORDER BY BONUS ASC NULLS FIRST; -- 오름차순 기본값은 NULLS LAST, 내림차순은 NULLS FIRST

/* 정렬기준 중첩 작성
 * 먼저 작성된 정렬을 적용하고 그 안에서 형성된 그룹별로 정렬을 진행
 * 
 * 형성되는 그룹: 같은 컬럼 값을 가지는 행
 */

-- EMPLOYEE 테이블에서 이름, 부서코드, 급여를 부서코드 오름차순, 급여 내림차순으로 정렬해서 조회
SELECT EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE 
ORDER BY DEPT_CODE ASC, SALARY DESC;

-- EMPLOYEE 테이블에서 이름, 부서코드, 직급코드를 부서코드 오름차순, 직급코드 내림차순, 이름 오름차순으로 정렬하고 조회
SELECT EMP_NAME 이름, DEPT_CODE 부서코드, JOB_CODE 직급코드 
FROM EMPLOYEE 
ORDER BY 부서코드 ASC, 직급코드 DESC, 이름 ASC;