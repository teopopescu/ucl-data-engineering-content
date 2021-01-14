provider "aws" {
  region = "eu-west-2"
}

module "dynamodb" {
  source = "./tf_modules"
}
