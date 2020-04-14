<#
.SYNOPSIS
Install various development tools.

.DESCRIPTION
Install various development tools.
#>

Configuration Python
{
    Param
    (
        [switch] $AutoUpgrade = $True
    )

    Import-DscResource -ModuleName cChoco

    cChocoinstaller InstallChocolatey {
        InstallDir              = 'C:\ProgramData\chocolatey'
    }

    ## Template
    # cChocoPackageInstaller InstallPackageName
    # {
    #     Name                    = 'PackageName'
    #     Version                 = ''
    #     Params                  = ''
    #     AutoUpgrade             = $AutoUpgrade
    #     Ensure                  = 'Present'
    #     DependsOn               = '[cChocoInstaller]InstallChocolatey'
    # }

    cChocoPackageInstaller InstallPython3
    {
        Name                    = 'python3'
        Params                  = '/InstallDir:C:\tools\python3'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallPython2
    {
        Name                    = 'python2'
        Params                  = '"/InstallDir:C:\tools\python2"'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }
}
