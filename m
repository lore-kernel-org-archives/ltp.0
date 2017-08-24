From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 25 Aug 2017 01:44:29 +0200
Subject: [LTP] [RFC PATCH v9 0/7] Simplify network setup + fix some
	multicast network	stress tests
Message-ID: <20170824234436.18145-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I decided to send v9 without route tests. Hope this helps to get v9 merged. I
plan to send fixed route tests (both IPv4 + IPv6) + more macast tests in the
next patch-set.

Kind regards,
Petr

Petr Vorel (7):
  lib/test_net.sh: Add unused IP address helper functions
  network/stress: Add library helper for stress testing
  network/stress: Simplify make_background_tcp_traffic usage
  network/stress: Reduce the default number of cycles for various tests
  network/stress: Fix and cleanup part of multicast IPv4 tests
  network: Add tools for setup IP related environment variables
  network: Use tools to set up IPv4 and IPv6 related variables

 include/tst_net.h                                  | 153 +++++
 testcases/lib/.gitignore                           |   3 +
 testcases/lib/Makefile                             |   2 +-
 testcases/lib/test_net.sh                          | 168 ++++--
 testcases/lib/tst_net_iface_prefix.c               | 180 ++++++
 testcases/lib/tst_net_ip_prefix.c                  | 123 ++++
 testcases/lib/tst_net_vars.c                       | 645 +++++++++++++++++++++
 testcases/network/stress/interface/if-addr-adddel  |  21 +-
 .../network/stress/interface/if-addr-addlarge      |  22 +-
 testcases/network/stress/interface/if-lib.sh       |  73 ---
 testcases/network/stress/interface/if-mtu-change   |  19 +-
 testcases/network/stress/interface/if-route-adddel |  26 +-
 .../network/stress/interface/if-route-addlarge     |  21 +-
 testcases/network/stress/interface/if-updown       |   9 +-
 testcases/network/stress/interface/if4-addr-change |  21 +-
 .../stress/multicast/grp-operation/mcast4-grpope01 | 221 +------
 .../stress/multicast/grp-operation/mcast4-grpope02 | 230 +-------
 .../stress/multicast/grp-operation/mcast4-grpope03 | 217 +------
 .../stress/multicast/grp-operation/mcast4-grpope04 | 236 +-------
 .../stress/multicast/grp-operation/mcast4-lib.sh   | 118 ++++
 testcases/network/stress/ns-tools/Makefile         |   2 +-
 .../network/stress/ns-tools/test_net_stress.sh     | 138 +++++
 22 files changed, 1621 insertions(+), 1027 deletions(-)
 create mode 100644 include/tst_net.h
 create mode 100644 testcases/lib/tst_net_iface_prefix.c
 create mode 100644 testcases/lib/tst_net_ip_prefix.c
 create mode 100644 testcases/lib/tst_net_vars.c
 delete mode 100644 testcases/network/stress/interface/if-lib.sh
 create mode 100644 testcases/network/stress/multicast/grp-operation/mcast4-lib.sh
 create mode 100644 testcases/network/stress/ns-tools/test_net_stress.sh

-- 
2.14.0

