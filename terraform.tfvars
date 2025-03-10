public_key_path = "~/.ssh/pulsar_aws.pub"
region          = "us-west-2"
az              = "us-west-2c"
ami_arm         = "ami-0c65913e98a358f43"
ami_x86         = "ami-0b8c6b923777519db"
user            = "ubuntu"
spot            = true

instance_types = {
  "messageservice" = "c7gn.4xlarge" 
  "logservice"     = "i3en.6xlarge"
  "client"         = "m5n.8xlarge"
}

num_instances = {
  "client"         = 1
  "messageservice" = 1
  "logservice"     = 3
}
