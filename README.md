# Hitomi-Downloader-Docker
Dockerized version of HDL by KurtBestor.

## Feature
* Manage ownership mismatch problem
  * This dockerization effectively solves docker's container-host fs ownership mismatch problem. ([what is ownership mismatch problem?](https://www.joyfulbikeshedding.com/blog/2021-03-15-docker-and-the-host-filesystem-owner-matching-problem.html]))
* Embedded DPI countermeasure powered by [SpoofDPI](https://github.com/xvzc/SpoofDPI).
## Usage
### Configure the installation
Open .env file and configure as you want. Default values should work fine.

### Build the image
```
$ ./build_docker.sh
```
If you did not specify the target uid/gid in configuration, you should not run the build script in root but with non-root user which has sudo permission.

### Start the container
```
$ ./run_example.sh
```
In example run script, it uses --publish-all flag to expose HTTP API and ssh service. Please manually check the mapped port for each service. HTTP API uses port 6975 and ssh uses 22.

### Initial configuration
By using *USER_IN_CONTAINER* as username and *PASS_IN_CONTAINER* as password, connect to the container via SSH. You should enable X passthrough by using -X or -Y option to perform initial configuration of HDL, since it does not enable HTTP API as default.
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
Run the binary. You may want to use --disable-gpu and --no-brower option to make the deployment lighter.