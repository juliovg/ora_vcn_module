/*
provider "oci" {
  tenancy_ocid = local.json_data.TERRAFORM.tenancy_ocid
  user_ocid = local.json_data.TERRAFORM.user_ocid
  private_key_path = local.json_data.TERRAFORM.private_key_path
  fingerprint = local.json_data.TERRAFORM.fingerprint
  region = local.json_data.TERRAFORM.region
}
*/


locals {

  subnets = flatten([
    for k, v in var.vcns : [
      for k1, v1 in v.subnets : {
        vcn_name        = k
        subnet_key      = k1
        display_name    = v1.name
        cidr            = v1.cidr
        compartment_id  = v1.compartment_id != null ? v1.compartment_id : var.compartment_id
      }
    ]
  ])
}



resource "oci_core_vcn" "poc_vcn" {
  for_each      = var.vcns
    #Required
    compartment_id  = each.value.compartment_id

    #Optional
    display_name    = each.value.display_name
    cidr_block      = each.value.cidr
}

### Subnets
resource "oci_core_subnet" "these" {
  for_each                   = { for subnet in local.subnets : "${subnet.vcn_name}.${subnet.subnet_key}" => subnet }
    display_name             = each.value.display_name
    vcn_id                   = oci_core_vcn.poc_vcn[each.value.vcn_name].id
    cidr_block               = each.value.cidr
    compartment_id           = each.value.compartment_id
}
