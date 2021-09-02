/*Challenging Puzzles*/
--1.Write a query that finds students who do not take CS180.

/*The correct result should include students who take no courses as well as students who take courses but none of them CS180.*/
SELECT *
FROM students
WHERE student_no NOT IN(
SELECT student_no FROM student_enrollment
WHERE course_no='CS180')

--method2
SELECT s.student_no,s.student_name,s.age
FROM students s LEFT JOIN student_enrollment se ON s.student_no=se.student_no
GROUP BY s.student_no,s.student_name,s.age
HAVING MAX(CASE WHEN se.course_no='CS180' THEN 1 ELSE 0 END)=0

--2.Write a query to find students who take CS110 or CS107 but not both.
--method 1
SELECT s.student_no,s.student_name,s.age
FROM students s JOIN student_enrollment se ON s.student_no=se.student_no
GROUP BY s.student_no,s.student_name,s.age
HAVING SUM(CASE WHEN se.course_no IN ('CS110','CS107') THEN 1 ELSE 0 END)=1

/*In method1, a CASE expression is used with the aggregate SUM function to find students who take either CS110 or CS107, but not both.*/
--method2
SELECT s.student_no,s.student_name,s.age
FROM students s JOIN student_enrollment se ON s.student_no=se.student_no
WHERE se.course_no IN ('CS110','CS107') 
AND s.student_no NOT IN
(SELECT a.student_no FROM student_enrollment a, student_enrollment b
WHERE a.student_no = b.student_no
AND a.course_no = 'CS110'
AND b.course_no = 'CS107')
/*It uses a self join on the student_enrollment table so that those students are narrowed down that take both CS110 and CS107 in the subquery. 
The outer query filters for those student_no that are not the ones retrieved from the subquery.*/

--3.Write a query to find students who take CS220 and no other courses.
SELECT s.student_no,s.student_name,s.age
FROM students s JOIN student_enrollment se ON s.student_no=se.student_no
GROUP BY s.student_no,s.student_name,s.age
HAVING SUM(CASE WHEN se.course_no='CS220'THEN 0 ELSE 1 END)=0  
/*because students on student_enrollment table must take at least one course, so students that didn't take any course are ruled out.
If students did not take CS220, then the value will be at least 1. 
If the students take more than CS220, the value will be at least 1 as well.*/

--method2
SELECT s.*
FROM students s, student_enrollment se
WHERE s.student_no = se.student_no
AND s.student_no NOT IN ( SELECT student_no
                          FROM student_enrollment
                          WHERE course_no != 'CS220')

/*The outer query gets all students regardless of what course they take. 
In essence, the subquery finds all students who take a course that is not CS220. 
The outer query returns all student who are not amongst those that take a course other than CS220. 
At this point, the only available students are those who actually take CS220 or take nothing at all.

It's better to draw a vein diagram to show the relations*/

--method3
SELECT s.student_no,s.student_name,s.age
FROM student_enrollment se JOIN 
(SELECT student_no FROM student_enrollment GROUP BY student_no HAVING COUNT(*)=1) se1
ON se.student_no=se1.student_no JOIN students s on s.student_no=se.student_no 
WHERE course_no='CS110'

/*4.Write a query that finds those students who take at most 2 courses. 
Your query should exclude students that don't take any courses as well as those that take more than 2 course.*/

SELECT s.student_no,s.student_name,s.age
FROM students s JOIN 
(SELECT student_no FROM student_enrollment
GROUP BY student_no
HAVING count(course_no)<=2) se
ON s.student_no=se.student_no

/*5. Write a query to find students who are older than at most two other students.*/
SELECT s1.*
FROM students s1
WHERE 2>= (SELECT COUNT(*) FROM students s2 WHERE s1.age>s2.age)
ORDER BY age






