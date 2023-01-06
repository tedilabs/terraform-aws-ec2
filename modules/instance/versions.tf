terraform {
  required_version = ">= 1.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.49"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = ">= 2.2"
    }
  }
}
