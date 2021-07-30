#To create VPC
resource "aws_vpc" "vpc_iac" {
  cidr_block                       = "10.7.0.0/16"
  enable_dns_hostnames             = "true"
  assign_generated_ipv6_cidr_block = true
  tags = {
    "Name" = "vpc_iac"
  }
}


#To create Subnet
resource "aws_subnet" "sub_iac_priv" {
  count                   = length(var.private_subnets)
  vpc_id                  = aws_vpc.vpc_iac.id
  availability_zone       = var.availability_zones[count.index]
  cidr_block              = var.private_subnets[count.index]
  map_public_ip_on_launch = "false"

  tags = {
    Name = "${var.base_name["subn_priv"]}_${aws_vpc.vpc_iac.tags.Name}_${count.index + 1}"
  }
}

resource "aws_subnet" "sub_iac_publ" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.vpc_iac.id
  availability_zone       = var.availability_zones[count.index]
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${var.base_name["subn_publ"]}_${aws_vpc.vpc_iac.tags.Name}_${count.index + 1}"
  }
}

#Associar DHCP a VPC
resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  depends_on = [
    aws_vpc.vpc_iac
  ]
  vpc_id          = aws_vpc.vpc_iac.id
  dhcp_options_id = "dopt-171f546d"
}

resource "aws_internet_gateway" "ig_iac" {
  depends_on = [
    aws_vpc.vpc_iac
  ]
  vpc_id = aws_vpc.vpc_iac.id

  tags = {
    Name = "ig_iac"
  }
}


#Criar route table publica
resource "aws_route_table" "rt_iac_pub01" {
  depends_on = [
    aws_vpc.vpc_iac
  ]
  vpc_id = aws_vpc.vpc_iac.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_iac.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.vpc_ipv6_resource.id
  }

  tags = {
    Name = "rt_iac_pub01"
  }
}

#Criar route table privada
resource "aws_route_table" "rt_iac_priv01" {
  depends_on = [
    aws_vpc.vpc_iac
  ]
  vpc_id = aws_vpc.vpc_iac.id

  tags = {
    Name = "rt_iac_priv01"
  }
}

#Associar subnets publicas a route table
resource "aws_route_table_association" "rt_association_iac_pub" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.sub_iac_publ[count.index].id
  route_table_id = aws_route_table.rt_iac_pub01.id
}

#Associar subnets privadas a route table
resource "aws_route_table_association" "rt_association_iac_priv" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.sub_iac_priv[count.index].id
  route_table_id = aws_route_table.rt_iac_priv01.id
}


resource "aws_egress_only_internet_gateway" "vpc_ipv6_resource" {
  vpc_id = aws_vpc.vpc_iac.id
  tags = {
    Name = "vpc_ipv6_resource"
  }
}