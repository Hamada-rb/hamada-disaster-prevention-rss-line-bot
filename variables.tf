variable "access_key" {
  description = "AWS Access Key"
}

variable "secret_key" {
  description = "AWS Secret Key"
}

variable "role_arn" {
  description = "AWS Role Arn"
}

variable "region" {
  default = "us-east-2"
}

variable "line_channel_secret" {
  description = "LINE Channel Secret"
}

variable "line_channel_token" {
  description = "LINE Channel Token"
}
