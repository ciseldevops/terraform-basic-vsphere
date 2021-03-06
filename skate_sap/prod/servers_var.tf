############################# PROD #############################
############################# HANA
#--- TEMPLATE 
variable "hana_template_name"{
  description = "Template SLES"
  default = "SLES12SP1SAP01"
}
#--- FOLDER 
variable "folder_terraform"{
  description = "Dossier VM Terraform"
  default = "TestSAP"
}

#--- VMNAME 
variable "hana_vm_name"{
  description = "Nom de la VM 1"
  default = "VMHANA_sme"
}
variable "hana_vm_name_prefix"{
  description = "Nom de la VM hana prefix"
  default = ""
}

variable "hana_ipv4_network_address" {
  description = "The network address to assign during customization of cloned virtual machines, in A.B.C.D/XX format. Leave at the default value for DHCP."
  default     = "10.210.8.0/24"
}

variable "hana_ipv4_address_start" {
  description = "The IP address to start assigning virtual machines at, relative to the network address and mask. Example: for two virtual machines in 10.0.0.0/24, a value of 10 here would give the IP addresses 10.0.0.10 and 10.0.0.11. For 10.0.0.128/25, a value of 10 would give 10.0.0.138 and 10.0.0.139."
  default     = "22"
}

variable "hana_ipv4_gateway" {
  description = "The default IPv4 gateway for the virtual machines. Leave blank for DHCP."
  default     = "10.210.8.1"
}

############################# S4
#--- TEMPLATE 
variable "s4_template_name"{
  description = "Template W2016"
  default = "WIN2016V2"
}
#--- FOLDER 
variable "s4_folder_terraform"{
  description = "Dossier VM Terraform"
  default = "TestSAP"
}
#--- VMNAME 
variable "s4_vm_name"{
  description = "Nom de la VM 1"
  default = "VMS4_sme"
}
variable "s4_vm_name_prefix"{
  description = "Nom de la VM 1"
  default = "test_"
}

variable "s4_ipv4_network_address" {
  description = "The network address to assign during customization of cloned virtual machines, in A.B.C.D/XX format. Leave at the default value for DHCP."
  default     = "10.210.8.0/24"
}

variable "s4_ipv4_address_start" {
  description = "The IP address to start assigning virtual machines at, relative to the network address and mask. Example: for two virtual machines in 10.0.0.0/24, a value of 10 here would give the IP addresses 10.0.0.10 and 10.0.0.11. For 10.0.0.128/25, a value of 10 would give 10.0.0.138 and 10.0.0.139."
  default     = "22"
}

variable "s4_ipv4_gateway" {
  description = "The default IPv4 gateway for the virtual machines. Leave blank for DHCP."
  default     = "10.210.8.1"
}