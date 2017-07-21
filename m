From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 21 Jul 2017 06:03:56 +0200
Subject: [LTP] [RFC PATCH v7 0/7] Simplify network setup + fix some network
	stress tests
Message-ID: <20170721040407.868-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

as it might be uncomfortable to see patches on mailing list, you can also see
them on github: https://github.com/pevik/ltp/tree/tst_net_vars.v7

Changes v6->v7:
* I more radically cleanup IPV4 multicast and route scripts. Also changed a bit
  interfaces tests. I spent a lot of time with cleanup and testing. Cleaned
  scripts should work under SSH and netns.
* I split tst_net_vars into 3 tools. This was necessary to have reading of
* rtnetlink on rhost.

TODO:
* Add more test links for netns (for route4-change-if).
* Fix also IPv6 scripts.

Alexey Kodanev (1):
  network/dhcp: Fix removing veth kernel module

Petr Vorel (10):
  network/stress: Add library test_net_stress.sh
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
 testcases/lib/test_net.sh                          | 149 +++--
 testcases/lib/tst_net_iface_prefix.c               | 173 ++++++
 testcases/lib/tst_net_ip_prefix.c                  | 116 ++++
 testcases/lib/tst_net_vars.c                       | 655 +++++++++++++++++++++
 testcases/network/dhcp/dhcp_lib.sh                 |   9 +-
 testcases/network/stress/interface/if-addr-adddel  |  21 +-
 .../network/stress/interface/if-addr-addlarge      |  22 +-
 testcases/network/stress/interface/if-lib.sh       |  73 ---
 testcases/network/stress/interface/if-mtu-change   |  30 +-
 testcases/network/stress/interface/if-route-adddel |  24 +-
 .../network/stress/interface/if-route-addlarge     |  21 +-
 testcases/network/stress/interface/if-updown       |   9 +-
 testcases/network/stress/interface/if4-addr-change |  21 +-
 .../stress/multicast/grp-operation/mcast4-grpope01 | 221 +------
 .../stress/multicast/grp-operation/mcast4-grpope02 | 230 +-------
 .../stress/multicast/grp-operation/mcast4-grpope03 | 217 +------
 .../stress/multicast/grp-operation/mcast4-grpope04 | 236 +-------
 .../stress/multicast/grp-operation/mcast4-lib.sh   | 129 ++++
 testcases/network/stress/ns-tools/Makefile         |   2 +-
 testcases/network/stress/ns-tools/initialize_if    |   3 -
 .../network/stress/ns-tools/test_net_stress.sh     | 172 ++++++
 testcases/network/stress/route/00_Descriptions.txt |  23 +-
 testcases/network/stress/route/route4-change-dst   | 283 +--------
 testcases/network/stress/route/route4-change-gw    | 302 +---------
 testcases/network/stress/route/route4-change-if    | 336 ++---------
 testcases/network/stress/route/route4-ifdown       | 283 ++-------
 testcases/network/stress/route/route4-lib.sh       | 206 +++++++
 testcases/network/stress/route/route4-redirect     | 220 ++-----
 testcases/network/stress/route/route4-rmmod        | 305 ++--------
 testcases/network/stress/route/route6-change-dst   |   2 +-
 33 files changed, 2106 insertions(+), 2532 deletions(-)
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

