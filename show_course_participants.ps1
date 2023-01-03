<#

    .SYNOPSIS
    Display all teachers and students of a specific course.  This can be by the SectionID from eSchool if your Google Classrooms are in sync with
    eSchool.

    .EXAMPLE
    .\show_course_participants.ps1 -courseID 5193472934219347
    
    .\show_course_partitipants.ps1 -sectionId 12345

#>

Param(
    [Parameter(Mandatory=$False)][string]$sectionId,
    [Parameter(Mandatory=$False)][string]$courseId
)

if ($sectionId) {
    & gam.exe print course-participants course "d:$($sectionId)" | 
        ConvertFrom-CSV | 
        Sort-Object -Property userRole,'profile.name.familyName' -Descending | 
        Select-Object -Property userRole,'profile.name.fullname','profile.emailAddress','profile.verifiedTeacher',courseId,CourseName | 
        Format-Table
} else {
    & gam.exe print course-participants course "$($courseId)" | 
        Sort-Object -Property userRole,'profile.name.familyName' -Descending | 
        Select-Object -Property userRole,'profile.name.fullname','profile.emailAddress','profile.verifiedTeacher',courseId,CourseName | 
        Format-Table
}

