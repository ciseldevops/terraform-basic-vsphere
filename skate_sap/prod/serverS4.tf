module "example-server-linuxvm" {
  source        = "Terraform-VMWare-Modules/vm/vsphere"
  version       = "1.0.0"
  vmtemp        = "TemplateName"
  instances     = 1
  vmname        = "example-server-windows"
  vmrp          = "esxi/Resources"
  network_cards = ["Name of the POrt Group in vSphere"]
  ipv4 = {
    "Name of the POrt Group in vSphere" = ["10.0.0.1"] # To use DHCP create Empty list for each instance
  }
  dc        = "Datacenter"
  datastore = "Data Store name(use ds_cluster for datastore cluster)"
}