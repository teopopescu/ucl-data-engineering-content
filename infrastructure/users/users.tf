provider "aws" {
  region = "eu-west-2"
}

output "users_details" {
  value = module.users_module.users_details
}
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

module "users_module" {
  source = "./tf_modules"
}
