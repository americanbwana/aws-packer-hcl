data "amazon-ami" "Aws-Win2k19" {
  filters = {
    name                = "Windows_Server-2019-English-Full-Base-*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["801119661308"]
}

data "amazon-ami" "Aws-Win2k22" {
  filters = {
    name                = "Windows_Server-2022-English-Full-Base-*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["801119661308"]
}


source "amazon-ebs" "Aws-Win2k19" {
  access_key                  = "${var.aws_access_key_id}"
  ami_name                    = "${var.aws_w2k19_vm_name_prefix}-${var.BUILDTIME}"
  associate_public_ip_address = "${var.aws_public_ip_address}" # Bool
  communicator                = "winrm"
  encrypt_boot                = true
  instance_type               = "t2.large"
  region                      = "${var.aws_region}"
  secret_key                  = "${var.aws_secret_key}"
  security_group_id           = "${var.aws_security_group_id}"
  source_ami                  =  data.amazon-ami.Aws-Win2k19.id
  subnet_id                   = "${var.aws_subnet_id}"
  user_data_file              = "../scripts/awsUserDataOrg.ps1"
  vpc_id                      = "${var.aws_vpc_id}"
  winrm_insecure              = true
  winrm_username              = "${var.new_ansible_user}"
  winrm_password              = "${var.new_ansible_password}"
  winrm_port                  = 5986
  winrm_timeout               = "30m"
  winrm_use_ssl               = true
}

source "amazon-ebs" "Aws-Win2k22" {
  access_key                  = "${var.aws_access_key_id}"
  ami_name                    = "${var.aws_w2k22_vm_name_prefix}-${var.BUILDTIME}"
  associate_public_ip_address = "${var.aws_public_ip_address}" # Bool
  communicator                = "winrm"
  encrypt_boot                = true
  instance_type               = "t2.large"
  region                      = "${var.aws_region}"
  secret_key                  = "${var.aws_secret_key}"
  security_group_id           = "${var.aws_security_group_id}"
  source_ami                  =  data.amazon-ami.Aws-Win2k22.id
  subnet_id                   = "${var.aws_subnet_id}"
  user_data_file              = "../scripts/awsUserDataOrg.ps1"
  vpc_id                      = "${var.aws_vpc_id}"
  winrm_insecure              = true
  winrm_username              = "${var.new_ansible_user}"
  winrm_password              = "${var.new_ansible_password}"
  winrm_port                  = 5986
  winrm_timeout               = "30m"
  winrm_use_ssl               = true
}

source "vsphere-iso" "vSphere-Rhel8" {
  CPUs                 = "2"
  RAM                  = "4096"
  RAM_reserve_all      = false
  boot_command         = ["e<down><down><end><bs><bs><bs><bs><bs>text inst.ks=${var.http_server}/rhel8.cfg<leftCtrlOn>x<leftCtrlOff>"]
  boot_order           = "disk,cdrom"
  boot_wait            = "5s"
  cluster              = "${var.vc_cluster}"
  convert_to_template  = "true"
  # cdrom_type           = "sata"
  create_snapshot      = "false"
  datastore            = "${var.vc_datastore}"
  disk_controller_type = ["pvscsi"]
  firmware             = "efi"
  # floppy_files         = ["../config/centos8.cfg"]
  folder               = "${var.vc_folder}"
  guest_os_type        = "rhel8_64Guest"
  # host                 = "${var.vcenter_host}"
  insecure_connection  = "true"
  iso_checksum         = "${var.vsphere_rhel8_checksum}"
  iso_paths            = ["${var.vsphere_rhel8_iso}"]
  network_adapters {
    network      = "${var.vc_network}"
    network_card = "vmxnet3"
  }
  # notes            = "Default SSH User: ${var.ssh_username}\nDefault SSH Pass: ${var.ssh_password}\nBuilt by Packer @ ${legacy_isotime("2006-01-02 03:04")}."

  remove_cdrom     = "true"
  # need to change username and password in config/centos8.cfg
  shutdown_command = "echo '${var.new_ansible_password}' | sudo -S -E shutdown -P now"
  # ssh_password     = "${var.ssh_password}"
  ssh_password     = "${var.new_ansible_password}"
  ssh_username     = "${var.new_ansible_user}"
  storage {
    disk_size             = "92160"
    disk_thin_provisioned = true
  }
  username       = "${var.vc_username}"
  password         = "${var.vc_password}"
  vcenter_server = "${var.vc_server}"
  vm_name        = "${var.vsphere_rhel8_vm_name_prefix}-${var.BUILDTIME}"
}

source "vsphere-iso" "Aws-Rhel8" {
  CPUs                 = "2"
  RAM                  = "4096"
  RAM_reserve_all      = false
  # boot_command         = ["e<down><down><end><bs><bs><bs><bs><bs>text inst.ks=${var.http_server}/awsrhel8.cfg<leftCtrlOn>x<leftCtrlOff>"]
  boot_command         = ["<tab> text inst.ks=${var.http_server}/awsrhel8.cfg<enter><wait>"]
  boot_order           = "disk,cdrom"
  boot_wait            = "5s"
  cluster              = "${var.vc_cluster}"
  communicator          = "ssh"
  configuration_parameters = {
    "disk.EnableUUID" = "TRUE"
  }
  convert_to_template  = "false"
  # cdrom_type           = "sata"
  create_snapshot      = "false"
  datastore            = "${var.vc_datastore}"
  disk_controller_type = ["lsilogic"]
  export {
    force = true
    output_directory = "./output_vsphere"
  }
  firmware             = "bios"
  # floppy_files         = ["../config/centos8.cfg"]
  folder               = "${var.vc_folder}"
  guest_os_type        = "rhel8_64Guest"
  # host                 = "${var.vcenter_host}"
  insecure_connection  = "true"
  iso_checksum         = "${var.vsphere_rhel8_checksum}"
  iso_paths            = ["${var.vsphere_rhel8_iso}"]
  network_adapters {
    network      = "${var.vc_network}"
    network_card = "e1000"
  }
  notes            = "Test for AWS import of custom build.  packer / br0wNGoffer$"

  remove_cdrom     = "true"
  # need to change username and password in config/centos8.cfg
  shutdown_command = "sudo shutdown -h now"
  shutdown_timeout  = "45m"
  # ssh_password     = "${var.ssh_password}"
  ssh_password     = "${var.new_ansible_password}"
  ssh_username     = "${var.new_ansible_user}"
  storage {
    disk_size             = "92160"
    disk_thin_provisioned = true
  }
  username       = "${var.vc_username}"
  password         = "${var.vc_password}"
  vcenter_server = "${var.vc_server}"
  vm_name        = "${var.vsphere_rhel8_vm_name_prefix}-${var.BUILDTIME}"
}

source "vsphere-iso" "vSphere-Rocky8" {
  CPUs                 = "2"
  RAM                  = "2048"
  RAM_reserve_all      = false
  boot_command         = ["e<down><down><end><bs><bs><bs><bs><bs>text inst.ks=${var.http_server}/rocky86.cfg<leftCtrlOn>x<leftCtrlOff>"]
  boot_order           = "disk,cdrom"
  boot_wait            = "5s"
  cluster              = "${var.vc_cluster}"
  convert_to_template  = "true"
  # cdrom_type           = "sata"
  create_snapshot      = "false"
  datastore            = "${var.vc_datastore}"
  disk_controller_type = ["pvscsi"]
  firmware             = "efi"
  # floppy_files         = ["../config/centos8.cfg"]
  folder               = "${var.vc_folder}"
  guest_os_type        = "centos8_64Guest"
  # host                 = "${var.vcenter_host}"
  insecure_connection  = "true"
  iso_checksum         = "${var.vsphere_rocky8_checksum}"
  iso_paths            = ["${var.vsphere_rocky8_iso}"]
  network_adapters {
    network      = "${var.vc_network}"
    network_card = "vmxnet3"
  }
  # notes            = "Default SSH User: ${var.ssh_username}\nDefault SSH Pass: ${var.ssh_password}\nBuilt by Packer @ ${legacy_isotime("2006-01-02 03:04")}."

  remove_cdrom     = "true"
  # need to change username and password in config/centos8.cfg
  shutdown_command = "echo '${var.new_ansible_password}' | sudo -S -E shutdown -P now"
  # ssh_password     = "${var.ssh_password}"
  ssh_password     = "${var.new_ansible_password}"
  ssh_username     = "${var.new_ansible_user}"
  storage {
    disk_size             = "20480"
    disk_thin_provisioned = true
  }
  username       = "${var.vc_username}"
  password         = "${var.vc_password}"
  vcenter_server = "${var.vc_server}"
  vm_name        = "${var.vsphere_rocky8_vm_name_prefix}-${var.BUILDTIME}"
}

source "vsphere-iso" "vSphere-Win2k19" {
  CPUs                 = "${var.vsphere_win2k19_vm_cpu_num}"
  RAM                  = "${var.vsphere_win2k19_vm_mem_size}"
  RAM_reserve_all      = false
  cluster              = "${var.vc_cluster}"
  communicator         = "winrm"
  convert_to_template  = "true"
  datacenter           = "${var.vc_datacenter}"
  datastore            = "${var.vc_datastore}"
  disk_controller_type = ["pvscsi"]
  firmware             = "bios"
  floppy_files         = ["../config/autounattend.xml","../scripts/addNewWindowsUser.ps1", "../scripts/disable-network-discovery.cmd", "../scripts/enable-rdp.cmd", "../scripts/enable-winrm.ps1", "../scripts/install-vm-tools.cmd", "../scripts/disable-all-fw.ps1","../drivers/pvscsi.cat", "../drivers/pvscsi.inf", "../drivers/pvscsi.sys", "../drivers/pvscsiver.dll"]
  folder               = "${var.vc_folder}"
  guest_os_type        = "windows9Server64Guest"
  insecure_connection  = "true"
  iso_paths            = ["${var.vsphere_win2k19_os_iso_path}", "[] /vmimages/tools-isoimages/windows.iso"]
  network_adapters {
    network      = "${var.vc_network}"
    network_card = "vmxnet3"
  }
  password     = "${var.vc_password}"
  remove_cdrom = true
  storage {
    disk_size             = "${var.vsphere_win2k19_vm_disk_size}"
    disk_thin_provisioned = true
  }
  username       = "${var.vc_username}"
  vcenter_server = "${var.vc_server}"
  vm_name        = "${var.vsphere_win2k19_vm_name_prefix}-${var.BUILDTIME}"
  winrm_password = "${var.new_ansible_password}"
  winrm_username = "${var.new_ansible_user}"
}

## Windows 2022

source "vsphere-iso" "vSphere-Win2k22" {
  CPUs                 = "${var.vsphere_win2k22_vm_cpu_num}"
  RAM                  = "${var.vsphere_win2k22_vm_mem_size}"
  RAM_reserve_all      = false
  boot_command         = ["w"]
  boot_wait            = "3s"
  cluster              = "${var.vc_cluster}"
  cdrom_type           = "sata"
  communicator         = "winrm"
  convert_to_template  = "true"
  datacenter           = "${var.vc_datacenter}"
  datastore            = "${var.vc_datastore}"
  disk_controller_type = ["pvscsi"]
  firmware             = "efi"
  floppy_files         = ["../config/Win2k22/autounattend.xml","../scripts/addNewWindowsUser.ps1", "../scripts/disable-network-discovery.cmd", "../scripts/enable-rdp.cmd", "../scripts/enable-winrm.ps1", "../scripts/install-vm-tools.cmd", "../scripts/disable-all-fw.ps1","../drivers/pvscsi.cat", "../drivers/pvscsi.inf", "../drivers/pvscsi.sys", "../drivers/pvscsiver.dll"]
  folder               = "${var.vc_folder}"
  guest_os_type        = "windows2019srvNext_64Guest"
  insecure_connection  = "true"
  iso_checksum        = "${var.iso_checksum}"
  iso_paths            = ["[] /vmimages/tools-isoimages/windows.iso"]
  iso_url             = "${var.iso_url}"
  network_adapters {
    network      = "${var.vc_network}"
    network_card = "vmxnet3"
  }
  password     = "${var.vc_password}"
  remove_cdrom = true
  storage {
    disk_size             = "${var.vsphere_win2k22_vm_disk_size}"
    disk_thin_provisioned = true
  }
  username       = "${var.vc_username}"
  vcenter_server = "${var.vc_server}"
  vm_name        = "${var.vsphere_win2k22_vm_name_prefix}-${var.BUILDTIME}"
  winrm_password = "${var.new_ansible_password}"
  winrm_username = "${var.new_ansible_user}"
  vm_version     = 18
}


# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
# will use sources from local file.
# need to append 'source.builder' to each one with PKR 1.8
build {
  sources = [
    "source.amazon-ebs.Aws-Win2k19",
    "source.amazon-ebs.Aws-Win2k22",
    "source.vsphere-iso.vSphere-Win2k22",
    "source.vsphere-iso.vSphere-Win2k19",
    "source.vsphere-iso.vSphere-Rocky8",
    "source.vsphere-iso.vSphere-Rhel8",
    "source.vsphere-iso.Aws-Rhel8"
  ]
  # sources = ["source.amazon-ebs.Aws-Win2k19", "source.vsphere-iso.vSphere-CentOS8", "source.vsphere-iso.vSphere-Win2k19"]
# sources = ["source.amazon-ebs.Aws-Win2k22","source.amazon-ebs.Aws-Win2k19"]
# sources = ["source.vsphere-iso.vSphere-Win2k19"]
# sources = ["source.vsphere-iso.vSphere-Rocky8"]
# sources = ["vsphere-iso.vSphere-Win2k22"]


# needs rework
  provisioner "shell" {
    # execute_command = "echo '${var.new_ansible_password}' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    only            = ["vsphere-iso.vSphere-Rocky8"]
    scripts         = ["../scripts/ssh_config.sh", "../scripts/centos_8.sh"]
  }

  # Run script on Aws-RHEL8 to disable vmtools and clean up for first boot
    provisioner "shell" {
    # execute_command = "echo '${var.new_ansible_password}' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    only            = ["vsphere-iso.Aws-Rhel8"]
    scripts         = ["../scripts/aws_rhel8.sh"]
  }

  # provisioner "powershell" {
  #   elevated_password = "${var.new_ansible_password}"
  #   elevated_user     = "${var.new_ansible_user}"
  #   only              = ["vSphere-Win2k19"]
  #   script            = "../scripts/disable-windows-updates.ps1"
  # }

#   provisioner "powershell" {
#     environment_vars = ["newAdminPassword=${var.new_win_admin_password}"]
#     only             = ["Aws-Win2k19"]
#     scripts          = ["../scripts/disable-windows-updates.ps1", "../scripts/changeAdminPassword.ps1"]
#   }

#     provisioner "powershell" {
# #     only             = ["vSphere-Win2k19"]
#     scripts          = ["../scripts/disable-windows-updates.ps1"]
#   }
  
    provisioner "windows-update" { 
    pause_before = "5m" 
    only            = ["vsphere-iso.vSphere-Win2k19","amazon-ebs.Aws-Win2k22","vsphere-iso.vSphere-Win2k22"]
  }

      provisioner "windows-update" { 
      pause_before = "5m" 
      only            = ["vsphere-iso.vSphere-Win2k19","amazon-ebs.Aws-Win2k22","vsphere-iso.vSphere-Win2k22"]
  }

  # export Rhel8 into AWS
  post-processor "amazon-import" {
    only = ["vsphere-iso.Aws-Rhel8"]
    region = "${var.aws_region}"
    access_key = "${var.amazon_import_key_id}"
    secret_key = "${var.amazon_import_secret}"
    s3_bucket_name = "${var.amazon_import_s3_bucket}"
    license_type = "BYOL"
    role_name = "vmimport"
    format = "vmdk"
    boot_mode = "legacy-bios"
    tags = {
      "source": "Packer-Import"
    }

  }
}


