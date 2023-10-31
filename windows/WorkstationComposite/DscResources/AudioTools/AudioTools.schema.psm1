<#
.SYNOPSIS
Install audio tools.

.DESCRIPTION
Install audio tools.

.PARAMETER Credential
User credental.

.PARAMETER AutoUpdate
Upgrade installed packages to their latest versions.
#>


Configuration AudioTools
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
    # }


    # ========================= Audio ==========================
    cChocoPackageInstaller InstallAudacity
    {
        Name                    = 'audacity'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallAudacityLame
    {
        Name                    = 'audacity-lame'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallAudacityFfmpeg
    {
        Name                    = 'audacity-ffmpeg'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    # Download from here updated version:
    # https://sourceforge.net/projects/equalizerapo/files/
    # cChocoPackageInstaller InstallEqualizerAPO
    # {
    #     Name                    = 'equalizerapo'
    #     AutoUpgrade             = $AutoUpdate
    #     Ensure                  = 'Present'
    #     DependsOn               = '[cChocoInstaller]InstallChocolatey'
    #     PsDscRunAsCredential    = $Credential
    # }

    cChocoPackageInstaller InstallFoobar2000
    {
        Name                    = 'foobar2000'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallMp3DirectCut
    {
        Name                    = 'mp3directcut'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    # Download from here updated version:
    # https://www.roomeqwizard.com/
    # cChocoPackageInstaller InstallRoomEqWizard
    # {
    #     Name                    = 'roomeqwizard'
    #     AutoUpgrade             = $AutoUpdate
    #     Ensure                  = 'Present'
    #     chocoParams             = "--ignore-checksums"
    #     DependsOn               = '[cChocoInstaller]InstallChocolatey'
    #     PsDscRunAsCredential    = $Credential
    # }

    cChocoPackageInstaller InstallSpotify
    {
        Name                    = 'spotify'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Absent'
        chocoParams             = "--ignore-checksums"
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }
}
