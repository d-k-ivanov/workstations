<#
.SYNOPSIS
Support functions.

.DESCRIPTION
Support functions.
#>


# ------------------------------------------------------------
# Region Init
# ------------------------------------------------------------
# Invocation check
if ($MyInvocation.InvocationName -ne '.')
{
    Write-Host "Error: Bad invocation. $($MyInvocation.MyCommand) supposed to be sourced. Exiting..." -ForegroundColor Red
    Exit
}


# ------------------------------------------------------------
# Region System
# ------------------------------------------------------------
function isAdmin()
{
    return ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
}

function ElevateScript()
{
    If (-Not (isAdmin)) {
        Write-Host "-- Restarting as Administrator" -ForegroundColor Cyan
        Start-Sleep -Seconds 1
        if($PSVersionTable.PSEdition -eq "Core") {
            Start-Process pwsh.exe `
                "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.PSCommandPath)`"" -Verb RunAs
        } else {
            Start-Process powershell.exe `
                "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.PSCommandPath)`"" -Verb RunAs
        }
        exit
    }
}

function ElevateSession()
{
    If (-Not (isAdmin)) {
        Write-Host "-- Restarting session as Administrator" -ForegroundColor Cyan
        Start-Sleep -Seconds 1
        if($PSVersionTable.PSEdition -eq "Core") {
            Start-Process pwsh.exe `
                "-NoProfile -NoExit -File `"$($MyInvocation.PSCommandPath)`"" -Verb RunAs
        } else {
            Start-Process powershell.exe `
                "-NoProfile -NoExit -File `"$($MyInvocation.PSCommandPath)`"" -Verb RunAs
        }
        exit
    }
}

function  Get-WindowsBuildNumber
{
    $os = Get-CimInstance -ClassName Win32_OperatingSystem
    return [int]($os.BuildNumber)
}


# ------------------------------------------------------------
# Region Formating
# ------------------------------------------------------------
function Skip-FirstLines()
{
     # Skipping 10 lines because statusbar covers output
     1..10 |% { Write-Host ""}
}


# ------------------------------------------------------------
# Region Logging
# ------------------------------------------------------------
### Info
function WriteInfo($message)
{
    Write-Host $message
}

function LogInfo($message)
{
    WriteInfo "$(Get-Date -UFormat '%Y-%M-%d-%H-%m-%S') $message"
}

### Highlighted
function WriteInfoHighlighted($message)
{
    Write-Host "$message" -ForegroundColor Cyan
}

function LogInfoHighlighted($message)
{
    WriteInfoHighlighted "$(Get-Date -UFormat '%Y-%M-%d-%H-%m-%S') $message"
}

### Success
function WriteSuccess($message)
{
    Write-Host "$message" -ForegroundColor Green
}

function LogSuccess($message)
{
    WriteSuccess "$(Get-Date -UFormat '%Y-%M-%d-%H-%m-%S') $message"
}

### Error
function WriteError($message)
{
    Write-Host "$message" -ForegroundColor Red
}

function LogError($message)
{
    WriteError "$(Get-Date -UFormat '%Y-%M-%d-%H-%m-%S') $message"
}

### Critical
function WriteCritical($message)
{
    Write-Host "$message. Exiting..." -ForegroundColor Red
    Exit
}

function LogCritical($message)
{
    WriteCritical "$(Get-Date -UFormat '%Y-%M-%d-%H-%m-%S') $message"
}


# ------------------------------------------------------------
# End of Functions
