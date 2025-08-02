terraform {
    required_version = "1.12.2"
  required_providers {
    aws = {
        source  = "hashicorp/aws"
    version = "6.5.0"
    }
  }
  backend "s3" {
  bucket = "git-jenkins-terraform-intigration-state-bucket"
  key = "terraform.tfstate"
  region = "ap-south-1"
  dynamodb_table = "git-jenkins-terraform-intigration-table"
 }
}

provider "aws" {
  region = "ap-south-1"
}
