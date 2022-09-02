locals {
  sql = join(",", [
    "id string",
    "name string",
    "address string",
    "renter string",
    "profession string"
  ])
}
