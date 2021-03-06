/*
The Employee table holds all employees. Every employee has an Id, a salary, and there is also a column for the department Id.

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
The Department table holds all departments of the company.

+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
Write a SQL query to find employees who have the highest salary in each of the departments. For the above tables, your SQL query should return the following rows (order of rows does not matter).

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
+------------+----------+--------+
*/

SELECT d.name AS department, e.name AS employee, salary
FROM employee e
JOIN department d
ON e.departmentid=d.id
WHERE (departmentid, salary) IN 
        (SELECT departmentid, MAX(salary)
         FROM employee
         GROUP BY departmentid);
         
--second method:
SELECT e3.department AS department, e1.name AS employee, e1.salary AS salary
FROM employee e1
INNER JOIN (SELECT d.name AS department, MAX(e2.salary) AS maxsalary
	    FROM employee e2
	    LEFT JOIN department d
	    ON e2.departmentid=d.id
	    GROUP BY d.name) AS e3
ON e1.salary=e3.maxsalary;
