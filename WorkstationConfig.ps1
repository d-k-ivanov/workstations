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
            SystemSoft       SystemSoft     {}

            # Office Software
            OfficeSoft       OfficeSoft     {}

            # Development Software
            DevLangs        DevLangs        {}
            DevOps          DevOps          {}
            DevTools        DevTools        {}
            # VisualStudio    VisualStudio    {}
        }
    }

    WorkstationConfig -OutputPath $PSScriptRoot | Out-Null

# ------------------------------------------------------------
# End of File
