From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 14 Apr 2020 17:24:10 +0200
Subject: [LTP] [PATCH v4 0/2] Route tests using netlink API (dst,gw)
Message-ID: <20200414152412.8278-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

Changes v3->v4:
* fix TCONF not handled in EXPECT_PASS()
* use ROUTE_RHOST_PORT variable for port
* use TST_SETUP="setup_gw" in route-change-gw.sh
* fix double TINFO report in route-change-gw.sh and route-change-netlink-gw.sh

For fixing TCONF not handled in EXPECT_PASS() I copy pasted solution
from tst_netload(). Discussing this with Cyril I'm planning to implement
his tip to use mapped memory to increment counter also in shell API.
That should simplify shell API as there will be just single "Summary:"
report.

Kind regards,
Petr

Petr Vorel (2):
  net: Move setup_addrinfo() into tst_net.h
  net/route: Add netlink based route change gw/dest tests

 configure.ac                                  |   1 +
 include/mk/config.mk.in                       |   2 +
 include/tst_net.h                             |   9 +-
 include/tst_private.h                         |   1 +
 lib/tst_net.c                                 |  14 +
 m4/ltp-libmnl.m4                              |   8 +
 runtest/net_stress.route                      |   4 +
 testcases/network/netstress/netstress.c       |  20 +-
 testcases/network/stress/route/.gitignore     |   1 +
 .../network/stress/route/00_Descriptions.txt  |  39 +-
 testcases/network/stress/route/Makefile       |  30 +-
 .../network/stress/route/route-change-dst.sh  |   1 +
 .../network/stress/route/route-change-gw.sh   |  15 +-
 .../network/stress/route/route-change-if.sh   |   1 +
 .../stress/route/route-change-netlink-dst.sh  |  33 ++
 .../stress/route/route-change-netlink-gw.sh   |  28 ++
 .../stress/route/route-change-netlink.c       | 348 ++++++++++++++++++
 testcases/network/stress/route/route-lib.sh   |  44 ++-
 travis/debian.cross-compile.sh                |   1 +
 travis/debian.sh                              |   1 +
 travis/fedora.sh                              |   3 +
 travis/tumbleweed.sh                          |   1 +
 22 files changed, 526 insertions(+), 79 deletions(-)
 create mode 100644 m4/ltp-libmnl.m4
 create mode 100644 testcases/network/stress/route/.gitignore
 create mode 100755 testcases/network/stress/route/route-change-netlink-dst.sh
 create mode 100755 testcases/network/stress/route/route-change-netlink-gw.sh
 create mode 100644 testcases/network/stress/route/route-change-netlink.c

-- 
2.26.0

