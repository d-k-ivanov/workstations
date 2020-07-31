<#
.SYNOPSIS
Install DevOps and Admin tools.

.DESCRIPTION
Install DevOps and Admin tools.

.PARAMETER Credential
User credental.

.PARAMETER NoUpgrate
Do not upgrade installed packages to their latest versions.
#>

Configuration DevOps
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

    Import-DscResource –ModuleName PSDesiredStateConfiguration
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

    cChocoPackageInstaller InstallAWSCli
    {
        Name                    = 'awscli'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallAzureCli
    {
        Name                    = 'azure-cli'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallBindTools
    {
        Name                    = 'bind-toolsonly'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    Script DownloadBindToolsConfig
    {
        SetScript               = {
            Write-Output 'nameserver 8.8.8.8' > $env:SystemRoot\System32\Drivers\etc\resolv.conf
            Write-Output 'nameserver 77.88.8.8' >> $env:SystemRoot\System32\Drivers\etc\resolv.conf
        }
        GetScript               = { @{} }
        TestScript              = {
            Test-Path $env:SystemRoot\System32\Drivers\etc\resolv.conf
        }
    }

    cChocoPackageInstaller InstallChefDK
    {
        Name                    = 'chefdk'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallCmderMini
    {
        Name                    = 'cmdermini'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallCurl
    {
        Name                    = 'curl'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallFtpdmin
    {
        Name                    = 'ftpdmin'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallGPG4Win
    {
        Name                    = 'gpg4win'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallKeepass
    {
        Name                    = 'keepass'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallKeepassFavicon
    {
        Name                    = 'keepass-yet-another-favicon-downloader'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallKeepassQRCode
    {
        Name                    = 'keepass-plugin-qrcodegen'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallKeystoreExplorer
    {
        Name                    = 'keystore-explorer.portable'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallKubernetesCli
    {
        Name                    = 'kubernetes-cli'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallKubernetesHelm
    {
        Name                    = 'kubernetes-helm'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallKubernetesKompose
    {
        Name                    = 'kubernetes-kompose'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallLdapAdmin
    {
        Name                    = 'ldapadmin'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallMinikube
    {
        Name                    = 'minikube'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallMremoteng
    {
        Name                    = 'mremoteng'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallMysqlWorkbench
    {
        Name                    = 'mysql.workbench'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallNmap
    {
        Name                    = 'nmap'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallNssm
    {
        Name                    = 'nssm'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallOpenSSH
    {
        Name                    = 'openssh'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallOpenSslLight
    {
        Name                    = 'openssl.light'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallOpenVPN
    {
        Name                    = 'openvpn'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallPacker
    {
        Name                    = 'packer'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    # cChocoPackageInstaller InstallPgAdmin4
    # {
    #     Name                    = 'pgadmin4'
    #     AutoUpgrade             = $AutoUpgrade
    #     Ensure                  = 'Present'
    #     DependsOn               = '[cChocoInstaller]InstallChocolatey'
    #     PsDscRunAsCredential    = $Credential
    # }

    cChocoPackageInstaller Pulumi
    {
        Name                    = 'pulumi'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallPuTTY
    {
        Name                    = 'putty'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    Script DownloadRDCMan
    {
        SetScript               = { Invoke-WebRequest -Uri 'https://github.com/d-k-ivanov/dsc-windows-workstation/blob/master/Installers/rdcman.msi?raw=true' -OutFile 'C:\Windows\Temp\rdcman.msi' }
        GetScript               = { @{} }
        TestScript              = { Test-Path 'C:\Windows\Temp\rdcman.msi' }
    }

    Script InstallRDCMan
    {
        SetScript               = { Start-Process -FilePath "msiexec.exe" -ArgumentList "/i C:\Windows\Temp\rdcman.msi /qn" -Wait }
        GetScript               = { @{} }
        TestScript              = { Test-Path "${Env:ProgramFiles(x86)}\Remote Desktop Connection Manager" }
        DependsOn               = '[Script]DownloadRDCMan'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallRobo3t
    {
        Name                    = 'robo3t'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallRufus
    {
        Name                    = 'rufus'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallSuperPuTTY
    {
        Name                    = 'superputty'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallSQLiteBrowser
    {
        Name                    = 'sqlitebrowser.install'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallTerraform
    {
        Name                    = 'terraform'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallTFTPD32
    {
        Name                    = 'tftpd32'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallTightVNC
    {
        Name                    = 'tightvnc'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallVagrant
    {
        Name                    = 'vagrant'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallVagrantManager
    {
        Name                    = 'vagrant-manager'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallVcXsrv
    {
        Name                    = 'vcxsrv'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallWget
    {
        Name                    = 'wget'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallWifiInfoView
    {
        Name                    = 'wifiinfoview'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallWinSCP
    {
        Name                    = 'winscp'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallWireshark
    {
        Name                    = 'wireshark'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallWMIExplorer
    {
        Name                    = 'wmiexplorer'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

}
