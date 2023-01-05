variable "function_name" {
    type = string
}

variable "source_file_path" {
    type = string
}

variable "handler_file_name" {
    type = string
}

variable "iam_role_arn" {
    type = string
}

variable "api_gateway_api_id" {
    type = string
}

variable "api_gateway_api_root_resource_id" {
    type = string
}

variable "api_gateway_path" {
    type = string
}

variable "api_gateway_method" {
    type = string
}

variable "myregion" {
    type = string
    default = "ap-southeast-1"
}

variable "aws_account_id" {
    type = string
}

variable "api_key_required" {
    type = bool
    default = true
}