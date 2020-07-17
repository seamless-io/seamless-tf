variable "file_name" {
  type = string
}

variable "function_name" {
  type = string
}

variable "handler" {
  type = string
}

variable "runtime" {
  type = string
}

variable "timeout" {
  type = string
}

variable "environment_variables" {
  type = map(string)
  default = {}
}