<#
.SYNOPSIS
Run automated configuration of developer workstation.

.DESCRIPTION
Run automated configuration of developer workstation.
#>

Begin
{
    # ------------------------------------------------------------
    # Variables
    # ------------------------------------------------------------
    $PSModulePathSys   = $Env:PSModulePath
    $PSModulePathLoc   = Join-Path $PSScriptRoot '.modules'
    $Env:PSModulePath  = "${PSScriptRoot}"    + "$([System.IO.Path]::PathSeparator)${PSModulePathSys}"
    # $DscResourcesPath  = Join-Path $PSScriptRoot 'DSC'
    # $Env:PSModulePath  = "${PSModulePathLoc}" + "$([System.IO.Path]::PathSeparator)${PSModulePathSys}"
    # $Env:PSModulePath  = "${PSScriptRoot}"    + "$([System.IO.Path]::PathSeparator)${PSModulePathLoc}" + "$([System.IO.Path]::PathSeparator)${PSModulePathSys}"

    # ------------------------------------------------------------
    # Init
    # ------------------------------------------------------------
    . "${PSScriptRoot}\Functions.ps1"
    Skip-FirstLines
    ElevateSession

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
        dir WSMan:\localhost | Format-Table
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
    # Load LCM Config
    # ------------------------------------------------------------
    . "${PSScriptRoot}\LCMConfig.ps1"
    Set-DscLocalConfigurationManager -Path $PSScriptRoot


    # ------------------------------------------------------------
    # Load Workstation DSC Composite Config
    # ------------------------------------------------------------
    . "${PSScriptRoot}\WorkstationConfig.ps1"


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


} # End block

# ------------------------------------------------------------
# End of Run script
