#module "virtual_machines" {
#  source               = "../modules/vsphere_vm"
#  datacenter           = "${var.datacenter}"
#  datastore            = "${var.datastore}"
#  network              = "${var.network}"
#  resource_pool        = "${var.resource_pool}"
#  
#  ipv4_address_start   = "${var.s4_ipv4_address_start}"
#  ipv4_gateway         = "${var.s4_ipv4_gateway}"
#  ipv4_network_address = "${var.s4_ipv4_network_address}"
#  
#  template_name        = "${var.s4_template_name}"
#  vm_name_prefix       = "${var.s4_vm_name_prefix}"
#  vm_count             = "1"
#
#}



 module "virtual_machines" {
   source                     = "vancluever/terraform-vsphere-virtual-machine"
   version                    = "1.0.0"
   datacenter                 = "${var.datacenter}"
   datastore                  = "${var.datastore}"
   disk_size                  = "20"
   guest_id                   = "otherLinuxGuest"
   memory                     = "2048"
   network                    = "${var.network}"
   resource_pool              = "${var.resource_pool}"
   vm_count                   = "1"
   vm_name_prefix             = "srv"
 }