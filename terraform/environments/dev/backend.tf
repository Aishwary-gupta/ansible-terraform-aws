terraform {
  backend "s3" {
    bucket         = "tf-state-ansible-web-866435873023"
    key            = "environments/dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "tf-state-locks"
    encrypt        = true
  }
}