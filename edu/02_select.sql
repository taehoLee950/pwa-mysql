-- INSERT 문
-- 신규 데이터를 저장하기위해 사용하는 문법
INSERT INTO employees(
	`name`
	,birth
	,gender
	,hire_at
	,fire_at
	,sup_id
	,created_at
	,updated_at
	,deleted_at
)
VALUES(
	'이태호'
	,'1995-02-17'
	,'M'
	,'2025-10-31'
	,NULL
	,NULL
	,NOW() 
	,NOW()
	,NULL
)
;

SELECT *
FROM employees
WHERE
	`name` = '이태호'
	AND birth = '1995-02-17'
	AND hire_at = '2025-10-31'
;

INSERT INTO salaries(
	emp_id
	,salary
	,start_at
)
VALUES(
	100005
	,4800000000
	,NOW()
)
;

-- SELECT INSERT
INSERT INTO salaries (
	emp_id
	,salary
	,start_at
)
SELECT
	emp_id
	,30000000 AS salary
	,created_at
FROM employees
WHERE
	`name` = '이태호'
	AND birth = '1995-02-17'
;