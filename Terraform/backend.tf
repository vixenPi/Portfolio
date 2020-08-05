terraform {
  backend "s3" {
    bucket  = "alexandra-neubauer-terraform-state"
    key     = "terraform"
    region  = "us-east-2"
    profile = "personal"
  }
}
