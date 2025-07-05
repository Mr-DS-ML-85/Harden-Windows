# === Run this script as Administrator ===

# ----------------------------------------
# 🚫 Block inbound dangerous or unneeded ports
# ----------------------------------------
$portsToBlock = @(
    "135", "137", "139", "445", "5040", "1462", "7680",
    "26822", "32683", "33683", "49664", "49665", "49666", "49667", "49670"
)

foreach ($port in $portsToBlock) {
    $ruleName = "Block TCP Port $port"
    Write-Host "🔒 Blocking port: $port"

    if (-not (Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue)) {
        New-NetFirewallRule -DisplayName $ruleName `
                            -Direction Inbound `
                            -LocalPort $port `
                            -Protocol TCP `
                            -Action Block `
                            -Profile Any
        Write-Host "✅ Port $port blocked"
    } else {
        Write-Host "⚠️ Rule already exists for port $port (skipping)"
    }
}

# ----------------------------------------
# ❌ Disable dangerous or unneeded services
# ----------------------------------------
$servicesToDisable = @(
    "RemoteRegistry",
    "TermService",         # Remote Desktop
    "LanmanServer",        # SMB File Sharing
    "LanmanWorkstation",   # SMB Client
    "SSDPDiscovery",       # Might not exist
    "upnphost",            # UPnP
    "FDResPub",            # Function Discovery
    "Spooler"              # Printer service (optional)
)

foreach ($svc in $servicesToDisable) {
    $service = Get-Service -Name $svc -ErrorAction SilentlyContinue
    if ($service) {
        Write-Host "🛑 Disabling service: $svc"
        Stop-Service -Name $svc -ErrorAction SilentlyContinue
        Set-Service -Name $svc -StartupType Disabled
    } else {
        Write-Host "⚠️ Service not found: $svc (skipping)"
    }
}

# ----------------------------------------
# 🧪 OPTIONAL: Disable IPv6 (Uncomment if needed)
# ----------------------------------------
<#
Write-Host "Disabling IPv6..."
New-ItemProperty `
    -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" `
    -Name "DisabledComponents" `
    -PropertyType DWord `
    -Value 0xFF `
    -Force
#>

# ----------------------------------------
# ✅ Done
# ----------------------------------------
Write-Host "`n🎉 System hardening complete. Please restart your PC to apply all changes." -ForegroundColor Green
