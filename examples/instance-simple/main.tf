provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}


###################################################
# EC2 Instance
###################################################

module "instance" {
  source = "../../modules/instance"
  # source  = "tedilabs/ec2/aws//modules/instance"
  # version = "~> 0.1.0"

  name          = "simple"
  instance_type = "t2.micro"
  instance_ami  = data.aws_ami.ubuntu.image_id

  tags = {
    "project" = "terraform-aws-ec2-examples"
  }
}
