param(
    [string]$name,
    [string]$lastname
)

if (!(Test-Path -Path "C:\akseeLearn\Test")) {
    New-Item -ItemType Directory -Path "C:\akseeLearn\Test" | Out-Null
}
Push-Location "C:\akseeLearn\Test"
$installDir = $((Get-Location).Path)
if (-not (Test-Path -Path $installDir)) {
    Write-Host "Creating $installDir..."
    New-Item -Path "$installDir" -ItemType Directory | Out-Null
}

$starttime = Get-Date
$starttimeString = $($starttime.ToString("yyMMdd-HHmm"))
$transcriptFile = "$installDir\aksedgedlog-$starttimeString.txt"

Start-Transcript -Path $transcriptFile

Set-ExecutionPolicy Bypass -Scope Process -Force

Write-Host "Hello $name $lastname"

$fork ="asergaz"
$branch="learnmodule"
$url = "https://github.com/$fork/AKS-Edge/archive/refs/heads/$branch.zip"
$zipFile = "AKS-Edge-$branch.zip"

if (!(Test-Path -Path "$installDir\$zipFile")) {
    try {
        Start-BitsTransfer -Source $url -Destination $installDir\$zipFile
    } catch {
        Write-Host "Error: Downloading Aide Powershell Modules failed" -ForegroundColor Red
        Stop-Transcript | Out-Null
        Pop-Location
        exit -1
    }
}