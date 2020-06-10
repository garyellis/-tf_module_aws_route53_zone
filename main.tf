data "aws_route53_zone" "current" {
  count = var.use_zone_datasource ? 1 : 0

  name         = format("%s.", var.name)
  private_zone = var.private_zone
  vpc_id       = var.vpc_id
}

resource "aws_route53_zone" "public_zone" {
  count = var.create_zone && ! var.private_zone ? 1 : 0

  name = var.name
  tags = merge(var.tags, map("Name", format("%s", var.name)))
}

resource "aws_route53_zone" "private_zone" {
  count = var.create_zone && var.private_zone ? 1 : 0

  name = var.name
  tags = merge(var.tags, map("Name", format("%s", var.name)))
  vpc {
    vpc_id = var.vpc_id
  }
}

locals {
  zone_id = var.create_zone ? join("", aws_route53_zone.public_zone.*.id, aws_route53_zone.private_zone.*.id) : join("", list(var.zone_id), data.aws_route53_zone.current.*.zone_id)
}

resource "aws_route53_zone_association" "zone" {
  count   = var.vpc_zone_associations_count
  zone_id = local.zone_id
  vpc_id  = element(var.vpc_zone_associations, count.index)
}

resource "aws_route53_record" "ns_record" {
  count   = var.ns_records_count
  zone_id = local.zone_id
  name    = lookup(var.ns_records[count.index], "name")
  type    = "NS"
  ttl     = "3600"
  records = split(",", lookup(var.ns_records[count.index], "record"))
}


resource "aws_route53_record" "a_record" {
  count   = var.a_records_count
  zone_id = local.zone_id
  type    = "A"
  ttl     = lookup(var.a_records[count.index], "ttl", "60")
  name    = lookup(var.a_records[count.index], "name")
  records = split(",", lookup(var.a_records[count.index], "record"))
}

resource "aws_route53_record" "alias_record" {
  count   = var.alias_records_count
  zone_id = local.zone_id
  type    = "A"
  name    = lookup(var.alias_records[count.index], "name")

  alias {
    name                   = lookup(var.alias_records[count.index], "aws_dns_name")
    zone_id                = lookup(var.alias_records[count.index], "zone_id")
    evaluate_target_health = lookup(var.alias_records[count.index], "evaluate_target_health")
  }
}
