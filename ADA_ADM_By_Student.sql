select
s.student_number student_number,
cd.date_value CD_Date,
sc.abbreviation School_Name,
s.grade_level Grade_Level,
--hr.secNbr Homeroom,
1 Enrollment,
coalesce(ac.att_code,'P') "Attendance Code",
case when presence_status_cd = 'Absent' then 0 else 1 end Attendance
FROM powerschool.powerschool_schools sc
JOIN (
  SELECT id studentid, schoolid, grade_level, entrydate, entrycode, exitdate, exitcode FROM powerschool.powerschool_students
  UNION ALL
  SELECT studentid, schoolid, grade_level, entrydate, entrycode, exitdate, exitcode FROM powerschool.powerschool_reenrollments
) e ON e.schoolid = sc.school_number and sc.school_number!=2001
join powerschool.powerschool_STUDENTS s on s.id = e.studentid
JOIN powerschool.powerschool_calendar_day cd ON cd.schoolid = e.schoolid AND cd.date_value BETWEEN e.entrydate AND e.exitdate-1 AND cd.insession = 1
left outer join powerschool.powerschool_attendance a on a.studentid = e.studentid and a.att_date = cd.date_value and att_mode_code = 'ATT_ModeDaily'
left join powerschool.powerschool_attendance_code ac on ac.id = a.attendance_codeid
--join (
--SELECT 
--DISTINCT cc.studentid studentid,
--            --MAX( se.dcid ) maxDcid,
--            MAX( cc.dateenrolled ) dateenrolled,
--            MAX( cc.dateleft ) dateleft,
--            MAX( cc.section_number ) secNbr
--FROM powerschool.powerschool_COURSES c
--INNER JOIN powerschool.powerschool_CC cc ON c.course_number = cc.course_number
--LEFT JOIN powerschool.powerschool_SECTIONS se ON cc.sectionId = abs(se.id)
--WHERE c.course_name = 'Homeroom'
--GROUP BY cc.studentid, cc.dateenrolled, cc.dateleft
--) hr on hr.studentid = e.studentid and cd.date_value between hr.dateenrolled and hr.dateleft
where cd.date_value between '15-AUG-16' and getdate()
and s.schoolid = 1100
