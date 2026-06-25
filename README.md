# aws-tf-github-action

AWS infrastructure foundation built with Terraform and automated with GitHub Actions. It provisions networking, IAM, security, and remote state — the base layer a web application is deployed on top of. 
---


## Overview

This repository provisions the base AWS layer for hosting web applications:

- **Network** — VPC with public and private subnets across two Availability Zones, internet and NAT gateways.
- **Identity** — EC2 instance role managed via SSM, with CloudWatch logging.
- **Security** — security groups for public (web) traffic and a database tier.
- **State** — versioned, encrypted S3 backend for Terraform state, owned by the bootstrap stack.
- **Automation** — GitHub Actions for plan/apply, scheduled teardown, and release versioning.


---

## Architecture

```
                          INTERNET
                             │
                     ┌───────▼────────┐
                     │ Internet GW    │
                     └───────┬────────┘
        ┌────────────────────┴─────────────────────┐
        │                  VPC 10.0.0.0/16          │
        │                                           │
        │  PUBLIC SUBNETS (az a / az b)             │
        │   10.0.0.0/24   10.0.1.0/24               │
        │     │  NAT GW         NAT GW              │
        │     ▼                                     │
        │  PRIVATE SUBNETS (az a / az b)            │
        │   10.0.3.0/24   10.0.4.0/24               │
        │                                           │
        │  Security groups: ccSGPublic (80/443)     │
        │                   ccSGRds   (5432 ← SGPub)│
        └───────────────────────────────────────────┘

```

The codebase is split into two stacks:

| Stack | Path | State | Purpose |
|-------|------|-------|---------|
| Bootstrap | `src/bootstrap` | local | Creates and owns the S3 state bucket. Applied once. |
| Main | `src` | remote (S3) | The foundation (`cc-init` → `cc-vpc`, `cc-iam`, `cc-sec`). |

The bootstrap stack uses local state to avoid storing the state bucket's own state inside itself.

---

## Repository structure

```
.
├── .github/workflows/
│   ├── terraform.yaml        # plan + apply on push to main
│   ├── destroy.yaml          # scheduled / manual teardown
│   └── release-please.yaml   # versioning, changelog, releases (+ module publish)
├── src/
│   ├── main.tf               # backend, provider, cc-init module call
│   ├── local.tf              # environment configuration values
│   ├── bootstrap/
│   │   └── main.tf           # state-bucket stack (local state)
│   └── modules/
│       ├── cc-init/          # orchestrator
│       ├── cc-vpc/           # network
│       ├── cc-iam/           # IAM
│       ├── cc-sec/           # security groups
│       └── cc-tf-state/      # state-bucket resources (used by bootstrap)
├── release-please-config.json
├── .release-please-manifest.json
└── CHANGELOG.md
```

---

## Modules

### `cc-init`
Composes the foundation modules. The only module the root stack calls.

| Inputs | Description |
|--------|-------------|
| `vpc_cidr`, `availability_zones`, `public_subnet_cidrs`, `private_subnet_cidrs` | Passed to `cc-vpc` |
| `environment` | Deployment environment name (e.g. `dev`) |

### `cc-vpc`
Creates the VPC, an Internet Gateway, two public and two private subnets across two AZs, two NAT gateways (one per AZ) with Elastic IPs, and the route tables.

| Inputs | Default |
|--------|---------|
| `vpc_cidr` | `10.0.0.0/16` |
| `availability_zones` | — (list) |
| `public_subnet_cidrs` | — (list) |
| `private_subnet_cidrs` | — (list) |
| `environment` | `dev` |

| Outputs | Description |
|---------|-------------|
| `cc_vpc_id` | VPC ID |
| `cc_public_subnets` | Public subnet objects |
| `cc_private_subnets` | Private subnet objects |

### `cc-iam`
Creates an EC2 instance role (`ccEC2Role`) with CloudWatch agent and SSM managed instance policies, plus an instance profile. Instances are managed via SSM, so no SSH key is required.

| Inputs | Description |
|--------|-------------|
| `environment` | Environment name |

| Outputs | Description |
|---------|-------------|
| `cc_ec2_instance_profile_name` | Instance profile to attach to EC2 |
| `cc_ec2_role_arn` | Role ARN |

### `cc-sec`
Creates two security groups:
- `ccSGPublic` — inbound HTTP (80) and HTTPS (443) from the internet.
- `ccSGRds` — inbound PostgreSQL (5432) from `ccSGPublic` only.

| Inputs | Description |
|--------|-------------|
| `vpc_id` | VPC to attach the groups to |
| `environment` | Environment name |

| Outputs | Description |
|---------|-------------|
| `cc_sg_public_id` | Public-tier security group ID |
| `cc_sg_rds_id` | Database security group ID |

### `cc-tf-state`
Defines the S3 bucket that stores the main stack's Terraform state, with versioning, AES-256 encryption, and `prevent_destroy`. Used by the bootstrap stack, not by `cc-init`.

| Inputs | Description |
|--------|-------------|
| `bucket_name` | State bucket name |

---

## Prerequisites

- Terraform `>= 1.10.0`
- AWS account with permissions to create VPC, IAM, S3, and EC2 networking resources
- Local runs: AWS credentials configured
- CI: GitHub OIDC role `arn:aws:iam::987213268383:role/aws-tf-gha-github-actions-role`

---

## Deployment

### Via CI
Push to `main`. The `terraform.yaml` workflow runs format check → init → plan → apply.

### Locally
```bash
cd src
terraform init
terraform fmt -check -recursive
terraform validate
terraform plan
terraform apply
```

### Teardown
Resources are destroyed daily by `destroy.yaml` via Actions → Destroy Terraform Resources → Run workflow. 
The state bucket is not destroyed.

---

## Configuration

Environment values are in `src/local.tf`:

```hcl
locals {
  environment          = "dev"
  availability_zones   = ["ca-central-1a", "ca-central-1b"]
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.0.0/24", "10.0.1.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
}
```

---

## CI/CD workflows

| Workflow | Trigger | Steps |
|----------|---------|-------|
| `terraform.yaml` | push to `main` | `fmt -check -recursive` → `init` → `plan` → `apply` |
| `destroy.yaml` | daily `23:00 UTC` + manual dispatch | `init` → evict any stray state-bucket entry → `destroy` |
| `release-please.yaml` | push to `main` | Version bump, `CHANGELOG.md`, GitHub release, module publish |

Authentication to AWS uses GitHub OIDC.

---

## Versioning & releases

Releases use [release-please](https://github.com/googleapis/release-please) with Conventional Commits:

| Commit prefix | Version bump |
|---------------|--------------|
| `fix:` | patch |
| `feat:` | minor |
| `feat!:` / `BREAKING CHANGE:` | major |
| `chore:`, `ci:`, `refactor:`, `docs:` | no release |

On push, release-please maintains a Release PR. Merging it tags the release, generates the changelog, and (when enabled) publishes `cc-vpc` and `cc-tf-state` to the module registry.

---

## Hosting an application on top

The foundation provides the network, identity, and security an application uses. Two consumption paths:

1. Same stack — add the application's modules to `cc-init` and reference the foundation's module outputs directly (e.g. `module.cc-vpc.cc_vpc_id`, `module.cc-iam.cc_ec2_instance_profile_name`).
2. Separate stack — read the foundation's outputs via a `terraform_remote_state` data source (requires the foundation to expose root outputs).

---

## Notes

- Module publishing is disabled while the JFrog trial is expired so the publish job in `release-please.yaml` is commented out.