terraform {
  required_providers {
    proxmox = {
      source  = "Terraform-for-Proxmox/proxmox"
      version = "3.0.2-rc04"
    }
  }
}

provider "proxmox" {
    pm_api_url          = "https://pve.home.com:8006/api2/json"
    pm_api_token_id     = ""
    pm_api_token_secret = ""
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
