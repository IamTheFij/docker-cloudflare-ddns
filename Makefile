DOCKER_TAG ?= cloudflare-ddns-dev-${USER}
.PHONY: clean

.PHONY: default
default: test

.PHONY:test
test:
	@echo ok

.PHONY: build
build:
	docker build . -t ${DOCKER_TAG}

.PHONY: cross-build-arm
cross-build-arm:
	docker build --build-arg REPO=arm32v7 --build-arg ARCH=arm . -t ${DOCKER_TAG}-linux-arm

.PHONY: cross-build-arm64
cross-build-arm64:
	docker build --build-arg REPO=arm64v8 --build-arg ARCH=aarch64 . -t ${DOCKER_TAG}-linux-arm64

.PHONY: all
all: build cross-build-arm cross-build-arm64

.PHONY: run
run: build
	docker run --rm  \
		-e CF_API_EMAIL=${CF_API_EMAIL} \
		-e CF_API_KEY=${CF_API_KEY} \
		${DOCKER_TAG} \
		"${DOMAIN}"
