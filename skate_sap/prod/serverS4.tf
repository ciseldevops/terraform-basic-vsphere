module "virtual_machines" {
  source               = "../modules/"
  datacenter           = "${var.datacenter}"
  datastore            = "${var.datastore}"
  network              = "${var.network}"
  resource_pool        = "${var.resource_pool}"
  
  ipv4_address_start   = "${var.s4_ipv4_address_start}"
  ipv4_gateway         = "${var.s4_ipv4_gateway}"
  ipv4_network_address = "${var.s4_ipv4_network_address}"
  
  template_name        = "${var.s4_template_name}"
  vm_name_prefix       = "${var.s4_vm_name_prefix}"
  #vm_count             = "${var.vm_count}"
  #vm_name_prefix       = "${var.vm_name_prefix}"
}