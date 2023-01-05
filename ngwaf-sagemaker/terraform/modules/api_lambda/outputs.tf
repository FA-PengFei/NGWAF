output "invoke_arn" {
    value = aws_lambda_function.lambda_func.invoke_arn
}

output "function_name" {
    value = var.function_name
}

output "function_arn" {
    value = aws_lambda_function.lambda_func.arn
}

output "api_method" {
    value = aws_api_gateway_method.api_method
}

output "api_integration" {
    value = aws_api_gateway_integration.apigateway_integration
}