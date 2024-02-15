<#
.SYNOPSIS
Install communication tools.

.DESCRIPTION
Install communication tools.

.PARAMETER Credential
User credental.

.PARAMETER AutoUpdate
Upgrade installed packages to their latest versions.
#>

Configuration CommunicationTools
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

    cChocoPackageInstaller InstallSlack
    {
        Name                 = 'slack'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    # cChocoPackageInstaller InstallTeams
    # {
    #     Name                 = 'microsoft-teams.install'
    #     AutoUpgrade          = $AutoUpdate
    #     Ensure               = 'Absent'
    #     DependsOn            = '[cChocoInstaller]InstallChocolatey'
    #     PsDscRunAsCredential = $Credential
    # }

    # cChocoPackageInstaller InstallTelegram
    # {
    #     Name                 = 'telegram.install'
    #     AutoUpgrade          = $AutoUpdate
    #     Ensure               = 'Absent'
    #     DependsOn            = '[cChocoInstaller]InstallChocolatey'
    #     PsDscRunAsCredential = $Credential
    # }

    cChocoPackageInstaller InstallWhatsapp
    {
        Name                 = 'whatsapp'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallSkype
    {
        Name                 = 'skype'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallZoom
    {
        Name                 = 'zoom'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }
}
