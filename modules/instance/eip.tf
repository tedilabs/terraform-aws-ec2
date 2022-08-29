###################################################
# EIP Associations to the Instance
###################################################

# TODO: Support multi-eni
resource "aws_eip_association" "this" {
  for_each = {
    for association in var.eip_associations :
    association.eip => association
  }

  allocation_id = each.key

  network_interface_id = (var.spot_enabled
    ? aws_spot_instance_request.this[0].primary_network_interface_id
    : aws_instance.this[0].primary_network_interface_id
  )
  private_ip_address = try(each.value.private_ip, null)
}
