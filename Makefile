default: io.buildpacks.stacks.jammy

VERSION := 5.3.0
ROOT_DIR := $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))

clean:
	rm -rf src/ dist/

console:
	@echo "Console Help"
	@echo
	@echo "Specify a verion to install:"
	@echo "    echo 5.2.1 > /env/JEMALLOC_VERSION"
	@echo
	@echo "To vendor jemalloc:"
	@echo "    bin/compile /app/ /cache/ /env/"
	@echo

	@docker run --rm -ti -v $(shell pwd):/buildpack -e "STACK=io.buildpacks.stacks.jammy" -w /buildpack paketobuildpacks/builder-jammy-full:latest \
		bash -c 'mkdir /app /cache /env; exec bash'

# Download missing source archives to ./src/
src/jemalloc-%.tar.bz2:
	mkdir -p $$(dirname $@)
	curl -fsL https://github.com/jemalloc/jemalloc/releases/download/$*/jemalloc-$*.tar.bz2 -o $@

.PHONY: io.buildpacks.stacks.jammy docker\:pull

# Updates the docker image to ensure we're building with the latest
# environment.
docker\:pull:
	docker pull paketobuildpacks/builder-jammy-full:latest

# Build for io.buildpacks.stacks.jammy stack
io.buildpacks.stacks.jammy: src/jemalloc-$(VERSION).tar.bz2 docker\:pull
	docker run --rm -it -u root --volume="$(ROOT_DIR):/wrk" \
		paketobuildpacks/builder-jammy-full:latest /wrk/build.sh $(VERSION) io.buildpacks.stacks.jammy

# Build recent releases for all supported stacks
all:
	$(MAKE) io.buildpacks.stacks.jammy VERSION=3.6.0
	$(MAKE) io.buildpacks.stacks.jammy VERSION=4.0.4
	$(MAKE) io.buildpacks.stacks.jammy VERSION=4.1.1
	$(MAKE) io.buildpacks.stacks.jammy VERSION=4.2.1
	$(MAKE) io.buildpacks.stacks.jammy VERSION=4.3.1
	$(MAKE) io.buildpacks.stacks.jammy VERSION=4.4.0
	$(MAKE) io.buildpacks.stacks.jammy VERSION=4.5.0
	$(MAKE) io.buildpacks.stacks.jammy VERSION=5.0.1
	$(MAKE) io.buildpacks.stacks.jammy VERSION=5.1.0
	$(MAKE) io.buildpacks.stacks.jammy VERSION=5.2.0
	$(MAKE) io.buildpacks.stacks.jammy VERSION=5.2.1
	$(MAKE) io.buildpacks.stacks.jammy VERSION=5.3.0
