# Readme
This working repository holds packer configuration files to build images
for vRealize Automation Cloud.

# Credits
To many to mention.

# Directory structure
- Cloud-init. Cloud-init examples.
- blueprint. vRealize Automation Cloud blueprint examples.
- docker. Dockerfile to build image for Image as Code pipeline.
- packer. Packer files to build.

# Required Environmental Variables
As recorded in environment.env in root directory
## AWS 
### Wait an hour for long running AWS processes.
* AWS_MAX_ATTEMPTS=30
* AWS_POLL_DELAY_SECONDS=120
* export PKR_VAR_aws_secret_key="changeme"
* export PKR_VAR_aws_vpc_id="vpc-changeme" 
* export PKR_VAR_aws_security_group_id="sg-changeme" 
* export PKR_VAR_aws_region="changeme" 
* export PKR_VAR_aws_subnet_id="changeme" 
* export PKR_VAR_aws_public_ip_address="true" 

## AWS import used to import the finished VMDK into AWS
* export PKR_VAR_amazon_import_secret="changeme" 
* export PKR_VAR_amazon_import_key_id="changeme"
* export PKR_VAR_amazon_import_s3_bucket="changeme" 

## General settings
* PACKER_LOG=1 
* export PKR_VAR_BUILDTIME="$(date "+%Y%m%d-%H%M%S")"
* export PKR_VAR_new_ansible_password="changeme"
* export PKR_VAR_new_ansible_user="changeme"
* export PKR_VAR_iso_checksum="changeme"
* export PKR_VAR_iso_url="changeme" 
* export PKR_VAR_http_server="changeme"  

## Linux settings 
* export PKR_VAR_ssh_user="changeme"
* export PKR_VAR_ssh_password="changeme"
* export PKR_VAR_linux_root_password="changeme"

## vSphere settings
* export PKR_VAR_vsphere_centos8_vm_name_prefix="changeme" 
* export PKR_VAR_vsphere_centos8_iso="changeme"
* export PKR_VAR_vsphere_centos8_checksum="changeme"
* export PKR_VAR_vsphere_rocky8_vm_name_prefix="changeme"
* export PKR_VAR_vsphere_rocky8_iso="changeme"
* export PKR_VAR_vsphere_rocky8_checksum="changeme"
* export PKR_VAR_vsphere_rhel8_vm_name_prefix="changeme"
* export PKR_VAR_vsphere_rhel8_iso="changeme"
* export PKR_VAR_vsphere_rhel8_checksum="changeme"
* export PKR_VAR_vc_username="administrator@vsphere.local"
* export PKR_VAR_vc_password="changeme"
* export PKR_VAR_vc_server="vc.corp.local"
* export PKR_VAR_vc_datacenter="DC1"
* export PKR_VAR_vc_datastore="datastore" 
* export PKR_VAR_vc_folder="changeme" 
* export PKR_VAR_vc_cluster="CL" 
* export PKR_VAR_vc_network="VM Network" 

## Windows settings 
* export PKR_VAR_new_win_admin_password="changeme" 
* export PKR_VAR_aws_w2k19_vm_name_prefix="changeme" 
* export PKR_VAR_vsphere_win2k19_vm_cpu_num="2" 
* export PKR_VAR_vsphere_win2k19_vm_mem_size="8192" 
* export PKR_VAR_vsphere_win2k19_os_iso_path="[datastore1] ISO/W2k19.iso"
* export PKR_VAR_vsphere_win2k19_vm_disk_size="100" 
* export PKR_VAR_vsphere_win2k19_vm_name_prefix="changeme" 
* export PKR_VAR_aws_w2k22_vm_name_prefix="changeme"
* export PKR_VAR_vsphere_win2k22_vm_cpu_num="2" 
* export PKR_VAR_vsphere_win2k22_vm_mem_size="8192" 
* export PKR_VAR_vsphere_win2k22_os_iso_path="[datastore1] ISO/W2k22.iso" 
* export PKR_VAR_sphere_win2k22_vm_disk_size="153600"
* export PKR_VAR_vsphere_win2k22_vm_name_prefix="changeme" 