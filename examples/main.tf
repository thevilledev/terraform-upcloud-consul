module "consul" {
  source              = "../terraform-consul-upcloud"
  cluster_name        = "tf-my-consul-cluster"
  domain              = "example.tld"
  cluster_size        = 3
  zone                = "de-fra1"
  login_user          = "tf"
  login_keys          = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCvN0xG3HxWplyDu2WCo8p6TcO0t1s++R3Nkzd09Tv+8pp/g8BZw4QLFI5iR/COysg/QJVZ0Hkf/nOV//E2iHcqfDu6eITds/HNgcx4n2wN7rOBZDf4jAfgbWx5U2eQn4j3qeVUitiyBoRJHScp/NAiF75ENkWhI9E0xp/g3JkIfrujr0V1hR+TItxSTGUNpdjHI2SV2bTfNBk0dvw5yrf+wezHgw1NEhZMhaK0zmqlQvoZNmfyQZWNYaI1U8Nhox32hHJsiHt8bfdiG+/abL9iHrAGM3JwrR9IxQlL/pPu91jcKla5zsx/PwgBBBaXPT6/2W28qDivOMYOCq/94C/6X1iyr3tuFda1bwPK22BECVsJ0QfyzkT5M7LhxLKQ99vuHlCo4WIxBm5jVrZlmPxNcG5ZIXGSSrMQ38iSuJSiCovrINjWBp9KzqVrVRgGNbIIdXt8RvhMhPFmUI9D3+ioxgueSw1eXlpIT4vQ5W9jD2Ez0FIZpPnXRPeBm+6/XG+47rQpr88jlmN7VjDaz85JP2+DT8GUV8EU4OLv2IBb+2c/DSZjPJdZstbUjpaYJj8ZaWHpf4bKJeosrkziQb1RUNiEzMru4B5m0dBeMkrqc7f+rPV6hq+Er018qXHjxxDrSG51Y6OsdtZb7t36tQ8+lu5HS852TtCJVWbmXX6MqQ== whatever"]
  storage_device_size = 20
  consul_tag_name     = "tf-my-consul-cluster"
  network_interface = [
    {
      type = "public"
    },
    {
      type = "utility"
    }
  ]
  upcloud_api_username = "ENTER_API_USERNAME_HERE"
  upcloud_api_password = "ENTER_API_PASSWORD_HERE"
}