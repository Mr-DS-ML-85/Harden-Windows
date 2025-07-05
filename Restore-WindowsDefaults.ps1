# === Run as Administrator ===

# ----------------------------------------
# 🔓 Remove custom firewall rules for blocked TCP ports
# ----------------------------------------
$portsToUnblock = @(
    "135", "137", "139", "445", "5040", "1462", "7680",
    "26822", "32683", "33683", "49664", "49665", "49666", "49667", "49670"
)

foreach ($port in $portsToUnblock) {
    $ruleName = "Block TCP Port $port"
    $rule = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue
    if ($rule) {
        Write-Host "🧹 Removing firewall rule: $ruleName"
        Remove-NetFirewallRule -DisplayName $ruleName
    } else {
        Write-Host "⚠️ Firewall rule not found: $ruleName (skipping)"
    }
}

# ----------------------------------------
# 🔄 Restore service startup types to defaults
# ----------------------------------------
$servicesToRestore = @{
    "RemoteRegistry"    = "Manual"
    "TermService"       = "Manual"
    "LanmanServer"      = "Automatic"
    "LanmanWorkstation" = "Automatic"
    "SSDPDiscovery"     = "Manual"
    "upnphost"          = "Manual"
    "FDResPub"          = "Manual"
    "Spooler"           = "Automatic"
}

foreach ($svc in $servicesToRestore.Keys) {
    $service = Get-Service -Name $svc -ErrorAction SilentlyContinue
    if ($service) {
        $desiredStartup = $servicesToRestore[$svc]
        Write-Host "🔁 Restoring service: $svc → $desiredStartup"
        Set-Service -Name $svc -StartupType $desiredStartup
    } else {
        Write-Host "⚠️ Service not found: $svc (skipping)"
    }
}

# ----------------------------------------
# ✅ Done
# ----------------------------------------
Write-Host "`n✅ System restore complete. Please restart your computer for full effect." -ForegroundColor Green
