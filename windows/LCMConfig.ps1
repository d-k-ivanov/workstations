<#
.SYNOPSIS
LCM Configuration.

.DESCRIPTION
LCM Configuration.
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
# LCM Config
# ------------------------------------------------------------
    [DSCLocalConfigurationManager()]
    configuration LCMConfig
    {
        Node localhost
        {
            Settings
            {
                ActionAfterReboot              = 'ContinueConfiguration'
                ConfigurationMode              = 'ApplyAndAutoCorrect'
                ConfigurationModeFrequencyMins = 1440    # Check for updates once a day
                RebootNodeIfNeeded             = $false
                # RefreshFrequencyMins         = 30
                RefreshMode                    = 'Push'
            }
        }
    }

    LCMConfig -OutputPath $PSScriptRoot | Out-Null

# ------------------------------------------------------------
# Region Cleanup
# ------------------------------------------------------------

# ------------------------------------------------------------
# End of File
