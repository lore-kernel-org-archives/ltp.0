From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 18 Aug 2017 18:44:26 +0200
Subject: [LTP] [RFC PATCH v8 00/11] Simplify network setup + fix some
	network	stress tests
Message-ID: <20170818164437.13556-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is full version of v8 (please ignore 2 patches introduced yesterday in
"[LTP] [RFC PATCH 0/2] Simplify network setup: Add unused IP address helper
functions + test_net_stress.sh")

It's also on https://github.com/pevik/ltp/tree/tst_net_vars.v8

Changes v7->v8:

* Fix all problems you mentioned.
* Add tst_ipaddr_un_host and tst_ipaddr_un_ip
* Fix reset_ltp_netspace() implementation (patch [RFC PATCH v8 07/11] lib/test_net.sh: Add function reset_ltp_netspace())
* Fix and simplify route "change" tests (route_test_change())

Petr Vorel (11):
  lib/test_net.sh: Add unused IP address helper functions
  network/stress: Add library helper for stress testing
  network/stress: Simplify make_background_tcp_traffic usage
  network/stress: Reduce the default number of cycles for various tests
  lib/test_net.sh: tst_rhost_run: Add testcases/bin into PATH for
    SSH/RSH
  network/stress: Fix and cleanup part of multicast IPv4 tests
  lib/test_net.sh: Add function reset_ltp_netspace()
  network/stress: Fix and cleanup route IPv4 tests
  network/stress: Further enhancements for route4-rmmod
  network: Add tools for setup IP related environment variables
  network: Use tools to set up IPv4 and IPv6 related variables

 include/tst_net.h                                  | 140 +++++
 testcases/lib/.gitignore                           |   3 +
 testcases/lib/Makefile                             |   2 +-
 testcases/lib/test_net.sh                          | 207 +++++--
 testcases/lib/tst_net_iface_prefix.c               | 173 ++++++
 testcases/lib/tst_net_ip_prefix.c                  | 112 ++++
 testcases/lib/tst_net_vars.c                       | 637 +++++++++++++++++++++
 testcases/network/stress/interface/if-addr-adddel  |  21 +-
 .../network/stress/interface/if-addr-addlarge      |  22 +-
 testcases/network/stress/interface/if-lib.sh       |  73 ---
 testcases/network/stress/interface/if-mtu-change   |  30 +-
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
 .../network/stress/ns-tools/test_net_stress.sh     | 170 ++++++
 testcases/network/stress/route/00_Descriptions.txt |  23 +-
 testcases/network/stress/route/route4-change-dst   | 283 +--------
 testcases/network/stress/route/route4-change-gw    | 305 ++--------
 testcases/network/stress/route/route4-change-if    | 341 ++---------
 testcases/network/stress/route/route4-ifdown       | 284 ++-------
 testcases/network/stress/route/route4-lib.sh       | 145 +++++
 testcases/network/stress/route/route4-redirect     | 223 ++------
 testcases/network/stress/route/route4-rmmod        | 311 +++-------
 testcases/network/stress/route/route6-change-dst   |   2 +-
 31 files changed, 2082 insertions(+), 2526 deletions(-)
 create mode 100644 include/tst_net.h
 create mode 100644 testcases/lib/tst_net_iface_prefix.c
 create mode 100644 testcases/lib/tst_net_ip_prefix.c
 create mode 100644 testcases/lib/tst_net_vars.c
 delete mode 100644 testcases/network/stress/interface/if-lib.sh
 create mode 100644 testcases/network/stress/multicast/grp-operation/mcast4-lib.sh
 create mode 100644 testcases/network/stress/ns-tools/test_net_stress.sh
 create mode 100644 testcases/network/stress/route/route4-lib.sh

-- 
2.13.2

