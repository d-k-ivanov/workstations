<#
.SYNOPSIS
Install various development tools.

.DESCRIPTION
Install various development tools.

.PARAMETER Credential
User credental.

.PARAMETER NoUpgrate
Do not upgrade installed packages to their latest versions.
#>

Configuration GameDev
{
    Param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [pscredential] $Credential,

        [switch] $NoUpgrate
    )

    if ($NoUpgrate)
    {
        $AutoUpgrade = $false
    }
    else
    {
        $AutoUpgrade = $true
    }

    Import-DscResource -ModuleName cChoco

    cChocoinstaller InstallChocolatey {
        InstallDir              = "C:\ProgramData\chocolatey"
    }

    ## Template
    # cChocoPackageInstaller InstallPackageName
    # {
    #     Name                    = 'PackageName'
    #     Version                 = ''
    #     Params                  = ''
    #     AutoUpgrade             = $AutoUpgrade
    #     Ensure                  = 'Present | Absent'
    #     DependsOn               = "[cChocoInstaller]InstallChocolatey"
    # }

    cChocoPackageInstaller InstallBuckaroo
    {
        Name                    = 'godot-mono'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallBuckaroo
    {
        Name                    = 'blender'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }
}

