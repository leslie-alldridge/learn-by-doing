locals {
  rg_string = "rg-d-lxr-aus-app1"
  // Use split by "-" to create an array so we can use contains()
  is_rg           = contains(split("-", local.rg_string), "rg")
  final_rg_string = local.is_rg ? replace(local.rg_string, "aus-", "") : local.rg_string

  not_rg_string       = "blah-d-lxr-aus-app1"
  is_not_rg           = contains(split("-", local.not_rg_string), "rg")
  final_not_rg_string = local.is_not_rg ? replace(local.not_rg_string, "aus-", "") : local.not_rg_string
}
