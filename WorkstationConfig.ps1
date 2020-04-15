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

# ------------------------------------------------------------
# Workstation Composite Config
# ------------------------------------------------------------
    # Import-Module WorkstationComposite
    # Import-Module InstallChocolateyPackages
    # Get-DscResource | Format-Table

    Configuration WorkstationConfig
    {
        Import-DscResource -ModuleName WorkstationComposite
        
        # Import-DscResource -ModuleName PSDesiredStateConfiguration
        # Import-DscResource -ModuleName WorkstationComposite

        Node localhost
        {
            # System Configuration
            SetComputerName  SetComputerName  { Name = 'divanov-dev' }

            # Office Software
            
            # DevSoftware
            DevTools        DevTools        {}
            DevLangs        DevLangs        {}
            # VisualStudio    VisualStudio    {}

            AddChocoPackages AddChocoPackages { Packages = 'googlechrome' }
        }
    }

    WorkstationConfig -OutputPath $PSScriptRoot | Out-Null

# ------------------------------------------------------------
# End of File
