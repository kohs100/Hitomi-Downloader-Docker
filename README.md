# Hitomi-Downloader-Docker

Dockerized version of HDL by KurtBestor.

## Feature

- Manage ownership mismatch problem
  - This dockerization effectively solves docker's container-host fs ownership mismatch problem. ([what is ownership mismatch problem?](https://www.joyfulbikeshedding.com/blog/2021-03-15-docker-and-the-host-filesystem-owner-matching-problem.html]))
- Embedded DPI countermeasure powered by [SpoofDPI](https://github.com/xvzc/SpoofDPI).

## Usage

### Configure the installation

Open .env file and configure as you want. You should configure TARGET_UID and TARGET_GID as desired.

### Build the image

```
$ sudo docker compose build
```

### Start the container

```
$ sudo docker compose up -d
```

You may want to change port mapping.

### Initial configuration

By using _USER_IN_CONTAINER_ as username and _PASS_IN_CONTAINER_ as password, connect to the container via SSH. You should enable X passthrough by using -X or -Y option to perform initial configuration of HDL, since it does not enable HTTP API as default.

```
$ sudo docker ps -a | grep hdl-container
bf93548550e5   hdl-image:1.0                   "/bin/bash -o pipefa…"   8 minutes ago       Up 8 minutes          0.0.0.0:32786->22/tcp, :::32786->22/tcp, 0.0.0.0:32787->6975/tcp, :::32787->6975/tcp   hdl-container
```

Host port 32787 is mapped for HTTP API, and 32786 for SSH.

```
$ ssh hitomi@localhost -p 32786
```

Default username and password is hitomi / hitomi.

```
hitomi@bf93548550e5:~$ ./hitomi_downloader_GUI.bin
```

Run the binary. You may want to use `--no_admin --disable-gpu --no-brower --round_menu=False` option to make the deployment lighter.

## Recommended options

In Options > Preferences (F5)

### Use embedded DPI countermeasure

In Network, enable Proxy and set as

- Host: http://127.0.0.1
- Port: 8080

### Enable HTTP API

In Advanced, enable _HTTP API_

### Disable administrator privileges

In Advanced, enable _Run without administrator privileges_.

###

## Credit

- [Hitomi-Downloader](https://github.com/KurtBestor/Hitomi-Downloader) by KurtBestor
- [SpoofDPI](https://github.com/xvzc/SpoofDPI) by xvzc
