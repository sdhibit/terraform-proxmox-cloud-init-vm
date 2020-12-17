output "vm_id" {
  description = "The VM Id."
  value       = proxmox_vm_qemu.cloudinit.vmid
}

output "vm_name" {
  description = "The VM name."
  value       = proxmox_vm_qemu.cloudinit.name
}

output "clone" {
  description = "Template name that this VM was cloned from."
  value       = proxmox_vm_qemu.cloudinit.clone
}
