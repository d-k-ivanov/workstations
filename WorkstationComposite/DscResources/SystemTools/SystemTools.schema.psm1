<#
.SYNOPSIS
Install system tools.

.DESCRIPTION
Install system tools.

.PARAMETER Credential
User credental.

.PARAMETER AutoUpdate
Upgrade installed packages to their latest versions.
#>

Configuration SystemTools
{
    Param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [pscredential] $Credential,

        [switch] $AutoUpdate
    )

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
    #     AutoUpgrade             = $AutoUpdate
    #     Ensure                  = 'Present | Absent'
    #     DependsOn               = '[cChocoInstaller]InstallChocolatey'
    #     PsDscRunAsCredential    = $Credential
    # }

    cChocoPackageInstaller Install7zip
    {
        Name                    = '7zip.install'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallCcleaner
    {
        Name                    = 'ccleaner'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallCrystalDiskInfo
    {
        Name                    = 'crystaldiskinfo.install'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallCrystalDiskMark
    {
        Name                    = 'crystaldiskmark'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallChocoCleaner
    {
        Name                    = 'choco-cleaner'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallDoublecmd
    {
        Name                    = 'doublecmd'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Absent'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallDU
    {
        Name                    = 'du'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallEncfs4Win
    {
        Name                    = 'encfs4win'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallFar
    {
        Name                    = 'far'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Absent'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallGNUCoreUtils
    {
        Name                    = 'gnuwin32-coreutils.install'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallGreenshot
    {
        Name                    = 'greenshot'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallGrep
    {
        Name                    = 'grep'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallImdiskToolkit
    {
        Name                    = 'imdisk-toolkit'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallLockHunter
    {
        Name                    = 'lockhunter'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallOpenHardwareMonitor
    {
        Name                    = 'openhardwaremonitor'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallPowerToys
    {
        Name                    = 'powertoys'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Absent'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallRapidee
    {
        Name                    = 'rapidee'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallRipgrep
    {
        Name                    = 'ripgrep'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallSwissFileKnife
    {
        Name                    = 'swissfileknife'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallSysInternals
    {
        Name                    = 'sysinternals'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallTrayStatus
    {
        Name                    = 'traystatus.install'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallTree
    {
        Name                    = 'tree'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallWarp
    {
        Name                    = 'warp'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Absent'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallWinDirStat
    {
        Name                    = 'windirstat'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallWinFSP
    {
        Name                    = 'winfsp'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }
}
