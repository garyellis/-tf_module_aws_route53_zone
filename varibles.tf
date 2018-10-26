variable "alias_records" {
  description    = "A list of alias record maps"
  type    = "list"
  default = []
  # [{ name = "foo", records = ""}]
}

variable "create_zone" {
  description    = "Create the route53 zone"
  type    = "string"
  default = "false"
}

variable "name" {
  description    = "The zone name"
  type    = "string"
}

variable "records" {
  description = "A list of A record maps"
  type    = "list"
  default = []
  # [{ name = "foo", 
}

variable "records_ttl" {
  default = "Set ttl for A records. (this might move into a records variable"
  type    = "string"
  default = "300"
}

variable "tags" {
  description = "A map of tags applied when creating the route53 zone"
  type    = "map"
  default = {}
}

variable "vpc_id" {
  description = "Required to create a private hosted zone"
  type        = "string"
  default     = ""
}

variable "vpc_zone_associations_count" {
  description = "Associate additional vpcs to the private hosted zone"
  type    = "string"
  default = "0"
}

variable "vpc_zone_associations" {
  description    = "A list of vpcs to associate to the zone"
  type    = "list"
  default = []
}

variable "zone_id" {
  description    = "The private hosted zone id"
  type    = "string"
  default = ""
}
