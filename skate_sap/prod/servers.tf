data "vsphere_datacenter" "matran" {}

# Create a folder
resource "vsphere_folder" "terraform_folder" {
  type          = "vm"
  datacenter_id = "${data.vsphere_datacenter.matran.id}"
  path = "${var.folder_terraform}"
}
#Variables serveur SLES SAP HANA
module "server-hana" {
  source        = "../modules/vsphere_vm"
  vmtemp        = "SLES12SP1SAP01"
  instances     = 1
  vmname        = "server-sles-sme"
  vmfolder = "${var.folder_terraform}"
  vmrp          = "LAB-1/Resources"
  network_cards = ["LAB-1_VLAN2247"]
  ipv4 = {
    "LAB-1_VLAN2247" = ["10.210.8.27"] # To use DHCP create Empty list for each instance
  }
  dc        = "MATRAN"
  datastore = "datastore1"
}
#Variables serveur Windows SAP S4
module "server-windowsvm-withdatadisk" {
  source        = "../modules/vsphere_vm"
  vmtemp        = "WIN2016V2"
  is_windows_image = "true"
  instances     = 1
  vmfolder = "${var.folder_terraform}"
  vmname        = "server-windowssme"
  vmrp          = "LAB-1/Resources"
  network_cards = ["LAB-1_VLAN2247"]
  ipv4 = {
    "LAB-1_VLAN2247" = ["10.210.8.26"] # To use DHCP create Empty list for each instance
  }
  dc        = "MATRAN"
  datastore = "datastore1"
  run_once = [
          "netsh advfirewall firewall add rule name=\"ICMP Allow incoming V4 echo request\" protocol=icmpv4:8,any dir=in action=allow",
          "Set-ItemProperty -Path 'HKLM:\\System\\CurrentControlSet\\Control\\Terminal Server'-name \"fDenyTSConnections\" -Value 0",
          "Enable-NetFirewallRule -DisplayGroup \"Remote Desktop\""]
}