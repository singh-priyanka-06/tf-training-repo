# creating s3_bucket
resource "aws_s3_bucket" "lambda_code_bucket" {
  bucket = var.s3_bucket_lambda
}

#archive the file/folder written in python under lambda-code folder.
data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "/tmp/lambda_zip.zip"
  source_dir = "lambda-code/"
}

#Uploading the file in s3 location(key) which is zipped in data archive_file on line 7.
resource "aws_s3_bucket_object" "lambda_code" {
  key        = "code/python.zip"
  bucket     = aws_s3_bucket.lambda_code_bucket.id
  source     = data.archive_file.lambda_zip.output_path
  etag       = data.archive_file.lambda_zip.output_base64sha256
}

#creates iam role for lambda function(mandatory)..
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda-new"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# creates lambda function.
# tUses the s3 zip code which is uploaded using aws_s3_bucke_object resource.
# IAM role created above is attached to the lambda function.
resource "aws_lambda_function" "demo_lambda" {
  function_name = "demo-lambda"
  role = aws_iam_role.iam_for_lambda.arn
  handler = "python.lambda_handler"    #name_of_file.function_name_in_file
  runtime = "python3.7"
  s3_bucket = aws_s3_bucket.lambda_code_bucket.id
  s3_key = aws_s3_bucket_object.lambda_code.id
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}