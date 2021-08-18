/*Assignment 5: Practice with Subqueries*/
--1. Is the students table directly related to the courses table? Why or why not?

/*No. They are not directly related. Because there is no common column.*/

/*--2. Using subqueries only, write a SQL statement that returns the names of those students that are taking the courses Physics and US History.*/
SELECT student_name FROM students 
WHERE student_no IN (
SELECT student_no FROM student_enrollment
WHERE course_no IN
(SELECT course_no FROM courses WHERE course_title='Physics' or course_title='US History'))

--or change "or" to IN()
SELECT student_name FROM students 
WHERE student_no IN (
SELECT student_no FROM student_enrollment
WHERE course_no IN
(SELECT course_no FROM courses WHERE course_title IN ('Physics','US History')))

/*3.Using subqueries only, write a query that returns the name of the student that is taking the highest number of courses.*/
SELECT student_name FROM students 
WHERE student_no IN(
SELECT student_no FROM student_enrollment
GROUP BY student_no
ORDER BY COUNT(course_no) DESC
LIMIT 1)

/*4.Answer TRUE or FALSE for the following statement:

Subqueries can be used in the FROM clause and the WHERE clause but cannot be used in the SELECT Clause.

Answer:FALSE. Subqueries can be used in the FROM, WHERE, SELECT and even the HAVING clause.*/

/*5.Write a query to find the student that is the oldest. You are not allowed to use LIMIT or the ORDER BY clause to solve this problem.*/
SELECT *
FROM students 
WHERE age=(SELECT max(age) FROM students)
--methon2 (a faster solution)
SELECT * 
FROM students s1 INNER JOIN (SELECT max(age) FROM students) s2 on s1.age=s2.max
--method3 (window function)
SELECT *
FROM (SELECT *,ROW_NUMBER() OVER(ORDER BY age DESC) rn FROM students ) src
WHERE rn=1


