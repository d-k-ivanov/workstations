<#
.SYNOPSIS
Install various development tools.

.DESCRIPTION
Install various development tools.
#>

Configuration DevTools
{
    Param
    (
        [switch] $AutoUpgrade = $True
    )

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
    #     Ensure                  = 'Present'
    #     DependsOn               = "[cChocoInstaller]InstallChocolatey"
    # }

    cChocoPackageInstaller InstallGit
    {
        Name                    = 'git'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallVSCodeInsiders
    {
        Name                    = 'vscode-insiders'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Absent'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallVSCode
    {
        Name                    = 'vscode'
        Params                  = '/NoDesktopIcon'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallNotepadPlusPlus
    {
        Name                    = 'notepadplusplus.install'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

}





