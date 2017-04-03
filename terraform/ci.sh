#!/usr/bin/env bash

TERRAFORM_IMAGE=hashicorp/terraform:0.9.1
TERRAFORM_CMD="docker run --rm -w /app -v `pwd`:/app -e TF_VAR_environment=$ENVIRONMENT $ENV_FILE_ARG $TERRAFORM_IMAGE"

CMD=$1

case "$CMD" in
  apply )
    $TERRAFORM_CMD plan -input=false -out=./plan \
      && $TERRAFORM_CMD apply -input=false ./plan \
    ;;
  plan )
    $TERRAFORM_CMD plan -input=false
    ;;
  validate )
    $TERRAFORM_CMD validate
    ;;
  * )
    echo "ERROR: No Terraform command specified."
    exit 1
    ;;
esac
