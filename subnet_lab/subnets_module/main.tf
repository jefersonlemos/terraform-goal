resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

}

resource "aws_internet_gateway" "internet" {
  vpc_id = aws_vpc.main.id
}

# resource "aws_route_table" "project_routes" {
  #TODO - Here maybe add a for_each too, so it can interact over multiple VPCs if needed
  # and create route table in different VPCs
  # vpc_id = aws_vpc.main.id
  
  # dynamic "route" {
  #   for_each = var.route_tables
  #   content {
  #       cidr_block = route.value.cidr_block
  #       gateway_id  = route.value.gateway_id
  #   }
  # }
  #It creates multiple routes into the same route table, now I want to create multiple route_tables and multiple
  #routes within


data "aws_route_tables" "route-private" {
  vpc_id = aws_vpc.main.id

  filter {
    name   = "tag:Subnet_type"
    values = ["private"]
  }
}

data "aws_route_tables" "route-public" {
  vpc_id = aws_vpc.main.id

  filter {
    name   = "tag:Subnet_type"
    values = ["public"]
  }
}

resource "aws_subnet" "main" {
  for_each = var.route_tables
  vpc_id      = aws_vpc.main.id
  cidr_block  = each.value.cidr_block
}

resource "aws_route_table_association" "this" {
  for_each  = var.route_tables
  subnet_id = aws_subnet.main[each.value.cidr_block].id
  route_table_id = each.value.subnet_type == "private" ? one(data.aws_route_tables.route-private.ids) : one(data.aws_route_tables.route-public.ids)
}
