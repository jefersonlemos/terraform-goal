variable subnet_private {
  type        = list[string]
  default     = [ "subnet1", "subnet2", "subnet3", "subnet4" ]
  description = "Subnets list"
}
