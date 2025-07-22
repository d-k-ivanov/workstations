<#
.SYNOPSIS
Install various development languages.

.DESCRIPTION
Install various development languages.

.PARAMETER Credential
User credental.

.PARAMETER AutoUpdate
Upgrade installed packages to their latest versions.
#>

Configuration DevLangs
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

    # ========================= Assembler ======================
    cChocoPackageInstaller InstallNasm
    {
        Name                 = 'nasm'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallYasm
    {
        Name                 = 'yasm'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    # ========================= Clojure ========================
    cChocoPackageInstaller InstallLein
    {
        Name                 = 'lein'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    # ========================= Go =============================
    cChocoPackageInstaller InstallGo
    {
        Name                 = 'golang'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    # ========================= Haskell ========================
    cChocoPackageInstaller InstallGHC
    {
        Name                 = 'ghc'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    # ========================= Java ===========================
    cChocoPackageInstaller InstallCorrettoJDKLatest
    {
        Name                 = 'correttojdk'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallOpenJDK11
    {
        Name                 = 'openjdk11'
        AutoUpgrade          = $AutoUpdate
        Version              = '11.0.16'
        Ensure               = 'Present'
        DependsOn            = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallOpenJDK11-MS
    {
        Name                 = 'microsoft-openjdk11'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallOpenJDKLatest
    {
        Name                 = 'openjdk'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallOracleJDK8
    {
        Name                 = 'jdk8'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallOracleJDK17
    {
        Name                 = 'oracle17jdk'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallOracleJDKLatest
    {
        Name                 = 'oraclejdk'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallTemurinJDKLatest
    {
        Name                 = 'temurin'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential = $Credential
    }

    # ========================= Julia ==========================
    cChocoPackageInstaller InstallJulia
    {
        Name                 = 'julia'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    # ========================= Lua ============================
    cChocoPackageInstaller InstallLua
    {
        Name                 = 'lua'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    # ========================= NodeJS =========================
    cChocoPackageInstaller InstallNodeJS
    {
        Name                 = 'nodejs-lts'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    # ========================= Perl ===========================
    cChocoPackageInstaller InstallPerl
    {
        Name                 = 'strawberryperl'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    # ========================= PowerShell =====================
    cChocoPackageInstaller InstallPowerShellCore
    {
        Name                 = 'powershell-core'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    # ========================= Python =========================
    cChocoPackageInstaller InstallPython
    {
        Name                 = 'python'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallMiniconda3
    {
        Name                 = 'miniconda3'
        Params               = '/InstallationType:AllUsers /AddToPath:0 /RegisterPython:0'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential = $Credential
    }

    # cChocoPackageInstaller InstallPenvWin
    # {
    #     Name                 = 'pyenv-win'
    #     AutoUpgrade          = $AutoUpdate
    #     Ensure               = 'Absent'
    #     DependsOn            = '[cChocoInstaller]InstallChocolatey'
    #     PsDscRunAsCredential = $Credential
    # }

    # ========================= R ==============================
    cChocoPackageInstaller InstallRProject
    {
        Name                 = 'r'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallRStudio
    {
        Name                 = 'r.studio'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    # ========================= Ruby ===========================
    cChocoPackageInstaller InstallRuby
    {
        Name                 = 'ruby'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }
}
