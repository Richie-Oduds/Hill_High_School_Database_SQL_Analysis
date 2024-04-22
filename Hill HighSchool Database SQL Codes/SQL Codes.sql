/* First, I want to know the total number of students that enrolled in Hill High School (Grade 12)
	To do this, I will write a query to count and return the total number of students in grade 12
*/    

SELECT COUNT(*) AS total_students
FROM student_database;


/*
The next question is to look for how many students had a perfect attendance records throughout the semester
  In hill_high_school an attendance of 180 is a perfect attendance for a student.
  Students are to attend classes in a semester a minimum of 170 times and a maximum of 180 times
    in order to have a good assessment.
    */

    SELECT Desk_ID, Student_Name, No_Attendance
    FROM attendance
    WHERE No_Attendance = 180
    LIMIT 10;


/*
This query is to find the total count of students who had a perfect attendance of 180
 */

SELECT COUNT(*) AS total_perfect_attend
FROM attendance
WHERE No_Attendance = 180;


/*
The Total amount of students with Active classroom_remarks
*/

SELECT COUNT(*) AS total_active_students
FROM classroom_remarks
WHERE Classroom_Remark = 'Active';


/*
The total amount of students with Non_active classroom_remarks
*/

SELECT COUNT(*) AS total_non_active_students
FROM classroom_remarks
WHERE Classroom_Remark = 'Non_active';


/*
Total amount of students with Playful classroom_remarks
*/

SELECT COUNT(*) AS total_playful_students
FROM classroom_remarks
WHERE Classroom_Remark = 'Playful';


/*
Using the JOIN statement to find students GPA and their number of attendance
*/

SELECT a.Student_ID, a.Student_Name, p.GPA, a.No_Attendance
FROM attendance a
JOIN percentage_and_grade p
ON a.Student_ID = p.Student_ID
ORDER BY a.No_Attendance DESC
LIMIT 15;


/* Using CASE statement to group and count all students GPAs into their various GPA performance */

SELECT
    CASE
        WHEN GPA BETWEEN 0.0 AND 0.7 THEN '0.0-0.7'
        WHEN GPA BETWEEN 1.0 AND 1.3 THEN '1.0-1.3'
        WHEN GPA BETWEEN 1.7 AND 2.0 THEN '1.7-2.0'
		WHEN GPA BETWEEN 2.3 AND 2.7 THEN '2.3-2.7'
        WHEN GPA BETWEEN 3.0 AND 3.3 THEN '3.0-3.3'
        WHEN GPA BETWEEN 3.7 AND 4.0 THEN '3.7-4.0'
        -- Add more WHEN clauses for other GPA ranges
        ELSE 'Unknown'
    END AS gpa_group,
    COUNT(*) AS gpa_count
FROM percentage_and_grade
GROUP BY
    CASE
		WHEN GPA BETWEEN 0.0 AND 0.7 THEN '0.0-0.7'
        WHEN GPA BETWEEN 1.0 AND 1.3 THEN '1.0-1.3'
        WHEN GPA BETWEEN 1.7 AND 2.0 THEN '1.7-2.0'
		WHEN GPA BETWEEN 2.3 AND 2.7 THEN '2.3-2.7'
        WHEN GPA BETWEEN 3.0 AND 3.3 THEN '3.0-3.3'
        WHEN GPA BETWEEN 3.7 AND 4.0 THEN '3.7-4.0'
        -- Add more WHEN clauses for other GPA ranges
        ELSE 'Unknown'
    END;


/* Using a CASE statement to group and count all students with Distinction in their English, Mathematics and Science
subjects. */

SELECT 
    COUNT(CASE WHEN English = 'Distinction' THEN 1 END) AS English_Distinction,
    COUNT(CASE WHEN Mathematics = 'Distinction' THEN 1 END) AS Mathematics_Distinction,
    COUNT(CASE WHEN Science = 'Distinction' THEN 1 END) AS Science_Distinction
FROM results 
WHERE 
    English = 'Distinction'
    OR Mathematics = 'Distinction'
    OR Science = 'Distinction';


/* Using a CASE statement to group and count all students who failed their English, Mathematics and Science
subjects. */

SELECT 
    COUNT(CASE WHEN English = 'Fail' THEN 1 END) AS English_fail,
    COUNT(CASE WHEN Mathematics = 'Fail' THEN 1 END) AS Mathematics_fail,
    COUNT(CASE WHEN Science = 'Fail' THEN 1 END) AS Science_fail
FROM results 
WHERE 
    English = 'Fail'
    OR Mathematics = 'Fail'
    OR Science = 'Fail';


/* Using a CASE statement to group and count all students in Grade 12 inton their various age groups. */

SELECT 
    CASE 
        WHEN age BETWEEN 15 AND 15 THEN '15'
        WHEN age BETWEEN 16 AND 16 THEN '16'
        WHEN age BETWEEN 17 AND 17 THEN '17'
        WHEN age BETWEEN 18 AND 18 THEN '18'
        WHEN age BETWEEN 19 AND 19 THEN '19'
        WHEN age BETWEEN 20 AND 20 THEN '20'
        ELSE 'Other' 
    END AS Age_Group,
    COUNT(*) AS Number_of_Students
FROM student_database
WHERE age BETWEEN 15 AND 20
GROUP BY Age_Group;


/* Using a JOIN Clause to find student names who had Percentage of 97-100 and Grade_Point_Scale of A+. */

SELECT s.Student_Name, a.Courses_Attendance, p.Percentage, p.Grade_Point_Scale
FROM student_database s
JOIN attendance a
ON s.Desk_ID = a.Desk_ID
JOIN percentage_and_grade p
ON a.Student_ID = p.Student_ID
WHERE p.Percentage = '97-100' AND p.Grade_Point_Scale = 'A+'
LIMIT 15;
