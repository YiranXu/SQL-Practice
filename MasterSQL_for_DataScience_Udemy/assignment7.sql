/*Assignment 7: ADVANCED Problems using Joins, Grouping and Subqueries
The questions that follow will be related to the tables that you created in assignment one. Query those tables and try to figure out how the data is related. Those tables are: students, courses, student_enrollment, professors, and teach. The follow problems are related to these.*/

/*Q1. Are the tables student_enrollment and professors directly related to each other? Why or why not?*/

/*No. They are not directly related to each other. They don't have common columns.*/

/*Q2. Write a query that shows the student's name, the courses the student is taking and the professors that teach that course.*/
SELECT s.student_name,cs.course_no,pr.last_name
FROM students s INNER JOIN student_enrollment e ON s.student_no=e.student_no
	 INNER JOIN teach te ON te.course_no=e.course_no
	 INNER JOIN courses cs ON te.course_no=cs.course_no
	 JOIN professors pr ON te.last_name=pr.last_name
ORDER BY s.student_name
/*Q3.If you execute the query from the previous answer, you'll notice the student_name and the course_no is being repeated. Why is this happening?*/
/*Because 1. student name is not unique, some names such as Michael are repeated name for multiple students.
2.Some courses are taught by multiple professors*/

/*Q4.In question 3 you discovered why there is repeating data. 
How can we eliminate this redundancy? 
Let's say we only care to see a single professor teaching a course and we don't care for all the other professors that teach the particular course. 
Write a query that will accomplish this so that every record is distinct.*/
SELECT s.student_name,cs.course_no,MIN(pr.last_name) 
FROM students s INNER JOIN student_enrollment e ON s.student_no=e.student_no
	 INNER JOIN teach te ON te.course_no=e.course_no
	 INNER JOIN courses cs ON te.course_no=cs.course_no
	 JOIN professors pr ON te.last_name=pr.last_name
GROUP BY s.student_name,cs.course_no
ORDER BY s.student_name,cs.course_no 

/*Q5.Why are correlated subqueries slower that non-correlated subqueries and joins?*/
/*Because for correlated subquery, every row of outer query will run the subquery once using the value from outer query.
For non-correlated subquery, the subquery will run only once at the begining.*/

/*Q6.In the video lectures, we've been discussing the employees table and the departments table. 
Considering those tables, write a query that returns employees whose salary is above average for their given department.*/

SELECT * 
FROM employees outere
WHERE salary > (SELECT AVG(salary)FROM employees innere WHERE outere.department=innere.department)

/*Q7.Write a query that returns ALL of the students as well as any courses they may or may not be taking.*/
SELECT s.student_no,s.student_name,se.course_no 
FROM students s LEFT JOIN student_enrollment se 
				ON s.student_no=se.student_no

