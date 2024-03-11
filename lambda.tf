# Define IAM role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda_s3_full_access_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach a policy to the IAM role for full S3 access
resource "aws_iam_role_policy_attachment" "lambda_s3_full_access_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess" # Full access to S3
  role       = aws_iam_role.lambda_role.name
}

#Create Lambda function
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "code.py"
  output_path = "Outputs/lambda.zip"
}
resource "aws_lambda_function" "example_lambda" {
  function_name = "lambda-terraform-jenkins"
  handler       = "code.lambda_handler"
  runtime       = "python3.8"
  filename      = "Outputs/lambda.zip" # Change to your Lambda function code package
  role          = aws_iam_role.lambda_role.arn
}
