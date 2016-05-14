#!/usr/bin/env bash

set -e

for page in $(comm -23 pages /opt/pages/pages); do
  echo "$host: create page $page"
  ./sshcommand create $page "/opt/pages/$page/page.sh"
  cp -avx "out/$page" "/opt/pages/$page"
  ln -s "/opt/pages/$page" "/etc/sv/pages-$page"
  sv start "pages-$page"
done

for page in $(comm -12 pages /opt/pages/pages); do
  echo "$host: remove page $page"
  sv stop "pages-$page"
  unlink "/etc/sv/pages-$page"
  deluser "$page"
  rm -rv "/home/$page" "/opt/pages/$page"
done

cp pages /opt/pages/pages

for page in $(cat pages); do
  for user in $(lookup pages_$page'_users'); do
    ./sshcommand acl-add
  done
done
