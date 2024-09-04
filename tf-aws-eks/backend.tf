terraform {
  backend "s3" {
    bucket = "jylee-cicd-endtoend"
    key    = "ide/terraform.tfstate"
    region = "ap-northeast-2"
  }
}