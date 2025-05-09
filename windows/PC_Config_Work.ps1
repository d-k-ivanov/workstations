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
                AutoUpdate          = $Update
            }

            SystemTools         SystemTools         { Credential = $Credential; AutoUpdate = $Update }
            Virtualization      Virtualization      { Credential = $Credential; AutoUpdate = $Update }

            # Dev
            DevLangs            DevLangs            { Credential = $Credential; AutoUpdate = $Update }
            DevTools            DevTools            { Credential = $Credential; AutoUpdate = $Update }
            DocTools            DocTools            { Credential = $Credential; AutoUpdate = $Update }
            Engineering         Engineering         { Credential = $Credential; AutoUpdate = $Update }
            GameDev             GameDev             { Credential = $Credential; AutoUpdate = $Update }
            Math                Math                { Credential = $Credential; AutoUpdate = $Update }
            Modelling           Modelling           { Credential = $Credential; AutoUpdate = $Update }
            # VisualStudio        VisualStudio        { Credential = $Credential; AutoUpdate = $Update }

            # DevOps
            DatabaseTools       DatabaseTools       { Credential = $Credential; AutoUpdate = $Update }
            DevOps              DevOps              { Credential = $Credential; AutoUpdate = $Update }
            KubernetesTools     KubernetesTools     { Credential = $Credential; AutoUpdate = $Update }

            # Office
            AudioTools          AudioTools          { Credential = $Credential; AutoUpdate = $Update }
            Browsers            Browsers            { Credential = $Credential; AutoUpdate = $Update }
            CommunicationTools  CommunicationTools  { Credential = $Credential; AutoUpdate = $Update }
            ImagingTools        ImagingTools        { Credential = $Credential; AutoUpdate = $Update }
            OfficeTools         OfficeTools         { Credential = $Credential; AutoUpdate = $Update }
            VideoTools          VideoTools          { Credential = $Credential; AutoUpdate = $Update }
        }
    }

    WorkstationConfig -Role DSC -ConfigurationData $ConfiguraionData -OutputPath $PSScriptRoot | Out-Null

# ------------------------------------------------------------
# End of File
