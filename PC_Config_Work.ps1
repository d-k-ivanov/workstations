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
            SystemTools         SystemTools         { Credential = $Credential; NoUpgrade = $true }
            Virtualization      Virtualization      { Credential = $Credential; NoUpgrade = $true }

            # Development Software
            DevLangs            DevLangs            { Credential = $Credential; NoUpgrade = $true }
            DevOps              DevOps              { Credential = $Credential; NoUpgrade = $true }
            DevTools            DevTools            { Credential = $Credential; NoUpgrade = $true }
            DocTools            DocTools            { Credential = $Credential; NoUpgrade = $true }
            GameDev             GameDev             { Credential = $Credential; NoUpgrade = $true }
            # VisualStudio        VisualStudio        { Credential = $Credential; NoUpgrade = $true }

            # Desktop Software
            AudioTools          AudioTools          { Credential = $Credential; NoUpgrade = $true }
            CommunicationTools  CommunicationTools  { Credential = $Credential; NoUpgrade = $true }
            ImagingTools        ImagingTools        { Credential = $Credential; NoUpgrade = $true }
            InternetTools       InternetTools       { Credential = $Credential; NoUpgrade = $true }
            OfficeTools         OfficeTools         { Credential = $Credential; NoUpgrade = $true }
            StorageTools        StorageTools        { Credential = $Credential; NoUpgrade = $true }
            VideoTools          VideoTools          { Credential = $Credential; NoUpgrade = $true }
        }
    }

    WorkstationConfig -Role DSC -ConfigurationData $ConfiguraionData -OutputPath $PSScriptRoot | Out-Null

# ------------------------------------------------------------
# End of File
