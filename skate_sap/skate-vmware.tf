provider "vsphere" {
  #user           = "${var.vsphere_username}"
  #password       = "${var.vsphere_password}"
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



module "windows_vm" {
  source = "github.com/www-aiqu-no/terraform-vsphere-windows-vm.git?ref=v0.0.2"
# ------------------------------------------------------------------------------
  hosts  = ["my-vsphere-host"]
# ------------------------------------------------------------------------------
  datacenter        = "Matran"
  resource_pool     = "${data.vsphere_resource_pool.root_rp.name}"
  datastore_backend = "${data.vsphere_datastore.datastore1.name}"
  network_backend   = "${data.vsphere_network.LAB-1_VLAN2247.name}"
  vsphere_folder    = "${vsphere_folder.terraform_folder.path}"
# ------------------------------------------------------------------------------
  name     = "vm-test1-linux"
  template = "${data.vsphere_virtual_machine.u1804_template.name}"
# ------------------------------------------------------------------------------
  #cpu     = 2
  #ram_mb  = 2048
  #disk_gb = 20
# ------------------------------------------------------------------------------
  #ipv4_address_start = "10"
  #ipv4_network       = "10.0.250.0/24"
  #ipv4_gateway       = "10.0.250.1"
  #dns_domain         = "contoso.com"
# ------------------------------------------------------------------------------
  #join_domain = false
# ------------------------------------------------------------------------------
  #vsphere_custom_attributes = {
  #  "${data.vsphere_custom_attribute.first.id}"  = "somevalue"
  #  "${data.vsphere_custom_attribute.second.id}" = "somevalue"
  #}
}

