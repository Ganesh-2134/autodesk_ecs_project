variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  default     = ""
}
variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  default     = ""
}
variable "config" {
  type = object({
    environment = string
    region      = string
    profile     = string
    projectName = string
  })
  default = {
    environment = "test"
    region      = "us-east-1"
    profile     = "Ganesh_M"
    projectName = "autodesk_ecr-project" #updated
  }
}

variable "securityGroupIds" {
  type    = list(string)
  default = ["sg-0c1c056fb89d2f733"] #updated
}
variable "subnetIds" {
  type    = list(string)
  default = ["subnet-0627aeeefd44faba3", "subnet-0f3318be48b54948f"] #updated
}
variable "container_port" {
  type    = number
  default = 3000
}
variable "hostPort" {
  type    = number
  default = 3000
}
variable "protocol" {
  type    = string
  default = "tcp"
}
variable "cpu" {
  type    = number
  default = 256
}
variable "memory" {
  type    = number
  default = 512
}
variable "network_mode" {
  type    = string
  default = "awsvpc"
}
variable "requires_compatibilities" {
  type    = list(string)
  default = ["FARGATE"]
}
variable "essential" {
  type    = bool
  default = true
}

##aws_ecs_service###
variable "desired_count" {
  type    = number
  default = 1
}
variable "deployment_minimum_healthy_percent" {
  type    = number
  default = 100
}
variable "deployment_maximum_percent" {
  type    = number
  default = 200
}
variable "launch_type" {
  type    = string
  default = "FARGATE"
}
variable "scheduling_strategy" {
  type    = string
  default = "REPLICA"
}

### Output of ECR ###
variable "image_url" {
  type        = string
  default     = "public.ecr.aws/d6w9t4c3/tf-repo-ecr:latest" #updated
  description = "the url of a docker image that contains the application process that will handle the traffic for this service"
}
/*variable "image" {
  type    = string
  default = "353211646521.dkr.ecr.us-east-1.amazonaws.com"
}*/
variable "name_prefix" {
  description = "Name Prefix"
  type        = string
  default     = "fw"
}
