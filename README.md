
<!-- markdownlint-disable -->
# terraform-helm-merge-values [![Latest Release](https://img.shields.io/github/release/cloudposse/terraform-example-module.svg)](https://github.com/cloudposse/terraform-example-module/releases/latest) [![Slack Community](https://slack.cloudposse.com/badge.svg)](https://slack.cloudposse.com) [![Discourse Forum](https://img.shields.io/discourse/https/ask.sweetops.com/posts.svg)](https://ask.sweetops.com/)
<!-- markdownlint-restore -->

![BioAnalyze Logo](https://raw.githubusercontent.com/Dabble-of-DevOps-BioAnalyze/biohub-info/master/logos/BioAnalyze_v2-01.jpg)

<!--




  ** DO NOT EDIT THIS FILE
  **
  ** This file was automatically generated by the `build-harness`.
  ** 1) Make all changes to `README.yaml`
  ** 2) Run `make init` (you only need to do this once)
  ** 3) Run`make readme` to rebuild this file.
  **
  ** (We maintain HUNDREDS of open source projects. This is how we maintain our sanity.)
  **





-->

Terraform module to deploy a multiuser Jupyterhub + Dask Cluster on an existing EKS cluster using the DaskHub helm chart. It deploys the DaskHub Helm chart, and optionally configures SSL for you if you are using a domain name on AWS hosted with Route53.


---

This project is part of the ["BioAnalyze"](https://www.dabbleofdevops.com/biohub) project, which aims to make High Performance Compute Architecture accessible to everyone.


It's 100% Open Source and licensed under the [APACHE2](LICENSE).






## Data Science Infrastructure on AWS

![BioAnalyze Logo](https://raw.githubusercontent.com/dabble-of-devops-bioanalyze/biohub-info/master/images/BioAnalyze-Ecosystem-Data-Visualization.jpeg)




## Introduction

This module was written because:

  ```
    helm install release_name chart \
      --values values1.yaml \
      --values values2.yaml \
      --values values3.yaml
  ```

  Does not merge the values yaml files. I wanted to be able to write my files separately, and then combine at the end.



**IMPORTANT:** We do not pin modules to versions in our examples because of the
difficulty of keeping the versions in the documentation in sync with the latest released versions.
We highly recommend that in your code you pin the version to the exact version you are
using so that your infrastructure remains stable, and update versions in a
systematic way so that they do not catch you by surprise.

Also, because of a bug in the Terraform registry ([hashicorp/terraform#21417](https://github.com/hashicorp/terraform/issues/21417)),
the registry shows many of our inputs as required when in fact they are optional.
The table below correctly indicates which inputs are required.


*External Dependencies*
You must have the python module `hiyapyco` installed.

```
pip install hiyapyco
```

For a complete example, see [examples/complete](examples/complete).

For automated tests of the complete example using [bats](https://github.com/bats-core/bats-core) and [Terratest](https://github.com/gruntwork-io/terratest)
(which tests and deploys the example on AWS), see [test](test).

For more information on how to handle filepaths in terraform see the [file functions docs](https://www.terraform.io/docs/language/functions/abspath.html) and [path functions](https://www.terraform.io/docs/language/expressions/references.html#filesystem-and-workspace-info).

```hcl
module "merge_values" {
  source = "dabble-of-devops-biodeploy/merge-values/helm"

  helm_values_files = [
  abspath("helm_charts/daskhub/secrets.yaml")
  ]
  helm_values_dir = abspath("${path.module}/")

  context = module.this.context
}
```


## Examples

Here is an example of using this module:
- [`examples/complete`](https://github.com/dabble-of-devops-biodeploy/terraform-helm-merge-values/) - complete example of using this module



<!-- markdownlint-disable -->
## Makefile Targets
```text
Available targets:

  help                                Help screen
  help/all                            Display help for all targets
  help/short                          This help short screen
  lint                                Lint terraform code

```
<!-- markdownlint-restore -->
<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 1.2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [null_resource.merge_yamls](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_string.computed_values](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_helm_release_merged_values_file"></a> [helm\_release\_merged\_values\_file](#input\_helm\_release\_merged\_values\_file) | Path to merged helm files. If none is supplied one will be created for you. | `string` | `""` | no |
| <a name="input_helm_values_dir"></a> [helm\_values\_dir](#input\_helm\_values\_dir) | Directory to store additional daskhub values files. | `string` | n/a | yes |
| <a name="input_helm_values_files"></a> [helm\_values\_files](#input\_helm\_values\_files) | Paths to additional values files to pass into the helm install command. | `list(string)` | `[]` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_helm_release_merged_values_file"></a> [helm\_release\_merged\_values\_file](#output\_helm\_release\_merged\_values\_file) | n/a |
| <a name="output_helm_values_dir"></a> [helm\_values\_dir](#output\_helm\_values\_dir) | n/a |
| <a name="output_helm_values_files"></a> [helm\_values\_files](#output\_helm\_values\_files) | Listing the values file for debugging |
| <a name="output_merge_helm_values_files_command"></a> [merge\_helm\_values\_files\_command](#output\_merge\_helm\_values\_files\_command) | n/a |
<!-- markdownlint-restore -->




## Share the Love

Like this project? Please give it a ★ on [our GitHub](https://github.com/dabble-of-devops-biodeploy/terraform-helm-merge-values)! (it helps **a lot**)



## Related Projects

Check out these related projects.

- [terraform-aws-eks-autoscaling](https://github.com/dabble-of-devops-biodeploy/terraform-aws-eks-autoscaling) - Terraform module to provision an Autoscaling EKS Cluster. Acts as a wrapper around cloudposse/terraform-aws-eks-cluster and cloudposse/terraform-aws-eks-node-groups
- [terraform-aws-eks-cluster](https://github.com/cloudposse/terraform-aws-eks-workers) - Terraform module to deploy an AWS EKS Cluster.
- [terraform-aws-eks-node-group](https://github.com/cloudposse/terraform-aws-eks-node-group) - Terraform module to provision an EKS Node Group
- [terraform-null-label](https://github.com/cloudposse/terraform-null-label) - Terraform module designed to generate consistent names and tags for resources. Use terraform-null-label to implement a strict naming convention.


## References

For additional context, refer to some of these links.

- [Terraform Standard Module Structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure) - HashiCorp's standard module structure is a file and directory layout we recommend for reusable modules distributed in separate repositories.
- [Terraform Module Requirements](https://www.terraform.io/docs/registry/modules/publish.html#requirements) - HashiCorp's guidance on all the requirements for publishing a module. Meeting the requirements for publishing a module is extremely easy.
- [Terraform `random_integer` Resource](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) - The resource random_integer generates random values from a given range, described by the min and max attributes of a given resource.
- [Terraform Version Pinning](https://www.terraform.io/docs/configuration/terraform.html#specifying-a-required-terraform-version) - The required_version setting can be used to constrain which versions of the Terraform CLI can be used with your configuration


## Help

**Got a question?** We got answers.

File a GitHub [issue](https://github.com/dabble-of-devops-biodeploy/terraform-helm-merge-values/issues), send us an jillian@dabbleofdevops.com.

## Bioinformatics Infrastructure on AWS for Startups

I'll help you build your data science cloud infrastructure from the ground up so you can own it using open source software. Then I'll show you how to operate it and stick around for as long as you need us.

[Learn More](https://www.dabbleofdevops.com)

Work directly with me via email, slack, and video conferencing.

- **Scientific Workflow Automation and Optimization.** Got workflows that are giving you trouble? Let's work together to ensure that your analyses run with or without your scientists being fully caffeinated.
- **High Performance Compute Infrastructure.** Highly available, auto scaling clusters to analyze *all the (bioinformatics related!) things*. All setups are completely integrated with your workflow system of choice, whether that is Airflow, Prefect, Snakemake or Nextflow.
- **Kubernetes and AWS Batch Setup for Apache Airflow** Orchestrate your Bioinformatics Workflows with Apache Airflow. Get full auditing, SLA, logging and monitoring for your workflows running on AWS Batch.
- **High Performance Compute Setup that Int** You'll have built-in governance with accountability and audit logs for all changes.
- **Docker Images** Get advice and hands on training for your team to build complex software stacks onto docker images.
- **Training.** You'll receive hands-on training so your team can operate what we build.
- **Questions.** You'll have a direct line of communication between our teams via a Shared Slack channel.
- **Troubleshooting.** You'll get help to triage when things aren't working.
- **Bug Fixes.** We'll rapidly work with you to fix any bugs in our projects.

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/dabble-of-devops-biodeploy/terraform-helm-merge-values/issues) to report any bugs or file feature requests.

### Developing

If you are interested in being a contributor and want to get involved in developing this project or help out with other projects, I would love to hear from you! Shoot me an email at jillian@dabbleofdevops.com.

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull Request** so that we can review your changes

#### Developer Notes

The `README.md` is created using the standard [CloudPosse](https://github.com/cloudposse/terraform-example-module) template that has been modified to use BioAnalyze information and URLs, and other documentation is generated using [jupyter-book](https://jupyterbook.org/).

Terraform code does not render properly when using the `literalinclude` directive, so instead we use `pygmentize` to render it to html which is included directly.

```
.. raw:: html
   :file: ./_html/main.tf.html
```

**NOTE:** Be sure to merge the latest changes from "upstream" before making a pull request!



## Copyrights

Copyright © 2020-2021 [Dabble of DevOps, SCorp](https://www.dabbleofdevops.com)





## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

```text
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
```









## Trademarks

All other trademarks referenced herein are the property of their respective owners.



### Contributors

<!-- markdownlint-disable -->
|  [![Jillian Rowe][jerowe_avatar]][jerowe_homepage]<br/>[Jillian Rowe][jerowe_homepage] |
<!-- markdownlint-restore -->

  [jerowe_homepage]: https://github.com/jerowe
  [jerowe_avatar]: https://img.cloudposse.com/150x150/https://github.com/jerowe.png

Learn more at [Dabble of DevOps](https://www.dabbleofdevops.com)

## Sponsor

BioAnalyze is and will always be open source. If you've found any of these resources helpful, please consider donating to the continued development of BioAnalyze.

[Sponsor BioAnalyze](https://github.com/sponsors/dabble-of-devops-bioanalyze)

  [logo]: https://cloudposse.com/logo-300x69.svg
  [docs]: https://cpco.io/docs?utm_source=github&utm_medium=readme&utm_campaign=dabble-of-devops-biodeploy/terraform-helm-merge-values&utm_content=docs
  [website]: https://cpco.io/homepage?utm_source=github&utm_medium=readme&utm_campaign=dabble-of-devops-biodeploy/terraform-helm-merge-values&utm_content=website
  [github]: https://cpco.io/github?utm_source=github&utm_medium=readme&utm_campaign=dabble-of-devops-biodeploy/terraform-helm-merge-values&utm_content=github
  [jobs]: https://cpco.io/jobs?utm_source=github&utm_medium=readme&utm_campaign=dabble-of-devops-biodeploy/terraform-helm-merge-values&utm_content=jobs
  [hire]: https://cpco.io/hire?utm_source=github&utm_medium=readme&utm_campaign=dabble-of-devops-biodeploy/terraform-helm-merge-values&utm_content=hire
  [slack]: https://cpco.io/slack?utm_source=github&utm_medium=readme&utm_campaign=dabble-of-devops-biodeploy/terraform-helm-merge-values&utm_content=slack
  [linkedin]: https://cpco.io/linkedin?utm_source=github&utm_medium=readme&utm_campaign=dabble-of-devops-biodeploy/terraform-helm-merge-values&utm_content=linkedin
  [twitter]: https://cpco.io/twitter?utm_source=github&utm_medium=readme&utm_campaign=dabble-of-devops-biodeploy/terraform-helm-merge-values&utm_content=twitter
  [testimonial]: https://cpco.io/leave-testimonial?utm_source=github&utm_medium=readme&utm_campaign=dabble-of-devops-biodeploy/terraform-helm-merge-values&utm_content=testimonial
  [office_hours]: https://cloudposse.com/office-hours?utm_source=github&utm_medium=readme&utm_campaign=dabble-of-devops-biodeploy/terraform-helm-merge-values&utm_content=office_hours
  [newsletter]: https://cpco.io/newsletter?utm_source=github&utm_medium=readme&utm_campaign=dabble-of-devops-biodeploy/terraform-helm-merge-values&utm_content=newsletter
  [discourse]: https://ask.sweetops.com/?utm_source=github&utm_medium=readme&utm_campaign=dabble-of-devops-biodeploy/terraform-helm-merge-values&utm_content=discourse
  [email]: https://cpco.io/email?utm_source=github&utm_medium=readme&utm_campaign=dabble-of-devops-biodeploy/terraform-helm-merge-values&utm_content=email
  [commercial_support]: https://cpco.io/commercial-support?utm_source=github&utm_medium=readme&utm_campaign=dabble-of-devops-biodeploy/terraform-helm-merge-values&utm_content=commercial_support
  [we_love_open_source]: https://cpco.io/we-love-open-source?utm_source=github&utm_medium=readme&utm_campaign=dabble-of-devops-biodeploy/terraform-helm-merge-values&utm_content=we_love_open_source
  [terraform_modules]: https://cpco.io/terraform-modules?utm_source=github&utm_medium=readme&utm_campaign=dabble-of-devops-biodeploy/terraform-helm-merge-values&utm_content=terraform_modules
  [readme_header_img]: https://cloudposse.com/readme/header/img
  [readme_header_link]: https://cloudposse.com/readme/header/link?utm_source=github&utm_medium=readme&utm_campaign=dabble-of-devops-biodeploy/terraform-helm-merge-values&utm_content=readme_header_link
  [readme_footer_img]: https://cloudposse.com/readme/footer/img
  [readme_footer_link]: https://cloudposse.com/readme/footer/link?utm_source=github&utm_medium=readme&utm_campaign=dabble-of-devops-biodeploy/terraform-helm-merge-values&utm_content=readme_footer_link
  [readme_commercial_support_img]: https://cloudposse.com/readme/commercial-support/img
  [readme_commercial_support_link]: https://cloudposse.com/readme/commercial-support/link?utm_source=github&utm_medium=readme&utm_campaign=dabble-of-devops-biodeploy/terraform-helm-merge-values&utm_content=readme_commercial_support_link
  [share_twitter]: https://twitter.com/intent/tweet/?text=terraform-helm-merge-values&url=https://github.com/dabble-of-devops-biodeploy/terraform-helm-merge-values
  [share_linkedin]: https://www.linkedin.com/shareArticle?mini=true&title=terraform-helm-merge-values&url=https://github.com/dabble-of-devops-biodeploy/terraform-helm-merge-values
  [share_reddit]: https://reddit.com/submit/?url=https://github.com/dabble-of-devops-biodeploy/terraform-helm-merge-values
  [share_facebook]: https://facebook.com/sharer/sharer.php?u=https://github.com/dabble-of-devops-biodeploy/terraform-helm-merge-values
  [share_googleplus]: https://plus.google.com/share?url=https://github.com/dabble-of-devops-biodeploy/terraform-helm-merge-values
  [share_email]: mailto:?subject=terraform-helm-merge-values&body=https://github.com/dabble-of-devops-biodeploy/terraform-helm-merge-values
  [beacon]: https://ga-beacon.cloudposse.com/UA-76589703-4/dabble-of-devops-biodeploy/terraform-helm-merge-values?pixel&cs=github&cm=readme&an=terraform-helm-merge-values
