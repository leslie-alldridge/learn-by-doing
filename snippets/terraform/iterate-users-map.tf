locals {
  service_principal = {
    admin = ["dpaf2-dev-sa"]
    dev   = []
    ops = [
      "dpaf2-dev-sa",
      "dpaf2-iacda-app-id",
    ]
  }
  users = {
    admin = [
      "oleh_mykolaishyn@gmail.com",
      "yevhen_plaksa@gmail.com"
    ]
    dev = [
      "yevhen_plaksa@gmail.com"
    ]
    ops = [
      "oleksandr_gorkun@gmail.com"
    ]
  }
  result = flatten([for role in keys(local.users) : [for user in local.users[role] :
  { role = role, user = user, principals = local.service_principal[role] }]])
}

resource "null_resource" "users" {
  count = length(local.result)
  provisioner "local-exec" {
    command = "echo user: $USER has role: $ROLE and principals: $SERVICE_PRINCIPAL >> ouput.txt"

    environment = {
      USER              = local.result[count.index].user
      ROLE              = local.result[count.index].role
      SERVICE_PRINCIPAL = join(", ", local.result[count.index].principals)
    }
  }
}
