From: Petr Vorel <pvorel@suse.cz>
Date: Sat,  3 Jun 2017 14:00:11 +0200
Subject: [LTP] [RFC PATCH v6 00/11] Simplify network setup + fix some
	network stress tests
Message-ID: <20170603120022.13415-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

as it might be uncomfortable to see patches on mailing list, you can also see
them on github: https://github.com/pevik/ltp/tree/tst_net_vars.v6

changes v5->v6:

Changes in network setup (testcases/lib/tst_net_vars.c):
* Simplify parsing network and host part of IP. Now it calculate just network
  part and set host as the rest of what is left from IP.
* Try to lookup local iface name and prefix in rtnetlink data if prefix not
  provided in setup (in form of IP/PREFIX). Don't look up for remote prefix and
  iface name as we would need to setup connection first, but this requires to
  know them (remote prefix and iface name) for remote connection (or am I
  missing something?).
* When rtnetlink find local prefix and remote prefix isn't provided, use the
  local one.

Changes in shell libraries:
* test_net.sh: Add reset_ltp_netspace() function (required by route4-rmmod test).
* Create general library test_stress_net.sh (for all stress tests) and
  mcast4-lib.sh (multicast IPv4 tests) and route4-lib.sh (route IPv4 tests).
* Fix 'unbound variable' error in shell libraries.

Changes in tests:
* Fixed part of IPv4 multicast and route and use variables parsed with
  tst_net_vars for them + cleanup. Lots of tests in
  testcases/network/stress/multicast and testcases/network/stress/route isn't
  working at least for netns. There is also great duplicity in the code. It
  would be great to get rid of all scripts in testcases/network/stress/ns-tools
  and use functions from test_net.sh or other libraries (also remove a lot of
  code duplicity) => TODO: cleanup all tests.
* tst_net_vars simplifies setup as it only needs to have passed 4 IP
  addresses (2x IPv4 and 2 IPv6) and alows to define different network part for
  local and remote hosts.
* Rename variables in rewritten tests to use variables defined by
  tst_net_vars. These scripts are run by testscripts/network.sh script which
  defined these variables by setting test_net.sh, so it makes a sense to use
  them. Old tests still use IPV4_NETWORK variable instead of IPV4_LNETWORK and
  IPV4_RNETWORK and have it defined locally.
* Various cleanup.

Petr Vorel (11):
  gitignore: Prefixing filenames
  lib: Fix 'unbound variable' error in shell libraries
  network/stress: Fix typo
  network/stress: Use correct reporting function
  network/stress: Remove bg_tcp_traffic script
  network/stress: Add library test_stress_net.sh for general usage
  network/stress: Fix and cleanup part of multicast IPv4 tests
  lib/test_net.sh: reset_ltp_netspace()
  network/stress: Fix and cleanup route IPv4 tests
  network: Add tools for setup IP related environment variables
  network: Use tst_net_vars to set up IPv4 and IPv6 related variables

 testcases/lib/.gitignore                           |  13 +-
 testcases/lib/Makefile                             |   4 +-
 testcases/lib/test.sh                              |   4 +-
 testcases/lib/test_net.sh                          |  70 +-
 testcases/lib/tst_net_vars.c                       | 802 +++++++++++++++++++++
 testcases/network/stress/README                    |   6 +-
 .../stress/icmp/multi-diffip/icmp4-multi-diffip01  |   2 +-
 testcases/network/stress/interface/if-addr-adddel  |   2 +-
 .../network/stress/interface/if-addr-addlarge      |   3 +-
 testcases/network/stress/interface/if-lib.sh       |  32 +-
 testcases/network/stress/interface/if-route-adddel |   2 +-
 .../network/stress/interface/if-route-addlarge     |   2 +-
 testcases/network/stress/interface/if-updown       |   2 +-
 testcases/network/stress/interface/if4-addr-change |   2 +-
 .../stress/multicast/grp-operation/mcast4-grpope01 | 222 +-----
 .../stress/multicast/grp-operation/mcast4-grpope02 | 231 +-----
 .../stress/multicast/grp-operation/mcast4-grpope03 | 217 +-----
 .../stress/multicast/grp-operation/mcast4-grpope04 | 233 +-----
 .../stress/multicast/grp-operation/mcast4-lib.sh   | 143 ++++
 .../network/stress/ns-tools/00_Descriptions.txt    |   3 -
 testcases/network/stress/ns-tools/Makefile         |   8 +-
 testcases/network/stress/ns-tools/bg_tcp_traffic   | 275 -------
 testcases/network/stress/ns-tools/initialize_if    |   3 -
 testcases/network/stress/ns-tools/ns-tcpserver.c   |   2 +-
 .../network/stress/ns-tools/test_stress_net.sh     | 138 ++++
 testcases/network/stress/route/00_Descriptions.txt |  23 +-
 testcases/network/stress/route/route4-change-dst   | 287 +-------
 testcases/network/stress/route/route4-change-gw    | 308 +-------
 testcases/network/stress/route/route4-change-if    | 348 ++-------
 testcases/network/stress/route/route4-ifdown       | 298 ++------
 testcases/network/stress/route/route4-lib.sh       | 252 +++++++
 testcases/network/stress/route/route4-redirect     | 232 ++----
 testcases/network/stress/route/route4-rmmod        | 329 +++------
 testcases/network/stress/route/route6-change-dst   |   2 +-
 testcases/network/stress/route/route6-rmmod        |   2 +-
 .../stress/tcp/multi-diffip/tcp4-multi-diffip01    |   2 +-
 .../stress/udp/multi-diffip/udp4-multi-diffip01    |   2 +-
 37 files changed, 1829 insertions(+), 2677 deletions(-)
 create mode 100644 testcases/lib/tst_net_vars.c
 create mode 100644 testcases/network/stress/multicast/grp-operation/mcast4-lib.sh
 delete mode 100644 testcases/network/stress/ns-tools/bg_tcp_traffic
 create mode 100644 testcases/network/stress/ns-tools/test_stress_net.sh
 create mode 100644 testcases/network/stress/route/route4-lib.sh

-- 
2.12.2

