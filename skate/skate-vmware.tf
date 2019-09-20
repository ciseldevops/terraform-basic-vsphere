provider "vsphere" {
  user           = "${var.vsphere_username}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "matran" {}

#Root resource pool
data "vsphere_resource_pool" "root_rp" {
  name          = "LAB-1/Resources"
  datacenter_id = "${data.vsphere_datacenter.matran.id}"
}

data "vsphere_datastore" "datastore1" {
  name          = "datastore1"
  datacenter_id = "${data.vsphere_datacenter.matran.id}"
}

data "vsphere_network" "LAB-1_VLAN2247" {
  name          = "LAB-1_VLAN2247"
  datacenter_id = "${data.vsphere_datacenter.matran.id}"
}

data "vsphere_virtual_machine" "u1804_template" {
  name          = "U1804"
  datacenter_id = "${data.vsphere_datacenter.matran.id}"
}

# Create a folder
resource "vsphere_folder" "terraform_folder" {
  type          = "vm"
  datacenter_id = "${data.vsphere_datacenter.matran.id}"
  path = "${var.folder_terraform}"
}

# Create a virtual machine within the folder
resource "vsphere_virtual_machine" "vm_name_01" {
  name       = "${var.vm_name_01}"
  guest_id = "${data.vsphere_virtual_machine.u1804_template.guest_id}"
  folder     = "${vsphere_folder.terraform_folder.path}"
  num_cpus       = 2
  memory     = 4096
  datastore_id     = "${data.vsphere_datastore.datastore1.id}"
  resource_pool_id = "${data.vsphere_resource_pool.root_rp.id}"

  network_interface {
    network_id = "${data.vsphere_network.LAB-1_VLAN2247.id}"
    adapter_type = "${data.vsphere_virtual_machine.u1804_template.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.u1804_template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.u1804_template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.u1804_template.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.u1804_template.id}"
  }
}
#   provisioner "remote-exec" {
#     connection {
#       type        = "ssh"
#       host        = "192.168.150.10"
#       user        = "root"
#       password    = "password123"
#     }
#
#     inline = [
#       "echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf",
#       "sysctl -p",
#       "yum -y install firewalld",
#       "systemctl start firewalld; systemctl enable firewalld",
#       "firewall-cmd --permanent --direct --add-rule ipv4 nat POSTROUTING 0 -o ens160 -j MASQUERADE",
#       "firewall-cmd --permanent --direct --add-rule ipv4 filter FORWARD 0 -i ens192 -o ens160 -j ACCEPT",
#       "firewall-cmd --permanent --direct --add-rule ipv4 filter FORWARD 0 -i ens160 -o ens192 -m state --state RELATED,ESTABLISHED -j ACCEPT",
#       "firewall-cmd --reload",
#     ]
#   }
#
# }

# # Create a virtual machine within the folder
# resource "vsphere_virtual_machine" "awshybriddb" {
#   name       = "awshybriddb"
#   depends_on = ["vsphere_virtual_machine.awshybridrtr1"]
#   datacenter = "GRT"
#   folder     = "${vsphere_folder.awshybridcloud.path}"
#   vcpu       = 2
#   memory     = 4096
#
#   network_interface {
#     label = "Hybrid"
#     ipv4_address       = "172.16.20.50"
#     ipv4_prefix_length = "24"
#     ipv4_gateway       = "172.16.20.1"
#   }
#
#   disk {
#     template = "centos7temp"
#     type     = "thin"
#   }
#
#   provisioner "remote-exec" {
#     connection {
#       bastion_host = "192.168.150.10"
#       bastion_user = "root"
#       bastion_password = "password123"
#       user        = "root"
#       password    = "password123"
#     }
#
#     inline = [
#       "yum -y install mariadb-server && systemctl enable mariadb && systemctl start mariadb",
#       "mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password123'; FLUSH PRIVILEGES;" && systemctl restart mariadb"
#     ]
#   }
# }
