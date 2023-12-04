# ecs-terraform

Execute at entry point

```bash
# Move work directory
$ cd src/envs/staging

# Initialize
$ terraform init

# Resource Apply
$ terraform apply -var="domain_name=example.com"
```

Execute at work directory

```bash
# Pre-commit checks
$ sh scripts/pre-commit.sh
```
