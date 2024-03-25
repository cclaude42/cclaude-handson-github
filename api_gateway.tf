
resource "aws_api_gateway_rest_api" "handson" {
  name        = "handson-api"
  description = "handson API"
}

resource "aws_api_gateway_resource" "root" {
  rest_api_id = aws_api_gateway_rest_api.handson.id
  parent_id   = aws_api_gateway_rest_api.handson.root_resource_id
  path_part   = "v1"
}

resource "aws_api_gateway_resource" "handson" {
  for_each = var.routes
  rest_api_id = aws_api_gateway_rest_api.handson.id
  parent_id   = aws_api_gateway_resource.root.id
  path_part   = each.value.path
}

resource "aws_api_gateway_method" "route_methods" {
  for_each = var.routes

  rest_api_id   = aws_api_gateway_rest_api.handson.id
  resource_id   = aws_api_gateway_resource.handson[each.key].id
  http_method   = each.value.method
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  for_each = var.routes

  rest_api_id             = aws_api_gateway_rest_api.handson.id
  resource_id             = aws_api_gateway_resource.handson[each.key].id
  http_method             = aws_api_gateway_method.route_methods[each.key].http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_functions[each.key].invoke_arn
  credentials             = aws_iam_role.handson.arn
}

resource "aws_api_gateway_method_response" "route_method_responses" {
  for_each = var.routes

  rest_api_id = aws_api_gateway_rest_api.handson.id
  resource_id = aws_api_gateway_resource.handson[each.key].id
  http_method = aws_api_gateway_method.route_methods[each.key].http_method
  status_code = 200
}

resource "aws_api_gateway_deployment" "handson_deployment" {
  depends_on  = [aws_api_gateway_integration.lambda_integration, data.archive_file.lambda_archives, aws_lambda_function.lambda_functions]
  rest_api_id = aws_api_gateway_rest_api.handson.id
  stage_name  = "prod"
}

output "api_gateway_urls" {
  value = { for key, value in var.routes : key => "${aws_api_gateway_deployment.handson_deployment.invoke_url}/v1/${value.path}" }
}