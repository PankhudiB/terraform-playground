variable "int_port" {
  type = number

  validation {
    condition = var.int_port <= 65535 && var.int_port > 0
    error_message = "The port must be in a valid port range 0 - 65535."
  }
}