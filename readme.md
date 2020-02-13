# Autoscaling EC2 GitLab Runners Spawned by Fargate

The purpose of the CloudFormation template is to create a Fargate Service that manages and autoscales EC2 instances to run Gitlab CI jobs. This allows for private GitLab Runners without managing, patching or maintaing servers.

[![Launch CloudFormation](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?stackName=stack_name&templateURL=template_locationhttps://console.aws.amazon.com/cloudformation/home?region=region#/stacks/new?stackName=stack_name&templateURL=https://autoscaling-ec2-gitlab-runners-fargate.s3-eu-west-1.amazonaws.com/master/gitlab-runner-template.yml)

![Diagram](https://github.com/woodjme/autoscaling-ec2-gitlab-runners-fargate/blob/master/diagram.png?raw=true)

## Parameters

* VpcId - Select a VPC that allows instances access to the Internet
* SubnetID - Select a subnet in the selected VPC - subnet-xyz123
* CacheExpirationInDays - Select how long to store a jobs cache output in S3
* RootVolumeSize -The size of the root volume on the runners
* GitLabURL - The Gitlab URL, change if self-hosted
* GitLabRegistrationToken - The Gitlab runer registration token
* DockerImage - The default docker image if not provided in a gitlab-ci.yml file
* AmiId - Enter a Ubuntu AMI ID for your region - example (eu-west-1) - ami-035966e8adab4aaad
* CPU - Set the number of CPUs for the spawner (1 CPU = 1024)
* Memory - Set the amount of RAM in KB for the spawner
* InstanceType - The instance type of the runners

## Resource Created

* IAM User - Needed as Fargate doesn't support Instance Profiles
* S3 Bucket for runner cache
* ECS Cluster, Service & Task Definition
* CloudWatch Logs Groups that streams to logs for the spawner
