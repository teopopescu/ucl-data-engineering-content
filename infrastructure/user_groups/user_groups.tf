provider "aws" {
  region = "eu-west-2"
}

module "user_groups" {
  source = "./tf_modules"
}
