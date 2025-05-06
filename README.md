# Hitomi-Downloader-Docker

Dockerized version of HDL by KurtBestor.

## Feature

- Manage ownership mismatch problem
  - This dockerization effectively solves docker's container-host fs ownership mismatch problem. ([what is ownership mismatch problem?](https://www.joyfulbikeshedding.com/blog/2021-03-15-docker-and-the-host-filesystem-owner-matching-problem.html]))

## Usage

### Configuration

From `docker-compose.yml`:
```
services:
  hdl:
    image: kohs100/docker-hdl:latest
    environment:
      - EUID=1001       # Set as id -u
      - EGID=1001       # Set as id -g
      - TZ=Asia/Tokyo
      - DISPLAY=xpra:0.0
    volumes:
      - "./hdl_sqlite.db:/app/hitomi_downloader_GUI.ini"
      - "./downloaded:/app/hitomi_downloaded"
    ports:
      - 36975:6975
```
Set proper EUID and EGID as desired. It is recommended to use hdl_sqlite.db as provided otherwise you have it initialized already. You also may want to change port mapping, or disable it if you do not use HTTP API feature.

```
  xpra:
    image: kohs100/docker-xpra:latest
    environment:
      - TZ=Asia/Tokyo
      - DISPLAY=:0.0
      # - PORT=8080
      # - WIDTH=1920
      # - HEIGHT=1080
      # - DEPTH=24
      # - BITPERPIXEL=32
    ports:
      - 38080:8080
```
You may want to change 38080 into some port you want.

### Start the container
```
$ sudo docker compose up -d
```
Open http://localhost:38080 to access web interface.

## Recommended options

In Options > Preferences (F5)

### Enable HTTP API

In Advanced, enable _HTTP API_

### Disable administrator privileges

In Advanced, enable _Run without administrator privileges_.

## Credit

- [Hitomi-Downloader](https://github.com/KurtBestor/Hitomi-Downloader) by KurtBestor
- [docker-xpra](https://github.com/kohs100/docker-xpra) by me