variable "vpc_cidr" {
 type = string
 default = ""
}

# variable "subnet_cidr" {
#   type = string
#   default = ""
# }

variable "route_tables" {
  type = map(object({
      vpc_id = string
      cidr_block = string
      subnet_type = string
  }))
}

# variable "route_type" {
#   type = string
#   default = ""
# }

# variable "subnets" {
#   type = list(string)
# }