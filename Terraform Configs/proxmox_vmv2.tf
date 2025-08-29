terraform {
    required_providers {
        proxmox = {
            source = "telmate/proxmox"
            version = ">= 3.0.1" 
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
variable "ciuser" {
  description = "Cloud-init username for this VM"
  type        = string
}

variable "cipassword" {
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

resource "proxmox_vm_qemu" "ubuntu-terratest" {
    name                = "ubuntu-terratest"
    target_node         = "pve"
    clone               = "ubuntu-cloud"
    full_clone          = true
    cores               = 2
    memory              = 2048
    sockets             = 1
    onboot              = true
    agent               = 1
    # Cloud-init settings
    ciuser     = var.ciuser
    cipassword = var.cipassword

    disk {
        size            = "32G"
        type            = "scsi"
        storage         = "local-lvm"
        discard         = "on"
    }

    network {
        model     = "virtio"
        bridge    = "vmbr0"
        firewall  = false
        link_down = false
    }

}
