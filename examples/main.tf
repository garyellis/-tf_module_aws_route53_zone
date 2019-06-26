variable "subdomain" {
  type = string
  default = "dev.foo.com"
}

variable "primary_domain" {
  type = string
  default = "foo.com"
}

variable "subdomain_a_records" {
  type = list(map(string))
  default = []
}

variable "subdomain_a_records_count" {
  type = number
  default = 1
}



module "dev-ews-works" {
  source = "../"
  create_zone     = true
  name            = var.subdomain
  a_records       = var.subdomain_a_records
  a_records_count = var.subdomain_a_records_count
}

module "dev-ews-works-ns" {
  source = "../"
  create_zone           = false
  name                  = var.primary_domain
  use_zone_datasource   = true
  ns_records            = [{ name = var.subdomain, record = join(",", module.dev-ews-works.public_zone_nameservers)}]
  ns_records_count      = 1
}


output "dev-ews-works-nameservers" {
  value = module.dev-ews-works.public_zone_nameservers
}
