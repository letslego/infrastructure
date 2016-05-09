#!/usr/bin/env bash

set -e

cache_dir="$provsn_root/.cache"
build_dir="container/build"

repo="$(lookup v03x_git)"
ref="$(lookup v03x_ref)"

cache_key="$(echo "$repo" | ipfs add -n | cut -d' ' -f3)"
cached_repo="$cache_dir/$cache_key"
if [ ! -d "$cached_repo" ]; then
  git clone --bare "$repo" "$cached_repo"
else
  git --git-dir="$cached_repo" fetch
fi

git clone "$cached_repo" "$build_dir"
git --work-tree="$build_dir" --git-dir="$build_dir/.git" reset --hard "$ref"

image=$(docker build -q "$build_dir")
# want to have the container rootfs instead
hash=$(docker save "$image" | ipfs tar add)
echo $hash > container/CURRENT

echo "$host: v03x container is $hash"
