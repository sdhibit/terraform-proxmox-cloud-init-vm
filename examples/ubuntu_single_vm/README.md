# Single Ubuntu VM Proxmox Deployment
Example Ubuntu Cloud-Init VM deployment

## Set Proxmox Terraform environment variables

```bash
export PM_API_URL="https://{{ promox_host }}:8006/api2/json"
export PM_USER="proxmox@pam"
export PM_PASS="{{ proxmox_password }}"

terraform init
terraform plan
terraform apply
```

## Install Cloud-Init enabled Ubuntu VM in Proxmox

This section will configure a cloud-init enabled Ubuntu 20.04 template on the Proxmox system. Alternatively, the [packer-proxmox-templates](https://github.com/sdhibit/packer-proxmox-templates) project can be used to build a cloud-init enabled Ubuntu 20.04 VM.

### Download Ubuntu Cloud Image
```bash
# Download Ubuntu 20.04 cloudimg
wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
```

### Install qemu-guest-agent on Ubuntu Cloud Image
This step will install qemu-guest-agent on the Ubuntu cloud image via `virt-customize`. The `libguestfs-tools` package must be installed on the system where the ubuntu cloudimg will be modified. 

```bash
# Install libguestfs-tools on Proxmox server.
apt-get install libguestfs-tools
# Install qemu-guest-agent on Ubuntu image.
virt-customize -a focal-server-cloudimg-amd64.img --install qemu-guest-agent
# Enable password authentication in the template. Obviously, not recommended for except for testing.
virt-customize -a focal-server-cloudimg-amd64.img --run-command "sed -i 's/.*PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config"
```

### Create Proxmox VM from Ubuntu Cloud Image

```bash
# Set environment variables. Change these as necessary.
export STORAGE_POOL="local-lvm"
export VM_ID="10000"
export VM_NAME="ubuntu-20.04-cloudimg"

# Create Proxmox VM image from Ubuntu Cloud Image.
qm create $VM_ID --memory 2048 --net0 virtio,bridge=vmbr0
qm importdisk $VM_ID focal-server-cloudimg-amd64.img $STORAGE_POOL
qm set $VM_ID --scsihw virtio-scsi-pci --scsi0 $STORAGE_POOL:vm-$VM_ID-disk-0
qm set $VM_ID --agent enabled=1,fstrim_cloned_disks=1
qm set $VM_ID --name $VM_NAME

# Create Cloud-Init Disk and configure boot.
qm set $VM_ID --ide2 $STORAGE_POOL:cloudinit
qm set $VM_ID --boot c --bootdisk scsi0
qm set $VM_ID --serial0 socket --vga serial0
```

### Convert VM to Template

```bash
qm template $VM_ID
```

### Clean Up

```bash
rm focal-server-cloudimg-amd64.img
```

### References
The following links/tutorials were used to help develop this example.
- https://pawa.lt/posts/2019/07/automating-k3s-deployment-on-proxmox/
- https://forum.proxmox.com/threads/installing-virt-customize-ok.78572/