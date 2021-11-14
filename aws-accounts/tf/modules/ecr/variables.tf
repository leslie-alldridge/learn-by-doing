variable "name" {
  type        = string
  description = "name of ECR repository"
}

variable "scan" {
    type = bool
    description = "scan on push"
}

variable "mutability" {
    type = string
    description = "MUTABLE or IMMUTABLE are accepted values"
}
