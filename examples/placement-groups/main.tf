provider "aws" {
  region = "us-east-1"
}

###################################################
# Placement Groups
###################################################

module "cluster" {
  source = "../../modules/placement-group"
  # source  = "tedilabs/ec2/aws//modules/placement-group"
  # version = "~> 0.1.0"

  name     = "cluster"
  strategy = "CLUSTER"

  tags = {
    "project" = "terraform-aws-ec2-examples"
  }
}

module "partition" {
  source = "../../modules/placement-group"
  # source  = "tedilabs/ec2/aws//modules/placement-group"
  # version = "~> 0.1.0"

  name           = "partition"
  strategy       = "PARTITION"
  partition_size = 4

  tags = {
    "project" = "terraform-aws-ec2-examples"
  }
}

module "spread" {
  source = "../../modules/placement-group"
  # source  = "tedilabs/ec2/aws//modules/placement-group"
  # version = "~> 0.1.0"

  name         = "spread"
  strategy     = "SPREAD"
  spread_level = "RACK"

  tags = {
    "project" = "terraform-aws-ec2-examples"
  }
}
