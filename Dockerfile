FROM texlive/texlive:latest

RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
        fonts-roboto \
        fonts-adobe-sourcesans3 \
        make \
    && rm -rf /var/lib/apt/lists/*

# Keep font and TeX caches writable when running with the host user's UID.
ENV TEXMFVAR=/tmp/texmf-var \
    TEXMFCONFIG=/tmp/texmf-config \
    XDG_CACHE_HOME=/tmp/.cache

WORKDIR /doc
CMD ["make"]
