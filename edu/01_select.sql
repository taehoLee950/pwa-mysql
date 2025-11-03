-- 테이블 전체 컬럼 조회
SELECT *
FROM employees;

-- 특정 컬럼만 지정하여 조회
SELECT
	NAME
   ,birth 
	,hire_at
FROM employees;

-- WHERE 절: 특정 컬럼의 값과 일치한 데이터만 조회
SELECT *
FROM employees
WHERE
	emp_id = 5
;

SELECT *
FROM employees
WHERE
	NAME = "강영화"
;

-- 이름이 강영화 이고, 성별이 M인 사원 조회
SELECT * 
FROM employees
WHERE
	NAME = '강영화'
	AND gender ='m'
;

-- 날짜를 필터링 할 경우
SELECT *
FROM employees
WHERE
	hire_at >= '2023-01-01'
;

-- 아직 재직중인 사원들만 조회
SELECT *
FROM employees
WHERE
	fire_at IS NOT NULL
;
-- WHERE 절에서 AND/OR 복합 사용시 주의
-- 입사일이 250101 이후거나, 000101 이전이고,
-- 이미 퇴사한 직원
SELECT *
FROM employees
WHERE
	(
		hire_at >= '2025-01-01'
		OR hire_at <= '2000-01-01'
	)
		AND fire_at IS NOT null
	;

-- BETWEEN:범위를 지정하여 조회
SELECT *
FROM employees
WHERE
	emp_id BETWEEN 10000 AND 10010
;

-- in: 지정한 값과 일치한 데이터 조회
-- 사번이 5, 7, 9, 12 사원 조회
SELECT *
FROM employees
WHERE
	emp_id IN(5, 7, 9, 12)
;

-- LIKE: 문자열 내용을 조회할 때 사용
-- % : 글자수와 상관없이 조회
-- _ : 글자수에 맞춰 조회
SELECT *
FROM employees
WHERE
	NAME LIKE '%태호'
;

SELECT *
FROM employees
WHERE
	NAME LIKE '태호%'
;

SELECT *
FROM employees
WHERE
	NAME LIKE '%호%'
;

-- '_' : 언더바로 글자 개수를 한정하여 조회
SELECT *
FROM employees
WHERE
	NAME LIKE '호%'
;

-- ORDER BY: 데이터 정렬
-- ASC: 오름차순
-- DESC: 내림차순
SELECT *
FROM employees
ORDER BY NAME ASC
;

SELECT *
FROM employees
ORDER BY NAME DESC
;

SELECT *
FROM employees
ORDER BY NAME DESC, birth ASC
;

-- 입사일이 2000년 이후인 사원을 
-- 이름, 생일, 오름차순으로 정렬해서 조회
SELECT *
FROM employees
WHERE
	hire_at >= '2000-01-01'
ORDER BY NAME ASC, birth ASC
;

-- 여자 사원을 이름, 생일 오름차순으로 정렬
SELECT *
FROM employees
WHERE
 gender = 'F'
ORDER BY NAME ASC, birth ASC
;

-- DISTINCT 키워드: 검색결과에서 중복되는 레코드를 제거
SELECT distinct NAME
FROM employees
ORDER BY NAME ASC
;
-- GROUP BY 절: 그룹으로 묶어서 조회
-- HAVING 절: GROUP BY절의 조건식
-- 사원 별 최고 연봉
 -- MAX() = 최대값
--  MIN() = 최소값
--  COUNT() = 개수
--  AVG() = 평균
--  SUM() = 합계
SELECT 
	emp_id
	,MAX(salary) AS MAX_salary
FROM salaries
GROUP BY emp_id
;

-- 사원 별 최고 연봉이 5천만원 이상인 사원 조회
SELECT
	emp_id
	,MAX(salary) max_salary
FROM salaries
GROUP BY emp_id
	HAVING max_salary >= 50000000
;

-- 성별에 따른 사원 수를 조회해 주세요
SELECT 
 gender 
 ,COUNT(gender) AS count_gender
FROM employees
GROUP BY gender
;

-- 재직중인 성별 사원수 조회
SELECT
	gender
	,COUNT(gender) AS count_gender
FROM employees
WHERE 
	fire_at IS null
GROUP BY gender
;

SELECT
	gender
	,COUNT(gender) AS count_gender
FROM employees
GROUP BY gender
;

-- LIMIT, OFFSET: 출력하는 데이터의 개수를 제한
-- 사원번호로 오름차순 정렬해서 10개만 조회
SELECT *
FROM employees
ORDER BY emp_id ASC
LIMIT 10 OFFSET 10
;

-- 현재 상위 연봉 5명 조회
SELECT *
FROM salaries
WHERE
	end_at IS NULL
ORDER BY salary DESC
LIMIT 5
;

-- SELECT문의 기본 구조
SELECT [DISTINCT] [컬럼명]
FROM [테이블명]
WHERE [쿼리 조건]
GROUP BY [컬럼명] HAVING [집계함수 조건]
ORDER BY [컬럼명 ASC || 컬럼명 DESC]
LIMIT [n] OFFSET [n]
;