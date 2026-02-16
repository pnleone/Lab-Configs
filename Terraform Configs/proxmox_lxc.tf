terraform {
  required_providers {
    proxmox = {
      source  = "Terraform-for-Proxmox/proxmox"
      
    }
  }
}
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
  description = "Cloud-init password for this VM"
  type        = string
  sensitive   = true
}
variable "lxc_name" {
  description = "Hostname of the LXC container"
  type        = string
  default     = "debian-lxc"

}

variable "lxc_id" {
  description = "VMID for the LXC container"
  type        = number
}


provider "proxmox" {
    pm_api_url          = "https://pve.home.com:8006/api2/json"
    pm_api_token_id     = var.pm_api_token_id
    pm_api_token_secret = var.pm_api_token_secret
    pm_tls_insecure     = false
}

resource "proxmox_lxc" "testct" {
  hostname     = var.lxc_name
  target_node  = "pve"
  vmid         = var.lxc_id
  ostemplate   = "Media4TBnvme:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
  password     = var.rootpassword
  unprivileged = true
  cores        = 2
  memory       = 512
  swap         = 512
  onboot       = true
  start        = true


  rootfs {
    storage = "local-lvm"
    size    = "8G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }

  features {
    nesting = true
  }
}
