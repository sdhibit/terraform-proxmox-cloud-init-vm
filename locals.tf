locals {

  proxmox_node          = var.proxmox_node
  proxmox_resource_pool = var.proxmox_resource_pool

  vm_name          = var.vm_name
  vm_id            = var.vm_id != null ? var.vm_id : 0
  vm_description   = var.vm_description
  vm_start_on_boot = var.vm_start_on_boot
  vm_boot_order    = var.vm_boot_order != null ? var.vm_boot_order : ""
  vm_boot_disk     = var.vm_boot_disk

  template_clone      = var.template_clone
  template_full_clone = var.template_full_clone

  admin_username        = var.admin_username
  admin_password        = var.admin_password
  admin_public_ssh_keys = var.admin_public_ssh_keys

  sockets = var.sockets
  cores   = var.cores
  memory  = var.memory

  primary_network = {
    model  = var.primary_network_model
    bridge = var.primary_network_bridge
  }

  disks                     = var.disks
  disk_default_type         = var.disk_default_type
  disk_default_format       = var.disk_default_format
  disk_default_storage_pool = var.disk_default_storage_pool
  disk_default_size         = var.disk_default_size

  ipconfig0_elements = [
    var.primary_network_cidr_address != null ? "ip=${var.primary_network_cidr_address}" : "ip=dhcp",
    var.primary_network_gateway != null ? "gw=${var.primary_network_gateway}" : ""
  ]

  tags = var.tags
}
