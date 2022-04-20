Param(
    [Parameter(Mandatory=$false)][switch]$Force
)

if ($Force) {
    & gam print courses state active fields id,name > classrooms_all_active_from_google.csv
    & gam csv classrooms_all_active_from_google.csv gam update course ~id state archived
} else {
    write-host "Info: You need to specify -Force to actually do this. You're welcome."
}