module "example-server-windowsvm-withdatadisk" {
  #source        = "Terraform-VMWare-Modules/vm/vsphere"
  #version       = "1.0.0"
  source        = "../modules/vsphere_vm"
  vmtemp        = "WIN2016V2"
  instances     = 1
  vmname        = "example-server-windowssme"
  vmrp          = "LAB-1/Resources"
  network_cards = ["LAB-1_VLAN2247"]
  ipv4 = {
    "LAB-1_VLAN2247" = ["10.210.8.26"] # To use DHCP create Empty list for each instance
  }
  dc        = "MATRAN"
  datastore = "datastore1"
}