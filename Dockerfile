FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

RUN apt-get update && \
    apt-get install -y \
      qtbase5-dev \
      libxcb-cursor0 && \
    rm -rf /var/lib/apt/lists/*

# --- Requirement done --- #

RUN mkdir /app
WORKDIR /app

# Install hitomi-downloader
COPY hitomi_downloader_GUI.bin /app/hitomi_downloader_GUI.bin

ARG CACHEBUST

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

EXPOSE 6975
ENTRYPOINT /app/entrypoint.sh
