<#
.SYNOPSIS
Install various development tools.

.DESCRIPTION
Install various development tools.

.PARAMETER Credential
User credental.

.PARAMETER NoUpgrade
Do not upgrade installed packages to their latest versions.
#>

Configuration DevLangs
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
    cChocoPackageInstaller InstallPython
    {
        Name                    = 'python'
        Params                  = '/InstallDir:C:\tools\python3'
        # Version                 = '3.9.2'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallMiniconda3
    {
        Name                    = 'miniconda3'
        Params                  = '/InstallationType:AllUsers /AddToPath:0 /RegisterPython:0'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    # cChocoPackageInstaller InstallPenvWin
    # {
    #     Name                    = 'pyenv-win'
    #     AutoUpgrade             = $AutoUpgrade
    #     Ensure                  = 'Present'
    #     DependsOn               = '[cChocoInstaller]InstallChocolatey'
    #     PsDscRunAsCredential    = $Credential
    # }

    # ========================= R ==============================
    cChocoPackageInstaller InstallRProject
    {
        Name                    = 'r'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallRStudio
    {
        Name                    = 'r.studio'
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
