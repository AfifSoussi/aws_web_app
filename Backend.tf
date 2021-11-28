terraform {
  required_version = ">= 0.12.0"
  required_providers {
    aws = {
      version = ">= 3.67"
    }
  }

  backend "s3" {
    bucket = "terraform-states-afif"
    key    = "states/terraform-test.tfstate"
    region = "eu-central-1"
    encrypt    = true
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-central-1"
  shared_credentials_file = "C:/Users/Soussi/.aws/credentials"
}


