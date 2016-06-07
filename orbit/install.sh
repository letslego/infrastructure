#!/usr/bin/env bash

set -e

target="/opt/nginx/conf.d"

reload=0

if [ ! -z "$(diff -Naur "$target/6-orbit.conf" "out/nginx.conf" || echo "new")" ]; then
  echo "orbit nginx config changed"
  reload=1
fi

mkdir -p "$target"

cp "out/nginx.conf" "$target/6-orbit.conf"

if [ "reload$reload" == "reload1" ]; then
  echo "nginx reloading"
  out=$(docker exec nginx sh -c '/etc/init.d/nginx configtest && /etc/init.d/nginx reload')
  echo $out | grep -v failed >/dev/null && echo $out && exit 1
fi
