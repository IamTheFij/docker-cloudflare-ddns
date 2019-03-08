DOCKER_TAG ?= cloudflare-ddns-dev-${USER}
default: test

test:
	@echo ok

update:
	curl -o update_ddns.py https://raw.githubusercontent.com/cloudflare/python-cloudflare/master/examples/example_update_dynamic_dns.py
	chmod +x update_ddns.py

build:
	docker build . -t ${DOCKER_TAG}

build/qemu-arm-static:
	mkdir -p build
	wget -N https://github.com/multiarch/qemu-user-static/releases/download/v2.9.1-1/x86_64_qemu-${target_arch}-static.tar.gz
	tar -xvf x86_64_qemu-${target_arch}-static.tar.gz

cross-build-arm32v6:
	docker build --build-arg REPO=arm32v6 --build-arg ARCH=arm . -t ${DOCKER_TAG}-arm32v6

run: build
	docker run --rm -e DOMAIN=${DOMAIN} \
		-e CF_API_EMAIL=${CF_API_EMAIL} \
		-e CF_API_KEY=${CF_API_KEY} \
		${DOCKER_TAG}
