resource "aws_vpc" "vpc" {
  cidr_block           = var.vpcCIDRblock
  instance_tenancy     = var.instanceTenancy
  enable_dns_support   = var.dnsSupport
  enable_dns_hostnames = var.dnsHostNames

  tags = {
    Name = var.vpcName
  }
}

# create the Subnet
resource "aws_subnet" "vpc_subnet" {
  count                   = 3
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnetCIDRblocks[count.index]
  map_public_ip_on_launch = var.mapPublicIP
  availability_zone       = var.availabilityZones[count.index]

  tags = {
    Name = var.subnetNames[count.index]
  }
} # end resource

# create the subnet group for the database
resource "aws_db_subnet_group" "vpc_subnet_group" {
  name       = "data_engineering_subnet_group_eu_west_2"
  subnet_ids = [aws_subnet.vpc_subnet[0].id, aws_subnet.vpc_subnet[1].id, aws_subnet.vpc_subnet[2].id]

  tags = {
    Name = "data_engineering_subnet_group_eu_west_2"
  }
}

# Create the Security Group
resource "aws_security_group" "vpc_security_group" {
  vpc_id      = aws_vpc.vpc.id
  name        = "vpc_security_group"
  description = "Data Engineering VPC Security Group"

  # allow ingress of port 22
  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "security_group"
    Description = "Data Engineering VPC Security Group"
  }
} # end resource


# # create VPC Network access control list
# resource "aws_network_acl" "My_VPC_Security_ACL" {
#   vpc_id = aws_vpc.My_VPC.id
#   subnet_ids = [ aws_subnet.My_VPC_Subnet.id ]
# # allow ingress port 22
#   ingress {
#     protocol   = "tcp"
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = var.destinationCIDRblock
#     from_port  = 22
#     to_port    = 22
#   }

#   # allow ingress port 80
#   ingress {
#     protocol   = "tcp"
#     rule_no    = 200
#     action     = "allow"
#     cidr_block = var.destinationCIDRblock
#     from_port  = 80
#     to_port    = 80
#   }

#   # allow ingress ephemeral ports
#   ingress {
#     protocol   = "tcp"
#     rule_no    = 300
#     action     = "allow"
#     cidr_block = var.destinationCIDRblock
#     from_port  = 1024
#     to_port    = 65535
#   }

#   # allow egress port 22
#   egress {
#     protocol   = "tcp"
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = var.destinationCIDRblock
#     from_port  = 22
#     to_port    = 22
#   }

#   # allow egress port 80
#   egress {
#     protocol   = "tcp"
#     rule_no    = 200
#     action     = "allow"
#     cidr_block = var.destinationCIDRblock
#     from_port  = 80
#     to_port    = 80
#   }

#   # allow egress ephemeral ports
#   egress {
#     protocol   = "tcp"
#     rule_no    = 300
#     action     = "allow"
#     cidr_block = var.destinationCIDRblock
#     from_port  = 1024
#     to_port    = 65535
#   }
# tags = {
#     Name = "My VPC ACL"
# }
# } # end resource

# Create the Internet Gateway
resource "aws_internet_gateway" "vpc_internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "vpc_internet_gateway"
  }
} # end resource

# Create the Route Table
resource "aws_route_table" "vpc_route_table" {
  count  = 3
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.routeTableNames[count.index]
  }
} # end resource
# Create the Internet Access
resource "aws_route" "vpc_internet_access" {
  count                  = 3
  route_table_id         = aws_route_table.vpc_route_table[count.index].id
  destination_cidr_block = var.destinationCIDRblock
  gateway_id             = aws_internet_gateway.vpc_internet_gateway.id
} # end resource
# Associate the Route Table with the Subnet
resource "aws_route_table_association" "vpc_route_table_association" {
  count          = 3
  subnet_id      = aws_subnet.vpc_subnet[count.index].id
  route_table_id = aws_route_table.vpc_route_table[count.index].id
} # end resource
# end vpc.tf

