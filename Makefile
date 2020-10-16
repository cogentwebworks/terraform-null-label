.ONESHELL:
.SHELL := /usr/bin/bash
.PHONY : lint apply  destroy apply dry init

.PHONY : init
init:
	terraform init --var-file=$(tfvar).tfvars

.PHONY : dry
dry:
	terraform plan --var-file=$(tfvar).tfvars

.PHONY : apply
apply:
	terraform apply -auto-approve --var-file=$(tfvar).tfvars

.PHONY : destroy
destroy:
	terraform destroy -auto-approve --var-file=$(tfvar).tfvars  && rm -rf .terraform  && rm -rf  terraform.tfstate

.PHONY : lint
lint:
	terraform validate && terraform fmt

help: ## Display this information. Default target.
	@echo "Valid targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'
