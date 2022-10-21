Param(
    [Parameter(Mandatory=$True)][string]$TeacherEmail #The teacher of the classes you want to add the administrator to.
)

& gam.exe print courses teacher $TeacherEmail state active fields id,name | ConvertFrom-CSV | Format-Table