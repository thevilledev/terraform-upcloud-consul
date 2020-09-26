module "consul-de-fra1" {
    source = "git@github.com:vtorhonen/terraform-upcloud-consul.git"
    domain = "example.tld"
    zone = "de-fra1"
    login_user = local.login_user
    login_keys = local.login_keys
    consul_tag_name = "tf-consul-server-de-fra1"
    consul_cluster_name = "tf-consul-server-de-fra1"
    consul_cluster_size = 3
    consul_config =<<EOF
{
    "leave_on_terminate": true,
    "datacenter": "de-fra1",
    "server": true,
    "retry_join_wan": [
        "provider=upcloud username=\"${local.upcloud_api_username}\" password=\"${local.upcloud_api_password}\" zone=\"fi-hel1\" tag=\"tf-consul-server-fi-hel1\" address_access=utility address_family=IPv4"
    ]
}
EOF
    upcloud_api_username = local.upcloud_api_username
    upcloud_api_password = local.upcloud_api_password
}

module "consul-fi-hel1" {
    source = "git@github.com:vtorhonen/terraform-upcloud-consul.git"
    domain = "example.tld"
    zone = "fi-hel1"
    login_user = local.login_user
    login_keys = local.login_keys
    consul_tag_name = "tf-consul-server-fi-hel1"
    consul_cluster_name = "tf-consul-server-fi-hel1"
    consul_cluster_size = 3
    consul_config =<<EOF
{
    "leave_on_terminate": true,
    "datacenter": "fi-hel1",
    "server": true,
    "retry_join_wan": [
        "provider=upcloud username=\"${local.upcloud_api_username}\" password=\"${local.upcloud_api_password}\" zone=\"de-fra1\" tag=\"tf-consul-server-de-fra1\" address_access=utility address_family=IPv4"
    ]
}
EOF
    upcloud_api_username = local.upcloud_api_username
    upcloud_api_password = local.upcloud_api_password
}