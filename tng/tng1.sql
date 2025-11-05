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
