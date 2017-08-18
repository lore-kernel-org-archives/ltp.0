From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 18 Aug 2017 18:44:28 +0200
Subject: [LTP] [RFC PATCH v8 02/11] network/stress: Add library helper for
	stress testing
In-Reply-To: <20170818164437.13556-1-pvorel@suse.cz>
References: <20170818164437.13556-1-pvorel@suse.cz>
Message-ID: <20170818164437.13556-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ use it in interface stress tests

test_net_stress.sh:
* test_net_stress.sh library is intended to be used throughout all
  stress tests reduce duplicity and use code from test_net.sh where
  possible instead of legacy scripts in testcases/network/stress/ns-tools/.
* TCID set automatically from basename.
* Add "unused network" related variables. So far used only IPv4 ones.
* Functions from if-lib.sh moved and (and some renamed) to
  test_net_stress.sh as they are going to be reused in other tests (not
  just interface stress tests).

Interfaces stress tests:
* Interfaces tests use test_net_stress.sh.
* Remove restore_ipaddr from cleanup functions as these functions would
  break netns testing with RTNETLINK errors. Use them just in setup during
  if-mtu-change where are really needed.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/interface/if-addr-adddel  |  15 +-
 .../network/stress/interface/if-addr-addlarge      |  16 +-
 testcases/network/stress/interface/if-lib.sh       |  73 ---------
 testcases/network/stress/interface/if-mtu-change   |  23 +--
 testcases/network/stress/interface/if-route-adddel |  19 +--
 .../network/stress/interface/if-route-addlarge     |  15 +-
 testcases/network/stress/interface/if-updown       |   9 +-
 testcases/network/stress/interface/if4-addr-change |   4 +-
 testcases/network/stress/ns-tools/Makefile         |   2 +-
 .../network/stress/ns-tools/test_net_stress.sh     | 168 +++++++++++++++++++++
 10 files changed, 208 insertions(+), 136 deletions(-)
 delete mode 100644 testcases/network/stress/interface/if-lib.sh
 create mode 100644 testcases/network/stress/ns-tools/test_net_stress.sh

diff --git a/testcases/network/stress/interface/if-addr-adddel b/testcases/network/stress/interface/if-addr-adddel
index dcc018a48..42c2d5afa 100644
--- a/testcases/network/stress/interface/if-addr-adddel
+++ b/testcases/network/stress/interface/if-addr-adddel
@@ -18,20 +18,13 @@
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_TOTAL=2
-TCID=if-addr-adddel
 
-. if-lib.sh
-
-TST_CLEANUP="do_cleanup"
+TST_CLEANUP="netstress_cleanup"
 
 # The interval of the check interface activity
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
 
-do_cleanup()
-{
-	cleanup
-	restore_ipaddr
-}
+. test_net_stress.sh
 
 test_body()
 {
@@ -88,7 +81,7 @@ test_body()
 			return
 		fi
 
-		check_connectivity $cnt || return
+		check_connectivity_interval $cnt || return
 
 		cnt=$(($cnt + 1))
 
@@ -122,7 +115,7 @@ test_body()
 	tst_resm TPASS "Test is finished correctly"
 }
 
-setup
+netstress_setup
 
 tst_check_cmds ifconfig
 
diff --git a/testcases/network/stress/interface/if-addr-addlarge b/testcases/network/stress/interface/if-addr-addlarge
index 9e550068b..e667d9138 100644
--- a/testcases/network/stress/interface/if-addr-addlarge
+++ b/testcases/network/stress/interface/if-addr-addlarge
@@ -18,20 +18,13 @@
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_TOTAL=2
-TCID=if-addr-addlarge
 
-. if-lib.sh
-
-TST_CLEANUP="do_cleanup"
+TST_CLEANUP="netstress_cleanup"
 
 # The interval of the check interface activity
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IP_TOTAL / 20))}
 
-do_cleanup()
-{
-	cleanup
-	restore_ipaddr
-}
+. test_net_stress.sh
 
 test_body()
 {
@@ -100,8 +93,7 @@ test_body()
 			return
 		fi
 
-		# Check the connectivity
-		check_connectivity $cnt || return
+		check_connectivity_interval $cnt || return
 
 		# Check the background TCP traffic
 		pgrep -x netstress > /dev/null || make_background_tcp_traffic
@@ -143,7 +135,7 @@ test_body()
 	tst_resm TPASS "Test is finished correctly"
 }
 
-setup
+netstress_setup
 
 tst_check_cmds ifconfig
 
diff --git a/testcases/network/stress/interface/if-lib.sh b/testcases/network/stress/interface/if-lib.sh
deleted file mode 100644
index 4168dd09f..000000000
--- a/testcases/network/stress/interface/if-lib.sh
+++ /dev/null
@@ -1,73 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.
-#
-# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
-
-TST_CLEANUP="cleanup"
-
-. test_net.sh
-
-ipver=${TST_IPV6:-4}
-
-IPV4_NET16_UNUSED=${IPV4_NET16_UNUSED:-"10.23"}
-IPV6_NET32_UNUSED=${IPV6_NET32_UNUSED:-"fd00:23"}
-
-setup()
-{
-	tst_require_root
-	tst_check_cmds ip pgrep pkill
-	trap "tst_brkm TBROK 'test interrupted'" INT
-}
-
-cleanup()
-{
-	# Stop the background TCP traffic
-	pkill -13 -x netstress
-	tst_rhost_run -c "pkill -13 -x netstress"
-}
-
-make_background_tcp_traffic()
-{
-	port=$(tst_get_unused_port ipv${ipver} stream)
-	netstress -R 3 -g $port > /dev/null 2>&1 &
-	tst_rhost_run -b -c "netstress -l -H $(tst_ipaddr) -g $port"
-}
-
-check_connectivity()
-{
-	local cnt="$1"
-	local restore="$2"
-
-	[ $CHECK_INTERVAL -eq 0 ] && return
-	[ $(($cnt % $CHECK_INTERVAL)) -ne 0 ] && return
-
-	tst_resm TINFO "check connectivity through $(tst_iface) on step $cnt"
-
-	[ -n "$restore" ] && restore_ipaddr
-
-	tst_ping
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "$(tst_iface) is broken"
-		return 1
-	fi
-	return 0
-}
-
-restore_ipaddr()
-{
-	tst_restore_ipaddr || return $?
-	tst_wait_ipv6_dad
-}
diff --git a/testcases/network/stress/interface/if-mtu-change b/testcases/network/stress/interface/if-mtu-change
index 637fa6389..5900f546a 100644
--- a/testcases/network/stress/interface/if-mtu-change
+++ b/testcases/network/stress/interface/if-mtu-change
@@ -18,9 +18,6 @@
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_TOTAL=2
-TCID=if-mtu-change
-
-. if-lib.sh
 
 TST_CLEANUP="do_cleanup"
 
@@ -33,16 +30,22 @@ CHANGE6_VALUES="1280 1445 1335 1390 1500 1280 1500 1280 1335 1500"
 [ "$TST_IPV6" ] && CHANGE_VALUES=$CHANGE6_VALUES
 saved_mtu=
 
+. test_net_stress.sh
+
+do_setup()
+{
+	tst_restore_ipaddr
+	tst_restore_ipaddr rhost
+	tst_wait_ipv6_dad
+}
+
 do_cleanup()
 {
-	cleanup
+	netstress_cleanup
 	if [ "$saved_mtu" ]; then
 		ip li set $(tst_iface) mtu $saved_mtu
 		tst_rhost_run -c "ip li set $(tst_iface rhost) mtu $saved_mtu"
 	fi
-	tst_restore_ipaddr
-	tst_restore_ipaddr rhost
-	tst_wait_ipv6_dad
 }
 
 test_body()
@@ -59,7 +62,7 @@ test_body()
 	local iface_rmt=$(tst_iface rhost)
 	[ "$TST_IPV6" ] && local netmask=64 || local netmask=16
 
-	tst_resm TINFO "'$cmd_name changes MTU $MTU_CHANGE_TIMES times " \
+	tst_resm TINFO "'$cmd_name changes MTU $MTU_CHANGE_TIMES times" \
 	               "every $CHANGE_INTERVAL seconds"
 
 	make_background_tcp_traffic
@@ -98,12 +101,14 @@ test_body()
 	done
 }
 
-setup
+netstress_setup
 
 tst_check_cmds ifconfig
 
 saved_mtu="$(cat /sys/class/net/$(tst_iface)/mtu)"
 
+do_setup
+
 test_body 'if_cmd'
 test_body 'ip_cmd'
 
diff --git a/testcases/network/stress/interface/if-route-adddel b/testcases/network/stress/interface/if-route-adddel
index 451674178..700e852a8 100644
--- a/testcases/network/stress/interface/if-route-adddel
+++ b/testcases/network/stress/interface/if-route-adddel
@@ -18,19 +18,12 @@
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_TOTAL=2
-TCID=if-route-adddel
 
-. if-lib.sh
-
-TST_CLEANUP="do_cleanup"
+TST_CLEANUP="netstress_cleanup"
 
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
 
-do_cleanup()
-{
-	cleanup
-	restore_ipaddr
-}
+. test_net_stress.sh
 
 test_body()
 {
@@ -47,10 +40,10 @@ test_body()
 	local new_rt=
 	local opt_rt=
 	if [ "$TST_IPV6" ]; then
-		new_rt=${IPV6_NET32_UNUSED}::
+		new_rt="$(TST_IPV6=6 tst_ipaddr_un_ip)"
 		opt_rt="/64"
 	else
-		new_rt="${IPV4_NET16_UNUSED}.23.0"
+		new_rt="$(tst_ipaddr_un_ip 23)"
 		case $cmd_type in
 		rt_cmd) ;;
 		ip_cmd) opt_rt='/24' ;;
@@ -86,7 +79,7 @@ test_body()
 			return
 		fi
 
-		check_connectivity $cnt || return
+		check_connectivity_interval $cnt || return
 
 		# Check the background TCP traffic
 		pgrep -x netstress > /dev/null || make_background_tcp_traffic
@@ -97,7 +90,7 @@ test_body()
 	tst_resm TPASS "Test is finished correctly"
 }
 
-setup
+netstress_setup
 
 tst_check_cmds route
 
diff --git a/testcases/network/stress/interface/if-route-addlarge b/testcases/network/stress/interface/if-route-addlarge
index e83cf60a7..3337b7225 100644
--- a/testcases/network/stress/interface/if-route-addlarge
+++ b/testcases/network/stress/interface/if-route-addlarge
@@ -18,19 +18,12 @@
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_TOTAL=2
-TCID=if-route-addlarge
 
-. if-lib.sh
-
-TST_CLEANUP="do_cleanup"
+TST_CLEANUP="netstress_cleanup"
 
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($ROUTE_TOTAL / 20))}
 
-do_cleanup()
-{
-	cleanup
-	restore_ipaddr
-}
+. test_net_stress.sh
 
 test_body()
 {
@@ -93,7 +86,7 @@ test_body()
 			return
 		fi
 
-		check_connectivity $cnt || return
+		check_connectivity_interval $cnt || return
 
 		# Check the background TCP traffic
 		pgrep -x netstress > /dev/null || make_background_tcp_traffic
@@ -112,7 +105,7 @@ test_body()
 	tst_resm TPASS "Test is finished correctly"
 }
 
-setup
+netstress_setup
 
 tst_check_cmds route
 
diff --git a/testcases/network/stress/interface/if-updown b/testcases/network/stress/interface/if-updown
index deefef639..5ab54a1f8 100644
--- a/testcases/network/stress/interface/if-updown
+++ b/testcases/network/stress/interface/if-updown
@@ -18,12 +18,13 @@
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_TOTAL=2
-TCID=if-updown
 
-. if-lib.sh
+TST_CLEANUP="netstress_cleanup"
 
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IF_UPDOWN_TIMES / 20))}
 
+. test_net_stress.sh
+
 test_body()
 {
 	local cmd_type=$1
@@ -59,7 +60,7 @@ test_body()
 			return
 		fi
 
-		check_connectivity $cnt restore_ip || return
+		check_connectivity_interval $cnt restore_ip || return
 
 		cnt=$(($cnt + 1))
 	done
@@ -67,7 +68,7 @@ test_body()
 	tst_resm TPASS "Test is finished correctly"
 }
 
-setup
+netstress_setup
 
 tst_check_cmds ifconfig
 
diff --git a/testcases/network/stress/interface/if4-addr-change b/testcases/network/stress/interface/if4-addr-change
index 54b8fd5fb..567f86643 100644
--- a/testcases/network/stress/interface/if4-addr-change
+++ b/testcases/network/stress/interface/if4-addr-change
@@ -21,12 +21,12 @@ TST_TOTAL=1
 TCID=if4-addr-change
 TST_CLEANUP="do_cleanup"
 
-. test_net.sh
-
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
 # Maximum host portion of the IPv4 address on the local host
 LHOST_IPV4_HOST_MAX="254"
 
+. test_net.sh
+
 do_cleanup()
 {
 	tst_restore_ipaddr
diff --git a/testcases/network/stress/ns-tools/Makefile b/testcases/network/stress/ns-tools/Makefile
index 61f85634a..1c186b232 100644
--- a/testcases/network/stress/ns-tools/Makefile
+++ b/testcases/network/stress/ns-tools/Makefile
@@ -29,7 +29,7 @@ INSTALL_TARGETS		:= check_envval get_ifname initialize_if set_ipv4addr \
 			   check_icmpv6_connectivity check_netem check_setkey \
 			   create_file find_portbundle killall_icmp_traffic \
 			   killall_tcp_traffic killall_udp_traffic output_ipsec_conf \
-			   ns-echoclient
+			   ns-echoclient test_net_stress.sh
 
 FILTER_OUT_MAKE_TARGETS	:= ns-common
 
diff --git a/testcases/network/stress/ns-tools/test_net_stress.sh b/testcases/network/stress/ns-tools/test_net_stress.sh
new file mode 100644
index 000000000..6173cc9bc
--- /dev/null
+++ b/testcases/network/stress/ns-tools/test_net_stress.sh
@@ -0,0 +1,168 @@
+#!/bin/sh
+# Copyright (c) International Business Machines  Corp., 2006
+# Copyright (c) 2015-2017 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+#
+# Author: Petr Vorel <pvorel@suse.cz>
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+#
+# Library for all network/stress/ tests.
+# NOTE: More information about network variables can be found
+# in test_net.sh and testcases/network/stress/README.
+
+export TCID="${TCID:-$(basename $0)}"
+
+# using variables IPV4_NET16_UNUSED and various functions
+. test_net.sh
+
+# Netmask of for the tested network
+IPV4_NETMASK="255.255.255.0"
+IPV4_NETMASK_NUM=24
+
+# Prefix of the Multicast Address
+MCAST_IPV4_ADDR_PREFIX="224.10"
+# Multicast Address
+MCAST_IPV4_ADDR="${MCAST_IPV4_ADDR_PREFIX}.10.1"
+
+LINK_TOTAL=$(echo $LHOST_HWADDRS | wc -w)
+RHOST_LINK_TOTAL=$(echo $RHOST_HWADDRS | wc -w)
+[ $LINK_TOTAL -ne $RHOST_LINK_TOTAL ] && \
+	tst_brkm TBROK "the number of element in LHOST_HWADDRS differs from RHOST_HWADDRS" \
+	"($LINK_TOTAL vs. $RHOST_LINK_TOTAL," \
+	"LHOST_HWADDRS: '$LHOST_HWADDRS' RHOST_HWADDRS: '$RHOST_HWADDRS')"
+
+ipver=${TST_IPV6:-4}
+
+# Setup for tests using netstress.
+netstress_setup()
+{
+	tst_require_root
+	tst_check_cmds ip pgrep pkill
+	trap "tst_brkm TBROK 'test interrupted'" INT
+}
+
+# Cleanup for tests using netstress.
+netstress_cleanup()
+{
+	# Stop the background TCP traffic
+	pkill -13 -x netstress
+	tst_rhost_run -c "pkill -13 -x netstress"
+}
+
+# Set an IPv4 address on local/remote interface.
+# tst_add_ipaddr_stress [TYPE] [IP] [LINK]
+# TYPE: { lhost | rhost }; Default value is 'lhost'.
+# IP: IP address to be set; Default value is from tst_ipaddr_un_host().
+# LINK: link number starting from 0. Default value is '0'.
+tst_add_ipaddr_stress()
+{
+	local type="${1:-lhost}"
+	local ip="${2:-}"
+	local link_num="${3:-0}"
+	local mask=$IPV4_NETMASK_NUM
+	local iface=$(tst_iface $type $link_num)
+
+	if [ -z "$ip" ]; then
+		[ $type = "lhost" ] && ip=$(tst_ipaddr_un_host) || ip=$(tst_ipaddr_un_host rhost)
+	fi
+
+	cmd="ip addr add $ip/$mask dev $iface"
+	[ $type = "lhost" ] && ROD "$cmd" || tst_rhost_run -s -c "$cmd"
+}
+
+# restore_ipaddr [TYPE] [LINK] [LOCAL_IFACE] [REMOTE_IFACE]
+# TYPE: { lhost | rhost }; Default value is 'lhost'.
+# LINK: link number starting from 0. Default value is '0'.
+# LOCAL_IFACE: local iface name.
+# REMOTE_IFACE: local iface name.
+restore_ipaddr()
+{
+	local type="${1:-lhost}"
+	local link_num="${2:-0}"
+	local iface_loc=${3:-$(tst_iface lhost $link_num)}
+	local iface_rmt=${4:-$(tst_iface rhost $link_num)}
+
+	tst_restore_ipaddr $type $link_num || return $?
+	[ $type = "lhost" ] && tst_wait_ipv6_dad $iface_loc $iface_rmt
+}
+
+# Check connectivity with tst_ping.
+# check_connectivity SRC_IFACE DST_ADDR [CNT]
+# SRC_IFACE: source interface name.
+# DST_ADDR: destination IPv4 or IPv6 address.
+# CNT: loop step.
+check_connectivity()
+{
+	local src_iface="${1}"
+	local dst_addr="${2}"
+	local cnt="${3:-}"
+	local cnt_msg
+
+	[ -n "$cnt" ] && cnt_msg=" (step $cnt)"
+
+	tst_resm TINFO "check connectivity through $src_iface iface to ${dst_addr}$cnt_msg"
+
+	tst_ping $src_iface $dst_addr
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "$src_iface is broken"
+		return 1
+	fi
+	return 0
+}
+
+# check_connectivity_interval CNT [RESTORE] [SRC_IFACE] [DST_ADDR]
+# CNT: loop step.
+# RESTORE: whether restore ip addr.
+# SRC_IFACE: source interface name.
+# DST_ADDR: destination IPv4 or IPv6 address.
+check_connectivity_interval()
+{
+	local cnt="$1"
+	local restore="${2:-false}"
+	local src_iface="${3:-$(tst_iface)}"
+	local dst_addr="${4:-$(tst_ipaddr rhost)}"
+
+	[ $CHECK_INTERVAL -eq 0 ] && return
+
+	[ $(($cnt % $CHECK_INTERVAL)) -ne 0 ] && return
+
+	[ "$restore" != "false" ] && restore_ipaddr
+
+	check_connectivity $src_iface $dst_addr $cnt
+}
+
+# Run netstress process on both lhost and rhost.
+# make_background_tcp_traffic [IP]
+# IP: server IP; Default value is $(tst_ipaddr).
+make_background_tcp_traffic()
+{
+	local ip="${1:-$(tst_ipaddr)}"
+	local port=$(tst_get_unused_port ipv${ipver} stream)
+
+	netstress -R 3 -g $port > /dev/null 2>&1 &
+	tst_rhost_run -b -c "netstress -l -H $ip -g $port"
+}
+
+# Kill process on local/remote host.
+# kill_daemon CMD [TYPE]
+# CMD: command to kill.
+# TYPE: { lhost | rhost }; Default value is 'lhost'.
+kill_daemon()
+{
+	local cmd="pkill -SIGHUP -x $1; tst_sleep 10ms; pkill -9 -x $1"
+	local type="${2:-lhost}"
+	[ $type = "lhost" ] && sh -c "$cmd" || tst_rhost_run -c "$cmd"
+}
-- 
2.13.2

