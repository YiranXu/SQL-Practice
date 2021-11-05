--https://platform.stratascratch.com/coding/10299-finding-updated-records
/*We have a table with employees and their salaries, 
however, some of the records are old and contain outdated salary information. 
Find the current salary of each employee assuming that salaries increase each year. 
Output their id, first name, last name, department ID, and current salary. Order your list by employee ID in ascending order.
*/
select DISTINCT id,first_name,last_name,department_id,max(salary) OVER(PARTITION BY id) current_salary
from ms_employee_salary
ORDER BY id ASC
