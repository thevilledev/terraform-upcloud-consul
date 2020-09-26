# terraform-upcloud-consul

NOTE: This is very much work in progress.

Terraform module for deploying a Consul cluster on UpCloud. Uses [cloud auto-join]() to find cluster peers on UpCloud as instance tags.

All cluster members run Consul server on Docker containers.

As of writing this, the implementation is based on a Consul image built on [vtorhonen/consul@feature/go-discover-upcloud-support branch](https://github.com/vtorhonen/consul/tree/feature/go-discover-upcloud-support). These images are built by Github Actions workflow at [vtorhonen/consul@feature/ci-go-discover-upcloud-support branch](https://github.com/vtorhonen/consul/tree/feature/ci-go-discover-upcloud-support). Idea is to eventually get this merged into upstream project. Underlying implementation is also based on [vtorhonen/go-discover@feature/upcloud-support branch](https://github.com/vtorhonen/go-discover/tree/feature/upcloud-support), also something waiting to be polished and merged into upstream.

## Requirements

First of all, build [terraform-provider-upcloud](https://github.com/UpCloudLtd/terraform-provider-upcloud) as instructed
on the documentation.

Next, create a new UpCloud API user with "all server access". You'll need a username and password in the deployment.

## Deploying

See `examples/` folder for a starting point. Create a new Terraform workspace and run:

```
terraform init
terraform plan -out=foo.plan
terraform apply foo.plan
```

By default, all cluster instances get a public IP address to install Docker and related components through `apt-get`. All cluster communication is done over `utility` network by default, meaning privately routed internal IP addresses.

After applying, log in to one of the cluster nodes over SSH and check container logs by running:

```
docker ps
docker logs consul-0
# OR
docker logs consul-1
# OR
docker logs consul-2
```

## TODO

- Add support for
    - Custom machine images (oof, no one should install container runtime on user data)
    - Storing Consul data on separate data volume
    - Backup schedules
    - Customizing Consul configuration by providing a set of configuration options as env variables
