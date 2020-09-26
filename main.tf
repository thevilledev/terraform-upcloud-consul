resource "upcloud_server" "this" {
  count    = var.consul_cluster_size
  zone     = var.zone
  hostname = "${var.consul_cluster_name}-${count.index}.${var.domain}"

  cpu = var.cpu
  mem = var.mem

  dynamic "network_interface" {
    for_each = var.network_interface
    content {
      type = network_interface.value["type"]
    }
  }

  dynamic "storage_devices" {
    for_each = var.storage_devices
    content {
      size    = storage_devices.value["size"]
      action  = storage_devices.value["action"]
      tier    = storage_devices.value["tier"]
      storage = storage_devices.value["storage"]
    }
  }

  login {
    user              = var.login_user
    keys              = var.login_keys
    create_password   = var.login_create_password
    password_delivery = var.login_password_delivery
  }

  user_data = <<EOF
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
    --net=host \
    -e CONSUL_LOCAL_CONFIG='${var.consul_config}' \
    ${var.consul_image} \
    agent \
    -retry-join="provider=upcloud username=\"${var.upcloud_api_username}\" password=\"${var.upcloud_api_password}\" zone=\"${var.zone}\" tag=\"${var.consul_tag_name}\" address_access=utility address_family=IPv4" \
    -server \
    -bootstrap-expect ${var.consul_cluster_bootstrap_expect} \
    -bind "{{ GetInterfaceIP \"eth1\" }}"
EOF
}

resource "upcloud_tag" "consul" {
  name        = var.consul_tag_name
  description = var.consul_tag_description
  servers     = upcloud_server.this.*.id
}