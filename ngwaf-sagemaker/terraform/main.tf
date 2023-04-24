# Variables
variable "myregion" {
  type = string
  default = "ap-southeast-1"
}

data "aws_caller_identity" "current" {}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-southeast-1"
  profile = "<insert_aws_profile_here>"
}

# Store Variables in SSM Parameters
resource "aws_ssm_parameter" "ssm_ngwaf_endpoint_name" {
    name = "ngwaf_endpoint_name"
    type = "String"
    value = aws_sagemaker_endpoint.ngwaf_serving_endpoint.name
}

resource "aws_ssm_parameter" "ssm_ngwaf_notebook_name" {
    name = "ngwaf_notebook_name"
    type = "String"
    value = aws_sagemaker_notebook_instance.sagemaker_notebook.name
}

resource "aws_ssm_parameter" "ssm_ngwaf_dynamodb_table_name" {
    name = "ngwaf_dynamodb_table_name"
    type = "String"
    value = var.ngwaf_dynamo_table_name
}

resource "aws_ssm_parameter" "ssm_ngwaf_bucket_name" {
    name = "ngwaf_bucket_name"
    type = "String"
    value = module.s3_sagemaker.bucket_name
}

resource "aws_ssm_parameter" "ssm_ngwaf_state_machine_arn" {
    name = "ngwaf_state_machine_arn"
    type = "String"
    value = aws_sfn_state_machine.state_function_terraform.arn
}

# Comment this after future runs
resource "aws_ssm_parameter" "ssm_ngwaf_should_notebook_start" {
    name = "ngwaf_should_notebook_start"
    type = "String"
    value = "FALSE"
}

resource "aws_ssm_parameter" "ssm_ngwaf_notebook_script_bucket" {
    name = "ngwaf_notebook_script_bucket_name"
    type = "String"
    value = module.s3_ngwaf_notebook_scripts.bucket_name
}

# KMS key used for encryption/decryption
resource "aws_kms_key" "ngwaf_cmk_key" {
  description = "CMK Key for Ops"
  key_usage = "ENCRYPT_DECRYPT"
  enable_key_rotation = true
}

module "s3_sagemaker" {
  source = "./modules/s3"

  bucketname = "ngwaf-sagemaker-terraform"
  kms_key_arn = aws_kms_key.ngwaf_cmk_key.arn
}

module "s3_ngwaf_notebook_scripts" {
  source = "./modules/s3"

  bucketname = "ngwaf-notebook-scripts-terraform"
  kms_key_arn = aws_kms_key.ngwaf_cmk_key.arn
}

resource "aws_s3_object" "ngwaf_notebook_script_train_file" {
    bucket = module.s3_ngwaf_notebook_scripts.id
    key = "train.ipynb"
    source = "../train.ipynb"
}

resource "aws_s3_object" "ngwaf_notebook_script_model_file" {
    bucket = module.s3_ngwaf_notebook_scripts.id
    key = "model_v2.py"
    source = "../script/model_v2.py"
}

resource "aws_s3_object" "ngwaf_notebook_script_utils_file" {
    bucket = module.s3_ngwaf_notebook_scripts.id
    key = "utils_v1.py"
    source = "../script/utils_v1.py"
}

resource "aws_s3_object" "ngwaf_notebook_script_boto3_utils_file" {
  bucket = module.s3_ngwaf_notebook_scripts.id
  key = "boto3_utils.py"
  source = "../boto3_utils.py"
}

resource "aws_s3_object" "ngwaf_notebook_script_dignostic_utils_file" {
  bucket = module.s3_ngwaf_notebook_scripts.id
  key = "diagnostic_utils.py"
  source = "../diagnostic_utils.py"
}

module "s3_trainbucket" {
  source = "./modules/s3"

  bucketname = "ngwaf-trainbucket-terraform"
  kms_key_arn = aws_kms_key.ngwaf_cmk_key.arn
}

#TODO: Remove after Testing
# {"train_file_path": "ngwaf-trainbucket-terraform/payload_login_patch.csv"}
resource "aws_s3_object" "upload_patch_file" {
    bucket = module.s3_trainbucket.id
    key = "payload_login_patch.csv"
    source = "../payload_login_patch.csv"
}


# Lambda Functions
module "lambda_sagemaker_all-jobs" {
  source = "./modules/api_lambda"

  function_name = "ngwaf-sagemaker-all-jobs-terraform"
  source_file_path = "../infra/lambda_functions/get_all_job_status.py"
  handler_file_name = "get_all_job_status"
  iam_role_arn = aws_iam_role.lambda_sagemaker_job_status_role_reduced.arn
  api_gateway_api_id = aws_api_gateway_rest_api.api.id
  api_gateway_api_root_resource_id = aws_api_gateway_rest_api.api.root_resource_id
  api_gateway_path = "all-jobs"
  api_gateway_method = "GET"
  aws_account_id = data.aws_caller_identity.current.account_id
  api_key_required = false
}

module "lambda_sagemaker_prediction" {
  source = "./modules/api_lambda"

  function_name = "ngwaf-sagemaker-prediction-terraform"
  source_file_path = "../infra/lambda_functions/sm_serving.py"
  handler_file_name = "sm_serving"
  iam_role_arn = aws_iam_role.lambda_sagemaker_serving_role_reduced.arn
  api_gateway_api_id = aws_api_gateway_rest_api.api.id
  api_gateway_api_root_resource_id = aws_api_gateway_rest_api.api.root_resource_id
  api_gateway_path = "prediction"
  api_gateway_method = "POST"
  aws_account_id = data.aws_caller_identity.current.account_id
}

module "lambda_sagemaker_retrain" {
  source = "./modules/api_lambda"

  function_name = "ngwaf-sagemaker-retrain-terraform"
  source_file_path = "../infra/lambda_functions/retrain_trigger.py"
  handler_file_name = "retrain_trigger"
  iam_role_arn = aws_iam_role.lambda_sagemaker_retrain_role_reduced.arn
  api_gateway_api_id = aws_api_gateway_rest_api.api.id
  api_gateway_api_root_resource_id = aws_api_gateway_rest_api.api.root_resource_id
  api_gateway_path = "retrain"
  api_gateway_method = "POST"
  aws_account_id = data.aws_caller_identity.current.account_id
}

# Step Function Lambda
module "lambda_stepfunction_start_notebook" {
  source = "./modules/lambda"

  function_name = "ngwaf-stepfunction-start-notebook-terraform"
  source_file_path = "../infra/lambda_functions/start_notebook.py"
  handler_file_name = "start_notebook"
  iam_role_arn = aws_iam_role.lambda_start_notebook_role.arn
}

module "lambda_stepfunction_exit_notebook" {
  source = "./modules/lambda"

  function_name = "ngwaf-stepfunction-exit-notebook-terraform"
  source_file_path = "../infra/lambda_functions/exit_notebook.py"
  handler_file_name = "exit_notebook"
  iam_role_arn = aws_iam_role.lambda_stop_notebook_role.arn
}

# Step Function
resource "aws_sfn_state_machine" "state_function_terraform" {
  name     = "retrain_step_function_terraform"
  role_arn = aws_iam_role.stepfunctions_notebook_role.arn

  definition = <<EOF
{
  "Comment": "A description of my state machine",
  "StartAt": "Start notebook",
  "States": {
    "Start notebook": {
      "Type": "Task",
      "Resource": "arn:aws:states:::lambda:invoke",
      "OutputPath": "$.Payload",
      "Parameters": {
        "Payload.$": "$",
        "FunctionName": "${module.lambda_stepfunction_start_notebook.function_arn}"
      },
      "Next": "Wait",
      "Retry": [
        {
          "ErrorEquals": [
            "Lambda.ServiceException",
            "Lambda.AWSLambdaException",
            "Lambda.SdkClientException"
          ],
          "IntervalSeconds": 2,
          "MaxAttempts": 6,
          "BackoffRate": 2
        }
      ]
    },
    "Wait": {
      "Type": "Wait",
      "Seconds": 3600,
      "Next": "End notebook"
    },
    "End notebook": {
      "Type": "Task",
      "Resource": "arn:aws:states:::lambda:invoke",
      "OutputPath": "$.Payload",
      "Parameters": {
        "Payload.$": "$",
        "FunctionName": "${module.lambda_stepfunction_exit_notebook.function_arn}"
      },
      "Retry": [
        {
          "ErrorEquals": [
            "Lambda.ServiceException",
            "Lambda.AWSLambdaException",
            "Lambda.SdkClientException"
          ],
          "IntervalSeconds": 2,
          "MaxAttempts": 6,
          "BackoffRate": 2
        }
      ],
      "End": true
    }
  }
}
EOF
}

variable "ngwaf_dynamo_table_name" {
  type = string
  default = "ngwaf-training-pipeline-terraform"
}

resource "aws_dynamodb_table" "ngwaf_dynamo_db" {
    name = var.ngwaf_dynamo_table_name
    billing_mode = "PROVISIONED"
    read_capacity = 1
    write_capacity = 1
    hash_key = "job_key"

    attribute {
      name = "job_key"
      type  = "S"
    }

    server_side_encryption {
      enabled = true
      kms_key_arn = aws_kms_key.ngwaf_cmk_key.arn
    }

    point_in_time_recovery { 
      enabled = true
    }
}

resource "aws_dynamodb_table_item" "job_status_entry" {
  table_name = var.ngwaf_dynamo_table_name
  hash_key = "job_key"

  item = <<ITEM
{
  "job_key": {"S": "_pipeline_status"},
  "pipeline_available": {"BOOL": true}
}
ITEM

  depends_on = [
    aws_dynamodb_table.ngwaf_dynamo_db
  ]
}

# Sage Maker Notebook
variable "notebookLifeCycleConfigName" {
  type = string
  default = "ngwafNotebookLifecycleConfigTerraform"
}

resource "aws_sagemaker_notebook_instance" "sagemaker_notebook" {
  name = "ngwaf-sagemaker-notebook-terraform"
  role_arn = aws_iam_role.sagemaker_notebook_role_reduced.arn
  instance_type = "ml.t2.medium"
  root_access = "Enabled"
  lifecycle_config_name = var.notebookLifeCycleConfigName
  platform_identifier = "notebook-al2-v2"

  depends_on = [
    aws_ssm_parameter.ssm_ngwaf_should_notebook_start,
    module.s3_ngwaf_notebook_scripts,
    aws_s3_object.ngwaf_notebook_script_train_file,
    aws_s3_object.ngwaf_notebook_script_model_file,
    aws_s3_object.ngwaf_notebook_script_utils_file,
    aws_dynamodb_table_item.job_status_entry
  ]

  kms_key_id = aws_kms_key.ngwaf_cmk_key.key_id
}

resource "aws_sagemaker_notebook_instance_lifecycle_configuration" "lc" {
  name = var.notebookLifeCycleConfigName
  on_start = filebase64("../infra/lifecycle_config.sh")
  on_create = filebase64("../infra/setup_files.sh")
}

# AWS Sagemaker Model
variable "model_artifact_s3_key" {
  type = string
  default = "model/tensorflow-2022-08-08-16-28-07/model.tar.gz"
}

resource "aws_s3_object" "ngwaf_model_artifact" {
    bucket = module.s3_sagemaker.id
    key = var.model_artifact_s3_key
    source = "model_artifact/model.tar.gz"
}

resource "aws_sagemaker_model" "ngwaf_serving_model" {
  name = "ngwaf-serving-model"

  execution_role_arn = aws_iam_role.sagemaker_serving_model_role.arn
  primary_container {
    # Not sure if it works in other regions
    image = "763104351884.dkr.ecr.ap-southeast-1.amazonaws.com/tensorflow-inference:2.8-cpu"
    mode = "SingleModel"
    model_data_url = "s3://${module.s3_sagemaker.id}/${var.model_artifact_s3_key}"
  }
}

resource "aws_sagemaker_endpoint_configuration" "ngwaf_serving_ec" {
  name = "ngwaf-serving-endpoint-config"

  production_variants {
    variant_name           = "variant-1"
    model_name             = aws_sagemaker_model.ngwaf_serving_model.name
    initial_instance_count = 1
    instance_type          = "ml.c5.large"
  }

  kms_key_arn = aws_kms_key.ngwaf_cmk_key.arn
}

resource "aws_sagemaker_endpoint" "ngwaf_serving_endpoint" {
  name = "ngwaf-serving-endpoint"

  endpoint_config_name = aws_sagemaker_endpoint_configuration.ngwaf_serving_ec.name
}

# AWS API Gateway
resource "aws_api_gateway_rest_api" "api" {
  name = "ngwaf_rest_api_terraform"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "api" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api.body))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    module.lambda_sagemaker_all-jobs.api_method,
    module.lambda_sagemaker_all-jobs.api_integration,
    module.lambda_sagemaker_prediction.api_method,
    module.lambda_sagemaker_prediction.api_integration,
    module.lambda_sagemaker_retrain.api_method,
    module.lambda_sagemaker_retrain.api_integration,
  ]
}

resource "aws_api_gateway_stage" "api" {
  deployment_id = aws_api_gateway_deployment.api.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = "terraform_deploy"

  xray_tracing_enabled = true
}

resource "aws_api_gateway_api_key" "apikey" {
  name = "ngwaf_terraform_apikey"
}

resource "aws_api_gateway_usage_plan" "usage_plan" {
  name = "ngwaf_api_gateway_usage_plan"

  api_stages {
    api_id = aws_api_gateway_rest_api.api.id
    stage  = aws_api_gateway_stage.api.stage_name
  }

  throttle_settings {
    burst_limit = 1500
    rate_limit  = 1000
  }
}

resource "aws_api_gateway_usage_plan_key" "usage_plan_key" {
  key_id        = aws_api_gateway_api_key.apikey.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.usage_plan.id
}

resource "aws_cloudwatch_log_group" "sagemaker_serving_logging" {
  name = "lambda_sagemaker_logging"
} 

resource "aws_iam_policy" "stepfunctions_notebook_policy" {
    name = "stepfunctions_notebook_policy_terraform"
    description = "Terraform Stepfunctions Notebook Policy"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "lambda:InvokeFunction"
            ]
            Effect = "Allow"
            Resource = [
              module.lambda_stepfunction_start_notebook.function_arn,
              module.lambda_stepfunction_exit_notebook.function_arn
            ]
          }
        ]
    })
}

resource "aws_iam_role" "stepfunctions_notebook_role" {
    name = "stepfunctions_notebook_role_terraform"
    managed_policy_arns = [
        aws_iam_policy.stepfunctions_notebook_policy.arn,
        ]

    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = ["sts:AssumeRole"]
          Effect = "Allow"
          Sid = ""
          Principal = {
            Service = "states.amazonaws.com"
          }
        }
      ]
    })
}

# Reduced Permissions Set Policies
data "aws_iam_policy_document" "sagemaker_serving_model_iam_policy_document" {

  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject"
    ]

    resources = [
      "${module.s3_sagemaker.arn}",
      "${module.s3_sagemaker.arn}/*",
    ]
  }

  statement {
    actions = [
      "kms:Decrypt"
    ]

    resources = [
      aws_kms_key.ngwaf_cmk_key.arn
    ]
  }

  statement {
    # Need to pull the ecr image for tensorflow
    actions = [
      "ecr:BatchGetImage"
    ]

    resources = [
      "arn:aws:ecr:ap-southeast-1:763104351884:repository/*"
    ]
  }

  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer"
    ]

    # Needed to pull the ecr image for tensorflow
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "sagemaker_serving_model_policy" {
  name = "sagemaker_serving_model_policy_terraform"
  description = "Used by Sagemaker Model to read model files"

  policy = data.aws_iam_policy_document.sagemaker_serving_model_iam_policy_document.json
}

resource "aws_iam_role" "sagemaker_serving_model_role" {
  name = "sagemaker_serving_model_role_terraform"

  managed_policy_arns = [
      aws_iam_policy.sagemaker_serving_model_policy.arn
    ]

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["sts:AssumeRole"]
        Effect = "Allow"
        Sid = ""
        Principal = {
          Service = "sagemaker.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role" "lambda_sagemaker_serving_role_reduced" {
    name = "lambda_sagemaker_serving_role_terraform"
    managed_policy_arns = [
          aws_iam_policy.lambda_sagemaker_serving_policy_reduced.arn
        ]
    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = ["sts:AssumeRole"]
          Effect = "Allow"
          Sid = ""
          Principal = {
            Service = "lambda.amazonaws.com"
          }
        }
      ]
    })
}

resource "aws_iam_policy" "lambda_sagemaker_serving_policy_reduced" {
    name = "lambda_sagemaker_serving_policy_terraform"
    description = "Terraform Lambda Sagemaker Serving"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "logs:CreateLogGroup"
            ]
            Effect = "Allow"
            Resource = [
              "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:*"
            ]
          },
                    {
            Action = [
              "logs:CreateLogStream",
              "logs:PutLogEvents",
            ]
            Effect = "Allow"
            Resource = [
              "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/ngwaf-sagemaker-serving:*",
              aws_cloudwatch_log_group.sagemaker_serving_logging.arn
            ]
          },
          {
            Action = [
              "ssm:GetParameter"
            ]
            Effect = "Allow"
            Resource = [
              "arn:aws:ssm:${var.myregion}:${data.aws_caller_identity.current.account_id}:parameter/ngwaf*"
            ]
          },
          {
            Action = [
              "sagemaker:InvokeEndpoint"
            ]
            Effect = "Allow",
            Resource = [
              aws_sagemaker_endpoint.ngwaf_serving_endpoint.arn,
            ]
          }
        ]
    })
}

resource "aws_iam_role" "lambda_sagemaker_job_status_role_reduced" {
    name = "lambda_sagemaker_job_status_role_terraform"
    managed_policy_arns = [
          aws_iam_policy.lambda_sagemaker_job_status_policy_reduced.arn
    ]
    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = ["sts:AssumeRole"]
          Effect = "Allow"
          Sid = ""
          Principal = {
            Service = "lambda.amazonaws.com"
          }
        }
      ]
    })
}

resource "aws_iam_policy" "lambda_sagemaker_job_status_policy_reduced" {
    name = "lambda_sagemaker_job_status_policy_terraform"
    description = "Terraform Lambda Sagemaker Job Status"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "logs:CreateLogGroup"
            ]
            Effect = "Allow"
            Resource = [
              "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:*"
            ]
          },
                    {
            Action = [
              "logs:CreateLogStream",
              "logs:PutLogEvents",
            ]
            Effect = "Allow"
            Resource = [
              "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/ngwaf-sagemaker-serving:*",
              aws_cloudwatch_log_group.sagemaker_serving_logging.arn
            ]
          },
          {
            Action = [
              "ssm:GetParameter"
            ]
            Effect = "Allow"
            Resource = [
              "arn:aws:ssm:${var.myregion}:${data.aws_caller_identity.current.account_id}:parameter/ngwaf*"
            ]
          },
          {
            Action = [
              "dynamodb:Scan"
            ]
            Effect = "Allow",
            Resource = [
              aws_dynamodb_table.ngwaf_dynamo_db.arn
            ]
          },
          {
            Action = [
              "kms:Decrypt"
            ]
            Effect = "Allow",
            Resource = [
              aws_kms_key.ngwaf_cmk_key.arn
            ]
          }
        ]
    })
}

resource "aws_iam_role" "lambda_sagemaker_retrain_role_reduced" {
    name = "lambda_sagemaker_retrain_role_terraform"
    managed_policy_arns = [
          aws_iam_policy.lambda_sagemaker_retrain_policy_reduced.arn
        ]
    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = ["sts:AssumeRole"]
          Effect = "Allow"
          Sid = ""
          Principal = {
            Service = "lambda.amazonaws.com"
          }
        }
      ]
    })
}

data "aws_iam_policy_document" "lambda_sagemaker_retrain_iam_policy_document" {

  statement {
    actions = [
      "ssm:GetParameter"
    ]
    resources = [
      "arn:aws:ssm:${var.myregion}:${data.aws_caller_identity.current.account_id}:parameter/ngwaf*"
    ]
  }

  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem"
    ]

    resources = [
      aws_dynamodb_table.ngwaf_dynamo_db.arn
    ]
  }

  statement {
    actions = [
      "s3:ListBucket",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]

    resources = [
      "${module.s3_sagemaker.arn}",
      "${module.s3_sagemaker.arn}/*"
    ]
  }

  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject"
    ]

     resources = [
      "${module.s3_trainbucket.arn}",
      "${module.s3_trainbucket.arn}/*"
     ]
  }

  statement {
    actions = [
      "kms:DescribeKey",
      "kms:GenerateDataKey",
      "kms:Decrypt"
    ]

    resources = [
      aws_kms_key.ngwaf_cmk_key.arn
    ]
  }

  statement {
    actions = [
      "states:StartExecution"
    ]

    resources = [
      # Hardcode due to cyclic reference
      "arn:aws:states:${var.myregion}:${data.aws_caller_identity.current.account_id}:stateMachine:retrain_step_function_terraform"
    ]
  }
}

resource "aws_iam_policy" "lambda_sagemaker_retrain_policy_reduced" {
    name = "lambda_sagemaker_retrain_policy_terraform"
    description = "IAM Policy for Retrain Lambda"

    policy = data.aws_iam_policy_document.lambda_sagemaker_retrain_iam_policy_document.json
}

resource "aws_iam_role" "sagemaker_notebook_role_reduced" {
    name = "sagemaker_notebook_role_terraform_reduced"
    managed_policy_arns = [
        aws_iam_policy.sagemaker_notebook_policy_reduced.arn,
        "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
        ]

    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = ["sts:AssumeRole"]
          Effect = "Allow"
          Sid = ""
          Principal = {
            Service = "sagemaker.amazonaws.com"
          }
        }
      ]
    })
}

data "aws_iam_policy_document" "sagemaker_notebook_iam_policy_document_reduced" {
  statement {
    actions = [
      "sagemaker:StopNotebookInstance",
      "sagemaker:DescribeNotebookInstance",
    ]

    resources = [
      "arn:aws:sagemaker:${var.myregion}:${data.aws_caller_identity.current.account_id}:notebook-instance/ngwaf*"
    ]    
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:GetBucketAcl",
      "s3:PutObjectAcl",
    ]

    resources = [
      module.s3_sagemaker.arn,
      "${module.s3_sagemaker.arn}/*"
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      module.s3_ngwaf_notebook_scripts.arn,
      "${module.s3_ngwaf_notebook_scripts.arn}/*"
    ]
  }

  # Needed for Sagemaker to store meta data on the training
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:CreateBucket",
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:GetBucketAcl",
      "s3:PutObjectAcl"
    ]

    resources = [
      "arn:aws:s3:::*SageMaker*",
      "arn:aws:s3:::*Sagemaker*",
      "arn:aws:s3:::*sagemaker*",
      "arn:aws:s3:::*aws-glue*",
    ]
  }

  statement {
    actions = [
      "sagemaker:CreateTrainingJob",
      "sagemaker:DescribeTrainingJob",
      "logs:DescribeLogStreams"
    ]

    not_resources = [
      "arn:aws:sagemaker:*:*:domain/*",
      "arn:aws:sagemaker:*:*:user-profile/*",
      "arn:aws:sagemaker:*:*:app/*",
      "arn:aws:sagemaker:*:*:flow-definition/*"
    ]
  }

  statement {
    actions = [
      "iam:PassRole"
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/sagemaker_notebook_role_terraform_reduced"
    ]
  }

  statement {
    actions = [
      "kms:DescribeKey",
      "kms:GenerateDataKey",
      "kms:Decrypt"
    ]

    resources = [
      aws_kms_key.ngwaf_cmk_key.arn
    ]
  }

  statement {
    actions = [
      "ecr:BatchGetImage"
    ]

    resources = [
      "arn:aws:ecr:ap-southeast-1:763104351884:repository/*"
    ]
  }

  statement {
    # Needed to pull down the tensorflow image
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    actions = [
      "ssm:GetParameter",
      "ssm:PutParameter"
    ]

    resources = [
      "arn:aws:ssm:${var.myregion}:${data.aws_caller_identity.current.account_id}:parameter/ngwaf*"
    ]
  }

  statement {
    actions  = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem"
    ]

    resources = [
      aws_dynamodb_table.ngwaf_dynamo_db.arn
    ]
  }

  statement {
    actions = [
      "sagemaker:CreateModel",
      "sagemaker:CreateEndpoint",
      "sagemaker:UpdateEndpoint",
      "sagemaker:DeleteEndpoint",              
      "sagemaker:DescribeEndpoint",
      "sagemaker:CreateEndpointConfig",
      "sagemaker:UpdateEndpointConfig",
      "sagemaker:DeleteEndpointConfig",
      "sagemaker:DescribeEndpointConfig",
    ]

    resources = [
      aws_sagemaker_endpoint.ngwaf_serving_endpoint.arn,
      # Date is appended behind the endpoint config name
      "${aws_sagemaker_endpoint_configuration.ngwaf_serving_ec.arn}*",
      # Meant for retraining model/config creation
      "arn:aws:sagemaker:${var.myregion}:${data.aws_caller_identity.current.account_id}:model/tensorflow*",
      "arn:aws:sagemaker:${var.myregion}:${data.aws_caller_identity.current.account_id}:endpoint/tensorflow*",
      "arn:aws:sagemaker:${var.myregion}:${data.aws_caller_identity.current.account_id}:endpoint-config/tensorflow*"
    ]
  }

  statement {
    actions = [
      "sagemaker:ListEndpoints",
      "sagemaker:ListEndpointConfig",
      "sagemaker:ListTags",
      "states:ListExecutions"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    actions = [
      "sagemaker:InvokeEndpoint"
    ]

    resources = [
      aws_sagemaker_endpoint.ngwaf_serving_endpoint.arn,
      "arn:aws:sagemaker:${var.myregion}:${data.aws_caller_identity.current.account_id}:endpoint/tensorflow*"
    ]
  }

  statement {
    actions = [
      "states:StopExecution"
    ]

    resources = [
      "arn:aws:states:${var.myregion}:${data.aws_caller_identity.current.account_id}:execution:retrain_step_function_terraform:*"
    ]
  }
}

resource "aws_iam_policy" "sagemaker_notebook_policy_reduced" {
    name = "sagemaker_notebook_policy_terraform_reduced"
    description = "Terraform SageMaker Notebook Policy"

    policy = data.aws_iam_policy_document.sagemaker_notebook_iam_policy_document_reduced.json
}


resource "aws_iam_role" "lambda_start_notebook_role" {
    name = "lambda_start_notebook_role_terraform"
    managed_policy_arns = [
        aws_iam_policy.lambda_start_notebook_policy.arn
        ]

    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = ["sts:AssumeRole"]
          Effect = "Allow"
          Sid = ""
          Principal = {
            Service = "lambda.amazonaws.com"
          }
        }
      ]
    })
}

data "aws_iam_policy_document" "lambda_start_notebook_policy_document" {
  statement {
    actions = [
      "sagemaker:StartNotebookInstance",
      "sagemaker:DescribeNotebookInstance",
    ]

    resources = [
      "arn:aws:sagemaker:${var.myregion}:${data.aws_caller_identity.current.account_id}:notebook-instance/ngwaf*"
    ]    
  }

  statement {
    actions = [
      "ssm:GetParameter"
    ]
    resources = [
      "arn:aws:ssm:${var.myregion}:${data.aws_caller_identity.current.account_id}:parameter/ngwaf*"
    ]
  }
}

resource "aws_iam_policy" "lambda_start_notebook_policy" {
    name = "lambda_start_notebook_policy"
    description = "Lambda Start Notebook Policy"

    policy = data.aws_iam_policy_document.lambda_start_notebook_policy_document.json
}

resource "aws_iam_role" "lambda_stop_notebook_role" {
    name = "lambda_stop_notebook_role_terraform"
    managed_policy_arns = [
        aws_iam_policy.lambda_stop_notebook_policy.arn
        ]

    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = ["sts:AssumeRole"]
          Effect = "Allow"
          Sid = ""
          Principal = {
            Service = "lambda.amazonaws.com"
          }
        }
      ]
    })
}

data "aws_iam_policy_document" "lambda_stop_notebook_policy_document" {
  statement {
    actions = [
      "sagemaker:StopNotebookInstance",
      "sagemaker:DescribeNotebookInstance",
    ]

    resources = [
      "arn:aws:sagemaker:${var.myregion}:${data.aws_caller_identity.current.account_id}:notebook-instance/ngwaf*"
    ]    
  }

  statement {
    actions  = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem"
    ]

    resources = [
      aws_dynamodb_table.ngwaf_dynamo_db.arn
    ]
  }

  statement {
    actions = [
      "kms:DescribeKey",
      "kms:GenerateDataKey",
      "kms:Decrypt"
    ]

    resources = [
      aws_kms_key.ngwaf_cmk_key.arn
    ]
  }
}

resource "aws_iam_policy" "lambda_stop_notebook_policy" {
    name = "lambda_stop_notebook_policy"
    description = "Lambda Stop Notebook Policy"

    policy = data.aws_iam_policy_document.lambda_stop_notebook_policy_document.json
}

# ngwaf S3 User
resource "local_file" "creds_file" {
  content = "ngwaf user Access ID: ${aws_iam_access_key.ngwaf_s3_iam_user_access_key.id}\nngwaf user Secret: ${aws_iam_access_key.ngwaf_s3_iam_user_access_key.secret}\nAPI Endpoint: ${aws_api_gateway_deployment.api.invoke_url}terraform_deploy\nAPI Key: ${aws_api_gateway_api_key.apikey.value}"
  filename = "aws_creds.txt"
}

resource "aws_iam_access_key" "ngwaf_s3_iam_user_access_key" {
  user = aws_iam_user.ngwaf_s3_user.name
}

resource "aws_iam_user" "ngwaf_s3_user" {
  name = "ngwaf_admin_s3_user"
}

data "aws_iam_policy_document" "ngwaf_s3_iam_user_policy_document" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket"
    ]

    resources = [
      module.s3_trainbucket.arn,
      "${module.s3_trainbucket.arn}/*",
    ]    
  }

  statement {
    actions = [
      "kms:DescribeKey",
      "kms:GenerateDataKey",
      "kms:Decrypt"
    ]

    resources = [
      aws_kms_key.ngwaf_cmk_key.arn
    ]
  }
}

resource "aws_iam_user_policy" "ngwaf_s3_iam_user_policy" {
    name = "ngwaf_admin_user_s3_policy"
    user = aws_iam_user.ngwaf_s3_user.name

    policy = data.aws_iam_policy_document.ngwaf_s3_iam_user_policy_document.json
}