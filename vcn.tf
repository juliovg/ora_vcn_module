/*
provider "oci" {
  tenancy_ocid = local.json_data.TERRAFORM.tenancy_ocid
  user_ocid = local.json_data.TERRAFORM.user_ocid
  private_key_path = local.json_data.TERRAFORM.private_key_path
  fingerprint = local.json_data.TERRAFORM.fingerprint
  region = local.json_data.TERRAFORM.region
}
*/

resource "oci_core_vcn" "test_vcn" {
  #Required
  compartment_id = var.compartment_ocid
  #Optional
  cidr_blocks = var.vcn_cidr_block
  display_name = var.display_name
}

