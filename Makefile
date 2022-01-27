.EXPORT_ALL_VARIABLES:

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

setup: ## Setup dependencies
	@brew bundle

hooks: ## install pre commit.
	@pre-commit install
	@pre-commit gc
	@pre-commit autoupdate

validate: ## Validate files with pre-commit hooks
	@pre-commit run --all-files

.PHONY: build
build: ## Build docker image '--progress plain'
	@docker build -t spring-config .

exec: ## Exec into container
	@docker run --rm -it spring-config /bin/sh

run: ## Run docker container  -e "SPRING_PROFILES_ACTIVE=dev"
	# docker run -p 8080:8080 -t spring-config -v $(PWD)/config:/config
	@docker-compose up

reload: ## Docker compose reload
	@docker-compose restart
