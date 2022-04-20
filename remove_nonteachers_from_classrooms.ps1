<#

    This script will create a user called GoogleClassroomCleanup and add them to the classroom_teachers group.
    It will pull all the primary Emails from the classroom_teachers group. Including from 1 subgroup level.

    We will filter out all Google Classrooms not owned by a user in the classroom_teachers group.
    It will then add GoogleClassroomCleanup as a teacher, remove the original user, then archive the classroom.

    We will keep a record of who owned what class by exporting a CSV file named similar to ".\classrooms-2022-04-20-04-07-32.csv"

    This script is designed around GAMADV-XTD3. Your mileage may vary using the original GAM.
    https://github.com/taers232c/GAMADV-XTD3

#>

#So you can run this script multiple times we check if the user already exists.
& gam info user GoogleClassroomCleanup

if ($LASTEXITCODE -ne 0) {
    #create a new user that will just be a dummy teacher account. You can deal with the password later.
    & gam create user GoogleClassroomCleanup
    #Add it to the classroom_teachers group.
    & gam update group classroom_teachers add member GoogleClassroomCleanup
}

#We really should get all courses. Including deleted and archived. Otherwise a student could just unarchive and continue to use the course.
$allCourses = & gam print courses state active fields id,name,owneremail | ConvertFrom-Csv

#Backup in case we fubar something.
$allCourses | Export-Csv ".\classrooms-$(Get-Date -Format "yyyy-MM-dd-HH-mm-ss").csv"

#Lets get the actual classroom_teachers group members. As those classes won't be modified.
$classroomTeachers = gam info group classroom_teachers formatjson | ConvertFrom-Json
$teacherEmails = $classroomTeachers.members | Where-Object { $PSitem.type -eq "USER" } | Select-Object -ExpandProperty email

#account for one level of subgroups.
$classroomTeachers.members | Where-Object { $PSitem.type -eq "GROUP" } | ForEach-Object {
    $groupmembers = & gam info group $PSitem.email formatjson | ConvertFrom-Json
    $teacherEmails += $groupmembers.members | Select-Object -ExpandProperty email
}

#Filter to courses that are owned by persons not in the teachers group.
$coursesOwnedByNonTeachers = $allCourses | Where-Object { $teacherEmails -notcontains $PSitem.ownerEmail }

#Add the temporary account instead of deleting just in case we did something wrong.
$coursesOwnedByNonTeachers | ConvertTo-Csv | & gam csv - gam course ~id add teacher GoogleClassroomCleanup

#Now remove the old owner.
$coursesOwnedByNonTeachers | ConvertTo-Csv | & gam csv - gam course ~id remove teacher ~ownerEmail

#Now Archive Them.
$coursesOwnedByNonTeachers | ConvertTo-Csv | & gam csv - gam update course ~id state archived