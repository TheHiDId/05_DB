-- 1번
-- 학생이름과 주소지를 조회하시오
-- 단, 출력 헤더는 "학생 이름", "주소지"로 하고, 정렬은 이름으로 오름차순 정렬
SELECT STUDENT_NAME AS "학생 이름", STUDENT_ADDRESS AS "주소지"
FROM TB_STUDENT 
ORDER BY STUDENT_NAME ASC;

-- 2번
-- 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서 조회하시오
SELECT STUDENT_NAME AS "이름", STUDENT_SSN AS "주민번호" 
FROM TB_STUDENT 
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;

-- 10번
-- 음악학과 학생들의 "학번", "학생 이름", "전체 평점"을 조회하시오.
-- (단, 평점은 소수점 1자리까지만 반올림하여 표시한다.)
SELECT STUDENT_NO, STUDENT_NAME, (
	SELECT ROUND(AVG(POINT), 1)
	FROM TB_GRADE
	GROUP BY STUDENT_NO
)
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '059';