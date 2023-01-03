<#

    .SYNOPSIS
    This script will add an administrator/tech to all active classrooms for a teacher.

    .EXAMPLE
    .\add_to_teacher_classrooms.ps1 -TeacherEmail jdoe@gentrypioneers.com -AdminEmail cmillsap@gentrypioneers.com

#>

Param(
    [Parameter(Mandatory=$True)][string]$TeacherEmail, #The teacher of the classes you want to add the administrator to.
    [Parameter(Mandatory=$True)][string]$AdminEmail #Administrator you want to add to all the classes.
)

& gam.exe print courses teacher $TeacherEmail state active fields id,name | & gam.exe csv - gam course ~id add teacher $AdminEmail

exit $LASTEXITCODE