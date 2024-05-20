provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
        Name = "Production"
        Description = "Terraform Labs"
        Created_By = "Terraform"    
    }
  }
}

variable "subnets" {
  type = list(string)
  default = [ "10.0.20.0/24", "10.0.30.0/24" ]
}

module "network" {
  source = "../subnets_module"
  vpc_cidr = var.vpc_cidr

  # subnets = var.subnets

  route_tables = {
    "10.0.10.0/24" = {
      vpc_id = module.network.vpc_id
      cidr_block = "10.0.10.0/24"
      subnet_type = "private"
    }
    "10.0.20.0/24" = {
      vpc_id = module.network.vpc_id
      cidr_block = "10.0.20.0/24"
      subnet_type = "public"
    } 
  }

  # route_tables = {
  #   "public_1" = {
  #      vpc_id = module.network.vpc_id
  #      cidr_block = "0.0.0.0/0"
  #      gateway_id = module.network.gateway_id     
  #      route_type = "public"
  #   }
  #   "public_2" = {
  #      vpc_id = module.network.vpc_id
  #      cidr_block = "200.147.3.157/32"
  #      gateway_id = module.network.gateway_id
  #      route_type = "public"
  #   }
  # }



}
