From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 23 Apr 2020 15:16:30 +0200
Subject: [LTP] [PATCH v5 0/2] Route tests using netlink API (dst,gw,if)
Message-ID: <20200423131632.20525-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

changes v4->v5:
* add implementation for changing interface
* lib: turn setup_addrinfo() into SAFE_GETADDRINFO() (1st commit)

route-change-netlink.c
* remove -l lhost parameter, interfaces are still created
* fixes required by Alexey:
  - use struct addrinfo. I still use char array for printing name, moved
	to the end (better for struct packing)
  - optimize char to numeric address conversion and string manipulation
	to get route destination (moved from test to setup, thus done fewer times)
  - use callback in save_item
  - change delimiter to ','

  - renamed functions

TODO:
* some further code cleanup is probably required.
* NS_TIMES=10 isn't really high enough.
shell tests could have 100 (there are some problems when higher than
300), but C tests could have it much higher (eg. 2000, but I've
tested it with the max 65535). Maybe there could be ROUTE_NS_TIMES and
ROUTE_NETLINK_NS_TIMES variables to not affect other tests which use
NS_TIMES.

Kind regards,
Petr


Petr Vorel (2):
  net: Add SAFE_GETADDRINFO()
  net/route: Add netlink based route change tests

 configure.ac                                  |   1 +
 include/mk/config.mk.in                       |   2 +
 include/tst_net.h                             |   9 +-
 include/tst_private.h                         |   1 +
 include/tst_safe_net.h                        |   6 +
 lib/tst_net.c                                 |  15 +
 m4/ltp-libmnl.m4                              |   8 +
 runtest/net_stress.route                      |   6 +
 testcases/network/netstress/netstress.c       |  20 +-
 testcases/network/stress/route/.gitignore     |   1 +
 .../network/stress/route/00_Descriptions.txt  |  40 +--
 testcases/network/stress/route/Makefile       |  30 +-
 .../network/stress/route/route-change-dst.sh  |   5 +-
 .../network/stress/route/route-change-gw.sh   |  18 +-
 .../network/stress/route/route-change-if.sh   |  61 +---
 .../stress/route/route-change-netlink-dst.sh  |  36 ++
 .../stress/route/route-change-netlink-gw.sh   |  31 ++
 .../stress/route/route-change-netlink-if.sh   |  38 +++
 .../stress/route/route-change-netlink.c       | 320 ++++++++++++++++++
 testcases/network/stress/route/route-lib.sh   | 104 +++++-
 travis/debian.cross-compile.sh                |   1 +
 travis/debian.sh                              |   1 +
 travis/fedora.sh                              |   3 +
 travis/tumbleweed.sh                          |   1 +
 24 files changed, 619 insertions(+), 139 deletions(-)
 create mode 100644 m4/ltp-libmnl.m4
 create mode 100644 testcases/network/stress/route/.gitignore
 create mode 100755 testcases/network/stress/route/route-change-netlink-dst.sh
 create mode 100755 testcases/network/stress/route/route-change-netlink-gw.sh
 create mode 100755 testcases/network/stress/route/route-change-netlink-if.sh
 create mode 100644 testcases/network/stress/route/route-change-netlink.c

-- 
2.26.1

