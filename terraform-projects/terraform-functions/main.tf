locals {
  json_data  = jsonencode(file("${path.module}/data.json"))
  rs_capital = upper(local.json_data.capitals.RS)
  rj_capital = lookup(local.json_data.capitals, "RJ", "Rio de Janeiro")
}

