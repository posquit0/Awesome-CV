# Tex Live image
# https://hub.docker.com/r/texlive/texlive
FROM texlive/texlive:latest

ARG USER_UID=1000
ARG USER_GID=${USER_UID}
RUN useradd --create-home --shell /bin/bash --uid ${USER_UID} tex && groupmod --gid ${USER_GID} tex
