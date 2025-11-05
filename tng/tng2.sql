-- DELETE 문
SELECT *
FROM salaries
WHERE emp_id = 100005
;

DELETE FROM salaries
WHERE
 emp_id = 100005
;

DELETE FROM employees
WHERE
 emp_id = 100005
;

SELECT *
FROM employees
WHERE
 emp_id = 100005
;

-- inner join
-- 여러 테이블이 공통적으로 만족하는 레코드를 출력
-- 전 사원의 사번, 이름, 현재 급여를 출력
SELECT
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
ORDER BY emp.emp_id ASC
;

-- 재직중인 사원의 사번, 이름, 생일, 부서명
SELECT
	depe.emp_id
	,emp.`name`
	,emp.birth
	,dept.dept_name
FROM department_emps depe
	JOIN departments dept
		ON depe.dept_code = dept.dept_code
		 AND depe.end_at IS null
	JOIN employees emp
		ON depe.emp_id = emp.emp_id
			AND emp.fire_at IS null
WHERE
	depe.end_at IS NULL
;

-- LEFT JOIN
SELECT
	emp.*
	,sal.*
FROM employees emp
	LEFT JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS null
;

-- 두개 이상의 쿼리의 결과를 합쳐서 출력
-- UNION (중복 레코드 제거)
-- UNION ALL (중복 레코드 제거 X 통합 O)
SELECT * FROM employees WHERE emp_id IN(1, 3)
UNION ALL
SELECT * FROM employees WHERE emp_id IN(3, 6)
;

-- self join
--  같은 테이블에 두번 조인
SELECT
	emp.emp_id AS junior_id
	,emp.`name`AS junior_name
	,supvid.emp_id AS supervisor_id
	,supvid.`name` AS supervisor_name
FROM employees emp
	JOIN employees supvid
		ON emp.sup_id = supvid.emp_id
		AND emp.sup_id IS NOT null
;

-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,titleE.title_code
FROM employees emp
	JOIN title_emps titleE
		ON emp.emp_id = titleE.emp_id
			AND titleE.end_at IS NULL
ORDER BY titleE.title_code ASC
;
-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.
SELECT
	emp.emp_id
	,emp.gender
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
			AND emp.fire_at IS NULL
ORDER BY sal.salary ASC
;
-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.
SELECT 
	sal.salary
	,emp.`name`
FROM salaries sal
	JOIN employees emp
		ON emp.emp_id = sal.emp_id
WHERE
	emp.emp_id = 10010
;
-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,dept.dept_name
FROM employees emp
	JOIN department_emps deptE
		ON emp.emp_id = deptE.emp_id
			AND deptE.end_at IS null
	JOIN departments dept
		ON dept.dept_code = deptE.dept_code
;
-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
-- sal과 emp의 대량 레코드 조회 + 대량 레코드 order by로 인해 쿼리속도가 1초대로 느림
SELECT
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
			AND emp.fire_at IS NULL
ORDER BY sal.salary DESC
LIMIT 10
;

-- 5 - 1. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요. 
SELECT
	emp.emp_id
	,emp.`name`
	,tmp_sal.salary
FROM employees emp
	JOIN (
		SELECT
			sal.emp_id
			,sal.salary
		FROM salaries sal
		WHERE
			sal.end_at IS null
		ORDER BY sal.salary desc
		LIMIT 10
	) tmp_sal
		ON emp.emp_id = tmp_sal.emp_id
ORDER BY tmp_sal.salary DESC
;
-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
SELECT
	dept.dept_name
	,emp.`name`
	,emp.hire_at
FROM employees emp
 	JOIN department_managers deptM
 		ON emp.emp_id = deptM.emp_id
	JOIN departments dept
		ON deptM.dept_code = dept.dept_code
WHERE
	emp.fire_at IS NULL
 	AND deptM.end_at IS NULL
ORDER BY dept.dept_code ASC
;
-- 7. 현재 직급이 "부장"인 사원들의 연봉 평균을 출력해 주세요.
SELECT
	truncate(AVG(sal.salary), 0) avg_sal_T005	
FROM titles tt
	JOIN title_emps ttE
		ON tt.title_code = ttE.title_code
		AND tt.title = '부장'
		AND ttE.end_at IS NULL
	JOIN salaries sal
		ON ttE.emp_id = sal.emp_id
		AND sal.end_at IS NULL
;
-- 7-1 현재 각 부장별 이름, 연봉평균
SELECT
	emp.`name`
	,AVG(sal.salary) avg_sal
FROM title_emps titleE
	JOIN salaries sal
		ON sal.emp_id = titleE.emp_id
		AND sal.end_at IS NULL
	JOIN employees emp
		ON emp.emp_id = titleE.emp_id
		AND emp.fire_at IS NULL
WHERE
	titleE.title_code = 'T005'
	AND titleE.end_at IS NULL
GROUP BY titleE.emp_id, emp.`name`
;
-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.
SELECT
	emp.`name`
	,emp.hire_at
	,emp.emp_id
	,deptM.dept_code
FROM employees emp
	JOIN department_managers deptM
		ON deptM.emp_id = emp.emp_id
;
-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 직급의 직급명, 평균연봉(정수)를을
--		평균연봉 내림차순으로 출력해 주세요.
SELECT
	title.title
	,truncate(avg(sal.salary), 0) avg_sal
FROM salaries sal
	JOIN title_emps titleE
		ON sal.emp_id = titleE.emp_id
		AND titleE.end_at IS NULL
		AND sal.end_at IS NULL
	JOIN titles title
	 ON title.title_code = titleE.title_code
GROUP BY title.title
	HAVING avg_sal >= 60000000
ORDER BY avg_sal desc
;
-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.
SELECT
	tt.title
	,count(emp.gender) f_total
FROM employees emp
	JOIN title_emps titleE
		ON emp.emp_id = titleE.emp_id
	JOIN titles tt
		ON tt.title_code = titleE.title_code
WHERE
	emp.gender = 'F'
	AND emp.fire_at IS NULL
	AND titleE.end_at IS NULL
GROUP BY tt.title
ORDER BY f_total ASC
; 