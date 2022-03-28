resource "oci_core_subnet" "test_subnet" {
  #Required
  cidr_block = var.subnet_cidr_block
  compartment_id = var.compartment_id
  vcn_id = var.vcn_id

  #Optional
  display_name = var.subnet_display_name
}