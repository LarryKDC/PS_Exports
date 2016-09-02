select
student_number,
usi,
count(*) Years_At_KIPP
from (
  select
  s.student_number,
  ps_customfields.getStudentsCF(s.id, 'state_usi') AS USI,
  e.*,
  e.exitdate - e.entrydate
  from students s
  join (select id as studentid, schoolid, grade_level, entrydate, entrycode, exitdate, exitcode from students
        union
        select studentid, schoolid, grade_level, entrydate, entrycode, exitdate, exitcode from reenrollments) e on e.studentid = s.id
  where e.exitdate - e.entrydate >= 90
  --order by s.student_number,e.entrydate,e.exitdate
) sub
group by student_number,usi
