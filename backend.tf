terraform {
  backend "s3" {
    bucket = "cclaude-handson-ci-2"
    key    = "handons/api-gateway/terraform.tfstates"
    region = "eu-west-1"
  }
}

