provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.bucket_name}"
  region = "${var.region}"
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
}
