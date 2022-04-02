terraform {
  backend "local" {}
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }
    http = {
      source = "hashicorp/http"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

resource "random_uuid" "random_uuid" {
}

output "random_uuid" {
  value = random_uuid.random_uuid
}
