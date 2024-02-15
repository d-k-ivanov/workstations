<#
.SYNOPSIS
Install various storage tools.

.DESCRIPTION
Install various storage tools.

.PARAMETER Credential
User credental.

.PARAMETER AutoUpdate
Upgrade installed packages to their latest versions.
#>

Configuration StorageTools
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
    #     Name                 = 'PackageName'
    #     Version              = ''
    #     Params               = ''
    #     AutoUpgrade          = $AutoUpdate
    #     Ensure               = 'Present | Absent'
    #     DependsOn            = '[cChocoInstaller]InstallChocolatey'
    #     PsDscRunAsCredential = $Credential
    # }

    cChocoPackageInstaller InstallDropBox
    {
        Name                 = 'dropbox'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    # cChocoPackageInstaller InstallExt2FSD
    # {
    #     Name                 = 'ext2fsd'
    #     AutoUpgrade          = $AutoUpdate
    #     Ensure               = 'Present'
    #     DependsOn            = '[cChocoInstaller]InstallChocolatey'
    #     PsDscRunAsCredential = $Credential
    # }
}
