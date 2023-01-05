data "archive_file" "lambda_zip" {
  type = "zip"
  source_file = "${var.source_file_path}"
  output_path = "lambda_packaged/${var.function_name}.zip"
}

resource "aws_lambda_function" "lambda_func" {
  # If the file is not in the current working directory you will need to include a 
  # path.module in the filename.
  filename      = "lambda_packaged/${var.function_name}.zip"
  function_name = "${var.function_name}"
  role          = var.iam_role_arn
  handler       = "${var.handler_file_name}.lambda_handler"

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime = "python3.9"
}

# API Endpoint Setup

resource "aws_api_gateway_resource" "apigateway_endpoint" {
  path_part   = var.api_gateway_path
  parent_id   = var.api_gateway_api_root_resource_id
  rest_api_id = var.api_gateway_api_id
}

resource "aws_api_gateway_method" "api_method" {
  rest_api_id   = var.api_gateway_api_id
  resource_id   = aws_api_gateway_resource.apigateway_endpoint.id
  http_method   = var.api_gateway_method
  authorization = "NONE"
  api_key_required = var.api_key_required
}

resource "aws_api_gateway_integration" "apigateway_integration" {
  rest_api_id             = var.api_gateway_api_id
  resource_id             = aws_api_gateway_resource.apigateway_endpoint.id
  http_method             = aws_api_gateway_method.api_method.http_method
  # https://stackoverflow.com/questions/41371970/accessdeniedexception-unable-to-determine-service-operation-name-to-be-authoriz
  # Lambda only integrates via POST
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_func.invoke_arn
}

resource "aws_lambda_permission" "apigw_lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.myregion}:${var.aws_account_id}:${var.api_gateway_api_id}/*/${aws_api_gateway_method.api_method.http_method}${aws_api_gateway_resource.apigateway_endpoint.path}"
}