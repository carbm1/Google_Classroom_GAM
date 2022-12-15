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

