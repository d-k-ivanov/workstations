<#
.SYNOPSIS
Install various development tools.

.DESCRIPTION
Install various development tools.

.PARAMETER Credential
User credental.

.PARAMETER AutoUpdate
Upgrade installed packages to their latest versions.
#>

Configuration Math
{
    Param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [pscredential] $Credential,

        [switch] $AutoUpdate
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
    #     AutoUpgrade             = $AutoUpdate
    #     Ensure                  = 'Present | Absent'
    #     DependsOn               = "[cChocoInstaller]InstallChocolatey"
    # }

    cChocoPackageInstaller InstallCoq
    {
        Name                    = 'coq'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        chocoParams             = '--ignore-checksums'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallFree42
    {
        Name                    = 'free42'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        chocoParams             = '--ignore-checksums'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallGnuplot
    {
        Name                    = 'gnuplot'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallMaxima
    {
        Name                    = 'maxima'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallOctave
    {
        Name                    = 'octave'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallSciLab
    {
        Name                    = 'scilab'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallSpeedCrunch
    {
        Name                    = 'speedcrunch'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }
}
