# General variables 
variable "BUILDTIME" {}
# AWS section
variable "aws_access_key_id" {
    sensitive = true
}
variable "aws_secret_key" {
    sensitive = true
}
variable "aws_w2k19_vm_name_prefix" {}
variable "aws_region" {}
variable "aws_vpc_id" {}
variable "aws_subnet_id" {}
variable "aws_security_group_id" {}
variable "aws_public_ip_address" {
    type = bool
}
# Winrm and ansible
variable "new_ansible_user" {
    default = "root"
}
variable "new_ansible_password" {
    sensitive = true
}
variable "new_win_admin_password" {
    sensitive = true
}
variable "ssh_user" {}
variable "ssh_password" {
    sensitive = true
}
variable "linux_root_password" {
    sensitive = true
}
# vSphere variables
variable "vsphere_centos8_iso" {}
variable "vsphere_centos8_checksum" {}

variable "vc_username" {}
variable "vc_password" {
    sensitive = true
}
variable "vc_server" {}
variable "vc_datacenter" {}
variable "vc_datastore" {}
variable "vc_folder" {}
variable "vc_cluster" {}
variable "vc_network" {}
variable "vsphere_win2k19_vm_cpu_num" {}
variable "vsphere_win2k19_vm_mem_size" {}
variable "vsphere_win2k19_os_iso_path" {}
variable "vsphere_win2k19_vm_disk_size" {}
variable "vsphere_centos8_vm_name_prefix" {}
variable "vsphere_win2k19_vm_name_prefix" {}
variable "http_server" {}
