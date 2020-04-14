
# Verify Running as Admin
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
If (-not $isAdmin) 
{
    Write-Host "-- Restarting as Administrator" -ForegroundColor Cyan
    Start-Sleep -Seconds 1

    If($PSVersionTable.PSEdition -eq "Core") 
    {
        Start-Process pwsh.exe "-NoProfile -NoExit -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs 
    }
    Else
    {
        Start-Process powershell.exe "-NoProfile -NoExit -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs 
    }

    exit
}

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12


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


# Install PSDepend
if (-Not (Get-Module -Name PSDepend -ListAvailable))
{
    Install-Module -Scope AllUsers -Name PSDepend -Force
}


# Check resources
Get-Module -ListAvailable
Get-DscResource | Format-Table

pause
