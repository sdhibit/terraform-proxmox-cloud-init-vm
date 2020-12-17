terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "~>2.0"
    }
  }
}

provider "proxmox" {
  # Set PM_API_URL, PM_USER, PM_PASS environment variables
  pm_tls_insecure = true
}

module "ubuntu_vm" {
  source = "../.."

  vm_name        = "ubuntu-single-vm"
  vm_id          = 900
  vm_description = "Example Ubuntu Cloud-Init VM built with Terraform"

  template_clone      = "ubuntu-20.04-cloudimg"
  template_full_clone = true

  # Must not be any existing user like 'admin' or 'ubuntu'
  admin_username = "localadmin"
  admin_password = "p@sswordz"
  # Uncomment and populate if the template does not allow SSH password authentication.
  # admin_public_ssh_keys = []


  # Uncomment for Static IP on the Primary NIC. DHCP is default.
  # primary_network_cidr_address = "10.0.0.246/24"
  # primary_network_gateway      = "10.0.0.1"

  disks = [
    {
      storage = "local-lvm"
      size    = "4G"
      format  = "raw"
    }
  ]

}

output "vm_id" {
  value = module.ubuntu_vm.vm_id
}

output "vm_name" {
  value = module.ubuntu_vm.vm_name
}
