FROM texlive/texlive:latest

RUN apt-get update && apt-get install -y --no-install-recommends \
      fonts-roboto \
      fonts-adobe-sourcesans3 \
    && rm -rf /var/lib/apt/lists/*

RUN luaotfload-tool --update
