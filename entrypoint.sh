#!/bin/bash
set -e

######

echo "AWS configuration..."
aws configure set default.region "${INPUT_AWS_REGION}"

######

echo "SSM send command..."
# echo $(aws ssm send-command --document-name "AWS-RunShellScript" --parameters "commands=${INPUT_COMMAND}" --instance-ids="${INPUT_INSTANCE_IDS}")
parameters="{\"workingDirectory\":[\"${INPUT_WORKING_DIRECTORY}\"],\"commands\":[\"${INPUT_COMMAND}\"]}"
targets="[{\"Key\":\"InstanceIds\",\"Values\":[\"${INPUT_INSTANCE_IDS}\"]}]" 
echo "parameters: $parameters"
echo "targets: $targets"
echo $(aws ssm send-command --document-name "AWS-RunShellScript" --targets "${targets}" --parameters "${parameters}" --comment "Github Actions" --timeout-seconds 30)

######

echo "Done."
