variable "aws_region" {
  type        = string
  default     = "ap-south-1"
}

variable "s3_bucket_name" {
  type        = string
  default     = "cloudzenia-terraform-statefiles"
}

variable "force_destroy" {
  description = "Set to true to allow bucket deletion without manual intervention"
  type        = bool
  default     = true
}


variable "versioning_status" {
  description = "Enable or disable versioning on the S3 bucket"
  type        = string
  default     = "Enabled"
}

variable "sse_algorithm" {
  description = "Server-side encryption algorithm"
  type        = string
  default     = "AES256"
}

variable "block_public_acls" {
  description = "Block public ACLs on the bucket"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Block public bucket policies"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Ignore public ACLs on the bucket"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Restrict public bucket policies"
  type        = bool
  default     = true
}
