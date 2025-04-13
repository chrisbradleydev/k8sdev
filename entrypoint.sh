#!/bin/sh

LOCAL_PATH=${LOCAL_PATH:-default}
REMOTE_PATH=${REMOTE_PATH:-default}

# copy rclone.conf from the config map dir because
# rclone expects the config dir to be writable
cp -v /config/rclone/rclone.conf /root/.config/rclone/

rclone mount $LOCAL_PATH $REMOTE_PATH --allow-non-empty --config=/root/.config/rclone/rclone.conf
