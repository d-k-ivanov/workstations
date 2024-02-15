<#
.SYNOPSIS
Install internet tools.

.DESCRIPTION
Install internet tools.

.PARAMETER Credential
User credental.

.PARAMETER AutoUpdate
Upgrade installed packages to their latest versions.
#>

Configuration InternetTools
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

    ## Template
    # cChocoPackageInstaller InstallPackageName
    # {
    #     Name        = 'PackageName'
    #     Version     = ''
    #     Params      = ''
    #     AutoUpgrade = $AutoUpdate
    #     Ensure      = 'Present | Absent'
    #     DependsOn   = '[cChocoInstaller]InstallChocolatey'
    # }

    cChocoPackageInstaller InstallQbittorrent
    {
        Name                 = 'qbittorrent'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallTorBrowser
    {
        Name                 = 'top-browser'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallYoutubeDl # Not working any more...
    {
        Name                 = 'youtube-dl'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallYtDlp
    {
        Name                 = 'yt-dlp'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }
}
