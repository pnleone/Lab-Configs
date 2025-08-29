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

provider "proxmox" {
    pm_api_url          = "https://pve.home.com:8006/api2/json"
    pm_api_token_id     = var.pm_api_token_id
    pm_api_token_secret = var.pm_api_token_secret
    pm_tls_insecure     = false
}

resource "proxmox_lxc" "testct" {
  hostname     = "tf-demo-ct"
  target_node  = "pve"
  vmid         = 223
  ostemplate   = "Media4TBnvme:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
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
