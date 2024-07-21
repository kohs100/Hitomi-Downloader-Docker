FROM ubuntu:24.04

ARG EUID
ARG EGID
ARG UNAME=hitomi
ARG UPASS=hitomi

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

# Create user
RUN groupadd --gid ${EGID} ${UNAME}
RUN useradd \
  --create-home \
  --shell /bin/bash \
  --gid ${EGID} \
  --uid ${EUID} \
  -G sudo \
  ${UNAME}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo "${UNAME}:${UPASS}" | chpasswd

USER ${UNAME}
WORKDIR /home/${UNAME}
RUN mkdir /home/${UNAME}/hitomi_downloaded

# Install hitomi-downloader
RUN wget \
https://github.com/KurtBestor/Hitomi-Downloader/releases/download/Technical-Preview/hitomi_downloader_GUI_test_linux.zip
RUN unzip hitomi_downloader_GUI_test_linux.zip
RUN rm -f hitomi_downloader_GUI_test_linux.zip

# Install SpoofDPI proxy
USER root
WORKDIR /root
RUN curl -fsSL https://raw.githubusercontent.com/xvzc/SpoofDPI/main/install.sh | bash -s linux

COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh
EXPOSE 6975 22
ENTRYPOINT /root/entrypoint.sh