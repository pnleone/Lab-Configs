Purpose

This lab environment has been deliberately designed as both a technical proving ground and a personal growth accelerator. Its primary purpose is to deepen my expertise across several interrelated domains that are critical to modern enterprise IT operations:

  •	Secure network infrastructure — designing, segmenting, and defending multizone networks with layered controls.
  •	Virtualization and containerization — orchestrating workloads across hypervisors and container platforms.
  •	Linux and Windows server deployment and administration — building, hardening, and maintaining heterogeneous systems in a unified operational model.
  •	Enterprise grade application hosting — deploying, integrating, and securing the same classes of tools and services found in production corporate environments.

This solution overview captures the current state of that environment, detailing the key technologies deployed and the security measures implemented.

The accompanying Security Hardening Checklist provides a structured view of the controls in place to ensure confidentiality, integrity, availability, and operational resilience.
The lab is built on the following guiding principles:

  •	Defense in Depth — multiple, complementary layers of security to reduce the likelihood and impact of compromise.
  •	Secure by Design — embedding security considerations into every architectural and configuration decision.
  •	Zero Trust — verifying every request, enforcing least privilege access, and minimizing implicit trust between systems.

By applying these principles consistently, I’ve strengthened not only the technical posture of the lab but also my own capabilities in architecting, securing, and operating complex systems.

This growth is reflected in the breadth of technologies integrated here — from identity aware reverse proxies and PKI infrastructure to high availability firewalls, vulnerability scanning, and digital forensics tooling.

Security Hardening Checklist

A comprehensive summary of hardening measures implemented across the lab environment to ensure confidentiality, integrity, availability, and operational resilience.

🔐 Network & Perimeter Security
  •	Network Segmentation & Rules-Based Access Control. 
  Implemented via pfSense firewalls to isolate services by trust level (e.g., DMZ, internal, management). VLANs and firewall rules restrict lateral movement and enforce least privilege.
  
  •	High Availability Firewall Cluster. 
  pfSense VMs configured in HA pair with XMLRPC sync for rules, aliases, and state tables. Ensures uninterrupted routing and inspection during failover.
  
  •	Inline Intrusion Detection & Prevention (IDS/IPS). 
  Suricata and Snort deployed in IPS mode on pfSense to inspect traffic in real time, block known threats, and log suspicious patterns for forensic analysis.
  
  •	Network and Host Vulnerability Scanning
  OpenVAS deployed in Docker with custom port mapping and feed synchronization. Used to scan internal subnets and hosts for exposed services, outdated software, and misconfigurations. Results feed into asset lists.


🧑‍💼 Identity & Access Management
  •	Multi-Factor Authentication (MFA) & Single Sign-On (SSO)
  Authentik provides OAuth2/OIDC flows across services, enforcing MFA and centralized identity verification. 
  
  •	Role-Based Access Control (RBAC). 
  Authentik and Active Directory enforce granular access policies across dashboards, containers, and infrastructure components.
  
  •	PKI Infrastructure 
  StepCA deployed with an offline Root CA and online Intermediate CA for issuing service certificates. Fullchain delivery and trust propagation automated across nodes and containers.

🌐 Web & Application Security
  •	Secure Web Access (HTTPS/TLS) 
  All services exposed via Traefik reverse proxy with TLS termination. Services without native HTTPS are secured via proxy-to-client encryption.
  
  •	ForwardAuth Middleware 
  Traefik integrates with Authentik outposts for identity-aware routing and header injection, enabling SSO and access control at the edge.
  
  •	Secure Headers & IP Whitelisting 
  Middleware enforces HSTS, X-Frame-Options, and restricts access to trusted subnets (e.g., 192.168.0.0/16).
  
🧠 DNS & Name Resolution
  •	DNS Filtering & Conditional Forwarding 
  Pi-hole blocks known ad/tracking domains. Conditional forwarding routes internal domains to Bind9 for authoritative resolution.
  
  •	Recursive DNS via Unbound 
  Unbound resolves queries directly from root servers, bypassing third-party resolvers for privacy and integrity.
    
  •	Encrypted DNS 
  DNSSEC enabled to validate authenticity of DNS responses and prevent spoofing.
  
  •	High Availability DNS 
  Dual Pi-hole containers run in separate Docker instances with sync via Nebula, ensuring redundancy and consistent policy enforcement.


🔐 Remote Access Architecture, Privacy & Endpoint Security
  •	SSH Hardening 
  Key-only authentication enforced; root login disabled. SSHD configured with rate limiting and banner warnings.
  
  •	Endpoint Detection & Response (EDR) 
  Wazuh agents deployed for real-time monitoring, log analysis, and threat detection. OpenVAS scans for vulnerabilities across hosts.
  
  •	Private Internet Access (PIA)
  VPN service configured on pfSense firewalls to encrypt internet-bound traffic for specific networks.
  
  •	Tailscale Mesh VPN 
  WireGuard-based overlay network for secure remote access to internal lab applications. 
  
  •	TOR Browser for Anonymous Browsing
  Sandboxed VM host TOR Browser for privacy-sensitive research and threat intelligence gathering. 
  
  •	Policy-Based Routing for Privacy Zones
  Outbound traffic from select containers and subnets routed through PIA or Tailscale gateways using firewall rules and routing tables.

📊 Observability & Monitoring
  •	Grafana Dashboards 
  Unified visibility across services, network, and system metrics. Custom panels for TLS status, SSO flows, and container health.
  
  •	Prometheus Scraping 
  Metrics collected from exporters (node, Traefik, Pi-hole, etc.) for time-series analysis and alerting.
  
  •	Uptime Kuma 
  Heartbeat monitoring for service availability with notification hooks for downtime events.
  
  •	Pulse 
  Proxmox environment monitoring.
  
  •	OpenVAS Scan Reporting
  Scan results exported and visualized to track vulnerability trends, asset exposure, and remediation progress over time.


📣 Alerting & Notification System
  •	Centralized Alert Repository (Discord)
  A private Discord server acts as the central hub for all lab alerts. Each monitored service has its own dedicated channel, including: #proxmox, #grafana, #splunk, #wazuh, #pulse, #uptime-kuma, #openvas, #pfsense, and #prometheus.
  
  •	Multi-Source Alert Integration
  Alerts are pushed from monitoring tools via native webhook integrations or custom scripts. Grafana, Prometheus Alertmanager, Splunk, Wazuh, OpenVAS, and Uptime Kuma all route notifications to Discord.
  
  •	Multi-Device Push Delivery
  Discord’s push notification system ensures real-time delivery to:
  •	Windows 11 desktop via Discord app
  •	iPad and iPhone via mobile app

📁 Secrets & Configuration Management
  •	Vaultwarden 
  Self-hosted secrets manager for storing credentials, API keys, and certificates with encrypted vaults.

  •	Infrastructure as Code (IaC) 
    •	Terraform for automated Infrastructure provisioning.
    •	Ansible for configuration automation and templating
    •	GitHub for version control and change tracking. 

💾 Backup & Recovery
  •	Multi-Point Backup Strategy 
  Automated backups of containers and VMs to Synology NAS and Proxmox Backup Server (PBS) running in VMware Workstation.

  •	Snapshot Before Change 
  Proxmox snapshots taken prior to config changes for rollback capability and change assurance.
  
🧰 Security Tooling & Digital Forensics
  Offensive, defensive, and forensic tools accessible via Kali Linux and supporting platforms, enabling deep inspection, threat simulation, and post-incident analysis.
  🔎 Offensive & Reconnaissance Tools (Kali Linux)
    •	Nmap – Network scanning and service enumeration to validate exposure and detect rogue services.
    •	Metasploit Framework – Exploitation and payload testing in isolated lab environments for vulnerability validation.
    •	ncat – Versatile networking utility for port listening, file transfers, and reverse shells.
    •	Hydra – Brute-force testing for login endpoints (used responsibly in lab scenarios).
    •	John the Ripper – Password hash cracking for audit and recovery testing.
    •	Gobuster – Directory and DNS enumeration to uncover hidden endpoints.
    •	SQLMap – Automated SQL injection testing for web applications.
    
  🌐 Network Observability & Packet Analysis
    •	Wireshark – Deep packet inspection for protocol analysis, handshake validation, and anomaly detection.
    •	Brim – Timeline-based network event analysis using Zeek logs and PCAPs.
    •	tcpdump – CLI-based packet capture for lightweight diagnostics and scripting.
    •	NetworkMiner – Passive network forensics tool for extracting metadata, files, and credentials from PCAPs.
    
  🧬 Digital Forensics & Incident Response
    •	Eric Zimmerman Tools – Specialized utilities for registry, event log, and artifact parsing (e.g., Registry Explorer, Timeline Explorer).
    •	KAPE (Kroll Artifact Parser and Extractor) – Rapid triage and artifact collection across endpoints.
    •	Volatility – Memory forensics framework for analyzing RAM dumps and detecting in-memory threats.
    •	Autopsy – GUI-based digital forensics platform for disk image analysis and timeline reconstruction.
    •	FTK Imager – Disk imaging and evidence preservation tool with hash verification.
    •	Redline – Endpoint investigation tool for volatile data capture and threat hunting.
    •	Velociraptor – Scalable endpoint visibility and response framework using custom queries and artifact collection.

🛡️ Threat Intelligence
  •	Behavior-Based Intrusion Prevention
  CrowdSec engine deployed in a Debian LXC ingests logs from pfSense, Suricata, and system sources. It parses and analyzes behavioral patterns using Hub-provided scenarios to detect brute force, port scans, and other anomalies.
  
  •	Distributed Remediation via Bouncers
  Firewall bouncer installed on pfSense enforces decisions from the CrowdSec Local API (LAPI), blocking malicious IPs in real time. Decisions are streamed from the engine to the bouncer using authenticated API keys.
  
  •	Threat Intelligence via CrowdSec Hub
  Curated collections and blocklists from the CrowdSec Hub are deployed to enhance detection coverage. Community signals and upstream feeds are integrated to enrich local decision-making.
