terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "~>2.0"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://proxmox.stevehibit.com:8006/api2/json" //PM_API_URL
  pm_user         = "root@pam" //PM_USER
  //pm_password     = var.proxmox_password //PM_PASS
  pm_tls_insecure = true
}

module "ubuntu-vm" {
  source = "../.."

  vm_name        = "vm-test-3"
  vm_id          = 169
  vm_description = "Test VM built with Terraform"

  template_clone      = "ubuntu-20.04-cloud-template"
  template_full_clone = true

  admin_username = "sdhibit"
  admin_password = "test123"
  admin_public_ssh_keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD2D+g4Lt1mie1puhOxN3b2hIBxCuq02Y//nMsI0e+1NZ78wKVShA5rDj6dDz6XD/UtBxxm5n/4nW1BeR8yDnTa9TFp6PRGhdNpD0s7VcmZq78iTFG2Nk915slxc0mmBm/ASiUTuY6XMzvQ1qx5LDCYs4EFU4Ohg6Ys7Ysov6QULeX7uKU/SCCC9Czq/sw0/VEBB7wsCJ88zG37kBBvfgkQiDSEjApEFOlbh+BnrLx4IB0OCx9UqKpDTVHvYGRIqd1DFB9LnrGOWZoC9GOTeEWAuxHCsEFkI/O06E2jqok2kos+PWpDM5IC0mKlb6zSaRIHY6aQDB/FH9LYJegsFBKj sdhibit@yoga"
  ]

  primary_network_cidr_address = "10.0.0.246/24"
  primary_network_gateway      = "10.0.0.1"

  disks = [
    {
      storage = "local-lvm"
      size    = "16G"
      format  = "raw"
    },
    {
      storage = "local-lvm"
      size    = "24G"
      format  = "raw"
    }
  ]



}
