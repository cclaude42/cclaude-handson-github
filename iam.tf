locals {
  lambda_arns = [for function in aws_lambda_function.lambda_functions : function.arn]
}

resource "aws_iam_role" "handson" {
  name = var.name_role

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": ["lambda.amazonaws.com","apigateway.amazonaws.com"]
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "handson" {
  role = aws_iam_role.handson.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "policy" {
  # for_each = var.lambda_functions
  name        = "policy_apigateway"
  path        = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "lambda:InvokeFunction",
        ]
        Effect   = "Allow"
        Resource =  local.lambda_arns
      },
      {
        Action = [
          "execute-api:Invoke"
        ]
        Effect   = "Allow"
        Resource =  aws_api_gateway_rest_api.handson.arn
      },

      
    ]
  })
    depends_on  = [aws_lambda_function.lambda_functions]

}

resource "aws_iam_role_policy_attachment" "api_gateway" {
  role = aws_iam_role.handson.name

  policy_arn = aws_iam_policy.policy.arn
}