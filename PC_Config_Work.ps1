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

            AudioTools          AudioTools          { Credential = $Credential; AutoUpdate = $Update } # Desktop Software
            CommunicationTools  CommunicationTools  { Credential = $Credential; AutoUpdate = $Update } # Desktop Software
            Databases           Databases           { Credential = $Credential; AutoUpdate = $Update } # Development Software
            DevLangs            DevLangs            { Credential = $Credential; AutoUpdate = $Update } # Development Software
            DevOps              DevOps              { Credential = $Credential; AutoUpdate = $Update } # Development Software
            DevTools            DevTools            { Credential = $Credential; AutoUpdate = $Update } # Development Software
            DocTools            DocTools            { Credential = $Credential; AutoUpdate = $Update } # Development Software
            GameDev             GameDev             { Credential = $Credential; AutoUpdate = $Update } # Development Software
            ImagingTools        ImagingTools        { Credential = $Credential; AutoUpdate = $Update } # Desktop Software
            InternetTools       InternetTools       { Credential = $Credential; AutoUpdate = $Update } # Desktop Software
            OfficeTools         OfficeTools         { Credential = $Credential; AutoUpdate = $Update } # Desktop Software
            StorageTools        StorageTools        { Credential = $Credential; AutoUpdate = $Update } # Desktop Software
            SystemTools         SystemTools         { Credential = $Credential; AutoUpdate = $Update } # System Software
            VideoTools          VideoTools          { Credential = $Credential; AutoUpdate = $Update } # Desktop Software
            Virtualization      Virtualization      { Credential = $Credential; AutoUpdate = $Update } # System Software

            # Disabled
            # VisualStudio        VisualStudio        { Credential = $Credential; AutoUpdate = $Update } # Development Software
        }
    }

    WorkstationConfig -Role DSC -ConfigurationData $ConfiguraionData -OutputPath $PSScriptRoot | Out-Null

# ------------------------------------------------------------
# End of File
