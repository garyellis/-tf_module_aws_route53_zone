variable "alias_records" {
  description = "A list of alias record maps"
  type        = list(map(string))
  default     = []
  # [{ name = "foo", records = ""}]
}

variable "alias_records_count" {
  type    = number
  default = 0
}

variable "create_zone" {
  description = "Create the route53 zone"
  type        = bool
  default     = false
}

variable "private_zone" {
  description = "Is a private hosted zone"
  type        = bool
  default     = true
}

variable "name" {
  description = "The zone name"
  type        = string
}

variable "use_zone_datasource" {
  description = "enable datasource lookup on zone name"
  type        = bool
  default     = false
}

variable "a_records" {
  description = "A list of A record maps"
  type        = list(map(string))
  default     = []
}

variable "a_records_count" {
  type    = number
  default = 0
}

variable "ns_records" {
  type    = list(map(string))
  default = []
}

variable "ns_records_count" {
  type    = number
  default = 0
}

variable "tags" {
  description = "A map of tags applied when creating the route53 zone"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "Required to create a private hosted zone or look it up"
  type        = string
  default     = ""
}

variable "vpc_zone_associations_count" {
  description = "Associate additional vpcs to the private hosted zone"
  type        = number
  default     = 0
}

variable "vpc_zone_associations" {
  description = "A list of vpcs to associate to the zone"
  type        = list(string)
  default     = []
}

variable "zone_id" {
  description = "The private hosted zone id"
  type        = string
  default     = ""
}
