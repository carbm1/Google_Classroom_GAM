Param(
    [Parameter(Mandatory=$True)][string]$sectionId
)

& gam.exe info course "d:$($sectionId)" formatjson | convertfrom-Json