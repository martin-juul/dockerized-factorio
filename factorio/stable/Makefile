
# Tasks
build:
	docker build -t dockerized-factorio/factorio:stable .

build-nc:
	docker build --no-cache -t dockerized-factorio/factorio:stable .

build-clean: ## build image without cache and intermediate containers
	docker build --no-cache --force-rm -t dockerized-factorio/factorio:stable .