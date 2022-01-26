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
## Requirements

| Name | Version |
|------|---------|
| terraform | >=0.14 |
| proxmox | ~>2.9.0 |

## Providers

| Name | Version |
|------|---------|
| proxmox | ~>2.9.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [proxmox_vm_qemu](https://registry.terraform.io/providers/Telmate/proxmox/~>2.9.0/docs/resources/vm_qemu) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_password | The password of the local administrator. This is set during the cloud-init process. If this is null, admin\_ssh\_public\_keys must be set. | `string` | `null` | no |
| admin\_public\_ssh\_keys | The public keys of the local administrator. This is set during the cloud-init process. If this is null, admin\_password must be set. | `list(string)` | `[]` | no |
| admin\_username | The username of the local administrator. This is set during the cloud-init process. | `string` | n/a | yes |
| cores | How many CPU cores to give the virtual machine. | `number` | `1` | no |
| disk\_default\_format | The format of the file backing the disk. | `string` | `"raw"` | no |
| disk\_default\_size | The size of the disk, including a unit suffix, such as 10G to indicate 10 gigabytes. | `string` | `null` | no |
| disk\_default\_storage\_pool | Name of the Proxmox storage pool to store the virtual machine disk on. | `string` | `"local-lvm"` | no |
| disk\_default\_type | The type of disk. Can be scsi, sata, virtio or ide | `string` | `"scsi"` | no |
| disks | A list of disks to attach to the VM. | `list(any)` | `[]` | no |
| memory | How much memory, in megabytes, to give the virtual machine. | `number` | `1024` | no |
| primary\_network\_bridge | Which Proxmox bridge to attach the adapter to. | `string` | `"vmbr0"` | no |
| primary\_network\_cidr\_address | The IP address with CIDR block for the primary network interface. DHCP will be used if not set. | `string` | `null` | no |
| primary\_network\_gateway | The network gateway to use for the primary network interface. | `string` | `null` | no |
| primary\_network\_model | Model of the virtual network adapter. | `string` | `"virtio"` | no |
| proxmox\_node | Which node in the Proxmox cluster to start the virtual machine on during creation. | `string` | `"proxmox"` | no |
| proxmox\_resource\_pool | Name of resource pool to create virtual machine in. | `string` | `null` | no |
| sockets | How many CPU sockets to give the virtual machine. | `number` | `1` | no |
| tags | List of virtual machine tags. | `list(string)` | `[]` | no |
| template\_clone | Name of the Proxmox template to clone from. | `string` | n/a | yes |
| template\_full\_clone | Performs a full clone of the template when enabled. | `bool` | `true` | no |
| vm\_boot\_order | The boot order for the VM. Proxmox 6.2 changed boot order text from 'cdn'. | `string` | `""` | no |
| vm\_description | The virtual machine description. | `string` | `null` | no |
| vm\_id | The ID of the virtual machine. If not set, the next available ID will be used. | `number` | `null` | no |
| vm\_name | The virtual machine name. | `string` | n/a | yes |
| vm\_start\_on\_boot | Specifies whether a VM will be started during system bootup. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| clone | Template name that this VM was cloned from. |
| vm\_id | The VM Id. |
| vm\_name | The VM name. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
