#!/bin/bash
# Run as root

service ssh restart

INIT_PLACEHOLDER="/.if_exists_already_initialized"

if [ ! -e /$INIT_PLACEHOLDER ]; then
  touch /$INIT_PLACEHOLDER

  groupadd --gid $EGID $UNAME
  useradd --create-home \
    --shell /bin/bash \
    --gid $EGID \
    --uid $EUID \
    -G sudo \
    $UNAME

  echo "${UNAME}:${UPASS}" | chpasswd

  chown $UNAME /app
  chown $UNAME /app/hitomi_downloader_GUI.bin
  chown $UNAME /app/hitomi_downloader_GUI.ini
  chown $UNAME /app/hitomi_downloaded

  echo "export QT_XCB_GL_INTEGRATION=none" >> /home/$UNAME/.bashrc
fi

# script that should run the rest of the times (instances where you
# stop/restart containers).

~/.spoofdpi/bin/spoofdpi