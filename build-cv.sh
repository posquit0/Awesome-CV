#!/usr/bin/env bash
podman container run --rm -it -v $(pwd):/workdir danteev/texlive make cv.pdf
