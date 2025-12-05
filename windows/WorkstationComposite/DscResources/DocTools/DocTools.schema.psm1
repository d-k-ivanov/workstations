<#
.SYNOPSIS
Install various documentation tools.

.DESCRIPTION
Install various documentation tools.

.PARAMETER Credential
User credental.

.PARAMETER AutoUpdate
Upgrade installed packages to their latest versions.
#>

Configuration DocTools
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
        InstallDir = 'C:\ProgramData\chocolatey'
    }

    cChocoPackageInstaller InstallDocFX
    {
        Name                 = 'docfx'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallDoxygen
    {
        Name                 = 'doxygen.install'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallMiKTeX
    {
        Name                 = 'miktex.install'
        # Params                  = '"/Set:complete /RepoPath:""c:\tools\MiKTeX-Repo"""'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallPandoc
    {
        Name                 = 'pandoc'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallPlantuml
    {
        Name                 = 'plantuml'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    # cChocoPackageInstaller InstallTeXLive
    # {
    #     Name                 = 'texlive'
    #     AutoUpgrade          = $AutoUpdate
    #     Ensure               = 'Present'
    #     # chocoParams          = '/scheme:full'
    #     DependsOn            = '[cChocoInstaller]InstallChocolatey'
    #     PsDscRunAsCredential = $Credential
    # }

    cChocoPackageInstaller InstallTeXStudio
    {
        Name                 = 'texstudio.install'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallYed
    {
        Name                 = 'yed'
        Params               = '/Associate'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallZotero
    {
        Name                 = 'zotero'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }
}
