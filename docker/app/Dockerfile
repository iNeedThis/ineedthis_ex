FROM elixir:1.12.0-alpine

RUN apk update \
    && apk add inotify-tools build-base git ffmpeg ffmpeg-dev npm nodejs file-dev libpng-dev gifsicle optipng libjpeg-turbo-utils librsvg imagemagick postgresql-client wget \
    && mix local.hex --force \
    && mix local.rebar --force

ADD https://api.github.com/repos/ineedthis/cli_intensities/git/refs/heads/master /tmp/cli_intensities_version.json
RUN git clone https://github.com/ineedthis/cli_intensities /tmp/cli_intensities \
    && cd /tmp/cli_intensities \
    && make -j$(nproc) install

ADD https://api.github.com/repos/ineedthis/mediatools/git/refs/heads/master /tmp/mediatools_version.json
RUN git clone https://github.com/ineedthis/mediatools /tmp/mediatools \
    && cd /tmp/mediatools \
    && make -j$(nproc) install

COPY docker/app/run-development /usr/local/bin/run-development
COPY docker/app/run-test /usr/local/bin/run-test
COPY docker/app/safe-rsvg-convert /usr/local/bin/safe-rsvg-convert
COPY docker/app/purge-cache /usr/local/bin/purge-cache
CMD run-development
