variable "consul_cluster_name" {
  type    = string
  default = "tf-consul"
}

variable "domain" {
  type = string
}

variable "consul_cluster_size" {
  type = number
}

variable "zone" {
  type = string
}

variable "cpu" {
  type    = string
  default = "1"
}

variable "mem" {
  type    = string
  default = "1024"
}

variable "login_user" {
  type = string
}

variable "login_keys" {
  type = list
}

variable "login_create_password" {
  type    = bool
  default = false
}

variable "login_password_delivery" {
  type    = string
  default = "none"
}

variable "consul_tag_name" {
  type    = string
  default = "consul-server"
}

variable "consul_tag_description" {
  type    = string
  default = "Consul Server"
}

variable "network_interface" {
  type = list(map(string))
  default = [
    {
      type = "public"
    },
    {
      type = "utility"
    }
  ]
}

variable "storage_devices" {
  type = list(map(string))
  default = [
    {
      size    = "20"
      action  = "clone"
      tier    = "maxiops"
      storage = "Debian GNU/Linux 10 (Buster)"
    }
  ]
}

variable "upcloud_api_username" {
  type = string
}

variable "upcloud_api_password" {
  type = string
}

variable "consul_image" {
  type    = string
  default = "ghcr.io/vtorhonen/consul/upcloud-support:6ccfa827c449759a925c43739cec4fe5b22c561f"
}

variable "consul_cluster_dc" {
  type    = string
  default = "dc1"
}

variable "consul_cluster_bootstrap_expect" {
  type    = number
  default = 3
}

variable "consul_config" {
  type    = string
  default = <<EOF
{
    "leave_on_terminate": true,
    "datacenter": "dc1",
    "server": true
}
EOF
}