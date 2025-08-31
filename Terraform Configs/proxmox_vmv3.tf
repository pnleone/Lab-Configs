terraform {
  required_providers {
    proxmox = {
      source  = "Terraform-for-Proxmox/proxmox"
      #version = "~> 0.65" # or latest
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

variable "vm_name" {
  description = "Name of the VM"
  type        = string
  default     = "ubuntu-vm"

}

variable "vm_id" {
  description = "VMID for the VM"
  type        = number
}


provider "proxmox" {
    pm_api_url          = "https://pve.home.com:8006/api2/json"
    pm_api_token_id     = var.pm_api_token_id
    pm_api_token_secret = var.pm_api_token_secret
    pm_tls_insecure     = false
}

resource "proxmox_vm_qemu" "ubuntu-vm" {
    name                = var.vm_name
    vmid                = var.vm_id
    target_node         = "pve"
    clone               = "ubuntu-cloud"
    full_clone          = true
    cores               = 2
    memory              = 2048
    sockets             = 1
    onboot              = true
    agent               = 1
    os_type             = "l26"
    clone_wait          = 0
    ciuser     = var.ciuser
    cipassword = var.cipassword


    boot    = "order=scsi0;ide2"
    bootdisk = "scsi0"
    scsihw      = "virtio-scsi-single"

    network {
        model     = "virtio"
        bridge    = "vmbr0"
        firewall  = false
        link_down = false
    }

# Attach cloud-init drive if not inherited
#  lifecycle {
 #   ignore_changes = [
  #    network,
  #    disk
   # ]
#  }


}