FROM ubuntu:18.04

RUN set -ex; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
	; \
	rm -rf /var/lib/apt/lists/*

ARG VERSION

RUN curl -L https://github.com/BTCGPU/BTCGPU/archive/v${VERSION}.tar.gz | tar -xz --strip-components=1 -C /

RUN useradd -m -u 1000 -s /bin/bash runner
USER runner

ENTRYPOINT ["bgoldd"]
