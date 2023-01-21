<#
.SYNOPSIS
Secret Credentials.

.DESCRIPTION
Secret Credentials.
#>

$MyInvocation.InvocationName

# Check invocation
if ($MyInvocation.InvocationName -ne '.')
{
    Write-Host `
        "Error: Bad invocation. $($MyInvocation.MyCommand) supposed to be sourced. Exiting..." `
        -ForegroundColor Red
    Exit
}

function Get-SecretDSCCreds
{
    $Credential = New-Object pscredential -Argumentlist 'UserName', (ConvertTo-SecureString 'SecretPa$$w0rD' -AsPlainText -Force)
    Return $Credential
}

