--1.List the teachers who have NULL for their department.

SELECT name FROM teacher
WHERE dept is NULL

--2.Note the INNER JOIN misses the teachers with no department and the departments with no teacher.

SELECT teacher.name, dept.name FROM teacher 
INNER JOIN dept ON (teacher.dept=dept.id)

--3.Use a different JOIN so that all teachers are listed.

SELECT t.name,d.name from teacher t
LEFT JOIN dept d on t.dept=d.id

--4.Use a different JOIN so that all departments are listed.

select t.name,d.name from teacher t
RIGHT join dept d on t.dept=d.id

--5.Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given.
--Show teacher name and mobile number or '07986 444 2266'

SELECT name,coalesce(mobile,'07986 444 2266') from teacher

--6.Use the COALESCE function and a LEFT JOIN to print the teacher name and department name.
--Use the string 'None' where there is no department.

select t.name,coalesce(d.name,'None') from teacher t
left join dept d on d.id=t.dept

--7.Use COUNT to show the number of teachers and the number of mobile phones.
SELECT COUNT(name) as no_teachers,COUNT(mobile) as no_mobiles
FROM teacher

--8.Use COUNT and GROUP BY dept.name to show each department and the number of staff.
--Use a RIGHT JOIN to ensure that the Engineering department is listed

SELECT d.name,count(t.id) AS no_staff from teacher t
RIGHT JOIN dept d on t.dept=d.id
GROUP BY d.name

--9.Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.

SELECT name,
case when dept=1 or dept=2 then 'Sci' else 'Art' END as department
FROM teacher

--10.Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2,
--show 'Art' if the teacher's dept is 3 and 'None' otherwise.

SELECT name,
    CASE when dept in (1,2) THEN 'Sci' when dept=3 then 'Art' ELSE 'None' END
from teacher

