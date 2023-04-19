# Terraform Static Website
This is a terraform deployment script that deploys a S3 bucket holding a static website and a CloudFront distribution connected to a domain


## Prerequisites
1) You will need to have an AWS account.
2) You will need to have Terraform Installed and AWS CLI

You will also need to have an S3 bucket created within the AWS account to store the state of the Terraform. Run the following command to do this:

Configure AWS CLI
```
aws configure
```

```
aws s3 mb s3://<YOUR_STATE_BUCKET_NAME>
```
Your state bucket name can be found in the `main.tf`.

## Run program
1) Fill out all the vairables within the variables.tf

2) Run the following command to initailse the Terraform script.
```
terraform init
```
3) Run the following command to plan the Terraform script.
```
terraform plan
```

4) Run the following command to apply the Terraform code to AWS.
```
terraform apply
```
