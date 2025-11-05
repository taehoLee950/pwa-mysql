-- 내장함수: 데이터 처리/분석 사용 프로그램

-- 데이터 타입 변환 함수
SELECT
	1234
	,CAST(1234 AS CHAR(4))
	,CONVERT(1234, CHAR(4))
;

-- 제어 흐름 함수
-- IF(수식, 참일 때, 거짓일 때)
-- 수식의 결과에 따라 분기 처리를 하는 함수
SELECT
	emp_id
	,`name`
	,IF(gender = 'M', '남자', '여자') AS ko_gender
FROM employees
;

-- CASE 문
SELECT
	emp_id
	,`name`
	,case gender
		when 'm' then '남자'
		when 'f' then '여자'
		ELSE '성별없음'
	END AS ko_gender
from employees
;

-- IFNULL (수식1, 수식2)
-- 수식1이 null일 시 수식2 반환
-- NULL이 아니면 수식1 반환
SELECT
	emp_id
	,IFNULL(end_at, '9999-12-31') AS end_at
FROM title_emps
;

-- NULLIF(수식1, 수식2)
-- 수식1과 수식2가 일치하는지 선 체크,
-- 참일시 null 반환, 거짓이면 수식1 반환
SELECT
	emp_id
	,`name`
	,NULLIF(gender, 'F')
FROM employees
;

-- 문자열 함수
-- concat(문자열1, 문자열2, ...)
-- 문자열을 연결하는 함수
SELECT CONCAT('안녕하세요.', ' 띄어쓰기  ', 'DB입니다');
SELECT CONCAT(gender, `name`) from employees;

-- concat_ws(구분자, 문자열1, 문자열2...)
-- 문자열 사이에 구분자를 넣어 연결하는 함수
SELECT CONCAT_WS(',', '딸기', '바나나', '수박');
SELECT CONCAT_WS('--', gender, `name`) FROM employees;


-- FORMAT(숫자, 소수점 자리수)
-- 숫자를 소수점 자릿수에 맞는 문자열을 반환하는 함수
SELECT FORMAT(39596, 7);

-- LEFT(문자열, 숫자)
-- 문자열을 왼쪽부터 숫자길이 만큼 잘라 반환
SELECT LEFT('abcdef', 2);

-- RIGHT(문자열, 숫자)
-- 문자열을 오른쪽부터 숫자길이 만큼 잘라 반환
SELECT RIGHT('abcdef', 2);

-- UPPER(문자열), LOWER(문자열)
-- 영어 대/소문자로 변환
SELECT UPPER('aBcDe'); 
SELECT LOWER('aBcDe');

-- LPAD(문자열, 길이, 채울 문자열)
-- RPAD(문자열, 길이, 채울 문자열)
-- 문자열을 포함해 길이만큼 채울 문자열을 
-- 좌/우에 삽입 후 반환
SELECT LPAD('12', 4, '0');

-- TRIM(문자열, RTRIM(문자열), LTRIM(문자열)
-- (좌우/우/좌) 공백을 제거
SELECT
	TRIM('    TRIM')
	,RTRIM('      TRIM    ')
	,LTRIM('      TRIM    ')
;

-- TRIM(방향 문자열1 FROM 문자열2)
-- 방향을 지정해서 문자열 2에서 문자열1을 제거하여 반환
-- 방향: LEADING(좌), BOTH(좌우), TRAILING(우)
-- 'Bearer 34kdinvOQKWMSCX9203'
SELECT TRIM(LEADING 'Bearer' FROM 'Bearer 34kdinvOQKWMSCX9203');
SELECT TRIM(TRAILING '9203' FROM 'Bearer 34kdinvOQKWMSCX9203');

-- SUBSTRING(문자열, 시작위치, 길이)
-- 문자열을 시작위치에서 길이만큼 잘라서 반환
SELECT SUBSTRING('abcdef', 3, 2);

-- SUBSTRING_INDEX(문자열, 구분자, 횟수)
-- 왼쪽부터 구분자가 횟수번째에 나오면 그 이후 문자열을 버림
-- 횟수를 음수로 설정시, 오른쪽부터 적용
SELECT SUBSTRING_INDEX('이태호_그린_테스트', '_', 2);

-- 수학 함수
-- CEILING(값) : 올림
-- FLOOR(값): 버림
-- ROUND(값) : 반올림
SELECT CEILING(1.2), FLOOR(1.9), ROUND(1.5);

-- TRUNCATE(값, 정수)
-- 소수점 기준으로 정수위치까지 구하고 나머지는 버림
SELECT TRUNCATE(3.141592, 2);

-- 날짜 및 시간 함수
-- NOW() : 현재 날짜 및 시간을 반환 (YYYY-MM-DD HH:mm:ss)
SELECT NOW();

-- DATE(데이트 타입의 값) : 시분초를 생략 
SELECT DATE(NOW());

-- ADDDATE(날짜1, INTERVAL 숫자 기준)
-- 날짜1에서 기준에 따라 숫자만큼 더해서 반환
SELECT ADDDATE(NOW(), INTERVAL 1 YEAR);

-- 집계함수
-- SUM, MAX, MIN, COUNT, AVG
SELECT
	SUM(salary)
	,max(salary)
	,min(salary)
	,count(salary)
	,avg(salary)
FROM salaries;

-- count(*): 검색 결과의 총 레코드 수를 출력(NULL 포함)
-- COUNT(컬럼명): NULL 비포함

-- 순위 함수
-- 컬럼의 값의 랭크를 매김
-- rank() over(order by column asc/desc)
SELECT
	emp_id
	,salary
	,RANK() OVER(ORDER BY salary ASC) AS sal_rank
FROM salaries
LIMIT 5
;

-- 레코드의 값의 랭크를 매김
-- rank_number() over(order by column asc/desc)
SELECT
 emp_id
 ,salary
 ,ROW_NUMBER() OVER(ORDER BY salary ASC) AS sal_rank
FROM salaries
LIMIT 5
;


-- d001 부서장의 사번과 이름을 출력
SELECT *
FROM department_managers
WHERE
	dept_code = 'd001'
	AND end_at IS null
;

-- 위의 쿼리를 서브쿼리로 사용
-- 참조 테이블도 표기
SELECT
	emp.emp_id
	, emp.`name`
FROM employees emp
WHERE
	emp.emp_id = (
	SELECT dept.emp_id
	FROM department_managers dept
	where
	dept.dept_code = 'd001'
	AND dept.end_at IS null
	)
;

-- 현재 부서장인 사원의 사번과 이름을 출력
SELECT
	emp.emp_id
	, emp.`name`
FROM employees emp
WHERE
	emp.emp_id in (
	SELECT dept.emp_id
	FROM department_managers dept
	where
	 dept.end_at IS null
	)
;

-- 다중 열 서브쿼리
-- 서브쿼리의 결과가 복수의 컬럼을 반환 할 경우,
-- 메인 쿼리의 조건과 동시비교
-- 현재 D002의 부서장이 해당 부서에 소속된 날짜 출력
SELECT
 department_emps.*
FROM department_emps
WHERE
	(department_emps.emp_id, department_emps.dept_code) IN (
	select
		department_managers.emp_id
		,department_managers.dept_code
		FROM department_managers
		where
			department_managers.dept_code = 'd002'
			AND department_managers.end_at IS null
		)
;

-- 연관 서브쿼리
-- 서브쿼리 내에서 메인쿼리의 컬럼이 사용된 서브쿼리
-- 부서장 직을 지냈던 경력이 있는 사원의 정보 출력
SELECT
	emp.*
FROM employees emp
WHERE 
	emp.emp_id IN (
		SELECT dep_m.emp_id
		FROM department_managers dep_m
		WHERE
			dep_m.emp_id = emp.emp_id
	)
;

-- SELECT 절에서 사용
-- 사원별 역대 전체 급여 평균
SELECT
	emp.emp_id
	,(
		SELECT AVG(sal.salary)
		FROM salaries sal
		WHERE emp.emp_id = sal.emp_id
	) avg_sal
FROM employees emp
;

-- FROM 절에서 서브쿼리 사용
SELECT
	tmp.*
FROM (
	SELECT
		emp.emp_id
		,emp.`name`
	FROM employees emp
) tmp
;

-- insert문에서 서브쿼리 사용
INSERT INTO title_emps(
	emp_id
	,title_code
	,start_at
)
VALUES(
	(SELECT MAX(emp_id) FROM employees)
	,(SELECT title_code FROM titles WHERE title = '사원')
	,DATE(NOW())
)
;


-- update문에서 사용
UPDATE title_emps title1
SET
	title1.end_at = (
		SELECT emp.fire_at
		from employees emp
		WHERE emp.emp_id = 100000
	)
WHERE
	title1.emp_id = 100000
	AND title1.end_at IS null
;

SELECT *
FROM employees
WHERE
	emp_id = 100000
;

-- 1. 직급테이블의 모든 정보를 조회해주세요.
SELECT *
FROM titles
;
-- 2. 급여가 60,000,000 이하인 사원의 사번을 조회해 주세요.
SELECT 
	sal.emp_id
	,sal.salary
FROM salaries sal
WHERE
	end_at IS null
	AND salary <= 60000000
;
-- 3. 급여가 60,000,000에서 70,000,000인 사원의 사번을 조회해 주세요.
SELECT
	sal.emp_id
	,sal.salary
FROM salaries sal
WHERE
	end_at IS null
	and salary BETWEEN 60000000 AND 70000000
;
-- 4. 사원번호가 10001, 10005인 사원의 사원테이블의 모든 정보를 조회해 주세요.
SELECT emp.*
FROM employees emp
WHERE
	emp_id IN(10001, 10005)
;
-- 5. 직급에 '사'가 포함된 직급코드와 직급명을 조회해 주세요.
SELECT
	title.title_code
	,title.title
FROM titles title
WHERE title.title LIKE '%사%'
;
-- 6. 사원 이름 오름차순으로 정렬해서 조회해 주세요.
SELECT 
	emp.name
FROM employees emp
ORDER BY 
	emp.`name` ASC
;
-- 7. 사원별 전체 급여의 평균을 조회해 주세요.
SELECT 
	sal.emp_id
	,truncate(avg(salary), 0) avg_salary 
FROM salaries sal
GROUP BY 
	sal.emp_id
;
-- 8. 사원별 전체 급여의 평균이 30,000,000 ~ 50,000,000인,
-- 사원번호와 평균급여를 조회해 주세요.
SELECT
	sal.emp_id
	,truncate(avg(salary), 0) avg_salary
FROM salaries sal
GROUP BY sal.emp_id
	having
	avg_salary BETWEEN 30000000 AND 50000000 
;

-- 9. 사원별 전체 급여 평균이 70,000,000이상인,
-- 사원의 사번, 이름, 성별을 조회해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,emp.gender
FROM employees emp
WHERE
	emp.emp_id IN (
		SELECT 
			sal.emp_id
		FROM salaries sal
		GROUP BY sal.emp_id
		HAVING AVG(salary) >= 70000000
	)
;
-- 10. 현재 직급이 'T005'인,
-- 사원의 사원번호와 이름을 조회해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
FROM employees emp
WHERE
	emp.emp_id IN (
		SELECT
			title.emp_id
		FROM title_emps title
		WHERE
			title.end_at IS null
			AND title.title_code = 'T005'		
	)
;