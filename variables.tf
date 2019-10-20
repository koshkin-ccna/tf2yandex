variable "yxtoken" {
    description = "yc config get token"  
    default = ""
    type = "string"
}

variable "yxcloudid" {
    description = "yc config get cloud-id"  
    default = ""
    type = "string"
}

variable "yxfolderid" {
    description = "yc resource-manager folder list"  
    default = ""
    type = "string"
}

variable "yxfolderid" {
    description = "yc compute zone list"  
    default = "ru-central1-c"
    type = "string"
}