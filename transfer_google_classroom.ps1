<#

    .SYNOPSIS
    This script will transfer ownership of a course from one teacher to another.  This may be useful if a teacher leaves mid year.
    This does require that the original owner account is not suspended.

    .EXAMPLE
    .\transfer_google_classroom.ps1 -CourseId 512348579874567 -NewOwner jdoe@gentrypioneers.com

    .\transfer_google_classroom.ps1 -SectionID 12345 -NewOwner jdoe@gentrypioneers.com.

#>

Param(
    [Parameter(Mandatory=$False)][string]$CourseId,
    [Parameter(Mandatory=$False)][string]$SectionId,
    [Parameter(Mandatory=$True)][string]$NewOwner
)

if ($SectionId) {
    $alias = "d:$($SectionId)"
} elseif ($CourseId) {
    $alias = "$($CourseId)"
} else {
    Write-Error "You did not specify a `$CourseId or `$SectionId"
    exit 1
}

$course = & gam.exe info course "$($alias)" formatjson | convertfrom-Json

if ($course) {

    #we have to add the new teacher as a teacher.
    & gam.exe course $course.id add teacher $NewOwner

    #Then transfer ownership.
    & gam.exe update course $course.id owner $NewOwner

}