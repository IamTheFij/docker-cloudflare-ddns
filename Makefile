DOCKER_TAG ?= cloudflare-ddns-dev-${USER}

.PHONY: default
default: test

.PHONY:test
test:
	@echo ok

.PHONY: update
update:
	curl -o update_ddns.py https://raw.githubusercontent.com/cloudflare/python-cloudflare/master/examples/example_update_dynamic_dns.py
	chmod +x update_ddns.py

.PHONY: build
build: build/qemu-x86_64-static
	docker build . -t ${DOCKER_TAG}

build/qemu-arm-static:
	./get_qemu.sh

build/qemu-x86_64-static:
	./get_qemu.sh

build/qemu-aarch64-static:
	./get_qemu.sh

.PHONY: cross-build-arm32v6
cross-build-arm32v6: build/qemu-arm-static
	docker build --build-arg REPO=arm32v6 --build-arg ARCH=arm . -t ${DOCKER_TAG}-arm32v6

.PHONY: run
run: build
	docker run --rm -e DOMAIN=${DOMAIN} \
		-e CF_API_EMAIL=${CF_API_EMAIL} \
		-e CF_API_KEY=${CF_API_KEY} \
		${DOCKER_TAG}
