Param(
    [Parameter(Mandatory=$True)][string]$TeacherEmail, #The teacher of the classes you want to add the administrator to.
    [Parameter(Mandatory=$True)][string]$AdminEmail #Administrator you want to add to all the classes.
)

& gam print courses teacher $TeacherEmail state active fields id,name | & gam csv - gam course ~id add teacher $AdminEmail

exit $LASTEXITCODE