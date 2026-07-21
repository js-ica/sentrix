# Solana CLI Installation Script for Windows
# Run this in PowerShell as Administrator

Write-Host "Installing Solana CLI..." -ForegroundColor Green

# Clean up any existing temp files
Write-Host "Cleaning up previous installation files..." -ForegroundColor Yellow
Get-ChildItem -Path $env:TEMP -Filter "solana-install-init*.exe" -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

# Download the Solana CLI installer
$timestamp = Get-Date -Format "yyyyMMddHHmmss"
$solanaInstaller = "$env:TEMP\solana-install-init-$timestamp.exe"
$solanaUrl = "https://github.com/solana-labs/solana/releases/download/v1.18.4/solana-install-init-x86_64-pc-windows-msvc.exe"

Write-Host "Downloading Solana CLI installer..." -ForegroundColor Yellow
try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri $solanaUrl -OutFile $solanaInstaller -UseBasicParsing
    Write-Host "Download successful!" -ForegroundColor Green
} catch {
    Write-Host "Error downloading: $_" -ForegroundColor Red
    exit 1
}

Write-Host "Running installer..." -ForegroundColor Yellow
try {
    Start-Process -FilePath $solanaInstaller -ArgumentList "init" -Wait -NoNewWindow
    Write-Host "`nInstallation complete!" -ForegroundColor Green
} catch {
    Write-Host "Error running installer: $_" -ForegroundColor Red
    exit 1
}

Write-Host "`nPlease restart your terminal and run: solana --version" -ForegroundColor Cyan
Write-Host "If the command is still not recognized, you may need to restart PowerShell or add Solana to your PATH manually." -ForegroundColor Yellow