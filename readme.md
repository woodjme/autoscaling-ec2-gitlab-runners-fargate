# Autoscaling EC2 GitLab Runners Spawned by Fargate

The purpose of the CloudFormation template is to create a Fargate Service that manages and autoscales EC2 instances to run Gitlab CI jobs. This allows for private GitLab Runners without managing, patching or maintaing servers.

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
