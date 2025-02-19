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