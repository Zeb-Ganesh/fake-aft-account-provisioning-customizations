resource "aws_iam_role" "lambda_exec" {
  name = "acme-provisioning-lambda"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRole"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
  tags = local.mandatory_tags
}

resource "aws_lambda_function" "p39_p48_lambda" {
  function_name = "acme-provisioning-hook"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "index.handler"
  runtime       = "python3.12"
  filename      = "hook.zip"
  environment {
    variables = {
      DB_PASSWORD = "SuperSecret123!"
    }
  }
  tags = local.mandatory_tags
}
