SHELL := /bin/bash

# Variables
TF_DIR := ./terraform
TF_CMD := terraform

# Targets
.PHONY: init plan apply

init:
	cd $(TF_DIR) && $(TF_CMD) init

plan:
	cd $(TF_DIR) && $(TF_CMD) plan

apply:
	cd $(TF_DIR) && $(TF_CMD) apply

destroy:
	cd $(TF_DIR) && $(TF_CMD) destroy