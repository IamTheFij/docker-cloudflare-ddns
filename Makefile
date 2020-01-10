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
	./get_qemu.sh arm

build/qemu-x86_64-static:
	./get_qemu.sh x86_64

build/qemu-aarch64-static:
	./get_qemu.sh aarch64

.PHONY: cross-build-arm
cross-build-arm: build/qemu-arm-static
	docker build --build-arg REPO=arm32v6 --build-arg ARCH=arm . -t ${DOCKER_TAG}-linux-arm

.PHONY: cross-build-arm64
cross-build-arm64: build/qemu-aarch64-static
	docker build --build-arg REPO=arm64v8 --build-arg ARCH=aarch64 . -t ${DOCKER_TAG}-linux-arm64

.PHONY: run
run: build
	docker run --rm -e DOMAIN=${DOMAIN} \
		-e CF_API_EMAIL=${CF_API_EMAIL} \
		-e CF_API_KEY=${CF_API_KEY} \
		${DOCKER_TAG}
