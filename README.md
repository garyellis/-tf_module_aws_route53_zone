# tf_module_aws_route53_zone

This module supports the following use cases:

* optionally create a public zone
* optionally create a private hosted zone and optionally associate to multiple vpcs
* create ns records from an input list of maps
* create a records from an input list of maps
* create route53 alias records from an input list of maps


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| a\_records | A list of A record maps | `list(map(string))` | `[]` | no |
| a\_records\_count | the count of items in the `a_records` list | `number` | `0` | no |
| alias\_records | A list of alias record maps | `list(map(string))` | `[]` | no |
| alias\_records\_count |  | `number` | `0` | no |
| create\_zone | Create the route53 zone | bool | `false` | no |
| ns\_records | A list of ns record maps | `list(map(string)` | `[]` | no |
| ns\_records\_count | The number of ns items in `ns_records` list | `number` | `0` | no |
| name | The zone name | `string` | n/a | yes |
| private\_zone | True when creating a private hosted zone | `bool` | `true` | no |
| tags | A map of tags applied when creating the route53 zone | `map(string)` | `{}` | no |
| vpc\_id | Required to create a private hosted zone | `string` | `""` | no |
| vpc\_zone\_associations | A list of additional vpcs to associate to the private hosted zone | `list(string)` | `[]` | no |
| vpc\_zone\_associations\_count | count of additional vpcs in `vpc_zone_associations` | `number` | `0` | no |
| use\_zone\_datasource | helper to enable datasource lookup on zone name | `bool` | `false` | no |
| zone\_id | The private hosted zone id | `string` | `""` | no |
