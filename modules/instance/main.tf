locals {
  metadata = {
    package = "terraform-aws-ec2"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
  module_tags = var.module_tags_enabled ? {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  } : {}
}


###################################################
# EC2 Instance
###################################################

resource "aws_instance" "this" {
  count = var.spot_enabled ? 0 : 1

  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = var.instance_ssh_key

  # security_groups = [aws_security_group.web.id]
  # subnet_id     = tolist(data.aws_subnet_ids.my-subnets.ids)[0]

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}

resource "aws_spot_instance_request" "this" {
  count = var.spot_enabled ? 1 : 0

  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = var.instance_ssh_key

  # security_groups = [aws_security_group.web.id]
  # subnet_id     = tolist(data.aws_subnet_ids.my-subnets.ids)[0]

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
