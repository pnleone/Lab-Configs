terraform {
  required_providers {
    proxmox = {
      source  = "Terraform-for-Proxmox/proxmox"
      version = "3.0.2-rc04"
    }
  }
}

provider "proxmox" {
  pm_api_url            = "https://pve.home.com:8006/api2/json"
  pm_api_token_id       = ""
  pm_api_token_secret   = ""
  pm_tls_insecure       = false  # true only for self-signed lab certs
}

resource "proxmox_lxc" "testct" {
  hostname     = "tf-demo-ct"
  target_node  = "pve"
  ostemplate   = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.zst"
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
