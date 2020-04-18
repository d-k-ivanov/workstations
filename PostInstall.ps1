<#
.SYNOPSIS
PostInstall Configuration.

.DESCRIPTION
PostInstall Configuration.
#>


# Check invocation
if ($MyInvocation.InvocationName -ne '.')
{
    Write-Host `
        "Error: Bad invocation. $($MyInvocation.MyCommand) supposed to be sourced. Exiting..." `
        -ForegroundColor Red
    Exit
}


$ScriptName         = [io.path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)

# Write-Host ${profileDir}\Modules\W10Init\Win10.ps1 -include "${profileDir}\Modules\W10Init\Win10.psm1" -preset "${PSScriptRoot}\${ScriptName}.preset"
# & ${profileDir}\Modules\W10Init\Win10.ps1 -include "${profileDir}\Modules\W10Init\Win10.psm1" -preset "${PSScriptRoot}\${ScriptName}.preset"
powershell.exe -NoProfile -ExecutionPolicy Bypass     `
  -File "${PSScriptRoot}\${ScriptName}\Win10.ps1"     `
  -include "${PSScriptRoot}\${ScriptName}\Win10.psm1" `
  -preset "${PSScriptRoot}\${ScriptName}.preset"

# Write-Host "${PSScriptRoot}\${ScriptName}.cmd" "${profileDir}\Modules\W10Init\Win10" "${PSScriptRoot}\${ScriptName}.preset"
# & "${PSScriptRoot}\${ScriptName}.cmd" "${profileDir}\Modules\W10Init\Win10" "${PSScriptRoot}\${ScriptName}.preset"

Set-Service "CDPUserSvc" -StartupType Automatic
