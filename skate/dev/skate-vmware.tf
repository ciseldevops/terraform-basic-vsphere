provider "vsphere" {
  user           = "${var.vsphere_username}"
  password       = "${var.dev_password}"
  vsphere_server = "${var.vsphere_server}"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "matran" {}

#Root resource pool
data "vsphere_resource_pool" "root_rp" {
  name          = "${var.ressource_rp_01}"
  datacenter_id = "${data.vsphere_datacenter.matran.id}"
}

data "vsphere_datastore" "datastore1" {
  name          = "${var.datastore1}"
  datacenter_id = "${data.vsphere_datacenter.matran.id}"
}

data "vsphere_network" "LAB-1_VLAN2247" {
  name          = "${var.LAB-1_VLAN2247}"
  datacenter_id = "${data.vsphere_datacenter.matran.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.vm_template}"
  datacenter_id = "${data.vsphere_datacenter.matran.id}"
}

data "template_file" "cloud_config" {
  template = "${file("cloud_config.yaml")}"
  vars = {
            vm_name_01 = "${var.vm_name_01}"
        }
}

# Create a folder
resource "vsphere_folder" "terraform_folder" {
  type          = "vm"
  datacenter_id = "${data.vsphere_datacenter.matran.id}"
  path          = "${var.folder_terraform}"
}

# Create a virtual machine within the folder
resource "vsphere_virtual_machine" "vm_name_01" {
  wait_for_guest_net_timeout = "5"
  name       = "${var.vm_name_01}"
  guest_id   = "${data.vsphere_virtual_machine.template.guest_id}"
  folder     = "${vsphere_folder.terraform_folder.path}"
  num_cpus   = 2
  memory     = 4096
  datastore_id     = "${data.vsphere_datastore.datastore1.id}"
  resource_pool_id = "${data.vsphere_resource_pool.root_rp.id}"

  network_interface {
        network_id   = "${data.vsphere_network.LAB-1_VLAN2247.id}"
        adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
        #adapter_type = "e1000e"
  }

  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options {
        host_name = "${var.vm_name_01}"
        domain    = "local"
      }
      network_interface {
        ipv4_address = "${var.vm_ipv4_01}"
        ipv4_netmask = 24
      }
      dns_server_list = "${var.dns_server_list}"
      dns_suffix_list = "${var.dns_suffix_list}"
      ipv4_gateway    = "${var.vm_gw_01}"
    }
  }
  
  extra_config = {
        "guestinfo.userdata" = "${base64gzip(data.template_file.cloud_config.rendered)}"
        "guestinfo.userdata.encoding" = "gzip+base64"
    }

  connection {
    host     = "${var.vm_ipv4_01}"
    type     = "ssh"
    user     = "cisadm"
    password = "${var.dev_password}"
    timeout  = "5m"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/cisadm/.ssh",
      "touch /home/cisadm/.ssh/authorized_keys",
      "echo ${var.ssh-cisadm-pub-key} >> /home/cisadm/.ssh/authorized_keys",
      "chmod 700 /home/cisadm/.ssh",
      "chmod 600 /home/cisadm/.ssh/authorized_keys",
      "sudo apt-get install python -y",
      "history -c"       
    ]
  }
} 


/*
  provisioner "remote-exec" {
    inline = [
      "mkdir /home/cisadm/.ssh",
      "touch /home/cisadm/.ssh/authorized_keys",
      "echo ${var.ssh-cisadm-pub-key} >> /home/cisadm/.ssh/authorized_keys",
      "chmod 700 /home/cisadm/.ssh",
      "chmod 600 /home/cisadm/.ssh/authorized_keys",
      "yum install python",
      "history -c"       
    ]
  }
*/


/* module "server-hana" {
  source        = "../modules/vsphere_vm"
  vmtemp        = "SLES12SP1SAP01"
  instances     = 1
  vmname        = "${var.vm_name_01}"
  vmfolder = "${var.folder_terraform}"
  vmrp          = "LAB-1/Resources"
  #vmrp = "${vsphere_resource_pool.root_rp.name}"
  network_cards = ["LAB-1_VLAN2247"]
  ipv4 = {
    "LAB-1_VLAN2247" = ["10.210.8.199"] # To use DHCP create Empty list for each instance
  }
  dc        = "MATRAN"
  datastore = "datastore1" 
   run_once = [
          "echo \"test\" >> /tmp/test.txt"]
} */