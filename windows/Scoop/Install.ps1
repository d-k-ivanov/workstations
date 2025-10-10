
if (! (Get-Command scoop -ErrorAction SilentlyContinue))
{
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}
else
{
    Write-Host "Installing buckets..."
    scoop bucket add extras
    scoop bucket add games
    scoop bucket add nerd-fonts

    Write-Host "Installing Software with Scoop..."`
    scoop install main/docker
    scoop install main/docker-compose
    scoop install main/nmap
    # scoop install main/msys2

    # Fonts
    scoop install nerd-fonts/Hack-NF
    scoop install nerd-fonts/Hack-NF-Propo
    scoop install nerd-fonts/Hack-NF-Mono
}
