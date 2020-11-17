terraform {
  backend "s3" {
    bucket = "remote-state-storage-test-lon-aws"
    region = "eu-west-2"
  }
}

provider "aws" {
  region = "eu-west-2"
}
