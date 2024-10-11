variable "prefix" {
  description = "The prefix used for all resources in this example"
  default     = "eastus"
}

variable "location" {
  description = "The Azure location where all resources in this example should be created"
  default     = "East US"
}

variable "extappgw-subnet" {
  type    = list(string)
  default = ["172.16.2.0/24"]
}

variable "ext-vnet" {
  type = object({
    name   = string
    prefix = list(string)
  })
  default = {
    name   = "ext-vnet"
    prefix = ["172.16.0.0/16"]
  }
}

variable "extappgw" {
  type = object({
    name   = string
    prefix = list(string)
  })
  default = {
    name   = "extappgw-subnet"
    prefix = ["172.16.2.0/24"]
  }
}

variable "ext-integration" {
  type = object({
    name   = string
    prefix = list(string)
  })
  default = {
    name   = "ext-integration-subnet"
    prefix = ["172.16.3.0/24"]
  }
}

variable "extweb" {
  type = object({
    name   = string
    prefix = list(string)
  })
  default = {
    name   = "extweb-subnet"
    prefix = ["172.16.4.0/24"]
  }
}

