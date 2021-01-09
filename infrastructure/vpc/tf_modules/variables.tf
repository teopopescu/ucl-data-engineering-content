variable "region" {
  default = "eu-west-2"
}
variable "availabilityZones" {
  default = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}
variable "instanceTenancy" {
  default = "default"
}
variable "dnsSupport" {
  default = true
}
variable "dnsHostNames" {
  default = true
}
variable "vpcCIDRblock" {
  default = "10.0.0.0/16"
}
variable "subnetCIDRblocks" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", ]
}
variable "destinationCIDRblock" {
  default = "0.0.0.0/0"
}
variable "ingressCIDRblock" {
  type    = list(any)
  default = ["0.0.0.0/0"]
}
variable "egressCIDRblock" {
  type    = list(any)
  default = ["0.0.0.0/0"]
}
variable "mapPublicIP" {
  default = true
}
variable "subnetNames" {
  type    = list(any)
  default = ["vpc_subnet_eu_west_2a", "vpc_subnet_eu_west_2b", "vpc_subnet_eu_west_2c"]
}
variable "routeTableNames" {
  type    = list(any)
  default = ["vpc_route_table_eu_west_2a", "vpc_route_table_eu_west_2b", "vpc_route_table_eu_west_2c"]
}
variable "vpcName" {
  type    = string
  default = "data_engineering_vpc_eu_west_2"
}
variable "securityGroupName" {
  type    = string
  default = "sg"
}
# end of variables.tf
