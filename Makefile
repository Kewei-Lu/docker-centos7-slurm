# Configure shell
SHELL = bash -e -o pipefail

HTTP_PROXY = ${http_proxy}
HTTPS_PROXY = ${https_proxy}
REGISTRY ?= 
GIT_TOKEN ?=

docker-build: ## @HELP Build docker image
	docker build --platform=linux/x86_64 \
		--build-arg SLURM_TAG="slurm-23-02-5-1" \
		-t docker-centos7-slurm:23.02.5 \
		-f ./Dockerfile \
		--build-arg http_proxy=${HTTP_PROXY} \
		--build-arg https_proxy=${HTTPS_PROXY} \
		--build-arg GIT_TOKEN=${GIT_TOKEN} .

