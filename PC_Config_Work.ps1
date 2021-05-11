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

            SystemTools         SystemTools         { Credential = $Credential; NoUpgrade = $true } # System Software
            Virtualization      Virtualization      { Credential = $Credential; NoUpgrade = $true } # System Software
            DevLangs            DevLangs            { Credential = $Credential; NoUpgrade = $true } # Development Software
            DevOps              DevOps              { Credential = $Credential; NoUpgrade = $true } # Development Software
            DevTools            DevTools            { Credential = $Credential; NoUpgrade = $true } # Development Software
            DocTools            DocTools            { Credential = $Credential; NoUpgrade = $true } # Development Software
            GameDev             GameDev             { Credential = $Credential; NoUpgrade = $true } # Development Software
            AudioTools          AudioTools          { Credential = $Credential; NoUpgrade = $true } # Desktop Software
            CommunicationTools  CommunicationTools  { Credential = $Credential; NoUpgrade = $true } # Desktop Software
            ImagingTools        ImagingTools        { Credential = $Credential; NoUpgrade = $true } # Desktop Software
            InternetTools       InternetTools       { Credential = $Credential; NoUpgrade = $true } # Desktop Software
            OfficeTools         OfficeTools         { Credential = $Credential; NoUpgrade = $true } # Desktop Software
            StorageTools        StorageTools        { Credential = $Credential; NoUpgrade = $true } # Desktop Software
            VideoTools          VideoTools          { Credential = $Credential; NoUpgrade = $true } # Desktop Software

            # Disabled
            # VisualStudio        VisualStudio        { Credential = $Credential; NoUpgrade = $false } # Development Software
        }
    }

    WorkstationConfig -Role DSC -ConfigurationData $ConfiguraionData -OutputPath $PSScriptRoot | Out-Null

# ------------------------------------------------------------
# End of File
