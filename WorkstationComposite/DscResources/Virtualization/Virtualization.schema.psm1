<#
.SYNOPSIS
Install virtualization tools.

.DESCRIPTION
Install virtualization tools.

.PARAMETER Credential
User credental.
#>

Configuration Virtualization
{
    Param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [pscredential] $Credential
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName cChoco

    WindowsOptionalFeature  EnableHyperVFeature
    {
        Name                 = 'Microsoft-Hyper-V'
        Ensure               = 'Enable'
    }

    WindowsOptionalFeature  EnableHyperVAllFeature
    {
        Name                 = 'Microsoft-Hyper-V-All'
        Ensure               = 'Enable'
    }

    WindowsOptionalFeature  EnableHyperVToolsAllFeature
    {
        Name                 = 'Microsoft-Hyper-V-Tools-All'
        Ensure               = 'Enable'
    }

    WindowsOptionalFeature  EnableVirtualMachineFeature
    {
        Name                 = 'VirtualMachinePlatform'
        Ensure               = 'Enable'
    }

    WindowsOptionalFeature  EnableHypervisorPlatformFeature
    {
        Name                 = 'HypervisorPlatform'
        Ensure               = 'Enable'
    }

    WindowsOptionalFeature  EnableWindowsSubsystemForLinuxFeature
    {
        Name                 = 'Microsoft-Windows-Subsystem-Linux'
        Ensure               = 'Enable'
    }

    WindowsOptionalFeature  EnableContainersFeature
    {
        Name                 = 'Containers'
        Ensure               = 'Enable'
    }

    WindowsOptionalFeature  EnableSandboxFeature
    {
        Name                 = 'Containers-DisposableClientVM'
        Ensure               = 'Enable'
    }

    cChocoinstaller InstallChocolatey
    {
        InstallDir              = 'C:\ProgramData\chocolatey'
    }

    if ($NoUpgrate)
    {
        $AutoUpgrade = $false
    }
    else
    {
        $AutoUpgrade = $true
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
    #     PsDscRunAsCredential    = $Credential
    # }

    cChocoPackageInstaller InstallDockerDesktop
    {
        Name                    = 'docker-desktop'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = ("[WindowsOptionalFeature]EnableHyperVAllFeature", '[cChocoInstaller]InstallChocolatey')
        PsDscRunAsCredential    = $Credential
    }


}
