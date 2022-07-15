# General variables 
variable "BUILDTIME" {}
# AWS section
variable "aws_access_key_id" {
    sensitive = true
}
variable "aws_secret_key" {
    sensitive = true
}

variable "amazon_import_key_id" {
    sensitive = true
}

variable "amazon_import_secret" {
    sensitive = true
}

variable "amazon_import_s3_bucket" {
    default = "packer-import-example"
}

variable "aws_w2k19_vm_name_prefix" {
    default = "Aws-W2k19"
}

variable "aws_w2k22_vm_name_prefix" {
    default = "Aws-W2k22"
}
variable "aws_region" {
    default="us-east-1"
}
variable "aws_vpc_id" {
    default = "vpc-1234"
}
variable "aws_subnet_id" {
    default = "subnet-1234"
}
variable "aws_security_group_id" {
    default = "sg-1234"
}
variable "aws_public_ip_address" {
    type = bool
    default = true
}
# Winrm and ansible
variable "new_ansible_user" {
    default = "ansibleuser"
}
variable "new_ansible_password" {
    sensitive = true
}
variable "new_win_admin_password" {
    sensitive = true
}
variable "ssh_user" {
    default = "ansibleuser"
}
variable "ssh_password" {
    sensitive = true
}
variable "linux_root_password" {
    sensitive = true
}
# vSphere variables
variable "vsphere_centos8_iso" {
    default = "[datastore1] ISO/Rocky-8.5-x86_64-minimal.iso"
}
variable "vsphere_centos8_checksum" {
    default = "c4eb2ae6b06876205f2209e4504110fe4115b37540c21ecfbbc0ebc11084cb779"
}

variable "vsphere_rocky8_iso" {
    default = "[datastore1] ISO/Rocky-8.5-x86_64-minimal.iso"
}
variable "vsphere_rocky8_checksum" {
    default = "c4eb2ae6b06876205f2209e4504110fe4115b37540c21ecfbbc0ebc11084cb779"
}

variable "vsphere_rhel8_vm_name_prefix" {
    default = "vSphere-Rhel8-Custom"
}
variable "vsphere_rhel8_iso" {
    default = "[datastore1] ISO/rhel-8.4-x86_64-dvd.iso"
}

# RHEL 8.6
# variable "vsphere_rhel8_checksum" {
#     default = "c324f3b07283f9393168f0a4ad2167ebbf7e4699d65c9670e0d9e58ba4e2a9a8"
# }

# RHEL 8.4
variable "vsphere_rhel8_checksum" {
    default = "48f955712454c32718dcde858dea5aca574376a1d7a4b0ed6908ac0b85597811"
}

variable "vc_username" {
    default = "administrator@vsphere.local"
}
variable "vc_password" {
    sensitive = true
}
variable "vc_server" {
    default = "vc.corp.local"
}
variable "vc_datacenter" {
    default = "DC"
}
variable "vc_datastore" {
    default = "datastore1"
}
variable "vc_folder" {
    default = "Packer Templates"
}
variable "vc_cluster" {
    default = "CL1"
}
variable "vc_network" {
    default = "VM Network"
}
variable "vsphere_win2k19_vm_cpu_num" {
    default = 2
}
variable "vsphere_win2k19_vm_mem_size" {
    default = 8192
}
variable "vsphere_win2k19_os_iso_path" {
    default = "[datastore1] ISO/W2k19.iso"
}
variable "vsphere_win2k19_vm_disk_size" {
    default = 100
}
variable "vsphere_centos8_vm_name_prefix" {
    default = "vSphere-CentOS8-Custom"
}

variable "vsphere_rocky8_vm_name_prefix" {
    default = "vSphere-Rocky8-Custom"
}
variable "vsphere_win2k19_vm_name_prefix" {
    default = "vSphere-W2k19-Custom"
}

variable "vsphere_win2k22_vm_cpu_num" {
    default = 2
}
variable "vsphere_win2k22_vm_mem_size" {
    default = 8192
}
variable "vsphere_win2k22_os_iso_path" {
    default = "[datastore1] ISO/W2k22.iso"
}
variable "vsphere_win2k22_vm_disk_size" {
    default = 153600
}

variable "vsphere_win2k22_vm_name_prefix" {
    default = "vSphere-W2k22"
}
variable "iso_checksum" {
  type    = string
  default = "sha256:4f1457c4fe14ce48c9b2324924f33ca4f0470475e6da851b39ccbf98f44e7852"
  description = "The checksum for the ISO specified in `iso_url`"
}

variable "iso_url" {
  type    = string
  default = "https://software-download.microsoft.com/download/sg/20348.169.210806-2348.fe_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso"
  description = "The download url for the installation ISO"
}

variable "http_server" {
    default ="http://192.168.1.200/repo/packer"
}
