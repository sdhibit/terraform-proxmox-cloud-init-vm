terraform {
  required_version = ">=0.13.0"
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">=2.6.5"
    }
  }
}
