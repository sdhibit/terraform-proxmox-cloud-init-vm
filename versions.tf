terraform {
  required_version = ">=0.14"
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = ">=2.6.5"
    }
  }
}
