variable "vsphere_username" {
  description = "vSphere LAB User"
  default = "administrator@vsphere.local"
}

variable "vsphere_password" {
  description = "vSphere LAB User"
  default = "Init.123456$"
}

variable "vsphere_server" {
  description = "vSphere LAB Server"
  default = "10.210.8.65"
}

variable "datacenter" {
  description = "Datacenter"
  default = "MATRAN"
}

variable "folder_terraform"{
  description = "Dossier VM Terraform"
  default = "TerraformVM"
}

variable "vm_name_01"{
  description = "Nom de la VM 1"
  default = "terratestfca"
}

variable "LAB-1_VLAN2247"{
  description = "LAB-1_VLAN2247"
  default = "LAB-1_VLAN2247"
}

variable "LAB-2_VLAN2248"{
  description = "LAB-2_VLAN2248"
  default = "LAB-2_VLAN2248"
}

variable "LAB-3_VLAN2252"{
  description = "LAB-3_VLAN2252"
  default = "LAB-3_VLAN2252"
}

variable "datastore1"{
  description = "Local datastore1"
  default = "datastore1"
}

variable "dns_server_list" {
  description = "List des serveurs DNS"
  default = ["1.1.1.1", "8.8.8.8"] 
}

variable "dns_suffix_list" {
  description = "List des suffixes DNS"
  default = ["local"]
}
