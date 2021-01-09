#!/bin/bash
set -e

######

echo "AWS configuration..."
aws configure set default.region "${INPUT_AWS_REGION}"

######

echo "SSM send command..."
# echo $(aws ssm send-command --document-name "AWS-RunShellScript" --parameters "commands=${INPUT_COMMAND}" --instance-ids="")

echo $(aws ssm send-command --document-name "AWS-RunShellScript" --targets "[{"Key":"InstanceIds","Values":["${INPUT_INSTANCE_IDS}"]}]" --parameters "{"workingDirectory":["/home/ubuntu"],"commands":["${INPUT_COMMAND}"]}" --comment "Actions" --timeout-seconds 30)

######

echo "Done."
