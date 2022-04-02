terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }
  }
}

module "main" {
  source = "../.."
}

resource "test_assertions" "random_uuid" {
  component = "random_uuid"

  check "random_uuid_exists" {
    description = "random uuid length greater than 0"
    condition   = can(length(module.main.random_uuid.result) > 0)
  }

  equal "random_uuid_pass" {
    description = "random uuid fields are available in outputs"
    got         = keys(module.main.random_uuid)
    want        = ["id", "keepers", "result"]
  }
}
