
resource "oci_core_vcn" "test_vcn" {
  #Required
  compartment_id = var.compartment_ocid
  #Optional
  cidr_blocks = var.vcn_cidr_blocks
  display_name = var.display_name
  cidr_block = var.vcn_cidr_block
}

