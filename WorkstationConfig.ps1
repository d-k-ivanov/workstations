<#
.SYNOPSIS
Workstation Configuration.

.DESCRIPTION
Workstation Configuration.
#>


# ------------------------------------------------------------
# Init
# ------------------------------------------------------------
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
        # Import-DscResource -ModuleName PSDesiredStateConfiguration
        # Import-DscResource -ModuleName WorkstationComposite
	Import-DscResource -Module WorkstationComposite
        #Import-DscResource -Name ComputerSettings
        #Import-DscResource -Name InstallChocolateyPackages

        Node localhost
        {
            SetComputerName  SetComputerName  { Name = 'divanov-dev' }
            AddChocoPackages AddChocoPackages
                             { 
                                 Packages = 
                                     'googlechrome',
                                     'notepadplusplus.install',
                                     'git'
                             }
        }
    }


    WorkstationConfig -OutputPath $PSScriptRoot | Out-Null


# ------------------------------------------------------------
# Region Cleanup
# ------------------------------------------------------------

# ------------------------------------------------------------
# End of File
