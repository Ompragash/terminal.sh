# Install WSL only if not enabled already
if (!(Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux)) {
    # Enable WSL
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
    Write-Host "Windows Subsystem for Linux (WSL) has been enabled. Please restart your computer to complete the installation."
} else {
    Write-Host "Windows Subsystem for Linux (WSL) is already enabled."
}

# Check if AlmaLinux distribution is already installed
if (!(Get-AppxPackage -Name "almalinux.AlmaLinux")) {
    # Download AlmaLinux distribution from Microsoft Store
    Write-Host "Downloading AlmaLinux distribution from Microsoft Store..."
    $almaAppx = "$env:TEMP\AlmaLinux.appx"
    Invoke-WebRequest -Uri https://aka.ms/wsl-almalinux -OutFile $almaAppx -UseBasicParsing
    
    # Install AlmaLinux distribution
    Write-Host "Installing AlmaLinux distribution..."
    Add-AppxPackage $almaAppx
    Write-Host "AlmaLinux distribution has been installed."
} else {
    Write-Host "AlmaLinux distribution is already installed."
}

# Check if Docker is already installed
if (!(Get-Command "docker")) {
    # Download Docker for Windows installer
    Write-Host "Downloading Docker for Windows installer..."
    $dockerInstaller = "$env:TEMP\docker-20.10.22.zip"
    Invoke-WebRequest -Uri https://download.docker.com/win/static/stable/x86_64/docker-20.10.22.zip -OutFile $dockerInstaller
    # Unzip the downloaded file
    $shell = new-object -com shell.application
    $zip = $shell.NameSpace($dockerInstaller)
    $destination = $shell.NameSpace($env:TEMP)
    $destination.CopyHere($zip.items())
    Write-Host "Docker for Windows has been installed."
} else {
    Write-Host "Docker for Windows is already installed."
}

# Check if Git Bash is already installed
if (!(Test-Path "$env:ProgramFiles\Git\git-bash.exe")) {
    # Download Git Bash installer
    Write-Host "Downloading Git Bash installer..."
    $gitInstaller = "$env:TEMP\GitBash.exe"
    Invoke-WebRequest "https://github.com/git-for-windows/git/releases/download/v2.30.2.windows.1/Git-2.30.2-32-bit.exe" -OutFile $gitInstaller

    # Install Git Bash
    Write-Host "Installing Git Bash..."
    Start-Process -FilePath $gitInstaller -ArgumentList "/SILENT" -Wait
    Write-Host "Git Bash has been installed."
} else {
    Write-Host "Git Bash is already installed."
}

