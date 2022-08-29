provider "aws" {
  region = "us-east-1"
}

###################################################
# SSH Key Pairs
###################################################

module "rsa_4096" {
  source = "../../modules/ssh-key"
  # source  = "tedilabs/ec2/aws//modules/ssh-key"
  # version = "~> 0.2.0"

  name       = "example-rsa-4096"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQClYzULAOUYVObZSWDgVH4yPfgBoSmYuc9mdrodHEutiTsEo0HwReeP4ljo6tc4kVC6EkNs53mpknT8WAgfHwoucY0ATlneCZub9TfyliUdsIjgUyhCHqDEj4fpXHXP4y4MX2lSoXnhjem9vOUjxDf0ZfGpsopXAVsbYBYZBGhGUzOycVRyjtn+rKd+ZePoTTl5mXA9Za+zz5dWOjtczE/FzzGHOrA/QA3b+FwY3tN8pJ96bHiFnmLIkKqJR9K7Q/+8AlXU1xQeqD4PxZBoD4fXoRX2UaVj9Z2KiTJYmPyrRq8panRZ9ZV9r+JhKYhhSsapYjOCwNEfv/so6+r9kbT7i50Y/d2atEP0sH4THXe4225Fj8wsScO5u8lMhwXqrjUiWFaj5ENtIYmIVJO+D33q+N8o9wB+Xwry9BhI/wE5pH6mcwtkEFepRN7c0akilCmU5DzBlsTTUBmurriv3sSMQX26RyHVZ7g7T6MZ6F0/rWwArqUjNwwSGO3XpJsVLmgpGVTl3baAF7vViNf0i/4GqK4AhtmsLqkv9F6A7J1lPmyULM2lvz18zkv5BjXOJR+u18Lf9in2jNxDLKlTlSFHLLnkhPS8+7pYkFo0jdMLzX7GfmY/EyWNrahWD1mx1gKJsMy9b7fko4Nneb/3PiIdCWD2OzNOlXBBWxX3yTDxWw=="

  tags = {
    "project" = "terraform-aws-ec2-examples"
  }
}

module "ed25519" {
  source = "../../modules/ssh-key"
  # source  = "tedilabs/ec2/aws//modules/ssh-key"
  # version = "~> 0.2.0"

  name       = "example-ed25519"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHzxdX2KjdjjkYHzj/0DreWyZDRFtLI8TZzbVZtkUJsn"

  tags = {
    "project" = "terraform-aws-ec2-examples"
  }
}
