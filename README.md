# tf2yandex
 This is a repo with the Terraform project for the Yandex provider.

## PREREQUISITES

+ Istall Terraform v0.12.5 or higher on your admin machine
+ Clone this repo to local directory

### Prepare override.tf file

Use yandex-cli to get your credentials


```yaml
provider "yandex" {
  // yc config list
  // yc config get token
  token = "your_token"
  // yc resource-manager cloud list
  // yc config get cloud-id
  // yc config set cloud-id $cloudid
  cloud_id = "your_cloud_id"
  // yc resource-manager folder list
  // yc config set folder-id $folderid
  folder_id = "your_folder_id"
  // yc compute zone list
  zone = "ru-central1-c"
}
```

## HOW TO USE

Commands must be executed in a current directory with .tf files
WARNING: use `destroy` with caution, it will destroy all resourses irreversably.

```console
foo@bar:~$ terraform --version
foo@bar:~$ terraform init
foo@bar:~$ terraform plan
foo@bar:~$ terraform apply
```

### Directory structure

+ main.tf - main file contains access variables and some uncategorized resources
+ variables.tf - defines variables
+ output.tf - defines information returned by terraform (vm public ip addresses)
+ images.tf - upload and create openstack images (image will be cached on terraform machine, make sure you have enough free disk space)
+ ipsec.tf - defines openstack ipsec-as-service connection parameters
+ networks.tf - network related resources
+ secgroups.tf - openstack firewall rules

> files that are gitignor'ed:

+ override.tf - don't store this file in git, this keeps your passwords safe
+ terraform.tfstate and terraform.tfstate.backup
