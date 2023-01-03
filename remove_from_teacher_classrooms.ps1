<#

    .SYNOPSIS
    This script will remove an administrator or secondary teacher from all classrooms owned by a teacher.

    .EXAMPLE
    .\remove_from_teacher_classrooms.ps1 -TeacherEmail jdoe@gentrypioneers.com -AdminEmail cmillsap@gentrypioneers.com

#>

Param(
    [Parameter(Mandatory=$True)][string]$TeacherEmail, #The teacher of the classes you want to remove the administrator from.
    [Parameter(Mandatory=$True)][string]$AdminEmail #Administrator you want to remove from all the classes.
)

& gam.exe print courses teacher $TeacherEmail state active fields id,name | & gam.exe csv - gam course ~id remove teacher $AdminEmail

exit $LASTEXITCODE