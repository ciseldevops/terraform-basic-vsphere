variable "vsphere_username" {
  description = "vSphere LAB User"
  default = "administrator@vsphere.local"
}

variable "vsphere_password" {
  description = "vSphere LAB User"
  default = "******"
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

variable "ssh-cisadm-pub-key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMkEvbSeFJrsCoRM3Ge/5SLf24QM4npF0H7FVLIuYdGu4Olj5iOA+yTSnGPoUqLtdJc+bdJT6kswTxENcbyjeHMzjWvq3cVsCWqbTvBUBe65pUBQ/JqFlMOlKKe5S+iXQOqm3/+xO5dECeQJ2xqdQgXAKPOmXfb3nvMyPOi2iutiWw7q7AhQeJrLvUyVXpgKGWGmKbpHiboeRxZJ1kiaYgTmfPry0obZ+ORJY3zfz1XZHrULWARDJDr0QX9Let6b/p6extpyz5wEKLv6OHSYkr7Z0UI1HMhdNwLyj4sVgoEt7bg8Mi4OmBEkmdoSSA3HBEW+IY/8mIueiEbnzEYpbP cisadm@SMANSIBLE001"
}

variable "ssh-root-pub-key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDF99X4jp1wO+ZKG8HyBHIAJC6ZKicET68SA9/G0TYg3hVvy85b1Gu5o8jp1JS4jH2ZLRXx9bO8AqPS+UFcqBWKD22069jip+XDPHvk08iONy7Yw0tLorHTM1YfqBp9eqYxjCqiPnPsW9ecRYo+2msRNjVUuXHK0J2ryZsGqr3gkjwP8GUZVwjYuXGLz92zjU2jacTBQXoyNE52+xc6f7PbbmqwpYSgkcutsJS+svjRs4d/Q6Ud5+GGZGiTRou1/ORY4ZK/kZ6nKuwqEwq/q0Kctk5Sn5/huf/3Msr/SjCQ4jYJe4xwgGG85GNSgA9kbfIvBM+L/yyHYAFNfNGKSYyt root@SMANSIBLE001"
}