<#
.SYNOPSIS
Install various development tools.

.DESCRIPTION
Install various development tools.
#>

Configuration DevLangs
{
    Param
    (
        [switch] $AutoUpgrade = $True
    )

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
    #     Ensure                  = 'Present'
    #     DependsOn               = '[cChocoInstaller]InstallChocolatey'
    # }

    # ========================= Assembler ======================
    cChocoPackageInstaller InstallNasm
    {
        Name                    = 'nasm'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallYasm
    {
        Name                    = 'yasm'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    # ========================= Clojure ========================
    cChocoPackageInstaller InstallLein
    {
        Name                    = 'lein'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    # ========================= Go =============================
    cChocoPackageInstaller InstallGo
    {
        Name                    = 'golang'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    # ========================= Haskell ========================
    cChocoPackageInstaller InstallGHC
    {
        Name                    = 'ghc'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    # ========================= Julia ==========================
    cChocoPackageInstaller InstallJulia
    {
        Name                    = 'julia'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    # ========================= NodeJS =========================
    cChocoPackageInstaller InstallNodeJS
    {
        Name                    = 'nodejs-lts'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    # ========================= Perl ===========================
    cChocoPackageInstaller InstallPerl
    {
        Name                    = 'strawberryperl'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    # ========================= Python =========================
    cChocoPackageInstaller InstallPython2
    {
        Name                    = 'python2'
        Params                  = '"/InstallDir:C:\tools\python2"'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

        cChocoPackageInstaller InstallPython3
    {
        Name                    = 'python3'
        Params                  = '/InstallDir:C:\tools\python3'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    # ========================= Ruby ===========================
    cChocoPackageInstaller InstallRuby
    {
        Name                    = 'ruby'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

}
