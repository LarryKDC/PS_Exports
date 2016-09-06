/*Use this query to verify that all students with a current HYCP enrollement have a homeless code and vis versa*/

select
s.student_number,
lastfirst,
s.schoolid,
ps_customfields.getStudentscf(s.id,'homeless_code') as homeless_code,
s.enroll_status,
hycp.enter_date,
hycp.exit_date
from students s
full outer join(
    select
    sp.enter_date,
    sp.exit_date,
    sp.studentid
    from students s
    join spenrollments sp on sp.studentid = s.id
    join gen on gen.id = sp.programid
    where gen.name = 'HYCP'
    and sysdate between sp.enter_date and sp.exit_date
) hycp on hycp.studentid = s.id
where (ps_customfields.getStudentscf(s.id,'homeless_code') is not null or hycp.enter_date is not null)
order by s.student_number
