variable region {
  type        = string
  default     = "ap-south-1"
  description = "description"
}

variable vpc_id {
  type        = string
  default     = "vpc-0dbb3ff386dd563ff"
  description = "description"
}

variable instance_type {
  type        = string
  default     = "t2.micro"
  description = "description"
}

variable private_subnet_ids {
  type        = list(string)
  default     = ["subnet-0d0dff24fea104067", "subnet-03db8770304b5a2de"]
  description = "description"
}



variable ec2_instances_names {
  type        = list(string)
  default     = ["ec2-Instance-1", "ec2-Instance-2"]
  description = "description"
}



variable ami_id {
  type        = string
  default     = "ami-0e35ddab05955cf57"
  description = "description"
}

variable public_subnet_id {
  type        = string
  default     = "subnet-031552e2504d520d3"
  description = "description"
}

# alb rules

variable aws_alb_arn {
  type        = string
  default     = "arn:aws:elasticloadbalancing:ap-south-1:096803082364:loadbalancer/app/cloudzenia-alb/e30a8c573bdc32cd"
  description = "description"
}

variable elb_instance_domain {
  type        = string
  default     = "ec2-alb-instance.shariff.info"
  description = "description"
}


variable elb_docker_domain {
  type        = string
  default     = "ec2-alb-docker.shariff.info"
  description = "description"
}

