/*

variable "compartment_ocid" {
  description = "Compartment info"
}
variable "display_name" {
  description = "name of your vcn"
}
variable "vcn_cidr_block" {
  description = "ip range for your vcn"
}

*/



variable "vcns" {
  description = "The VCNs."
  type = map(object({
    compartment_id    = string,
    cidr              = string,
    display_name      = string,
    subnets = map(object({
      compartment_id    = string,
      name              = string,
      cdir              = string
    }))
  }))
}
