#!/usr/bin/env bash

return

v03x/env.sh
v03x/runit/run
v03x/runit/log/run
v03x/runit/log/config
v03x/container/Dockerfile
v03x/container/container.json
v03x/repo/config

/opt/v03x/container/container.json
/opt/v03x/container/CURRENT => Qmfoobar
/opt/v03x/container/Qmfoobar/ ???
/opt/v03x/container/rootfs -> /opt/v03x/container/Qmfoobar
/opt/v03x/repo/config
/opt/v03x/runit/run
/opt/v03x/runit/log/config
/opt/v03x/runit/log/run
/etc/sv/v03x -> /opt/v03x/runit

# build (deps: docker)

git clone
hash=$(docker build) # this will always change if v03x_ref or Dockerfile change
echo $hash > container/CURRENT

# install (deps: runc runit)

mkdir -p /opt/v03x/{container,runit/log,repo}
file container/container.json
file container/CURRENT
file runit/run
file runit/log/run
file runit/log/config
file repo/config

if container/CURRENT changed
  ipfs get -a -o $CURRENT.tar $CURRENT
  tar -xC container/$CURRENT/
  unlink container/rootfs
  ln -s container/$CURRENT container/rootfs
  sv restart v03x
fi
if container/container.json changed || repo/config changed
  sv restart v03x
fi
# TODO check if these needs a restart
if runit/run changed
  sv restart v03x
fi
if runit/log/run changed || runit/log/config changed
  sv restart v03x/log
fi
