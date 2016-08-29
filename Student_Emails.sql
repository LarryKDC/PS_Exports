/*Use this query to export student emails from PS and Upload them into Illuminate
Emails are generated in the Google App, exported from Clever, and imported into Powerschool daily */

SELECT

 s.student_number "Student Id"
--,s.lastfirst "Student Name"
--,s.schoolid "School Id"
--,sc.abbreviation "School Name"
--,s.grade_level "Grade Level"
--,s.home_room "Homeroom"
,stuemails.email "Email"
,stuemails.email "Username"
,TO_CHAR(s.dob,'MMDDYYYY') "Temp Password"
,1 "Enable Portal"

FROM students s
INNER JOIN schools sc ON sc.school_number = s.schoolid
LEFT JOIN
    (SELECT ssm.studentsdcid
          , psc.email 
     FROM PSM_Studentcontact psc
     INNER JOIN psm_studentcontacttype psct ON psc.studentcontacttypeid= psct.id AND psct.name='Self'
     INNER JOIN sync_studentmap ssm ON psc.studentid = ssm.studentid) stuemails ON stuemails.studentsdcid = s.dcid
    
WHERE s.enroll_status = 0

ORDER BY s.schoolid, s.grade_level
