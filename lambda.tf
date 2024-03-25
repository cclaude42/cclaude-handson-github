data "archive_file" "lambda_archives" {
  for_each = var.lambda_functions

  type        = "zip"
  source_dir  = each.value.source_code_path
  output_path = "${each.key}.zip"
}


resource "aws_lambda_function" "lambda_functions" {
  for_each = var.lambda_functions

  function_name = each.value.function_name
  handler       = each.value.handler
  runtime       = "python3.11"
  memory_size   = 128
  timeout       = 30

  role = aws_iam_role.handson.arn

  filename         = data.archive_file.lambda_archives[each.key].output_path
  source_code_hash = filebase64sha256(data.archive_file.lambda_archives[each.key].output_path)
  depends_on  = [data.archive_file.lambda_archives]

}
