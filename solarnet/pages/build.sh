#!/usr/bin/env bash

echo "${pages[@]}" > out/pages
for page in ${pages[@]}; do
  lookup pages_$page'_private_key' > "out/$page.key"
  echo "/ipns/$(lookup pages_$page'_peerid')" > "out/$page.ref"
done
