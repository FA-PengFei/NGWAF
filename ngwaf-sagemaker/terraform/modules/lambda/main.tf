data "archive_file" "lambda_zip" {
  type = "zip"
  source_file = "${var.source_file_path}"
  output_path = "lambda_packaged/${var.function_name}.zip"
}

resource "aws_lambda_function" "lambda_func" {
  filename      = "lambda_packaged/${var.function_name}.zip"
  function_name = "${var.function_name}"
  role          = var.iam_role_arn
  handler       = "${var.handler_file_name}.lambda_handler"

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime = "python3.9"
}