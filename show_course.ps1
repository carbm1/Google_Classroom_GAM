<#

    .SYNOPSIS
    This script will print courses that match a specific eSchool Section ID.  Your Google Classroom must be set to sync based on the
    SectionID from eSchool. This is the default configuration for Clever.

    .EXAMPLE
    .\show_course.ps1 -sectionId 12345

#>

Param(
    [Parameter(Mandatory=$True)][string]$sectionId
)

& gam.exe info course "d:$($sectionId)" formatjson | convertfrom-Json