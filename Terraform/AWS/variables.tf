####################### CONTA ########################################
variable "region" {
  description = "Define what region the instance will be deployed"
  default     = "us-east-1"
}

variable "base_name" {
  description = "Define the standard the names to utilize in services"
  type        = map(string)
  default = {
    "server_web" = "webserver"
    "subn_priv"  = "sub_priv"
    "subn_publ"  = "sub_publ"
  }
}

variable "env" {
  description = "Environment of the application"
  type        = map(string)
  default = {
    "desenvolvimento" = "DSV"
    "homologacao"     = "HML"
    "producao"        = "PRD"
  }
}
####################################################################


####################### EC2 ########################################
variable "instance_count" {
  description = "Number of instances to create"
  default = "2"
}

variable "instance_type" {
  description = "AWS Instance type defines the hardware configuration of the machine"
  default     = "t2.micro"
}
####################################################################

####################### VPC ########################################
variable "availability_zones" {
  type        = list(string)
  description = "Define list of availability zone to use"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "private_subnets" {
  type        = list(string)
  description = "Define list of private subnets IP's"
  default     = ["10.7.1.0/24", "10.7.2.0/24", "10.7.3.0/24"]
}

variable "public_subnets" {
  type        = list(string)
  description = "Define list of public subnets IP's"
  default     = ["10.7.100.0/24", "10.7.110.0/24", "10.7.120.0/24"]
}
####################################################################