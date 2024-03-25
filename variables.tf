variable "name_role" {

}
variable "region" {

}


variable "routes" {
  type = map(object({
    method = string
    path   = string
  }))
}
variable "lambda_functions" {
  type = map(object({
    function_name    = string
    handler          = string
    source_code_path = string
  }))
}