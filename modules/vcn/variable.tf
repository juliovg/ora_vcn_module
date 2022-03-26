variable "compartment_ocid" {
  description = "Compartment info"
}
variable "display_name" {
  description = "name of your vcn"
}
variable "vcn_cidr_block" {
  description = "ip range for your vcn"
}
variable "vcn_cidr_blocks" {
  default = "ip range blocks"
}