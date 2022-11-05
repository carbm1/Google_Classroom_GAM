Param(
    [Parameter(Mandatory=$True)][string]$TeacherEmail, #The teacher of the classes you want to add the administrator to.
    [Parameter(Mandatory=$False)][switch]$ActiveOnly
)

$classrooms = & gam.exe print courses teacher $TeacherEmail fields id,name,coursestate alias | ConvertFrom-CSV

if ($ActiveOnly) {
    $classrooms | Where-Object { $PSItem.courseState -eq "ACTIVE" } | Format-Table
} else {
    $classrooms | Format-Table
}

Write-Host "Dot Source this script for `$classrooms variable."