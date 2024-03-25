terraform {
  backend "s3" {
    bucket = "cclaude-handson-ci"
    key    = "handons/api-gateway/terraform.tfstates"
    region = "eu-west-1"
  }
}

