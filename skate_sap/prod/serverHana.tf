module "example-server-windowsvm-withdatadisk" {
  source        = "../modules/vsphere_vm"
  vmtemp        = "SLES12SP1SAP01"
  instances     = 1
  vmname        = "example-server-sles-sme"
  vmrp          = "LAB-1/Resources"
  network_cards = ["LAB-1_VLAN2247"]
  ipv4 = {
    "LAB-1_VLAN2247" = ["10.210.8.27"] # To use DHCP create Empty list for each instance
  }
  dc        = "MATRAN"
  datastore = "datastore1"
}