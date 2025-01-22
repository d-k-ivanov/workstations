<#
.SYNOPSIS
Install DevOps and Admin tools.

.DESCRIPTION
Install DevOps and Admin tools.

.PARAMETER Credential
User credental.

.PARAMETER AutoUpdate
Upgrade installed packages to their latest versions.
#>

Configuration DevOps
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

    cChocoPackageInstaller InstallOnePassword
    {
        Name                 = '1password'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallActCLI
    {
        Name                 = 'act-cli'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallAWSCli
    {
        Name                 = 'awscli'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallAWSIAMAuthenticator
    {
        Name                 = 'aws-iam-authenticator'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallAzureCli
    {
        Name                 = 'azure-cli'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallBindTools
    {
        Name                 = 'bind-toolsonly'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    Script DownloadBindToolsConfig
    {
        SetScript  = {
            Write-Output 'nameserver 8.8.8.8' > $env:SystemRoot\System32\Drivers\etc\resolv.conf
            Write-Output 'nameserver 77.88.8.8' >> $env:SystemRoot\System32\Drivers\etc\resolv.conf
        }
        GetScript  = { @{} }
        TestScript = {
            Test-Path $env:SystemRoot\System32\Drivers\etc\resolv.conf
        }
    }

    cChocoPackageInstaller InstallBitwarden
    {
        Name                 = 'bitwarden'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    # cChocoPackageInstaller InstallBitwardenCli
    # {
    #     Name                 = 'bitwarden-cli'
    #     AutoUpgrade          = $AutoUpdate
    #     Ensure               = 'Absent'
    #     DependsOn            = '[cChocoInstaller]InstallChocolatey'
    #     PsDscRunAsCredential = $Credential
    # }

    cChocoPackageInstaller InstallCharles4
    {
        Name                 = 'charles4'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallChefDK
    {
        Name                 = 'chefdk'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallCodecov
    {
        Name                 = 'codecov'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallConEmu
    {
        Name                 = 'conemu'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallConsul
    {
        Name                 = 'consul'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallCurl
    {
        Name                 = 'curl'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallFtpdmin
    {
        Name                 = 'ftpdmin'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallGitHubCli
    {
        Name                 = 'gpg4win'
        AutoUpgrade          = $false
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallGPG4Win
    {
        Name                 = 'gpg4win'
        AutoUpgrade          = $false
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallKeepass
    {
        Name                 = 'keepass'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallKeepassFavicon
    {
        Name                 = 'keepass-yet-another-favicon-downloader'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallKeepassQRCode
    {
        Name                 = 'keepass-plugin-qrcodegen'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallKeystoreExplorer
    {
        Name                 = 'keystore-explorer.portable'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallLdapAdmin
    {
        Name                 = 'ldapadmin'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallMremoteng
    {
        Name                 = 'mremoteng'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallNmap
    {
        Name                 = 'nmap'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallNssm
    {
        Name                 = 'nssm'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallOpenConnect
    {
        Name                 = 'openconnect-gui'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallOpenSSH
    {
        Name                 = 'openssh'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallOpenSslLight
    {
        Name                 = 'openssl.light'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallOpenVPN
    {
        Name                 = 'openvpn'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallTAPWindows
    {
        Name                 = 'tapwindows'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallPacker
    {
        Name                 = 'packer'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller Pulumi
    {
        Name                 = 'pulumi'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallPuTTY
    {
        Name                 = 'putty'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    # Script DownloadRDCMan
    # {
    #     SetScript  = { Invoke-WebRequest -Uri 'https://github.com/d-k-ivanov/workstations/raw/main/windows/Installers/rdcman.msi' -OutFile 'C:\Windows\Temp\rdcman.msi' }
    #     GetScript  = { @{} }
    #     TestScript = { Test-Path 'C:\Windows\Temp\rdcman.msi' }
    # }

    # Script InstallRDCMan
    # {
    #     SetScript            = { Start-Process -FilePath "msiexec.exe" -ArgumentList "/i C:\Windows\Temp\rdcman.msi /qn" -Wait }
    #     GetScript            = { @{} }
    #     TestScript           = { Test-Path "${Env:ProgramFiles(x86)}\Remote Desktop Connection Manager" }
    #     DependsOn            = '[Script]DownloadRDCMan'
    #     PsDscRunAsCredential = $Credential
    # }

    cChocoPackageInstaller InstallRufus
    {
        Name                 = 'rufus'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallSuperPuTTY
    {
        Name                 = 'superputty'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallTerraform
    {
        Name                 = 'terraform'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallTFTPD32
    {
        Name                 = 'tftpd32'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallTightVNC
    {
        Name                 = 'tightvnc'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallTravisCLI
    {
        Name                 = 'travis'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallVagrant
    {
        Name                 = 'vagrant'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallVagrantManager
    {
        Name                 = 'vagrant-manager'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallVcXsrv
    {
        Name                 = 'vcxsrv'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallWget
    {
        Name                 = 'wget'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallWifiInfoView
    {
        Name                 = 'wifiinfoview'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallWinSCP
    {
        Name                 = 'winscp.install'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallWinpcap
    {
        Name                 = 'winpcap'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallWireshark
    {
        Name                 = 'wireshark'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallWMIExplorer
    {
        Name                 = 'wmiexplorer'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }
}
