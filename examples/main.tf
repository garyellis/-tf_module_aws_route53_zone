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

variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}




# public lb
locals {
  listeners                  = [{ port = "443", target_group_index = "0" },]
  listeners_count            = 1
  target_groups              = [{ name = "https",target_type = "instance", port = "443",  proxy_protocol_v2 = "false", deregistration_delay = "5" },]
  target_group_health_checks = [{ target_groups_index = "0", protocol = "HTTPS", path = "/healthz", port = "443", interval = "10", healthy_threshold = "2", unhealthy_threshold = "2" },]
  target_groups_count        = 1
  
}

resource "aws_eip" "external_lb_eip_allocations" {
  count = length(var.public_subnets)

  tags     = var.tags
  vpc      = true
}

module "external_lb" {
  source = "github.com/garyellis/tf_module_aws_nlb"

  eip_allocation_ids         = aws_eip.external_lb_eip_allocations.*.allocation_id
  enable_deletion_protection = false
  internal                   = false
  listeners_count            = local.listeners_count
  listeners                  = local.listeners
  name                       = "lb-ext-eip"
  subnets                    = var.public_subnets
  target_groups_count        = local.target_groups_count
  target_groups              = local.target_groups
  target_group_health_checks = local.target_group_health_checks
  vpc_id                     = var.vpc_id
  tags                       = var.tags
}
# end public lb


# public dns
module "subdomain" {
  source = "../"
  create_zone         = true
  name                = var.subdomain
  alias_records       = [{ name = "tfmod-route53", aws_dns_name = module.external_lb.lb_dns_name, zone_id = module.external_lb.lb_zone_id, evaluate_target_health = "true"}]
  alias_records_count = 1
}

module "primary-domain-subdomain-ns" {
  source = "../"
  create_zone           = false
  name                  = var.primary_domain
  use_zone_datasource   = true
  ns_records            = [{ name = var.subdomain, record = join(",", module.subdomain.public_zone_nameservers)}]
  ns_records_count      = 1
}

output "subdomain-nameservers" {
  value = module.subdomain.public_zone_nameservers
}


# private dns zone and internal lb
module "internal_lb" {
  source = "github.com/garyellis/tf_module_aws_nlb"

  enable_deletion_protection = false
  internal                   = true
  listeners_count            = 1
  listeners                  = local.listeners
  name                       = "lb-int"
  subnets                    = var.private_subnets
  target_groups_count        = 1
  target_groups              = local.target_groups
  target_group_health_checks = local.target_group_health_checks
  vpc_id                     = var.vpc_id
  tags                       = var.tags
}

module "subdomain-internal" {
  source = "../"
  create_zone         = true
  name                = var.subdomain
  alias_records       = [{ name = "tfmod-route53", aws_dns_name = module.internal_lb.lb_dns_name, zone_id = module.internal_lb.lb_zone_id, evaluate_target_health = "true"}]
  alias_records_count = 1
  vpc_id              = var.vpc_id
}
