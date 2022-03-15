provider "aws" {
  region     = "us-east-1"
  access_key = "123"
  secret_key = "123"
  #123
}

resource "aws_s3_bucket" "example" {
    bucket = "practices3-creation-second" 
      tags = {
    Name        = "My bucket"
    Environment = "Dev"
     key    = "first bucket"
  }
  
 
}

resource "aws_s3_bucket_object" "file_upload" {
  bucket = aws_s3_bucket.example.id
  key    = "first bucket"
  source = "photos/beach.jpg"
  content_type = "image/jpeg"
  
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}



resource "aws_s3_bucket_policy" "my-s3-read-policy" {
  bucket = aws_s3_bucket.example.id
  policy = data.aws_iam_policy_document.s3_read_permissions.json
}


data "aws_iam_policy_document" "s3_read_permissions" {
  statement {
   principals {
      type        = "AWS"
      identifiers = ["*"]
    }

 
    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:ListBucket",
    ]

    resources = ["arn:aws:s3:::practices3-creation-second",
                  "arn:aws:s3:::practices3-creation-second/*"
    ]
  }
}







