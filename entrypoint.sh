#!/bin/bash
# Run as root

INIT_PLACEHOLDER="/.if_exists_already_initialized"

if [ ! -e $INIT_PLACEHOLDER ]; then
  touch $INIT_PLACEHOLDER

  export UNAME=${UNAME:-"hitomi"}
  export UPASS=${UPASS:-"hitomi"}

  groupadd --gid $EGID $UNAME
  useradd --create-home \
    --shell /bin/bash \
    --gid $EGID \
    --uid $EUID \
    -G sudo \
    $UNAME

  echo "${UNAME}:${UPASS}" | chpasswd

  chown -R $UNAME /app

  echo "export QT_XCB_GL_INTEGRATION=none" >> /home/$UNAME/.bashrc
fi

export QT_XCB_GL_INTEGRATION=none
export LANG=C.UTF-8

echo "Using X server at $DISPLAY ..."

su --preserve-environment \
   --command "/app/hitomi_downloader_GUI.bin --no_browser --disable_gpu --round_menu=False" \
   $UNAME