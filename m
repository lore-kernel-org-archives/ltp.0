From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Apr 2020 21:23:37 +0200
Subject: [LTP] [PATCH v6 0/3]	Route tests using netlink API (dst,gw,if)
Message-ID: <20200429192340.14252-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey, Cyril,

changes v5->v6:

* new commit: Add $ROUTE_CHANGE_IP and $ROUTE_CHANGE_NETLINK variables
(increase, but better not affect $NS_TIMES as used by other tests)

* route-change-netlink.c: Better error handling with
brk_on_route_error() (Alexey), use global prefix
variable in rtnl_route().

Kind regards,
Petr

Petr Vorel (3):
  net: Add SAFE_GETADDRINFO()
  net/route: Add netlink based route change tests
  route: Increase default loop values

 configure.ac                                  |   1 +
 include/mk/config.mk.in                       |   2 +
 include/tst_net.h                             |   9 +-
 include/tst_private.h                         |   1 +
 include/tst_safe_net.h                        |   6 +
 lib/tst_net.c                                 |  15 +
 m4/ltp-libmnl.m4                              |   8 +
 runtest/net_stress.route                      |   6 +
 testcases/lib/tst_net.sh                      |   2 +
 testcases/network/netstress/netstress.c       |  20 +-
 testcases/network/stress/route/.gitignore     |   1 +
 .../network/stress/route/00_Descriptions.txt  |  40 +--
 testcases/network/stress/route/Makefile       |  30 +-
 .../network/stress/route/route-change-dst.sh  |   7 +-
 .../network/stress/route/route-change-gw.sh   |  14 +-
 .../network/stress/route/route-change-if.sh   |  59 +---
 .../stress/route/route-change-netlink-dst.sh  |  36 ++
 .../stress/route/route-change-netlink-gw.sh   |  33 ++
 .../stress/route/route-change-netlink-if.sh   |  39 +++
 .../stress/route/route-change-netlink.c       | 327 ++++++++++++++++++
 testcases/network/stress/route/route-lib.sh   | 103 +++++-
 travis/debian.cross-compile.sh                |   1 +
 travis/debian.sh                              |   1 +
 travis/fedora.sh                              |   3 +
 travis/tumbleweed.sh                          |   1 +
 25 files changed, 632 insertions(+), 133 deletions(-)
 create mode 100644 m4/ltp-libmnl.m4
 create mode 100644 testcases/network/stress/route/.gitignore
 create mode 100755 testcases/network/stress/route/route-change-netlink-dst.sh
 create mode 100755 testcases/network/stress/route/route-change-netlink-gw.sh
 create mode 100755 testcases/network/stress/route/route-change-netlink-if.sh
 create mode 100644 testcases/network/stress/route/route-change-netlink.c

-- 
2.26.2

