module "virtual_machines_hana" {
  source               = "../modules/"
  datacenter           = "${var.datacenter}"
  datastore            = "${var.datastore}"
  network              = "${var.network}"
  resource_pool        = "${var.resource_pool}"
  
  ipv4_address_start   = "${var.hana_ipv4_address_start}"
  ipv4_gateway         = "${var.hana_ipv4_gateway}"
  ipv4_network_address = "${var.hana_ipv4_network_address}"
  
  template_name        = "${var.hana_template_name}"
  vm_name_prefix       = "${var.hana_vm_name_prefix}"
  #vm_count             = "${var.vm_count}"
  #vm_name_prefix       = "${var.vm_name_prefix}"
}