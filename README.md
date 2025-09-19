# 🔐 Hybrid Cloud Security Lab

A self-built enterprise-style hybrid environment that integrates on-premises infrastructure with AWS cloud workloads.  
This project demonstrates **Active Directory, DNS, VPN connectivity, centralized logging, SIEM visibility, and security incident response** — simulating challenges faced in real enterprise environments.

---

## 🎯 Objectives

- Build an **on-prem lab** with pfSense (edge router), Windows Server 2019 (Active Directory Domain Controller), Ubuntu (internal services), and Windows 10/11 client.
- Deploy an **AWS VPC** (public & private subnets, EC2 workloads).
- Establish a **site-to-site VPN** between pfSense and AWS.
- Configure **centralized logging & SIEM integration** (ELK / Splunk).
- Simulate and detect **security incidents** (e.g., data exposure, brute force, port scans).
- Apply **security controls & remediation** (IAM, encryption, least privilege).
- Package results into a **portfolio case study** with diagrams, configs, and evidence.

---

## 🏗️ Architecture Overview

### On-Premises (VirtualBox)
- **pfSense** → Edge router, NAT + LAN segmentation.
- **Windows Server 2019** → Active Directory, DNS.
- **Ubuntu Server** → Internal app / log forwarder.
- **Windows Workstation** → Domain-joined client.
- **Kali Linux** → Attacker simulation.

### AWS (Free Tier)
- **VPC** (10.0.0.0/16) with public & private subnets.
- **EC2 Instances**:
  - Web server (public).
  - App/DB server (private).
- **Security Tools**: GuardDuty, CloudTrail, VPC Flow Logs.

### Connectivity
- **Site-to-Site VPN** between pfSense (on-prem) and AWS VPN Gateway.
- Unified DNS via Windows AD DC.
- Centralized log collection into ELK / Splunk.

---

## 🚀 Project Roadmap

- **Phase 1: Foundation**
  - Set up on-prem lab (pfSense, AD, Ubuntu, clients).
  - Configure AWS accounts, VPC, and baseline security services.
- **Phase 2: Hybrid Connectivity**
  - Build VPN bridge between pfSense and AWS.
  - Forward logs from both sides into SIEM.
- **Phase 3: Enterprise Simulation**
  - Simulate incidents (data exposure, brute force).
  - Detect and respond with GuardDuty + SIEM.
  - Harden environment and implement Terraform automation.

---

## 📂 Repository Structure

Hybrid-Cloud-Security-Lab/
├── README.md
├── docs/
│ ├── architecture.md # Detailed diagrams & explanations
│ ├── setup.md # Reproducible setup instructions
│ ├── issues.md # Troubleshooting notes
│ ├── evidence.md # Screenshots, proofs of work
│ └── screenshots/ # Raw screenshot files
├── configs/
│ ├── pfSense/ # pfSense exports
│ ├── windows/ # AD/DNS configs
│ ├── ubuntu/ # Netplan, service configs
│ └── AWS/ # Terraform / CloudFormation scripts
├── diagrams/ # draw.io, Lucidchart, PNG diagrams
└── scripts/ # Helper scripts (bash, PowerShell, etc.)

---

## 📸 Evidence (Preview)

- ✅ pfSense WAN/LAN setup  
- ✅ Windows Server promoted to Domain Controller  
- ✅ Ubuntu joined to AD DNS  
- ✅ Successful hybrid connectivity (ping between on-prem and AWS)  
- 📊 SIEM dashboard screenshots (to be added)  

---

## 🧑‍💻 Author

**Brett Banks**  
- GitHub: [brettbanks](https://github.com/brettbanks)  
- LinkedIn: [linkedin.com/in/brettbanks1](https://linkedin.com/in/brettbanks1)  
- Portfolio: [brettbanks.site](https://brettbanks.site)  

---

