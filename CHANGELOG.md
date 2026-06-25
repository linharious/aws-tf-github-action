# Changelog

## [1.2.0](https://github.com/linharious/aws-tf-github-action/compare/v1.1.0...v1.2.0) (2026-06-25)


### Features

* add cc-ecr module for container image registry ([314742e](https://github.com/linharious/aws-tf-github-action/commit/314742e7cc7cf3c66d8baf44d0fb8dda2de7ba30))
* establish reusable infrastructure foundation (vpc, iam, security, ci/cd) ([091c185](https://github.com/linharious/aws-tf-github-action/commit/091c185bf156489050f2e85f0d1ddc21262bb7cc))

## [1.1.0](https://github.com/linharious/aws-tf-github-action/compare/v1.0.0...v1.1.0) (2026-06-16)


### Features

* add cc-s3 app bucket and scaffold serverless modules (cc-lambda, cc-apigw) ([4b1eb4f](https://github.com/linharious/aws-tf-github-action/commit/4b1eb4ff95a9b583728158dab9fdb929b6ddd9ef))

## 1.0.0 (2026-06-15)


### Features

* add cc-iam and cc-security modules ([1d1ccd7](https://github.com/linharious/aws-tf-github-action/commit/1d1ccd7c4817c1f8ee6a7241b0653e722d788583))
* add third availability zone with subnet and NAT gateway ([a0fbe0e](https://github.com/linharious/aws-tf-github-action/commit/a0fbe0e9c8d646ac04602ed9505cbeb2c7425d89))
* remove 3rd subnet ([3d9e06e](https://github.com/linharious/aws-tf-github-action/commit/3d9e06ec527c3cebe842702cea843234d3739cbe))
* wire app_bucket_name from locals through cc-init module ([8eeabc6](https://github.com/linharious/aws-tf-github-action/commit/8eeabc6dcfd7db5d1e2b370bb65903d6b5c9f1d7))
* wire cc-iam module into cc-init ([9fcb43e](https://github.com/linharious/aws-tf-github-action/commit/9fcb43ec67251c7a156ea85ca3a094c9b394004d))


### Bug Fixes

* correct subnet_id reference for ccNatGateway2 ([10ee28f](https://github.com/linharious/aws-tf-github-action/commit/10ee28fca727facd62ab9edcf1c9e032814dae14))
* import existing s3 state bucket instead of creating ([e5065d6](https://github.com/linharious/aws-tf-github-action/commit/e5065d671df7d145368da329b26aebc33aa6ca0e))
* manage tf state bucket in separate bootstrap stack ([31987d3](https://github.com/linharious/aws-tf-github-action/commit/31987d3a2fe95e836c1f2979665d03dec9ca9e23))
* prevent S3 state bucket deletion on terraform destroy ([8d1c75d](https://github.com/linharious/aws-tf-github-action/commit/8d1c75d29f9848d8ea5cedc5b43f8c1741cc93f2))
* publish wf ([6ff800d](https://github.com/linharious/aws-tf-github-action/commit/6ff800d2fa6f8c04e44df75197f925489b37ec85))
* rename s3 state bucket for ca-central-1 ([a921d1a](https://github.com/linharious/aws-tf-github-action/commit/a921d1a74f6c59c9c4fb43a7da44b9cd44c1e28c))
* trigger both workflows for testing ([326b40c](https://github.com/linharious/aws-tf-github-action/commit/326b40ced7bc0459e7b6e6c8c59302f904f6d936))
* update jfrog server id to match pipeline setup ([3c70b2c](https://github.com/linharious/aws-tf-github-action/commit/3c70b2cca2dfe19d2f87788a3e975aab519f2c9c))
* upgrade aws provider to 5.0 ([775efb9](https://github.com/linharious/aws-tf-github-action/commit/775efb932a932282123b1ec92ec9545e9b2cee4f))
* use migrate-state for backend init ([3beb630](https://github.com/linharious/aws-tf-github-action/commit/3beb630c60229cf013d73c76894f41cd8cc6f1d0))
