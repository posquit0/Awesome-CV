FROM texlive/texlive:latest@sha256:e8148b126545105c4aeeaa212f8a7bd02d05b500351372881055e1e59ae67d33

# Freeze added packages and their dependencies as well as the TeX Live image.
# Keep signature verification enabled; archived Release files have expired dates.
RUN rm -f /etc/apt/sources.list /etc/apt/sources.list.d/* \
    && printf '%s\n' \
        'deb [check-valid-until=no] https://snapshot.debian.org/archive/debian/20261020T000000Z/ forky main' \
        > /etc/apt/sources.list.d/snapshot.list \
    && apt-get update \
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
