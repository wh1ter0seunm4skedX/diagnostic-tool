# **Diagnostic Tool**

A cross-platform diagnostic tool designed to troubleshoot performance and system issues on **Windows** and **macOS** computers. This tool collects key system information, checks hardware and software health, and generates logs to assist with troubleshooting.

## **Features**
- **Windows Diagnostics:** 
  - CPU, memory, disk space usage.
  - Installed applications and startup programs.
  - Network diagnostics (ping test, open connections).
  - Error logs and hardware information.
  - Windows Update status.

- **macOS Diagnostics:** 
  - System and hardware overview.
  - CPU, memory, and disk space usage.
  - Startup programs and network diagnostics.
  - System error logs and software updates.
  - Peripheral and thermal status.

- **Logs:** 
  - All diagnostic results are saved in timestamped log files for easy sharing and analysis.

---

## **Folder Structure**
```plaintext
diagnostic-tool/
├── windows/
│   ├── diagnostic.ps1      
│   ├── README.md               
├── macos/
│   ├── diagnostic.sh           
│   ├── README.md               
├── shared/
│   ├── logs/                   # Folder to store diagnostic logs
│   ├── utilities/              # basically the helpers in the future enhencements
│   └── README.md               
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
3. Run the script:
   ```powershell
   .\diagnostic.ps1
   ```
4. Find the log file in the `shared/logs/` folder.

---

### **macOS**
1. Open **Terminal**.
2. Navigate to the `macos/` folder:
   ```bash
   cd path/to/diagnostic-tool/macos
   ```
3. Make the script executable (only needed once):
   ```bash
   chmod +x diagnostic.sh
   ```
4. Run the script with sudo:
   ```bash
   sudo ./diagnostic.sh
   ```
5. Find the log file in the `shared/logs/` folder.

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
