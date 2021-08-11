/*Assignment 3*/
--1.Write a query against the professors table that can output the following in the result: "Chong works in the Science department"
SELECT last_name|| ' '||'works in the '||department||' department' FROM professors

/*2. Write a SQL query against the professors table that would return the following result:

"It is false that professor Chong is highly paid"
"It is true that professor Brown is highly paid"
"It is false that professor Jones is highly paid"
"It is true that professor Wilson is highly paid"
"It is false that professor Miller is highly paid"
"It is true that professor Williams is highly paid"

NOTE: A professor is highly paid if they make greater than 95000.

*/

SELECT CASE WHEN salary >95000 THEN ('It is true that professor '|| last_name || 'is highly paid')
ELSE ('It is false that professor '|| last_name || 'is highly paid')
END
FROM professors

--method2
SELECT 'It is ' || (salary > 95000) ||

' that professor ' || last_name || ' is highly paid'

FROM professors

--3.Write a query that returns all of the records and columns from the professors table but shortens the department names to only the first three characters in upper case.
SELECT last_name,salary,hire_date,SUBSTRING(UPPER(department),1,3)as department
FROM professors

--4.Write a query that returns the highest and lowest salary from the professors table excluding the professor named 'Wilson'.
SELECT MAX(salary) as highest_salary,MIN(salary) as lowest_salary
FROM professors
WHERE last_name!='Wilson'

--5.Write a query that will display the hire date of the professor that has been teaching the longest.
SELECT MIN(hire_date)
FROM professors


