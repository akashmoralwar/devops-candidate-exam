terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.0"
    }
  }
}
provider "aws" {
  region     = "us-east-1"
}

  backend "s3" {
    bucket         = "3.devops.candidate.exam"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}

resource "aws_subnet" "Nitin_private_subnet" {
  vpc_id                  = aws_vpc.vpc_id
  availability_zone       = "us-east-1a"
  cidr_block = "10.0.1.0/24","10.0.2.0/24"
  tags = {
    Name = "Nitin_private_subnet"
  }
}

resource "aws_route_table" "Nitin_route_table" {
  vpc_id = aws_vpc.vpc_id

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_nat_gateway.nat_id
  }

resource "aws_lambda_function" "test_lambda" {
  filename      = "lambda_function_payload.zip"
  function_name = "Nitin_test_lambda"
  role          = aws_iam_role.lambda_name
  handler       = "index.py"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.8"

  environment {
    variables = {
      foo = "bar"
    }
