#!/usr/bin/env bash

provsn_hosts=(pluto neptune uranus saturn jupiter venus earth mercury pollux biham nihal phobos deimos)
provsn_groups=(gateway bootstrapper storage metrics pinbot pages)

# provsn_hosts=(pluto neptune uranus saturn jupiter venus earth mercury pollux biham nihal)
# provsn_hosts=(pluto neptune uranus saturn jupiter venus earth mercury)
default_units=(base docker mtail)

gateway_hosts=(pluto neptune uranus saturn jupiter venus earth mercury)
gateway_units=(ipfs secrets/ipfs ipfs/v03x ipfs/multireq)

bootstrapper_hosts=(${gateway_hosts[@]})
bootstrapper_units=(ipfs secrets/ipfs)

storage_hosts=(pollux biham nihal)
storage_units=(ipfs secrets/ipfs)

metrics_hosts=(phobos)
metrics_units=()

pinbot_hosts=(deimos)
pinbot_units=()

pages_hosts=()
pages_units=()

default_ssh_options="-o ConnectTimeout=30"
default_omit_build=(secrets/ipfs)

pluto_ssh="root@104.236.179.241"
neptune_ssh="root@104.236.176.52"
uranus_ssh="root@162.243.248.213"
saturn_ssh="root@128.199.219.111"
jupiter_ssh="root@104.236.151.122"
venus_ssh="root@104.236.76.40"
earth_ssh="root@178.62.158.247"
mercury_ssh="root@178.62.61.185"
pollux_ssh="root@5.9.59.34"
biham_ssh="root@188.40.114.11"
nihal_ssh="root@188.40.116.66"
phobos_ssh="root@104.131.3.162"
deimos_ssh="root@46.101.230.158"
