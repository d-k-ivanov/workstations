<#
.SYNOPSIS
Install various development tools.

.DESCRIPTION
Install various development tools.

.PARAMETER Credential
User credental.

.PARAMETER NoUpgrate
Do not upgrade installed packages to their latest versions.
#>

Configuration DevLangs
{
    Param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [pscredential] $Credential,

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

    cChocoinstaller InstallChocolatey {
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

    # ========================= Assembler ======================
    cChocoPackageInstaller InstallNasm
    {
        Name                    = 'nasm'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallYasm
    {
        Name                    = 'yasm'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    # ========================= Clojure ========================
    cChocoPackageInstaller InstallLein
    {
        Name                    = 'lein'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    # ========================= Go =============================
    cChocoPackageInstaller InstallGo
    {
        Name                    = 'golang'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    # ========================= Haskell ========================
    cChocoPackageInstaller InstallGHC
    {
        Name                    = 'ghc'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    # ========================= Julia ==========================
    cChocoPackageInstaller InstallJulia
    {
        Name                    = 'julia'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    # ========================= NodeJS =========================
    cChocoPackageInstaller InstallNodeJS
    {
        Name                    = 'nodejs-lts'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    # ========================= Perl ===========================
    cChocoPackageInstaller InstallPerl
    {
        Name                    = 'strawberryperl'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    # ========================= Python =========================
    cChocoPackageInstaller InstallPython2
    {
        Name                    = 'python2'
        Params                  = '"/InstallDir:C:\tools\python2"'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

        cChocoPackageInstaller InstallPython3
    {
        Name                    = 'python3'
        Params                  = '/InstallDir:C:\tools\python3'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    # ========================= Ruby ===========================
    cChocoPackageInstaller InstallRuby
    {
        Name                    = 'ruby'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

}
