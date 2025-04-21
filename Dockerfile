FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

RUN apt-get update && apt-get install -y \
  wget \
  openssh-server \
  unzip \
  sudo \
  nano \
  curl \
  qtbase5-dev \
  libxcb-cursor0

# --- Requirement done --- #

RUN mkdir /app
WORKDIR /app

# Install hitomi-downloader
RUN wget \
https://github.com/KurtBestor/Hitomi-Downloader/releases/download/Technical-Preview/hitomi_downloader_GUI_test_linux.zip
RUN unzip hitomi_downloader_GUI_test_linux.zip
RUN rm -f hitomi_downloader_GUI_test_linux.zip

# Install SpoofDPI proxy
RUN curl -fsSL https://raw.githubusercontent.com/xvzc/SpoofDPI/main/install.sh | bash -s linux-amd64

ARG CACHEBUST

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
EXPOSE 6975 22
ENTRYPOINT /app/entrypoint.sh
# CMD /bin/bash