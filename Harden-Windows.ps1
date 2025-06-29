# === Run as Administrator ===

# Block dangerous inbound ports
$portsToBlock = "135", "139", "445", "5040", "1462", "49664-49669"
foreach ($port in $portsToBlock) {
    New-NetFirewallRule -DisplayName "Block Port $port" `
                        -Direction Inbound `
                        -LocalPort $port `
                        -Protocol TCP `
                        -Action Block `
                        -Profile Any
}

# Disable dangerous or unneeded services
$servicesToDisable = @(
    "RemoteRegistry",
    "TermService",           # Remote Desktop
    "LanmanServer",          # File Sharing (SMB)
    "LanmanWorkstation",     # SMB Client
    "SSDPDiscovery",
    "upnphost",              # UPnP
    "FDResPub",              # Function Discovery
    "Spooler"                # Printer (optional, comment out if needed)
)

foreach ($svc in $servicesToDisable) {
    Write-Host "Disabling service: $svc"
    Stop-Service -Name $svc -ErrorAction SilentlyContinue
    Set-Service -Name $svc -StartupType Disabled
}

# OPTIONAL: Disable IPv6 (uncomment if you want)
<# 
Write-Host "Disabling IPv6..."
New-ItemProperty `
    -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" `
    -Name "DisabledComponents" `
    -PropertyType DWord `
    -Value 0xFF `
    -Force
#>

Write-Host "`n✅ System hardening complete. Please restart your computer to apply all changes."
