<#

    .SYNOPSIS
    This script is designed to be an end of the year cleanup script by archiving all classrooms in your domain. You should notify
    your teachers and admin before running this script. Classrooms can be made active again by the owner if they still need the
    classroom.

    .EXAMPLE
    .\archive_all_classes.ps1 -Force

#>

Param(
    [Parameter(Mandatory=$false)][switch]$Force
)

$allActiveClassrooms = & gam.exe print courses state active fields id,name,coursestate,owneremail | ConvertFrom-CSV

Write-Host "Info: Archving list of Active Classrooms:" -ForegroundColor Yellow
$allActiveClassrooms | Export-CSV ".\ActiveClassrooms-$(Get-Date -Format "yyyy-MM-dd-HH-mm-ss").csv" -Verbose

if ($Force) {
    $allActiveClassrooms | ConvertTo-Csv | & gam.exe csv - gam update course ~id state archived
} else {
    write-host "Info: You need to specify -Force to actually do this. You're welcome." -ForegroundColor Red
}