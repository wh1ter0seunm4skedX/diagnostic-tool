# **Diagnostic Tool**

A cross-platform diagnostic tool designed to troubleshoot performance and system issues on **Windows** and **macOS** computers. This tool collects key system information, checks hardware and software health, and generates logs to assist with troubleshooting.

## **Features**
- **Windows Diagnostics:** 
  - CPU, memory, and disk space usage.
  - Installed applications and startup programs.
  - Network diagnostics (ping test, open connections).
  - Error logs and hardware information.
  - Windows Update status.
  - Advanced diagnostics:
    - Security checks (firewall and antivirus status).
    - Battery health for laptops.
    - Process and resource hog detection.
    - Storage health (SMART data).
    - Boot time analysis.

- **macOS Diagnostics:** 
  - System and hardware overview.
  - CPU, memory, and disk space usage.
  - Startup programs and network diagnostics.
  - System error logs and software updates.
  - Peripheral and thermal status.
  - Advanced diagnostics:
    - Battery health for laptops.
    - Process and resource hog detection.
    - Storage health (SMART data).
    - Boot time analysis.

- **Logs:** 
  - All diagnostic results are saved in timestamped log files for easy sharing and analysis.

---

## **Folder Structure**
```plaintext
diagnostic-tool/
├── windows/
│   ├── diagnostic.ps1            # Main Windows diagnostic script
│   ├── advanced/                 # Advanced diagnostic tools
│   │   ├── security_check.ps1
│   │   ├── battery_check.ps1
│   │   ├── network_performance.ps1
│   │   ├── storage_health.ps1
│   │   └── boot_analysis.ps1
│   ├── README.md               
├── macos/
│   ├── diagnostic.sh             # Main macOS diagnostic script
│   ├── advanced/                 # Advanced diagnostic tools
│   │   ├── security_check.sh
│   │   ├── battery_check.sh
│   │   ├── network_performance.sh
│   │   ├── storage_health.sh
│   │   └── boot_analysis.sh
│   ├── README.md               
├── shared/
│   ├── logs/                     # Folder to store diagnostic logs
│   ├── utilities/                # Helper scripts and shared resources
│   │   ├── os_detector.sh        
│   └── README.md               
├── LICENSE                      
├── README.md                     
```

---

## **How to Use**

### **Windows**
1. Open **PowerShell as Administrator**.
2. Navigate to the `windows/` folder:
   ```powershell
   cd path\to\diagnostic-tool\windows
   ```
3. Run the main diagnostic script:
   ```powershell
   .\diagnostic.ps1
   ```
4. To use advanced tools, navigate to the `advanced/` folder and run the desired script:
   ```powershell
   cd advanced
   .\battery_check.ps1
   ```
5. Find the log files in the `shared/logs/` folder.

---

### **macOS**
1. Open **Terminal**.
2. Navigate to the `macos/` folder:
   ```bash
   cd path/to/diagnostic-tool/macos
   ```
3. Make the main diagnostic script executable (only needed once):
   ```bash
   chmod +x diagnostic.sh
   ```
4. Run the main diagnostic script with sudo:
   ```bash
   sudo ./diagnostic.sh
   ```
5. To use advanced tools, navigate to the `advanced/` folder and run the desired script:
   ```bash
   cd advanced
   sudo ./battery_check.sh
   ```
6. Find the log files in the `shared/logs/` folder.

---

## **Logs**
- Logs are saved in the `shared/logs/` folder with a timestamped filename for each diagnostic run:
  - **Windows Example:** `diagnostic_windows_20240101_123456.log`
  - **macOS Example:** `diagnostic_macos_20240101_123456.log`

---

## **Requirements**
- **Windows:**
  - PowerShell 5.1 or later (default in most Windows versions).
  - Run the script with Administrator privileges.

- **macOS:**
  - Zsh or Bash (default in macOS).
  - Run the script with sudo for full diagnostics.

---

## **License**
This project is licensed under the MIT License.

---

## **Future Improvements**
- Add cross-platform log parsing for easier comparison.
- Create a web-based dashboard for log visualization.
- Extend the tool to include Linux diagnostics.
- Automate running advanced diagnostics as part of the main scripts.
- Add alerts for critical findings in logs.
