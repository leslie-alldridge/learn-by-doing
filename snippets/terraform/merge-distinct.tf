locals {
  input           = { mykey = ["item1", "item2", "item3"] }
  input2          = { mykey = ["item4", "item5", "item6"] }
  merged          = concat(local.input.mykey, local.input2.mykey)
  merged_distinct = distinct(concat(local.input.mykey, local.input2.mykey))
}
