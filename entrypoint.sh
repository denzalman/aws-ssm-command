#!/bin/bash
set -e

######

echo "AWS configuration..."
aws configure set default.region "${INPUT_AWS_REGION}"

######

aws ssm send-command \
    --document-name "AWS-RunShellScript" \
    --parameters commands=["${INPUT_COMMAND}"] \
    --instance-ids=["${INPUT_INSTANCE_IDS}"] \
    --comment "${INPUT_COMMENT}"
