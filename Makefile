DOCKER_TAG ?= cloudflare-ddns-dev-${USER}
default: test

test:
	@echo ok

update:
	curl -o update_ddns.py https://raw.githubusercontent.com/cloudflare/python-cloudflare/master/examples/example_update_dynamic_dns.py
	chmod +x update_ddns.py

build:
	docker build . -t ${DOCKER_TAG}

run: build
	docker run --rm -e DOMAIN=${DOMAIN} \
		-e CF_API_EMAIL=${CF_API_EMAIL} \
		-e CF_API_KEY=${CF_API_KEY} \
		${DOCKER_TAG}
