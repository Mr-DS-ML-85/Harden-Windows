# === Run as Administrator ===

# Restore default services
$servicesToRestore = @{
    "RemoteRegistry"     = "Manual";
    "TermService"        = "Manual";   # Remote Desktop
    "LanmanServer"       = "Automatic";
    "LanmanWorkstation"  = "Automatic";
    "SSDPDiscovery"      = "Manual";
    "upnphost"           = "Manual";
    "FDResPub"           = "Manual";
    "Spooler"            = "Automatic";  # Printer service
}

foreach ($svc in $servicesToRestore.Keys) {
    Write-Host "Restoring service: $svc to $($servicesToRestore[$svc])"
    Set-Service -Name $svc -StartupType $servicesToRestore[$svc] -ErrorAction SilentlyContinue
    Start-Service -Name $svc -ErrorAction SilentlyContinue
}

# Remove firewall rules that blocked ports
$portsToUnblock = "135", "139", "445", "5040", "1462", "49664-49669"
foreach ($port in $portsToUnblock) {
    $ruleName = "Block Port $port"
    Write-Host "Removing firewall rule: $ruleName"
    Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue | Remove-NetFirewallRule
}

# OPTIONAL: Re-enable IPv6 (only if previously disabled)
$ipv6Key = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
if (Get-ItemProperty -Path $ipv6Key -Name "DisabledComponents" -ErrorAction SilentlyContinue) {
    Remove-ItemProperty -Path $ipv6Key -Name "DisabledComponents"
    Write-Host "IPv6 setting restored (you may need a reboot)."
}

Write-Host "`n✅ System restore complete. Please restart your computer to apply all changes."
