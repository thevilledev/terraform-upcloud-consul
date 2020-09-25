resource "upcloud_server" "this" {
  count    = var.cluster_size
  zone     = var.zone
  hostname = "${var.cluster_name}-${count.index}.${var.domain}"

  cpu = var.cpu
  mem = var.mem

  dynamic "network_interface" {
      for_each = var.network_interface
      content {
          type = network_interface.value["type"]   
      }
  }

  login {
    user              = var.login_user
    keys              = var.login_keys
    create_password   = var.login_create_password
    password_delivery = var.login_password_delivery
  }

  storage_devices {
    size    = var.storage_device_size
    action  = "clone"
    tier    = var.storage_device_tier
    storage = var.storage_device_src
  }

  user_data =<<EOF
#!/bin/bash

export DEBIAN_FRONTEND="noninteractive"

apt update && apt-get install -y -q \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

apt-get update && apt-get install -y -q \
    docker-ce \
    docker-ce-cli \
    containerd.io

docker run -dit \
    --name=consul-${count.index} \
    --net=host -e 'CONSUL_LOCAL_CONFIG={"leave_on_terminate": true}' \
    ${var.consul_image} \
    agent \
    -retry-join="provider=upcloud username=\"${var.upcloud_api_username}\" password=\"${var.upcloud_api_password}\" zone=\"${var.zone}\" tag=\"${var.consul_tag_name}\" address_access=utility address_family=IPv4" \
    -server \
    -bootstrap-expect 3 \
    -bind "{{ GetInterfaceIP \"eth1\" }}"
EOF
}

resource "upcloud_tag" "consul" {
  name        = var.consul_tag_name
  description = var.consul_tag_description
  servers     = upcloud_server.this.*.id
}