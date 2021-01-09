provider "aws" {
  region = "eu-west-2"
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["data_engineering_vpc_eu_west_2"]
  }
}

data "aws_db_subnet_group" "vpc_subnet_group" {
  name = "data_engineering_subnet_group_eu_west_2"
}

output "database_endpoint" {
  value = module.pgdb.database_endpoint
}

output "database_password" {
  value = module.pgdb.database_password
}
output "database_port" {
  value = module.pgdb.database_port
}
output "database_name" {
  value = module.pgdb.database_name
}

module "pgdb" {
  source              = "./tf_modules"
  database_identifier = "depgdb"
  vpc_id              = data.aws_vpc.vpc.id
  subnet_group        = data.aws_db_subnet_group.vpc_subnet_group.id
  project             = "Data Engineering"
  environment         = "Seminar-Playground"
  publicly_accessible = true
}
