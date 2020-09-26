module "consul" {
  source               = "git@github.com:vtorhonen/terraform-upcloud-consul.git"
  domain               = "example.tld"
  zone                 = "de-fra1"
  login_user           = "tf"
  login_keys           = ["ENTER_KEY_HERE"]
  consul_tag_name      = "tf-consul-server"
  consul_cluster_name  = "tf-consul"
  consul_cluster_size  = 3
  consul_cluster_dc    = "de-fra1"
  upcloud_api_username = "ENTER_UPCLOUD_API_USERNAME_HERE"
  upcloud_api_password = "ENTER_UPCLOUD_API_PASSWORD_HERE"
}