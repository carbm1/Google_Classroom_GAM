<#

    .SYNOPSIS
    This script will remove a teacher from ALL classrooms where they are listed as a teacher.  This will not remove them if
    they are a student of a classroom. You must use -Force for this to actualy do any work.

    .EXAMPLE
    .\remove_user_from_all_classrooms.ps1 -TeacherEmail cmillsap@gentrypioneers.com -Force

#>

Param(
    [Parameter(Mandatory=$True)][string]$TeacherEmail,
    [Parameter(Mandatory=$false)][switch]$Force
)

if ($Force) {
    & gam.exe print courses teacher $TeacherEmail status active fields id,name | & gam.exe csv - gam course ~id remove teacher $TeacherEmail
} else {
    write-host "Info: You need to specify -Force to actually do this. You're welcome."
}