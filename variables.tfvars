name_role = "role_lambda"
region    = "eu-west-1"
routes = {
  handson = {
    method = "GET",
    path   = "handson"
  },
  hello_world = {
    method = "GET",
    path   = "helloworld"
  }
}

lambda_functions = { handson = {
  function_name    = "handson_lambda"
  handler          = "lambda_function.handler"
  source_code_path = "lambda/handson/"
  },
  hello_world = {
    function_name    = "hello_world_lambda"
    handler          = "lambda_function.handler"
    source_code_path = "lambda/hello_world/"
  }
}