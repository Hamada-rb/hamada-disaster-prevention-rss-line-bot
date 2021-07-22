resource "aws_lambda_function" "hamada_disaster_prevention_rss_line_bot" {
  function_name = "hamada_disaster_prevention_rss_line_bot"

  filename = "${path.module}/lambda.zip"

  handler     = "lambda_function.lambda_handler"
  role        = aws_iam_role.hamada_disaster_prevention_rss_line_bot_role.arn
  runtime     = "ruby2.7"
  timeout     = 300
  memory_size = 128
  environment {
    variables = {
      LINE_CHANNEL_SECRET = "${var.line_channel_secret}"
      LINE_CHANNEL_TOKEN  = "${var.line_channel_token}"
    }
  }
}

resource "aws_cloudwatch_log_group" "hamada_disaster_prevention_rss_line_bot_log_group" {
  name              = "/aws/lambda/hamada_disaster_prevention_rss_line_bot"
}

resource "aws_iam_role" "hamada_disaster_prevention_rss_line_bot_role" {
  name               = "hamada_disaster_prevention_rss_line_bot_role"
  path               = "/service-role/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
