Param(
    [Parameter(Mandatory=$True)][string]$TeacherEmail,
    [Parameter(Mandatory=$false)][switch]$Force
)

if ($Force) {
    & gam print courses teacher $TeacherEmail status active fields id,name | & gam csv - gam course ~id remove teacher $TeacherEmail
} else {
    write-host "Info: You need to specify -Force to actually do this. You're welcome."
}