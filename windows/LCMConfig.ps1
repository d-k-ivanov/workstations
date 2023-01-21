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
                ConfigurationModeFrequencyMins = 15
                RebootNodeIfNeeded             = $false
                RefreshMode                    = 'Push'
                RefreshFrequencyMins           = 30
            }
        }
    }

    LCMConfig -OutputPath $PSScriptRoot | Out-Null

# ------------------------------------------------------------
# Region Cleanup
# ------------------------------------------------------------

# ------------------------------------------------------------
# End of File
