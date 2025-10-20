# 🛰️ Hybrid Cloud Security Lab

![Hybrid Cloud Architecture](screenshots/005_aws_vpc_configuration.png)

A complete hybrid enterprise security lab that integrates **on-prem VirtualBox infrastructure** with **AWS cloud networking**.  
This lab demonstrates secure routing, centralized authentication, intrusion detection, and cloud-native monitoring using pfSense, Active Directory, Zeek/Suricata, and ELK Stack.

---

## ⚙️ On-Prem Environment

**Platform:** Oracle VirtualBox  
**Network Segments:**
- WAN (NAT): `10.0.2.0/24`
- LAN (Host-Only): `192.168.84.0/24`

| Component | Role | IP Address | Function |
|------------|------|------------|-----------|
| pfSense | Firewall / Router | WAN 10.0.2.6 / LAN 192.168.84.1 | Segmentation, NAT, DHCP, DNS forwarding |
| Win-DC | Windows Server 2019 | 192.168.84.10 | Active Directory Domain Controller |
| Win-Workstation | Windows 10 | 192.168.84.101 | Domain-joined workstation |
| Ubuntu-dev-engine | Ubuntu 22.04 | 192.168.84.40 | Zeek / Suricata IDS node |
| Ubuntu-ELK | Ubuntu 22.04 | 192.168.84.30 | SIEM node (Elasticsearch + Kibana) |
| Kali | Kali Linux | DHCP | Red Team / Attack Simulation host |

---

## 🧩 Active Directory Integration

**Domain:** `corp.local`  
**DNS Zone:** Forward Lookup Zone — `corp.local`  
**Test User:** `labuser`

**Verification:**
Windows login → corp\labuser
Ubuntu login → su - labuser@corp.local

nslookup dev-engine.corp.local

✅ Cross-authentication between Windows and Linux validated.  
✅ DNS resolution verified bidirectionally.  

---

## ☁️ AWS Cloud Environment

**VPC Configuration**
CIDR: 10.0.0.0/16
Public Subnet: 10.0.1.0/24
Private Subnet: 10.0.2.0/24
Internet Gateway + NAT Gateway: Configured
Bastion Host: 3.135.221.242
AppServer: 10.0.2.48


**Security Groups**
- BastionSG → SSH from admin IP only  
- AppServerSG → SSH allowed only from Bastion  

---

## 📸 Key Project Screenshots

| Screenshot | Description |
|-------------|-------------|
| ![pfSense Dashboard](screenshots/001_pfsense_dashboard.png) | pfSense firewall dashboard — NAT and LAN routing verification |
| ![Active Directory Setup](screenshots/002_active_directory_setup.png) | Windows Server AD DS configuration for domain `corp.local` |
| ![Bastion Connection](screenshots/006_bastion_connection.png) | SSH tunneling from Bastion → AppServer (private subnet) |
| ![IDS Logs](screenshots/007_ids_suricata_logs.png) | Zeek + Suricata detection logs showing live packet inspection |
| ![SIEM Dashboard](screenshots/008_siem_elk_dashboard.png) | ELK SIEM dashboard visualizing hybrid log data |

---

## 📊 Phase Completion Map

| Phase | Description | Status |
|--------|--------------|--------|
| 1 | On-Prem Core Setup (pfSense + AD + DHCP/DNS) | ✅ Complete |
| 2 | Domain Integration (Linux + Windows) | ✅ Complete |
| 3 | AWS VPC + Bastion + AppServer Deployment | ✅ Complete |
| 4 | Cloud Logging & GuardDuty Configuration | 🔄 In Progress |
| 5 | SIEM Integration (Hybrid Correlation) | ⏳ Upcoming |

---

## 🚀 Next Steps

- [ ] Enable organization-wide CloudTrail logging  
- [ ] Integrate GuardDuty alerts into SIEM  
- [ ] Configure hybrid log forwarding to S3  
- [ ] Add network diagrams and flow maps under `/docs/`  
- [ ] Build correlation rules for suspicious logins  

---

## 📦 Deliverables

- `Hybrid_Cloud_Security_Lab.pdf` — Full write-up  
- `Hybrid_Cloud_Security_Lab_20.html` — CherryTree export  
- `/screenshots/` — Visual verification (pfSense, AD, AWS, IDS, SIEM)  
- `/docs/` — Diagrams and architecture references  
- `README.md` — Project overview (public-facing)

---

## 👤 Author

**Brett Banks**  
📍 Las Vegas, Nevada  
💻 [github.com/brettbanks](https://github.com/brettbanks)

---
