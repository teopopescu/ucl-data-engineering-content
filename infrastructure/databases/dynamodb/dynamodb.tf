provider "aws" {
  region = "eu-west-2"
}

# data "aws_vpc" "de_vpc" {
#   filter {
#     name   = "tag:Name"
#     values = ["data_engineering_vpc_eu_west_2"]
#   }
# }

# data "aws_db_subnet_group" "de_vpc_subnet_group" {
#   name = "subnet_group_eu_west_2"
# }

module "dynamodb" {
  # source              = "./tf_modules"
  # database_identifier = "depgdb"
  # vpc_id              = data.aws_vpc.se_vpc.id
  # subnet_group        = data.aws_db_subnet_group.se_vpc_subnet_group.id
  # project             = "Software Engineering"
  # environment         = "Seminar-Playground"
  # publicly_accessible = true
}
