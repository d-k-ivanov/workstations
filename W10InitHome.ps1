<#
.SYNOPSIS
PostInstall Configuration.

.DESCRIPTION
PostInstall Configuration.
#>

# Check invocation
# if ($MyInvocation.InvocationName -ne '.')
# {
#     Write-Host `
#         "Error: Bad invocation. $($MyInvocation.MyCommand) supposed to be sourced. Exiting..." `
#         -ForegroundColor Red
#     Exit
# }

$ScriptName         = [io.path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)

if($PSVersionTable.PSEdition -eq "Core")
{
    pwsh.exe -NoProfile -ExecutionPolicy Bypass                             `
        -File "${PSScriptRoot}\Win10-Initial-Setup-Script\Win10.ps1"        `
        -include "${PSScriptRoot}\Win10-Initial-Setup-Script\Win10.psm1"    `
        -preset "${PSScriptRoot}\${ScriptName}.preset"
}
else
{
    powershell.exe -NoProfile -ExecutionPolicy Bypass                       `
        -File "${PSScriptRoot}\Win10-Initial-Setup-Script\Win10.ps1"        `
        -include "${PSScriptRoot}\Win10-Initial-Setup-Script\Win10.psm1"    `
        -preset "${PSScriptRoot}\${ScriptName}.preset"
}

Set-Service "CDPUserSvc" -StartupType Automatic
