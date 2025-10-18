terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.85"
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
#This module abstracts many of the nerd knobs and lets you define just a handful of variables for provisioning LXC containers.
#All you have to provide are things like the hostname, ip address, template, and resources. It handles all the other details internally. 
#It applies recommended defaults for things like disk storage, bridges, and cloud-init. This helps to make sure your Terraform 
#code doesn’t grow to be unwieldy in size as well.

# module "lxc_containers" {
#   source = "bpg/proxmox-lxc/proxmox"

#   for_each   = toset(["web01", "db01", "media01"])
#   hostname   = each.key
#   template   = "ubuntu-22.04"
#   password   = var.lxc_password
#   ip_address = "10.1.149.${100 + count.index}"
#   cores      = 2
#   memory     = 2048
# }

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