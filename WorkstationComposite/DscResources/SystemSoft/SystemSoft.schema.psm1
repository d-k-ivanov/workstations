<#
.SYNOPSIS
Install system tools.

.DESCRIPTION
Install system tools.
#>

Configuration SystemSoft
{
    Param
    (
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

    cChocoinstaller InstallChocolatey
    {
        InstallDir              = 'C:\ProgramData\chocolatey'
    }

    ## Template
    # cChocoPackageInstaller InstallPackageName
    # {
    #     Name                    = 'PackageName'
    #     Version                 = ''
    #     Params                  = ''
    #     AutoUpgrade             = $AutoUpgrade
    #     Ensure                  = 'Present | Absent'
    #     DependsOn               = '[cChocoInstaller]InstallChocolatey'
    # }

    cChocoPackageInstaller Install7zip
    {
        Name                    = '7zip.install'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallCcleaner
    {
        Name                    = 'ccleaner'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallChocoCleaner
    {
        Name                    = 'choco-cleaner'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallDoublecmd
    {
        Name                    = 'doublecmd'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallDU
    {
        Name                    = 'du'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallFar
    {
        Name                    = 'far'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallGreenshot
    {
        Name                    = 'greenshot'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallImdiskToolkit
    {
        Name                    = 'imdisk-toolkit'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallLockHunter
    {
        Name                    = 'lockhunter'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallSwissFileKnife
    {
        Name                    = 'swissfileknife'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallSysInternals
    {
        Name                    = 'sysinternals'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallTree
    {
        Name                    = 'tree'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallWinDirStat
    {
        Name                    = 'windirstat'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }
}
