resource "aws_s3_bucket" "terraform_state" {
  bucket = "youngyz1-terraform-state"
  tags = {
    Name = "Terraform State"
  }
}
