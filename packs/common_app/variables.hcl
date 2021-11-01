variable "job_name" {
  description = "The name to use as the job name which overrides using the pack name"
  type        = string
  // If "", the pack name will be used
  default = ""
}

variable "region" {
  description = "The region where jobs will be deployed"
  type        = string
}

variable "datacenters" {
  description = "A list of datacenters in the region which are eligible for task placement"
  type        = list(string)
  default     = ["dc1"]
}

variable "image" {
  description = ""
  type        = string
  default     = ""
}

variable "count" {
  description = "The number of app instances to deploy"
  type        = number
  default     = 1
}

variable "restart_attempts" {
  description = "The number of times the task should restart on updates"
  type        = number
  default     = 2
}

variable "has_health_check" {
  description = "If you want to register a health check in consul"
  type        = bool
  default     = true
}

variable "health_check" {
  description = ""
  type = object({
    interval = string
    timeout = string
  })

  default = {
    interval = "10s"
    timeout  = "2s"
  }
}

variable "register_consul_service" {
  description = "If you want to register a consul service for the job"
  type        = bool
  default     = true
}

variable "ports" {
  description = ""
  type = list(object({
    name = string
    port = number
  }))

  default = [{
    name = "http"
    port = 80
  }]
}

variable "env_vars" {
  description = ""
  type = map(string)
}

variable "consul_service_name" {
  description = "The consul service name for the application"
  type        = string
  default     = "service"
}

variable "consul_service_port" {
  description = "The consul service name for the application"
  type        = string
  default     = "http"
}

variable "consul_tags" {
  description = ""
  type = list(string)
  default = [
    "documentation",
    "traefik.enable=true",
    "traefik.frontend.rule=Host: cloud.halykbank.nb",
    "traefik.frontend.entryPoints=http"
  ]
}

variable "resources" {
  description = "The resource to assign to the task that runs on every client"
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 100,
    memory = 100
  }
}
