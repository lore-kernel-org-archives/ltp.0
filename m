From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 11 Apr 2018 13:41:31 +0200
Subject: [LTP] [PATCH v7 0/7] Rewriting network tests into new shell API
Message-ID: <20180411114131.30141-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

I did last final testing.

Changes v6->v7
* I addressed the issues you pointed out (removed TCID, TST_ID)
* Rename some more functions in tst_net.sh)
* Prevent useless restoring ip in ip-updown when command not found.
* Minor changes in test description (related to previous changes).

This is the final diff v6->v7, whole code also available at
https://github.com/pevik/ltp/commits/tst_net.sh.v7
(Not sending it here to spam the others.)
If you're ok with merging, I'll add to the commits your Acked-by.

Kind regards,
Petr


$ git diff tst_net.sh.v6..tst_net.sh.v7
diff --git testcases/lib/tst_net.sh testcases/lib/tst_net.sh
index 2c5d22dba..cb3b144a0 100644
--- testcases/lib/tst_net.sh
+++ testcases/lib/tst_net.sh
@@ -38,7 +38,7 @@ tst_net_parse_args()
 	esac
 }
 
-tst_read_opts()
+tst_net_read_opts()
 {
 	local OPTIND
 	while getopts "$TST_OPTS" opt; do
@@ -57,7 +57,7 @@ tst_net_usage()
 	echo "-6      IPv6 tests"
 }
 
-tst_remote_tmpdir()
+tst_net_remote_tmpdir()
 {
 	[ "$TST_NEEDS_TMPDIR" = 1 ] || return
 	[ -n "$TST_USE_LEGACY_API" ] && tst_tmpdir
@@ -69,7 +69,7 @@ tst_remote_tmpdir()
 tst_net_setup()
 {
 	ipver=${TST_IPV6:-4}
-	tst_remote_tmpdir
+	tst_net_remote_tmpdir
 	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
 }
 
@@ -78,7 +78,7 @@ if [ -z "$TST_LIB_LOADED" ]; then
 fi
 
 if [ -n "$TST_USE_LEGACY_API" ]; then
-	tst_read_opts $*
+	tst_net_read_opts $*
 	ipver=${TST_IPV6:-4}
 fi
 
@@ -744,4 +744,4 @@ export RHOST_HWADDRS="${RHOST_HWADDRS:-$(tst_get_hwaddrs rhost)}"
 # More information about network parameters can be found
 # in the following document: testcases/network/stress/README
 
-[ -n "$TST_USE_LEGACY_API" ] && tst_remote_tmpdir
+[ -n "$TST_USE_LEGACY_API" ] && tst_net_remote_tmpdir
diff --git testcases/network/stress/interface/if-lib.sh testcases/network/stress/interface/if-lib.sh
index b486c66d7..f54c03d9d 100644
--- testcases/network/stress/interface/if-lib.sh
+++ testcases/network/stress/interface/if-lib.sh
@@ -38,6 +38,7 @@ if_setup()
 
 	tst_check_cmds "$CMD"
 	netstress_setup
+	TST_CLEANUP="${TST_CLEANUP:-netstress_cleanup}"
 }
 
 if_cleanup_restore()
@@ -47,9 +48,7 @@ if_cleanup_restore()
 	restore_ipaddr rhost
 }
 
-TST_CNT=2
 TST_SETUP="${TST_SETUP:-if_setup}"
-TST_CLEANUP="${TST_CLEANUP:-netstress_cleanup}"
 TST_TESTFUNC="test_body"
 TST_PARSE_ARGS="if_parse_args"
 TST_USAGE="if_usage"
diff --git testcases/network/stress/interface/if4-addr-change testcases/network/stress/interface/if4-addr-change
index ce0a5047a..8ed3ce3a8 100644
--- testcases/network/stress/interface/if4-addr-change
+++ testcases/network/stress/interface/if4-addr-change
@@ -18,7 +18,6 @@
 #
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-TST_CNT=1
 TCID=if4-addr-change
 TST_CLEANUP="do_cleanup"
 TST_TESTFUNC="test_body"
diff --git testcases/network/stress/multicast/grp-operation/mcast-lib.sh testcases/network/stress/multicast/grp-operation/mcast-lib.sh
index 5939c0e9a..13a445f55 100644
--- testcases/network/stress/multicast/grp-operation/mcast-lib.sh
+++ testcases/network/stress/multicast/grp-operation/mcast-lib.sh
@@ -19,7 +19,6 @@
 #
 # Setup script for multicast stress tests.
 
-TST_CNT=1
 TST_SETUP="do_setup"
 TST_CLEANUP="mcast_cleanup"
 TST_TESTFUNC="do_test"
diff --git testcases/network/stress/ns-tools/tst_net_stress.sh testcases/network/stress/ns-tools/tst_net_stress.sh
index e70417237..9b02fd9ca 100644
--- testcases/network/stress/ns-tools/tst_net_stress.sh
+++ testcases/network/stress/ns-tools/tst_net_stress.sh
@@ -23,8 +23,6 @@
 # NOTE: More information about network variables can be found
 # in tst_net.sh and testcases/network/stress/README.
 
-export TCID="${TCID:-$(basename $0)}"
-
 . tst_net.sh
 
 # Netmask of for the tested network
diff --git testscripts/network.sh testscripts/network.sh
index b18f202d5..c946e4d86 100755
--- testscripts/network.sh
+++ testscripts/network.sh
@@ -86,15 +86,12 @@ if [ "$OPTIND" -eq 1 ]; then
 fi
 shift $(($OPTIND - 1))
 
-TST_TOTAL=1
-TCID="network_settings"
-
 TST_NO_DEFAULT_RUN=1
 . tst_net.sh
 
 # Reset variables.
 # Don't break the tests which are using 'testcases/lib/cmdlib.sh'
-unset TCID TST_LIB_LOADED TST_USE_LEGACY_API
+unset TST_ID TST_LIB_LOADED TST_NO_DEFAULT_RUN
 
 rm -f $CMDFILE
 
---


Petr Vorel (7):
  tst_net.sh: Support both new and legacy APIs + rename
  tst_test.sh: Introduce TST_NO_DEFAULT_RUN
  network.sh: Migrate to new shell API
  network/interface: Cleanup if4-addr-change
  network/if-updown: Restore IP in cleanup function
  tst_net_stress.sh: Migrate with dependencies to new API + rename
  network/interface: Split tests to test only one command per test

 runtest/net_stress.interface                       |  38 +++--
 testcases/lib/{test_net.sh => tst_net.sh}          | 165 ++++++++++++++-------
 testcases/lib/tst_test.sh                          |  91 ++++++------
 testcases/network/README.md                        |   4 +-
 testcases/network/busy_poll/busy_poll01.sh         |   3 +-
 testcases/network/busy_poll/busy_poll02.sh         |   3 +-
 testcases/network/busy_poll/busy_poll03.sh         |   3 +-
 testcases/network/dccp/dccp01.sh                   |   3 +-
 testcases/network/dctcp/dctcp01.sh                 |   3 +-
 testcases/network/dhcp/dhcpd_tests.sh              |   3 +-
 testcases/network/dhcp/dnsmasq_tests.sh            |   3 +-
 testcases/network/iproute/ip_tests.sh              |   3 +-
 testcases/network/multicast/mc_cmds/mc_cmds        |   3 +-
 testcases/network/multicast/mc_commo/mc_commo      |   3 +-
 testcases/network/multicast/mc_member/mc_member    |   3 +-
 testcases/network/multicast/mc_opts/mc_opts        |   3 +-
 testcases/network/nfs/fsx-linux/fsx.sh             |   3 +-
 testcases/network/nfs/nfs_stress/nfs01             |   3 +-
 testcases/network/nfs/nfs_stress/nfs02             |   3 +-
 testcases/network/nfs/nfs_stress/nfs03             |   3 +-
 testcases/network/nfs/nfs_stress/nfs04             |   3 +-
 testcases/network/nfs/nfs_stress/nfs05             |   3 +-
 testcases/network/nfs/nfs_stress/nfs06             |   3 +-
 testcases/network/nfs/nfslock01/nfslock01          |   3 +-
 testcases/network/nfs/nfsstat01/nfsstat01          |   3 +-
 testcases/network/rpc/basic_tests/rpc01/rpc01      |   3 +-
 .../network/rpc/basic_tests/rpcinfo/rpcinfo01      |   3 +-
 testcases/network/rpc/basic_tests/rup/rup01        |   3 +-
 testcases/network/rpc/basic_tests/rusers/rusers01  |   3 +-
 testcases/network/rpc/rpc-tirpc/rpc_test.sh        |   4 +-
 testcases/network/sctp/sctp01.sh                   |   3 +-
 testcases/network/sockets/bind_noport01.sh         |   3 +-
 .../network/stress/broken_ip/broken_ip4-checksum   |   3 +-
 .../network/stress/broken_ip/broken_ip4-dstaddr    |   3 +-
 .../network/stress/broken_ip/broken_ip4-fragment   |   3 +-
 testcases/network/stress/broken_ip/broken_ip4-ihl  |   3 +-
 .../network/stress/broken_ip/broken_ip4-protcol    |   3 +-
 .../network/stress/broken_ip/broken_ip4-totlen     |   3 +-
 .../network/stress/broken_ip/broken_ip4-version    |   3 +-
 .../network/stress/broken_ip/broken_ip6-dstaddr    |   3 +-
 .../network/stress/broken_ip/broken_ip6-nexthdr    |   3 +-
 testcases/network/stress/broken_ip/broken_ip6-plen |   3 +-
 .../network/stress/broken_ip/broken_ip6-version    |   3 +-
 testcases/network/stress/dns/dns-stress            |   3 +-
 testcases/network/stress/ftp/ftp-download-stress   |   3 +-
 testcases/network/stress/ftp/ftp-upload-stress     |   3 +-
 testcases/network/stress/http/http-stress          |   3 +-
 testcases/network/stress/interface/if-addr-adddel  |  52 +++----
 .../network/stress/interface/if-addr-addlarge      |  57 +++----
 testcases/network/stress/interface/if-lib.sh       |  57 +++++++
 testcases/network/stress/interface/if-mtu-change   |  52 +++----
 testcases/network/stress/interface/if-route-adddel |  55 +++----
 .../network/stress/interface/if-route-addlarge     |  51 ++-----
 testcases/network/stress/interface/if-updown       |  49 +++---
 testcases/network/stress/interface/if4-addr-change |  70 ++++-----
 testcases/network/stress/ipsec/ipsec_lib.sh        |   9 +-
 .../grp-operation/mcast-group-multiple-socket      |  16 +-
 .../multicast/grp-operation/mcast-group-same-group |  17 ++-
 .../grp-operation/mcast-group-single-socket        |  17 ++-
 .../grp-operation/mcast-group-source-filter        |  17 ++-
 .../stress/multicast/grp-operation/mcast-lib.sh    |  28 ++--
 testcases/network/stress/ns-tools/Makefile         |   2 +-
 .../{test_net_stress.sh => tst_net_stress.sh}      |  34 +++--
 testcases/network/stress/ssh/ssh-stress            |   3 +-
 testcases/network/tcp_cmds/arping/arping01.sh      |   3 +-
 .../network/tcp_cmds/clockdiff/clockdiff01.sh      |   3 +-
 testcases/network/tcp_cmds/ipneigh/ipneigh01.sh    |   3 +-
 testcases/network/tcp_cmds/ping/ping01.sh          |   3 +-
 testcases/network/tcp_cmds/ping/ping02.sh          |   3 +-
 testcases/network/tcp_cmds/rlogin/rlogin01         |   3 +-
 testcases/network/tcp_cmds/sendfile/sendfile01     |   3 +-
 testcases/network/tcp_cmds/tcpdump/tcpdump01       |   3 +-
 testcases/network/tcp_cmds/telnet/telnet01         |   3 +-
 .../network/tcp_cmds/tracepath/tracepath01.sh      |   3 +-
 testcases/network/tcp_fastopen/tcp_fastopen_run.sh |  16 +-
 testcases/network/traceroute/traceroute01.sh       |   3 +-
 testcases/network/virt/geneve01.sh                 |   3 +-
 testcases/network/virt/gre01.sh                    |   3 +-
 testcases/network/virt/ipvlan01.sh                 |   3 +-
 testcases/network/virt/macvlan01.sh                |   3 +-
 testcases/network/virt/macvtap01.sh                |   3 +-
 testcases/network/virt/vlan01.sh                   |   3 +-
 testcases/network/virt/vlan02.sh                   |   3 +-
 testcases/network/virt/vlan03.sh                   |   3 +-
 testcases/network/virt/vxlan01.sh                  |   3 +-
 testcases/network/virt/vxlan02.sh                  |   3 +-
 testcases/network/virt/vxlan03.sh                  |   3 +-
 testcases/network/xinetd/xinetd_tests.sh           |   3 +-
 testscripts/network.sh                             |  10 +-
 89 files changed, 624 insertions(+), 485 deletions(-)
 rename testcases/lib/{test_net.sh => tst_net.sh} (85%)
 create mode 100644 testcases/network/stress/interface/if-lib.sh
 rename testcases/network/stress/ns-tools/{test_net_stress.sh => tst_net_stress.sh} (88%)

-- 
2.16.3

