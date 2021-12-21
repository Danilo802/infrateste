variable "cluster_identifier" {
    description = "Nome do Cluster"
    type = string
    default = "bemobitdb"
  
}
variable "engine" {
    description = "Motor do banco de dados"
    type = string
    default = "aurora-mysql"
  
}

variable "engine_version" {
    description = "versão do motor do banco de dados"
    type = string
    default = "5.7.mysql_aurora.2.10.1"
  
}

variable "database_name" {
    description = "nome do banco de dados"
    type = string
    default = "bemobitdb"
  
}

variable "master_username" {
    description = "nome do usuario master"
    type = string
    default = "bemobiuser"
  
}

variable "porta" {
    description = "numero da porta"
    type = string
    default = "3306"
  
}



variable "db_subnet_ids" {
    description = "subnets utilizadas pelo banco de dados"
    type = list(string)
    default = ["subnet-083ff4d96e98fc1e7", "subnet-027fa40daba762b96"]
  
}

variable "vpc_id" {
    description = "vpc id"
    type = string
    default = "vpc-03ca3e15719b13c82"  
}

variable "cidr" {
    description = "cidr vpc"
    type = list(string)
    default = ["172.31.0.0/16","189.0.0.0/16"]
}


variable "cluster_group_family" {
    description = "Familia do Cluster"
    type = string
    default = "aurora-mysql5.7"  
}

variable "copy_tags_to_snapshot" {
    description = "copia tags para snapshot"
    type = bool
    default = true  
}

variable "enabled_cloudwatch_logs_exports" {
    description = "ativa logs para cloudwatch"
    type = list(string)
    default = ["audit","error","general","slowquery"]  
}

variable "preferred_maintenance_window" {
    description = "Familia do Cluster"
    type = string
    default = "sun:01:00-sun:02:30"  
}

variable "kmsars" {
    description = "arnkms"
    type = string
    default = "sun:01:00-sun:02:30"  
}

variable "app_name" {
    description = "arnkms"
    type = string
    default = "putfiles3"  
}



locals {
  master_password=random_password.password.result
}

