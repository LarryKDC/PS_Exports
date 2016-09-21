/*This query gives output equivalent to the All Enrollments screen in PS*/

select
dateenrolled,
dateleft,
cc.expression,
cc.course_number,
c.course_name
from cc
join courses c on c.course_number = cc.course_number
where studentid = (select id from students where student_number = XXXXX)
order by dateenrolled desc
