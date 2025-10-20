
# Hybrid Cloud Security Lab

A technical demonstration of a hybrid enterprise environment combining on-prem VirtualBox infrastructure with AWS cloud services.  
This lab integrates pfSense-based routing, Active Directory, and AWS VPC networking to simulate enterprise-grade security architecture.

---

## 1. On-Prem Environment

**Virtualization Platform:** Oracle VirtualBox  
**Network Segments:**  
- WAN (NAT): 10.0.2.0/24  
- LAN (Host-Only): 192.168.84.0/24

| Component | Role | IP Address | Function |
|------------|------|-------------|-----------|
| pfSense | Firewall / Router | WAN 10.0.2.6 / LAN 192.168.84.1 | Segmentation, DHCP, DNS forwarding |
| Win-DC | Windows Server 2019 | 192.168.84.10 | AD DS, DNS Server |
| Win-Workstation | Windows 10 | 192.168.84.101 | Domain-joined client |
| Ubuntu-dev-engine | Ubuntu 22.04 | 192.168.84.40 | Linux domain member, Zeek/Suricata node |
| Ubuntu-ELK | Ubuntu 22.04 | 192.168.84.30 | SIEM node for log aggregation |
| Kali | Kali Linux | DHCP | Attack simulation host |

**pfSense Configuration Summary**
- WAN: em0 → 10.0.2.6 (NAT network)
- LAN: em1 → 192.168.84.1 (gateway)
- DHCP: 192.168.84.100–192.168.84.150
- Aliases:
  - AD_PORTS → 53, 88, 389, 445, 135
  - AD_CLIENTS → 192.168.84.40, 192.168.84.101
- Firewall Rule: Allow AD_CLIENTS → DC via AD_PORTS

---

## 2. Active Directory Integration

**Domain:** corp.local  
**DNS Zone:** Forward Lookup Zone for corp.local  
**User:** labuser  
**Verification:**  
- Windows login: `corp\labuser`  
- Ubuntu login: `su - labuser@corp.local`  
- DNS resolution: `nslookup dev-engine.corp.local`  
- Cross-DNS resolution verified both directions.

**Result:** Domain authentication functional across Windows and Linux, completing enterprise identity foundation.

---

## 3. AWS Cloud Environment

**VPC Configuration**
- CIDR: 10.0.0.0/16  
- Public Subnet: 10.0.1.0/24  
- Private Subnet: 10.0.2.0/24  
- Internet Gateway + NAT Gateway: Configured  
- Bastion Host: 3.135.221.242 (public subnet)  
- AppServer: 10.0.2.48 (private subnet)

**Security Groups**
- BastionSG → sg-017d7267373eb4c47 (SSH from admin IP only)
- AppServerSG → sg-0761e2f56da72b658 (SSH allowed only from Bastion)

**Example CLI Workflow:**
```bash
# Create VPC and Subnets
aws ec2 create-vpc --cidr-block 10.0.0.0/16
aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.1.0/24
aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.2.0/24

# Gateways and Routes
aws ec2 create-internet-gateway
aws ec2 attach-internet-gateway --internet-gateway-id $IGW_ID --vpc-id $VPC_ID
aws ec2 create-route-table --vpc-id $VPC_ID
aws ec2 create-route --route-table-id $PUB_RT --destination-cidr-block 0.0.0.0/0 --gateway-id $IGW_ID

# Security Groups and Instances
aws ec2 create-security-group --group-name BastionSG --description "Allow SSH from admin IP"
aws ec2 create-security-group --group-name AppSG --description "Allow SSH only from Bastion"
aws ec2 authorize-security-group-ingress --group-id $APP_SG --protocol tcp --port 22 --source-group $BASTION_SG
```

---

## 4. Phase Completion Map

| Phase | Description | Status |
|--------|--------------|--------|
| 1 | On-Prem Core Setup (pfSense + AD + DHCP/DNS) | ✅ Complete |
| 2 | Domain Integration (Linux + Windows) | ✅ Complete |
| 3 | AWS VPC, Bastion, AppServer Deployment | ✅ Complete |
| 4 | Logging & Monitoring (S3, CloudTrail, GuardDuty) | 🔄 In Progress |
| 5 | SIEM Integration (ELK + Hybrid Logs) | ⏳ Upcoming |

---

## 5. Next Steps
- Create S3 bucket for central log storage
- Enable CloudTrail organization-wide
- Enable VPC Flow Logs for all subnets
- Enable GuardDuty and Security Hub
- Visualize architecture diagram with logging paths
- Finalize SIEM correlation dashboard

---

## 6. Deliverables
- Hybrid_Cloud_Security_Lab.pdf (Full notes)
- Hybrid_Cloud_Security_Lab_20.html (CherryTree export)
- Screenshots: pfSense setup, AD join, VPC, EC2 connectivity, DNS verification
- README.md (Technical summary for GitHub)
=======
#  Hybrid Cloud Security Lab

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
│   ├── architecture.md
│   ├── setup.md
│   ├── issues.md
│   ├── evidence.md
│   └── screenshots/
├── configs/
│   ├── pfSense/
│   ├── windows/
│   ├── ubuntu/
│   └── AWS/
├── diagrams/
│   └── README.md
└── scripts/
    └── README.md


---

##  Evidence (Preview)

- ✅ pfSense WAN/LAN setup  
- ✅ Windows Server promoted to Domain Controller  
- ✅ Ubuntu joined to AD DNS  
- ✅ Successful hybrid connectivity (ping between on-prem and AWS)  
- 📊 SIEM dashboard screenshots (to be added)  

---

##  Author

**Brett Banks**  
- GitHub: [brettbanks](https://github.com/brettbanks)  
- LinkedIn: [linkedin.com/in/brettbanks1](https://linkedin.com/in/brettbanks1)  
- Portfolio: [brettbanks.site](https://brettbanks.site)  

---
 c8b87d8e13b0edb971b3a2d3c5bd4140be4f3bb5
