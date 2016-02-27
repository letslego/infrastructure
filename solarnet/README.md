An insightful description of what we're actually running will follow.
For now, bear with this rump readme for Provsn, and the units code itself.


✔ ✘

``` sh
$ provsn deploy
spacerock: build ... ok
spacerock: upload ... ok
spacerock: install ... ok

$ provsn deploy -v
spacerock: build
spacerock:   ipfs ... ok
spacerock:   nginx ... ok
spacerock:   gateway ... ok
spacerock: build finished in 1.432s
spacerock: upload
spacerock:   17 files, 432 KB ... ok
spacerock: upload finished in 0.765s
spacerock: install
spacerock:   ipfs ... ok
spacerock:   nginx ... ok
spacerock:   gateway
spacerock:     change /opt/nginx/conf/gateway.conf ... ok
spacerock:     test nginx config ... fail
spacerock: nginx: [emerg] "server" directive is not allowed here in /opt/nginx/conf/gateway.conf:147
spacerock: nginx: configuration file /opt/nginx/conf/nginx.conf test failed
provsn: debug information preserved in .provsn/debug/
provsn: 3 hosts, 2 ok, 1 fail
```


# Provsn

Provsn is infrastructure provisioning in one self-contained shell script.
It's meant to be as simple, fast, and direct as possible.

There is no dependency hell, no weird SSH libraries,
and no obscurity through DSLs on top of DSLs.
Just plain shell scripts and good old OpenSSH.

Provsn supports parallel execution, secrets, dry runs,
host grouping, overriding of variables, templating, and one-off commands.

**Please note:** Provsn is still in its earliest stages.
The code is bad, and I should feel bad ;)
Help me out by reviewing it,
and pointing out pieces that could be simpler, more solid, or more direct.
Also, let me know what you like about it compared to e.g. Ansible or Chef.

- Introduction
- Getting started
- Hosts and groups
  - Naming conventions
- Units and unit.sh
  - Base unit
    - ~~sets provsn_hosts provsn_groups var_units var_ssh~~
  - Using
- The three stages
  - Build
  - Upload
  - Install
- Commands
  - hosts
  - units
  - dryrun
  - deploy
  - run
  - exec
- Tips and tricks
  - The tiniest possible project
  - Testing
  - Cloud orchestration
- Reference
  - $provsn_hosts
  - $provsn_groups
  - $provsn_root
  - $provsn_units
    - Load order
  - $provsn_host
  - $provsn_unit
  - provsn_var
    - Precedence
  - provsn_template
  - provsn_dry


## Introduction

Provsn is a self-contained bash script
and operates on a defined set of *hosts*.
Hosts can be assembled in named *groups*,
and be assigned *units* which execute code on each host.

~~It scans for *units*, which is every sub-directory containing a `unit.sh` file.
The units can contain scripts for the *build* and *install* stages,
and arbitrary other files.~~

Provsn devides the deploy process into three stages:

- Build
- Upload
- Install

The *build* stage runs locally and builds the configuration and files for each host.
Units can provide a `build.sh` script for this purpose.

The *upload* stage uploads the individual build to each host.

The *install* stage runs on each host, and applies changes to it.
This includes changed files, updated docker images, restarting processes, etc.
Units can provide an `install.sh` script for this purpose

## Getting started

```sh
# print setup and usage help
$ provsn

# test ssh connectivity and secrets setup
$ provsn test

# build, upload, and install changes
$ provsn deploy
```


### TODO
- [x] run arbitrary scripts (build, install, foobar)
- [x] upload units and provsn itself
- [x] prepare a complete tree for upload (1 scp call per host)
- [x] proper commands
- [ ] secrets
- [ ] groups
- [ ] parallelism
- [ ] screen
- [ ] rocksolid error handling
  - [ ] maybe: json return values from sub-processes
- [ ] make sure hosts have up-to-date build tree
