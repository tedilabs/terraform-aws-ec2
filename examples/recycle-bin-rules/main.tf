provider "aws" {
  region = "us-east-1"
}


###################################################
# Recycle Bin Retention Rules
###################################################

# Retain all AMIs in the region. (`EXCLUSION` mode without tags by default)
module "image" {
  source = "../../modules/recycle-bin-rule"
  # source  = "tedilabs/ec2/aws//modules/recycle-bin-rule"
  # version = "~> 0.2.0"

  name          = "example-image"
  description   = "Retain deregistered AMIs for 14 days."
  resource_type = "EC2_IMAGE"

  retention_period = 14

  # WARNING: A locked rule can't be modified or deleted (even by `terraform destroy`)
  # until it is unlocked and the unlock delay expires.
  # lock = {
  #   enabled      = true
  #   unlock_delay = 7
  # }

  tags = {
    "project" = "terraform-aws-ec2-examples"
  }
}

# Retain all snapshots in the region, except temporary ones. (`EXCLUSION` mode)
module "snapshot" {
  source = "../../modules/recycle-bin-rule"
  # source  = "tedilabs/ec2/aws//modules/recycle-bin-rule"
  # version = "~> 0.2.0"

  name          = "example-snapshot"
  description   = "Retain deleted snapshots for 7 days, except temporary ones."
  resource_type = "EBS_SNAPSHOT"

  retention_period = 7

  filter = {
    mode = "EXCLUSION"
    resource_tags = {
      "Temp" = "true"
    }
  }

  tags = {
    "project" = "terraform-aws-ec2-examples"
  }
}

# Retain critical volumes only. (`INCLUSION` mode)
module "volume" {
  source = "../../modules/recycle-bin-rule"
  # source  = "tedilabs/ec2/aws//modules/recycle-bin-rule"
  # version = "~> 0.2.0"

  name          = "example-volume"
  description   = "Retain deleted critical volumes for 3 days."
  resource_type = "EBS_VOLUME"

  retention_period = 3

  filter = {
    mode = "INCLUSION"
    resource_tags = {
      "Critical" = "true"
    }
  }

  tags = {
    "project" = "terraform-aws-ec2-examples"
  }
}
