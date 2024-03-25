terraform {
  backend "s3" {
    bucket = "backend-test-terraform"
    key    = "handons/api-gateway/terraform.tfstates"
    region = "eu-west-1"
  }
}

