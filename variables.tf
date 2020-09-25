variable "cluster_name" {
    type = string
    default = "tf-consul"
}

variable "domain" {
    type = string
}

variable "cluster_size" {
    type = number
}

variable "zone" {
    type = string
}

variable "cpu" {
    type = string
    default = "1"
}

variable "mem" {
    type = string
    default = "1024"
}

variable "login_user" {
    type = string
}

variable "login_keys" {
    type = list
}

variable "login_create_password" {
    type = bool
    default = false
}

variable "login_password_delivery" {
    type = string
    default = "none"
}

variable "network_interface_type" {
    type = string
    default = "utility"
}

variable "storage_device_size" {
    type = number
    default = 100
}

variable "storage_device_tier" {
    type = string
    default = "maxiops"
}

variable "storage_device_src" {
    type = string
    default = "Debian GNU/Linux 10 (Buster)"
}

variable "consul_tag_name" {
    type = string
    default = "consul-server"
}

variable "consul_tag_description" {
    type = string
    default = "Consul Server"
}

variable "network_interface" {
    type = list(map(string))
}

variable "upcloud_api_username" {
    type = string
}

variable "upcloud_api_password" {
    type = string
}

variable "consul_image" {
    type = string
    default = "ghcr.io/vtorhonen/consul/upcloud-support:6ccfa827c449759a925c43739cec4fe5b22c561f"
}