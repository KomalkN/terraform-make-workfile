# =============================================================================

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-dev-1" # Change this to a unique bucket name

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_object" "filee" {
  bucket = aws_s3_bucket.my_bucket.id
  key    = "index.html"
  source = "C:/Users/Admin/Desktop/terraform-make/infra/terraform/modules/aws_s3/index.html"
}

resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id

  policy = jsonencode({

    "Version" : "2008-10-17",
    "Id" : "PolicyForCloudFrontPrivateContent",
    "Statement" : [
      {
        "Sid" : "AllowCloudFrontServicePrincipal",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "cloudfront.amazonaws.com"
        },
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::my-bucket-dev-1/*",
        "Condition" : {
          "StringEquals" : {
            "AWS:SourceArn" : "arn:aws:cloudfront::767397793170:distribution/${aws_cloudfront_distribution.my_distribution.domain_name.id}"
          }
        }
      }
    ]
  })
}