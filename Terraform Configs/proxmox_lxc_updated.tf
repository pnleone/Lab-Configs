terraform {
  required_providers {
    proxmox = {
      source = "Terraform-for-Proxmox/proxmox"
    }
  }
}
# Example run  command:
# terraform plan -var="lxc_name=traefik-lxc" -var="lxc_id=200" -var="memory=2048"

# --- Infrastructure Variables ---
variable "container_count" {
  description = "Number of containers to deploy"
  type        = number
  default     = 1
}

variable "lxc_name" {
  description = "The hostname for the LXC"
  type        = string
  default     = "lxc-instance"
}

variable "lxc_id" {
  description = "Starting VMID for the LXC"
  type        = number
}

# --- Resource Customization Variables ---
variable "cores" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 1024
}

variable "rootfs_storage" {
  type    = string
  default = "local-lvm"
}

# --- Auth Variables ---
variable "pm_api_token_id" {
  description = "Proxmox API token ID"
  type        = string
}

variable "pm_api_token_secret" {
  description = "Proxmox API token secret"
  type        = string
  sensitive   = true
}
variable "rootpassword" {
  description = "Root password for this LXC"
  type        = string
  sensitive   = true
}

provider "proxmox" {
  pm_api_url          = "https://pve.home.com:8006/api2/json"
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  pm_tls_insecure     = false
}

resource "proxmox_lxc" "dynamic_lxc" {
  # This creates multiple containers if var.container_count > 1
  count = var.container_count

  # Makes the Proxmox Name unique if deploying multiple
  hostname    = var.container_count > 1 ? "${var.lxc_name}-${count.index}" : var.lxc_name
  target_node = "pve"
  vmid        = var.lxc_id + count.index
  
  ostemplate   = "Media4TBnvme:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
  password     = var.rootpassword
  unprivileged = true
  cores        = var.cores
  memory       = var.memory
  swap         = 512
  onboot       = true
  start        = true

  rootfs {
    storage = var.rootfs_storage
    size    = "8G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
    # Optional: tag = 10 (to add the LXC to a specific VLAN)
    # Optional: ip = "192.168.1.${var.lxc_id}/24" (for static IPs that match the VMID number)
  }

  features {
    nesting = true
  }

  # This ensures that if you change the template, it rebuilds correctly
  lifecycle {
    ignore_changes = [
      mountpoint,
    ]
  }
}
