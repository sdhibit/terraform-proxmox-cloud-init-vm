# terraform-proxmox-cloud-init-vm
Terraform module that creates a cloud-init enabled VM in Proxmox.

## Requirements
Cloud Init and QEMU Guest Agent must be installed. 
iso9660 (isofs) module must be loaded for cloud-init to mount the Proxmox cloud-init drive.

## Improvements
- Allow multiple network interfaces 
- Expose all disk options
- Expose all network options

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->