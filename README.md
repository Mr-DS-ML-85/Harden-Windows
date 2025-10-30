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

## 🧱 Harden-Windows.ps1 :

- ✅ Blocks commonly exposed ports (e.g., `135`, `139`, `445`, `5040`, `49664–49669`)
- ✅ Disables unneeded Windows services like:
  - Remote Registry  
  - Remote Desktop (RDP)  
  - SMB file sharing  
  - UPnP
- ☰ *(Optional)* Disables IPv6 (commented by default)

## ✅⚙️ Prerequisites
- Windows 11
- Administrator privileges
- PowerShell execution policy temporarily modified
  
## Installation :

### Method 1: Download from Releases
Download the PowerShell(.ps1) files from [Releases](https://github.com/Mr-DS-ML-85/Harden-Windows/releases)

### Method 2: Git Clone

#### 1) Install [Git](https://git-scm.com/downloads)
#### 2) 2. Clone the repository:
```
git clone https://github.com/Mr-DS-ML-85/Harden-Windows.git
```

### 🔧Usage :

### Navigate to the folder containing the scripts, then:

  </> Execute:
  ```powershell
cd C:\Users\USERNAME\Downloads
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
Y
.\Harden-Windows.ps1
```

## ♻️ Restore-WindowsDefaults.ps1 :

### ♻️ Restore Default Settings 🔧

This script:

🔂 Re-enables all services disabled by the hardening script

🔂 Removes all firewall rules created to block ports

🔂 Restores IPv6 if it was disabled

### 🔧Usage :

Navigate to the folder containing the scripts, then:

  </> Execute:
  ```powershell
cd C:\Users\USERNAME\Downloads
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
Y
.\Restore-WindowsDefaults.ps1
```

⚠️ Warnings :

  ✅️ Use only if you're not running SMB shares, RDP, or printers

  ⚠️ Always test on a non-critical machine first

  🛠 Requires Administrator privileges

#### ✅🧪📝 Tested :

- Only on Windows 11
- [Windows 10 Expires on October 14, 2025](https://support.microsoft.com/en-us/windows/windows-10-support-ends-on-october-14-2025-2ca8b313-1946-43d3-b55c-2b95b107f281)

### 📦 License :

 This project is open-source and available under the 📜 [MIT License](LICENSE)

### 🤝 Contribution :
- Contributors are welcome to contribute and make sure checking [CONTRIBUTING.md](https://github.com/Mr-DS-ML-85/Harden-Windows/blob/main/CONTRIBUTING.md)

