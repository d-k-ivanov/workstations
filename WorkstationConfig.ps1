<#
.SYNOPSIS
Workstation Configuration.

.DESCRIPTION
Workstation Configuration.
#>


# Check invocation
if ($MyInvocation.InvocationName -ne '.')
{
    Write-Host `
        "Error: Bad invocation. $($MyInvocation.MyCommand) supposed to be sourced. Exiting..." `
        -ForegroundColor Red
    Exit
}


# ------------------------------------------------------------
# Base
# ------------------------------------------------------------
. "${PSScriptRoot}\Functions.ps1"
. "${PSScriptRoot}\Secrets.ps1"


# ------------------------------------------------------------
# Configuration Data
# ------------------------------------------------------------
    $ConfiguraionData = `
    @{
        AllNodes = @(
            @{
                NodeName                    = 'localhost'
                Role                        = "DSC"
                PSDscAllowPlainTextPassword = $true
                PSDscAllowDomainUser        = $true
            }
        )
    }

# ------------------------------------------------------------
# Workstation Composite Config
# ------------------------------------------------------------
    # Get-DscResource | Format-Table

    Configuration WorkstationConfig
    {
        Param
        (
            # Just for Fun Parameter. Could be skipped.
            [Parameter(Mandatory = 0)]
            [ValidateNotNullOrEmpty()]
            [string]$Role
        )

        Import-DscResource -ModuleName WorkstationComposite

        # Import-DscResource -ModuleName PSDesiredStateConfiguration
        # Import-DscResource -ModuleName WorkstationComposite

        Node $Allnodes.Where{$_.Role -eq $Role}.NodeName
        {
            $Credential = Get-SecretDSCCreds
            # System Configuration
            SetComputerName     SetComputerName     { Name = 'divanov-dev' }
            SystemTools         SystemTools         { Credential = $Credential }

            # Desktop Software
            AudioTools          AudioTools          { Credential = $Credential }
            CommunicationTools  CommunicationTools  { Credential = $Credential }
            ImagingTools        ImagingTools        { Credential = $Credential }
            InternetTools       InternetTools       { Credential = $Credential }
            OfficeTools         OfficeTools         { Credential = $Credential }
            StorageTools        StorageTools        { Credential = $Credential }
            VideoTools          VideoTools          { Credential = $Credential }

            # # Development Software
            DevLangs            DevLangs            { Credential = $Credential }
            DevOps              DevOps              { Credential = $Credential }
            DevTools            DevTools            { Credential = $Credential }
            # VisualStudio        VisualStudio        { Credential = $Credential }
        }
    }

    WorkstationConfig -Role DSC -ConfigurationData $ConfiguraionData -OutputPath $PSScriptRoot | Out-Null

# ------------------------------------------------------------
# End of File
