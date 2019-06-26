output "public_zone_nameservers" {
  value = flatten(aws_route53_zone.public_zone.*.name_servers)
}

output "public_zone_id" {
  value = join("", aws_route53_zone.public_zone.*.zone_id)
}
