terraform {
  backend "s3" {
    bucket = "tf-state-production"
    key    = "terraform-projects/ecs-python-docker/state"
    region = "ap-southeast-2"
  }
}

provider "aws" {
  region = "ap-southeast-2"
  default_tags {
    tags = {
      environment = local.environment
      respository = local.service_name
    }
  }
}

locals {
  service_name = "ecs-python-docker"
  environment  = "production"
}

// Build docker image
// TODO: docker installation corrupt - needs fixing
resource "null_resource" "docker_build" {
  provisioner "local-exec" {
    command     = "docker build ../../../app/Dockerfile"
    interpreter = ["bash", "-e"]
  }
}
