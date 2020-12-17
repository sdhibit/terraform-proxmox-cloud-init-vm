
/* Uses cloud-init options from Proxmox 5.2 onward */
resource "proxmox_vm_qemu" "cloudinit" {
  name    = local.vm_name
  desc    = local.vm_description
  vmid    = local.vm_id
  os_type = "cloud-init"
  agent   = 1
  onboot  = local.vm_start_on_boot
  boot    = local.vm_boot_order

  target_node = local.proxmox_node
  pool        = local.proxmox_resource_pool

  clone      = local.template_clone
  full_clone = local.template_full_clone
  clone_wait = local.clone_wait

  cores   = local.cores
  sockets = local.sockets
  memory  = local.memory

  # Disks
  dynamic "disk" {
    for_each = local.disks
    content {
      type    = lookup(disk.value, "type", local.disk_default_type)
      storage = lookup(disk.value, "storage", local.disk_default_storage_pool)
      size    = lookup(disk.value, "size", local.disk_default_size)
      format  = lookup(disk.value, "format", local.disk_default_format)
    }
  }

  # Primary Network
  network {
    model  = local.primary_network.model
    bridge = local.primary_network.bridge
  }

  # Additional Networks - Future

  # Cloud-Init Drive
  ciuser        = local.admin_username
  cipassword    = local.admin_password
  sshkeys       = <<-EOF
  %{for key in local.admin_public_ssh_keys~}
  ${key}
  %{endfor~}
  EOF

  # ci_wait = null
  # cicustom = null

  nameserver    = null
  searchdomain  = null
  ipconfig0     = join(",", compact(local.ipconfig0_elements))

}
