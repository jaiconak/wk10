terraform {
  backend "s3" {
    bucket         = "terraform-backend-jaico"
    key            = "dev/terraform.tfstate" #This is where the path where terraform stores the statefile 
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}