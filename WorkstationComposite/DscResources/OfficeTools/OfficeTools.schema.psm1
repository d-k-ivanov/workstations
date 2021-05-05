<#
.SYNOPSIS
Install office tools.

.DESCRIPTION
Install office tools.

.PARAMETER Credential
User credental.

.PARAMETER NoUpgrade
Do not upgrade installed packages to their latest versions.
#>

Configuration OfficeTools
{
    Param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [pscredential] $Credential,

        [switch] $NoUpgrade
    )

    if ($NoUpgrade)
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

    cChocoPackageInstaller InstallAdobereader
    {
        Name                    = 'adobereader'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        chocoParams             = '--ignore-checksums'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallCalibre
    {
        Name                    = 'calibre'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallGhostscript
    {
        Name                    = 'Ghostscript.app'
        Version                 = '9.53.3'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallGrammarly
    {
        Name                    = 'grammarly'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallLibrecad
    {
        Name                    = 'librecad'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Absent'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallMiKTeX
    {
        Name                    = 'miktex.install'
        # Params                  = '"/Set:complete /RepoPath:""c:\tools\MiKTeX-Repo"""'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }


    cChocoPackageInstaller InstallMicrosoftTeams
    {
        Name                    = 'microsoft-teams'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallOffice365
    {
        Name                    = 'office365business'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallPdfsam
    {
        Name                    = 'pdfsam'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallWindjview
    {
        Name                    = 'windjview'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        chocoParams             = '--ignore-checksums'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallXpdfUtils
    {
        Name                    = 'xpdf-utils'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallYed
    {
        Name                    = 'yed'
        Params                  = '/Associate'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }
}
