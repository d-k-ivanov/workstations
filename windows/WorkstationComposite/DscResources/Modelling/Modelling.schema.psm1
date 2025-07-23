<#
.SYNOPSIS
Install various modelling tools.

.DESCRIPTION
Install various modelling tools.

.PARAMETER Credential
User credental.

.PARAMETER AutoUpdate
Upgrade installed packages to their latest versions.
#>

Configuration Modelling
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
        InstallDir = "C:\ProgramData\chocolatey"
    }

    ## Template
    # cChocoPackageInstaller InstallPackageName
    # {
    #     Name        = 'PackageName'
    #     Version     = ''
    #     Params      = ''
    #     AutoUpgrade = $AutoUpdate
    #     Ensure      = 'Present | Absent'
    #     DependsOn   = "[cChocoInstaller]InstallChocolatey"
    # }

    cChocoPackageInstaller InstallBlender
    {
        Name                 = 'blender'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallLibrecad
    {
        Name                 = 'librecad'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    # Install from here: hhttps://ephtracy.github.io/index.html?page=mv_main
    cChocoPackageInstaller InstallMagicaVoxel
    {
        Name                 = 'magicavoxel'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallMeshLab
    {
        Name                 = 'meshlab'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        chocoParams          = "--force"
        DependsOn            = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential = $Credential
    }

    # cChocoPackageInstaller InstallMeshMixer
    # {
    #     Name                 = 'meshmixer'
    #     AutoUpgrade          = $AutoUpdate
    #     chocoParams          = "--ignore-checksums"
    #     Ensure               = 'Absent'
    #     DependsOn            = "[cChocoInstaller]InstallChocolatey"
    #     PsDscRunAsCredential = $Credential
    # }

    cChocoPackageInstaller InstallOpenSCAD
    {
        Name                 = 'openscad.install'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential = $Credential
    }
}
