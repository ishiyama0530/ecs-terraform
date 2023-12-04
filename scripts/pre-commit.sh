terraform fmt --recursive
terraform validate
tfsec .
terraform-docs markdown table --output-file README.md --output-mode inject ./src/envs/staging
