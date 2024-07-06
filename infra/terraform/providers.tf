#Provider:----------------------------------
#provider "aws" {
#  access_key = "AKIA3FLDZBWJP3TEXQGR"
# secret_key = "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"
#}

terraform {
  backend "s3" {
    bucket = "tf-bucket-demo-1"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}
