<#
.SYNOPSIS
Run automated configuration of developer workstation.

.DESCRIPTION
Run automated configuration of developer workstation.
#>

[CmdletBinding()]
param
(
    [Parameter(Mandatory = $true)]
    [string] $WorkstationType,
    [string] $Workgroup = 'Workgroup',
    [switch] $Update
)

Begin
{
    # ------------------------------------------------------------
    # Variables
    # ------------------------------------------------------------
    $PSModulePathSys   = $Env:PSModulePath
    # $PSModulePathLoc   = Join-Path $PSScriptRoot '.modules'
    # $DscResourcesPath  = Join-Path $PSScriptRoot 'DSC'

    $Env:PSModulePath  = "${PSScriptRoot}" + "$([System.IO.Path]::PathSeparator)${PSModulePathSys}"
    # $Env:PSModulePath  = "${PSModulePathLoc}" + "$([System.IO.Path]::PathSeparator)${PSModulePathSys}"
    # $Env:PSModulePath  = "${PSScriptRoot}"    + "$([System.IO.Path]::PathSeparator)${PSModulePathLoc}" + "$([System.IO.Path]::PathSeparator)${PSModulePathSys}"

    # ------------------------------------------------------------
    # Init
    # ------------------------------------------------------------
    . "${PSScriptRoot}\Functions.ps1"
    Skip-FirstLines
    ElevateSession

    Stop-Transcript
    Remove-Item -Force "$PSScriptRoot\Run.log" -ErrorAction SilentlyContinue
    Start-Transcript -Path "$PSScriptRoot\Run.log" -Force
    $StartDateTime = get-date
    Write-Host "Script started at $StartDateTime"

    Remove-Item -Force ${PSScriptRoot}\*.mof -ErrorAction SilentlyContinue

} # Begin block

Process
{
    # ------------------------------------------------------------
    # Base
    # ------------------------------------------------------------
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    # Create local modules directory
    # if (-Not (Test-Path "${PSModulePathLoc}"))
    # {
    #     New-Item -ItemType Directory -Force -Path "${PSModulePathLoc}" | Out-Null
    # }

    # Enable WinRM if needed
    if (-Not (Test-WSMan -ComputerName localhost -ErrorAction SilentlyContinue))
    {
        # For public networks
        # Enable-PSRemoting -SkipNetworkProfileCheck -Force

        Set-NetConnectionProfile -NetworkCategory Private
        Enable-PSRemoting -Force
        Set-WSManInstance -ValueSet @{MaxEnvelopeSizekb = "2000"} -ResourceURI winrm/config
        Get-ChildItem WSMan:\localhost | Format-Table
    }

    # Install Nuget package provide if needed
    if (-Not (Get-packageProvider -Name NuGet -ListAvailable -ErrorAction SilentlyContinue))
    {
        Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    }

    # Make PSGallery Trusted if needed
    if (-Not (Get-PSRepository -Name PSGallery -ErrorAction SilentlyContinue).InstallationPolicy -eq 'Trusted')
    {
        Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    }

    # ------------------------------------------------------------
    # PSDepend
    # ------------------------------------------------------------
    if (-Not (Get-Module -Name PSDepend -ListAvailable))
    {
        # Find-Module -Name 'PSDepend' -Repository 'PSGallery' | Save-Module -Path "${PSModulePathLoc}"
        # Import-Module -FullyQualifiedName "${PSModulePathLoc}\PSDepend"
        Install-Module -Scope AllUsers -Name PSDepend -Force
    }
    Import-Module -Name PSDepend
    Invoke-PSDepend -Path $PSScriptRoot -Force -Import -Install # -Tags 'SampleTag'
    # WriteInfoHighlighted($Env:PSModulePath)

    # ------------------------------------------------------------
    # Clean up duplicates
    # ------------------------------------------------------------
    Uninstall-DuplicatedModules

    # ------------------------------------------------------------
    # Win10-Initial-Setup-Script
    # ------------------------------------------------------------
    . "${PSScriptRoot}\W10Init.ps1"

    # ------------------------------------------------------------
    # Disable Windows Defender One More Time......................
    # ------------------------------------------------------------
    . "${PSScriptRoot}\DefenderDisable.ps1"

    # ------------------------------------------------------------
    # Load LCM Config
    # ------------------------------------------------------------
    . "${PSScriptRoot}\LCMConfig.ps1"
    Set-DscLocalConfigurationManager -Path $PSScriptRoot -Force

    # ------------------------------------------------------------
    # Load Workstation DSC Composite Config
    # ------------------------------------------------------------
    switch ($WorkstationType)
    {
        "Home"
        {
            . "${PSScriptRoot}\PC_Config_Home.ps1"
            break
        }
        "Work"
        {
            . "${PSScriptRoot}\PC_Config_Work.ps1"
            break
        }
    }
    $WorkstationType

    # ------------------------------------------------------------
    # Execute Workstation Config
    # ------------------------------------------------------------
    Start-DscConfiguration -Path $PSScriptRoot -Wait -Verbose -Force

} # Process block

End
{
    # ------------------------------------------------------------
    # Cleanup
    # ------------------------------------------------------------
    $Env:PSModulePath = $PSModulePathSys
    Write-Host "Script finished at $(Get-date) and took $(((get-date) - $StartDateTime).TotalMinutes) Minutes"
    Stop-Transcript

} # End block

# ------------------------------------------------------------
# End of Run script
