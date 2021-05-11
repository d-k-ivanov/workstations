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
. "${PSScriptRoot}\Secrets.Work.ps1"


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

            # TestResource        TestResource        {RepoFolder = $RepoFolder}

            # System Configuration
            SystemSettings      SystemSettings
            {
                Credential          = $Credential
                SetComputerName     = $false
                DisableSearchEngine = $true
                NoUpgrade           = $true
            }

            # System Software
            SystemTools         SystemTools         { Credential = $Credential; NoUpgrade = $false }
            Virtualization      Virtualization      { Credential = $Credential; NoUpgrade = $false }

            # Development Software
            DevLangs            DevLangs            { Credential = $Credential; NoUpgrade = $false }
            DevOps              DevOps              { Credential = $Credential; NoUpgrade = $false }
            DevTools            DevTools            { Credential = $Credential; NoUpgrade = $false }
            DocTools            DocTools            { Credential = $Credential; NoUpgrade = $false }
            GameDev             GameDev             { Credential = $Credential; NoUpgrade = $false }
            # VisualStudio        VisualStudio        { Credential = $Credential; NoUpgrade = $false }

            # Desktop Software
            AudioTools          AudioTools          { Credential = $Credential; NoUpgrade = $false }
            CommunicationTools  CommunicationTools  { Credential = $Credential; NoUpgrade = $false }
            ImagingTools        ImagingTools        { Credential = $Credential; NoUpgrade = $false }
            InternetTools       InternetTools       { Credential = $Credential; NoUpgrade = $false }
            OfficeTools         OfficeTools         { Credential = $Credential; NoUpgrade = $false }
            StorageTools        StorageTools        { Credential = $Credential; NoUpgrade = $false }
            VideoTools          VideoTools          { Credential = $Credential; NoUpgrade = $false }
        }
    }

    WorkstationConfig -Role DSC -ConfigurationData $ConfiguraionData -OutputPath $PSScriptRoot | Out-Null

# ------------------------------------------------------------
# End of File
