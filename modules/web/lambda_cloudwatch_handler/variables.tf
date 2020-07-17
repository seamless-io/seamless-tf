variable "stage" {
  type = string
}

variable "environment_variables" {
  type = map(string)
  default = {}
}