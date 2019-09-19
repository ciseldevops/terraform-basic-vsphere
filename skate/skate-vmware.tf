provider "vsphere" {
  user           = "${var.vsphere_username}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}

# Create a folder
resource "vsphere_folder" "awshybridcloud" {
  datacenter = "GRT"
  path = "awshybridcloud"
}

# Create a virtual machine within the folder
resource "vsphere_virtual_machine" "awshybridrtr1" {
  name       = "awshybridrtr1"
  datacenter = "GRT"
  folder     = "${vsphere_folder.awshybridcloud.path}"
  vcpu       = 2
  memory     = 4096

  network_interface {
    label = "VM Network"
    ipv4_address       = "192.168.150.10"
    ipv4_prefix_length = "24"
    ipv4_gateway       = "192.168.150.254"
  }

  network_interface {
    label = "Hybrid"
    ipv4_address       = "172.16.20.1"
    ipv4_prefix_length = "24"
    ipv4_gateway       = "172.16.20.1"
  }

  disk {
    template = "centos7temp"
    type     = "thin"
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = "192.168.150.10"
      user        = "root"
      password    = "password123"
    }

    inline = [
      "echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf",
      "sysctl -p",
      "yum -y install firewalld",
      "systemctl start firewalld; systemctl enable firewalld",
      "firewall-cmd --permanent --direct --add-rule ipv4 nat POSTROUTING 0 -o ens160 -j MASQUERADE",
      "firewall-cmd --permanent --direct --add-rule ipv4 filter FORWARD 0 -i ens192 -o ens160 -j ACCEPT",
      "firewall-cmd --permanent --direct --add-rule ipv4 filter FORWARD 0 -i ens160 -o ens192 -m state --state RELATED,ESTABLISHED -j ACCEPT",
      "firewall-cmd --reload",
    ]
  }

}

# Create a virtual machine within the folder
resource "vsphere_virtual_machine" "awshybriddb" {
  name       = "awshybriddb"
  depends_on = ["vsphere_virtual_machine.awshybridrtr1"]
  datacenter = "GRT"
  folder     = "${vsphere_folder.awshybridcloud.path}"
  vcpu       = 2
  memory     = 4096

  network_interface {
    label = "Hybrid"
    ipv4_address       = "172.16.20.50"
    ipv4_prefix_length = "24"
    ipv4_gateway       = "172.16.20.1"
  }

  disk {
    template = "centos7temp"
    type     = "thin"
  }

  provisioner "remote-exec" {
    connection {
      bastion_host = "192.168.150.10"
      bastion_user = "root"
      bastion_password = "password123"
      user        = "root"
      password    = "password123"
    }

    inline = [
      "yum -y install mariadb-server && systemctl enable mariadb && systemctl start mariadb",
      "mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password123'; FLUSH PRIVILEGES;" && systemctl restart mariadb"
    ]
  }
}
