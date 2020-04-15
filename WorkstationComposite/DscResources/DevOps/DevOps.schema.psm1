<#
.SYNOPSIS
Install DevOps and Admin tools.

.DESCRIPTION
Install DevOps and Admin tools.
#>

Configuration DevOps
{
    Param
    (
        [switch] $AutoUpgrade = $True
    )

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
    #     Ensure                  = 'Present'
    #     DependsOn               = '[cChocoInstaller]InstallChocolatey'
    # }

    cChocoPackageInstaller InstallAWSCli
    {
        Name                    = 'awscli'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallAzureCli
    {
        Name                    = 'azure-cli'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallBindTools
    {
        Name                    = 'bind-toolsonly'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
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
    }

    cChocoPackageInstaller InstallCmderMini
    {
        Name                    = 'cmdermini'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallCurl
    {
        Name                    = 'curl'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallFtpdmin
    {
        Name                    = 'ftpdmin'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallGPG4Win
    {
        Name                    = 'gpg4win'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallKeepass
    {
        Name                    = 'keepass'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallKeepassFavicon
    {
        Name                    = 'keepass-yet-another-favicon-downloader'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallKeepassQRCode
    {
        Name                    = 'keepass-plugin-qrcodegen'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallKeystoreExplorer
    {
        Name                    = 'keystore-explorer.portable'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallKubernetesCli
    {
        Name                    = 'kubernetes-cli'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallKubernetesHelm
    {
        Name                    = 'kubernetes-helm'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallKubernetesKompose
    {
        Name                    = 'kubernetes-kompose'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallLdapAdmin
    {
        Name                    = 'ldapadmin'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallMinikube
    {
        Name                    = 'minikube'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallMremoteng
    {
        Name                    = 'mremoteng'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallMysqlWorkbench
    {
        Name                    = 'mysql.workbench'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallNmap
    {
        Name                    = 'nmap'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallNssm
    {
        Name                    = 'nssm'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallOpenSSH
    {
        Name                    = 'openssh'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallOpenSslLight
    {
        Name                    = 'openssl.light'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallOpenVPN
    {
        Name                    = 'openvpn'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallPacker
    {
        Name                    = 'packer'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallPgAdmin4
    {
        Name                    = 'pgadmin4'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallPuTTY
    {
        Name                    = 'putty'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallRobo3t
    {
        Name                    = 'robo3t'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallRufus
    {
        Name                    = 'rufus'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallSuperPuTTY
    {
        Name                    = 'superputty'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallSQLiteBrowser
    {
        Name                    = 'sqlitebrowser.install'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallTerraform
    {
        Name                    = 'terraform'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallTFTPD32
    {
        Name                    = 'tftpd32'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallTightVNC
    {
        Name                    = 'tightvnc'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallVagrant
    {
        Name                    = 'vagrant'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallVagrantManager
    {
        Name                    = 'vagrant-manager'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallVcXsrv
    {
        Name                    = 'vcxsrv'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallWget
    {
        Name                    = 'wget'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallWifiInfoView
    {
        Name                    = 'wifiinfoview'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallWinSCP
    {
        Name                    = 'winscp'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallWireshark
    {
        Name                    = 'wireshark'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallWMIExplorer
    {
        Name                    = 'wmiexplorer'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }
}
