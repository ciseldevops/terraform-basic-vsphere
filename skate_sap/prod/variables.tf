#--- CREDENTIALS
variable "vsphere_user" {
  description = "vSphere LAB User"
  default = "administrator@vsphere.local"
}
variable "vsphere_password" {
  description = "vSphere LAB User"
  #PASSWORD TO ENTER EVERY TIME
}
variable "vsphere_server" {
  description = "vSphere LAB Server"
  default = "10.210.8.65"
}

#--- DATACENTER 
variable "datacenter" {
  description = "Datacenter"
  default = "MATRAN"
}
#--- VLAN 
variable "network"{
  description = "LAB-1_VLAN2247"
  default = "LAB-1_VLAN2247"
}
#--- DATASTORE 
variable "datastore"{
  description = "Local datastore1"
  default = "datastore1"
}
#--- RESSOURCE POOL
variable "resource_pool"{
  description = "resource pool"
  default = "LAB-1/Resources"
}

