#!/bin/bash
###############################################################################
# galaxy_roles_install.sh
# Install all recommended Galaxy roles and collections for the lab
# Run this on your Ansible controller before running any playbooks
###############################################################################

set -e  # Exit on error

echo "Installing Ansible Galaxy roles and collections..."
echo ""

###############################################################################
# CORE COLLECTIONS (required by playbooks)
###############################################################################
echo "==> Installing core collections..."
ansible-galaxy collection install ansible.posix
ansible-galaxy collection install community.general
ansible-galaxy collection install checkmk.general

###############################################################################
# MONITORING ROLES
###############################################################################
echo ""
echo "==> Installing monitoring roles..."

# Wazuh agent role - not available on Galaxy, must clone from GitHub
echo "Installing Wazuh agent role from GitHub..."
if [ ! -d "roles/wazuh-ansible" ]; then
    git clone --branch v4.14.3 https://github.com/wazuh/wazuh-ansible.git roles/wazuh-ansible
    echo "✅ Wazuh role cloned to roles/wazuh-ansible"
else
    echo "⚠️  Wazuh role already exists at roles/wazuh-ansible"
fi

###############################################################################
# LINUX INFRASTRUCTURE ROLES
###############################################################################
echo ""
echo "==> Installing Linux infrastructure roles..."
ansible-galaxy role install geerlingguy.docker
ansible-galaxy role install geerlingguy.nginx
ansible-galaxy role install robertdebock.fail2ban
ansible-galaxy role install geerlingguy.pip
ansible-galaxy role install geerlingguy.git

###############################################################################
# MONITORING STACK
###############################################################################
echo ""
echo "==> Installing monitoring stack roles..."
ansible-galaxy role install geerlingguy.node_exporter
ansible-galaxy role install cloudalchemy.prometheus
ansible-galaxy role install cloudalchemy.grafana
ansible-galaxy role install elastic.elasticsearch
ansible-galaxy collection install elastic.elasticsearch

###############################################################################
# WINDOWS MANAGEMENT
###############################################################################
echo ""
echo "==> Installing Windows collections..."
ansible-galaxy collection install ansible.windows
ansible-galaxy collection install community.windows
ansible-galaxy collection install chocolatey.chocolatey

###############################################################################
# CISCO NETWORKING
###############################################################################
echo ""
echo "==> Installing Cisco collections..."
ansible-galaxy collection install cisco.ios
ansible-galaxy collection install cisco.nxos
ansible-galaxy collection install ansible.netcommon

###############################################################################
# VMWARE
###############################################################################
echo ""
echo "==> Installing VMware collection..."
ansible-galaxy collection install community.vmware

###############################################################################
# FORTINET
###############################################################################
echo ""
echo "==> Installing Fortinet collection..."
ansible-galaxy collection install fortinet.fortios

###############################################################################
# KUBERNETES
###############################################################################
echo ""
echo "==> Installing Kubernetes collection..."
ansible-galaxy collection install kubernetes.core

###############################################################################
# VERIFICATION
###############################################################################
echo ""
echo "==> Verifying installed roles and collections..."
echo ""
echo "Roles installed:"
ansible-galaxy role list
echo ""
echo "Collections installed:"
ansible-galaxy collection list

echo ""
echo "✅ All Galaxy roles and collections installed successfully!"
echo ""
echo "Next steps:"
echo "  1. Encrypt vault.yml: ansible-vault encrypt group_vars/vault.yml"
echo "  2. Run bootstrap: ansible-playbook new_install_baseline_roles.yml -i inventory/hosts.ini --ask-vault-pass"
echo "  3. Run hardening: ansible-playbook harden.yml -i inventory/hosts.ini --ask-vault-pass"