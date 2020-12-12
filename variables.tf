#### Required Parameters #####

variable "vm_name" {
  type        = string
  description = "The virtual machine name."
}

variable "template_clone" {
  type        = string
  description = "Name of the Proxmox template to clone from."
}

variable "admin_username" {
  type        = string
  description = "The username of the local administrator. This is set during the cloud-init process."
}

#### Optional Parameters #####

variable "vm_id" {
  type        = number
  description = "The ID of the virtual machine. If not set, the next available ID will be used."
  default     = null
}

variable "vm_description" {
  type        = string
  description = "The virtual machine description."
  default     = null
}

variable "vm_onboot" {
  type        = bool
  description = "Specifies whether a VM will be started during system bootup."
  default     = false
}

variable "template_full_clone" {
  type        = bool
  description = "Performs a full clone of the template when enabled."
  default     = true
}

variable "admin_password" {
  type        = string
  description = "The password of the local administrator. This is set during the cloud-init process. If this is null, admin_ssh_public_keys must be set."
  default     = null
}

variable "admin_public_ssh_keys" {
  type        = list(string)
  description = "The public keys of the local administrator. This is set during the cloud-init process. If this is null, admin_password must be set."
  default     = []
}

variable "sockets" {
  type        = number
  description = "How many CPU sockets to give the virtual machine."
  default     = 1
}

variable "cores" {
  type        = number
  description = "How many CPU cores to give the virtual machine."
  default     = 1
}

variable "memory" {
  type        = number
  description = "How much memory, in megabytes, to give the virtual machine."
  default     = 1024
}

variable "primary_network_model" {
  type        = string
  description = "Model of the virtual network adapter."
  default     = "virtio"

  validation {
    condition     = contains(["rtl8139", "ne2k_pci", "e1000", "pcnet", "virtio", "ne2k_isa", "i82551", "i82557b", "i82559er", "vmxnet3", "e1000-82540em", "e1000-82544gc", "e1000-82545em"], var.primary_network_model)
    error_message = "The Proxmox network model is invalid."
  }
}

variable "primary_network_bridge" {
  type        = string
  description = "Which Proxmox bridge to attach the adapter to."
  default     = "vmbr0"
}

variable "primary_network_cidr_address" {
  type        = string
  description = "The IP address with CIDR block for the primary network interface. DHCP will be used if not set."
  default     = null
}

variable "primary_network_gateway" {
  type        = string
  description = "The network gateway to use for the primary network interface."
  default     = null
}

variable "disks" {
  type        = list(any)
  description = "A list of disks to attach to the VM. "
  default     = []
}

variable "disk_default_type" {
  type        = string
  description = "The type of disk. Can be scsi, sata, virtio or ide"
  default     = "scsi"

  validation {
    condition     = contains(["scsi", "sata", "virtio", "ide"], var.disk_default_type)
    error_message = "The Proxmox disk type is invalid."
  }
}

variable "disk_default_format" {
  type        = string
  description = "The format of the file backing the disk."
  default     = "raw"

  validation {
    condition     = contains(["raw", "cow", "qcow", "qed", "qcow2", "vmdk", "cloop"], var.disk_default_format)
    error_message = "The Proxmox disk format is invalid."
  }
}

variable "disk_default_storage_pool" {
  type        = string
  description = "Name of the Proxmox storage pool to store the virtual machine disk on."
  default     = "local-lvm"
}

variable "disk_default_size" {
  type        = string
  description = "The size of the disk, including a unit suffix, such as 10G to indicate 10 gigabytes."
  default     = null
}

variable "proxmox_node" {
  type        = string
  description = "Which node in the Proxmox cluster to start the virtual machine on during creation."
  default     = "proxmox"
}

variable "proxmox_resource_pool" {
  type        = string
  description = "Name of resource pool to create virtual machine in."
  default     = null
}
