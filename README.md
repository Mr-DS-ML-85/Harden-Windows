 # 💻📜⚡ Windows Port Hardening & Restore Scripts
 
### 🛡️ Harden your Windows PC by blocking open ports and disabling unused services.
This repository contains two PowerShell scripts for securing and restoring your Windows 10/11 system by managing open ports, services, and IPv6 settings.

💻📜⚡ PowerShell Script ⚡📜💻

## 📁 Files

| 📝 Script                       | 📄 Description                                 | ⚙️ Function                |
|-------------------------------|-------------------------------------------------|----------------------------|
| 💻📜⚡ `Harden-Windows.ps1`      | Blocks dangerous ports and disables services    | 🛡️ Harden your system       |
| 💻📜⚡ `Restore-WindowsDefaults.ps1` | Restores default services, ports, and IPv6      | ♻️ Rollback if needed       |

---

🧱 Harden-Windows.ps1 :

- ✅ Blocks commonly exposed ports (e.g., `135`, `139`, `445`, `5040`, `49664–49669`)
- ✅ Disables unneeded Windows services like:
  - Remote Registry  
  - Remote Desktop (RDP)  
  - SMB file sharing  
  - UPnP
- ☰ *(Optional)* Disables IPv6 (commented by default)

🔧 Usage :

Run PowerShell as Administrator


  </> Execute:
  ```powershell
    .\Harden-Windows.ps1
```

♻️ Restore-WindowsDefaults.ps1 :

♻️ Restore Default Settings 🔧

This script:

🔂 Re-enables all services disabled by the hardening script

🔂 Removes all firewall rules created to block ports

🔂 Restores IPv6 if it was disabled

🔧Usage

  Run PowerShell as Administrator

  </> Execute:
  ```powershell
    .\Restore-WindowsDefaults.ps1
```

⚠️ Warnings :

  ✅️ Use only if you're not running SMB shares, RDP, or printers

  ⚠️ Always test on a non-critical machine first

  🛠 Requires Administrator privileges

📦 License
This project is open-source and available under the 📜 [MIT License](LICENSE)
