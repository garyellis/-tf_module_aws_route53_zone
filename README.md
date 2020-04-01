# tf_module_aws_route53_zone

This module supports the following use cases:

* optionally create a public zone
* optionally create a private hosted zone and optionally associate to multiple vpcs
* create ns records from an input list of maps
* create a records from an input list of maps
* create route53 alias records from an input list of maps


## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| a\_records | A list of A record maps | `list(map(string))` | `[]` | no |
| a\_records\_count | n/a | `number` | `0` | no |
| alias\_records | A list of alias record maps | `list(map(string))` | `[]` | no |
| alias\_records\_count | n/a | `number` | `0` | no |
| create\_zone | Create the route53 zone | `bool` | `false` | no |
| name | The zone name | `string` | n/a | yes |
| ns\_records | n/a | `list(map(string))` | `[]` | no |
| ns\_records\_count | n/a | `number` | `0` | no |
| private\_zone | Is a private hosted zone | `bool` | `true` | no |
| tags | A map of tags applied when creating the route53 zone | `map(string)` | `{}` | no |
| use\_zone\_datasource | enable datasource lookup on zone name | `bool` | `false` | no |
| vpc\_id | Required to create a private hosted zone | `string` | `""` | no |
| vpc\_zone\_associations | A list of vpcs to associate to the zone | `list(string)` | `[]` | no |
| vpc\_zone\_associations\_count | Associate additional vpcs to the private hosted zone | `number` | `0` | no |
| zone\_id | The private hosted zone id | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| private\_zone\_id | n/a |
| private\_zone\_nameservers | n/a |
| public\_zone\_id | n/a |
| public\_zone\_nameservers | n/a |
