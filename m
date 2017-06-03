From: Petr Vorel <pvorel@suse.cz>
Date: Sat,  3 Jun 2017 14:00:17 +0200
Subject: [LTP] [RFC PATCH v6 06/11] network/stress: Add library
	test_stress_net.sh for general usage
In-Reply-To: <20170603120022.13415-1-pvorel@suse.cz>
References: <20170603120022.13415-1-pvorel@suse.cz>
Message-ID: <20170603120022.13415-7-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* This library is intended to be used throughout all stress tests reduce
duplicity and use code test_net.sh where possible instead of legacy
scripts in testcases/network/stress/ns-tools/.

* check_connectivity() is split into general part (in test_stress_net.sh)
ment as replacement of check_icmpv4_connectivity script and loop part
wrapper check_connectivity_loop() (in if-lib.sh).

* if-lib.sh sources test_stress_net.sh.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/interface/if-addr-adddel  |   2 +-
 .../network/stress/interface/if-addr-addlarge      |   3 +-
 testcases/network/stress/interface/if-lib.sh       |  32 +++--
 testcases/network/stress/interface/if-route-adddel |   2 +-
 .../network/stress/interface/if-route-addlarge     |   2 +-
 testcases/network/stress/interface/if-updown       |   2 +-
 testcases/network/stress/ns-tools/Makefile         |   2 +-
 .../network/stress/ns-tools/test_stress_net.sh     | 136 +++++++++++++++++++++
 8 files changed, 157 insertions(+), 24 deletions(-)
 create mode 100644 testcases/network/stress/ns-tools/test_stress_net.sh

diff --git a/testcases/network/stress/interface/if-addr-adddel b/testcases/network/stress/interface/if-addr-adddel
index dcc018a48..1e80368c9 100644
--- a/testcases/network/stress/interface/if-addr-adddel
+++ b/testcases/network/stress/interface/if-addr-adddel
@@ -88,7 +88,7 @@ test_body()
 			return
 		fi
 
-		check_connectivity $cnt || return
+		check_connectivity_interval $cnt || return
 
 		cnt=$(($cnt + 1))
 
diff --git a/testcases/network/stress/interface/if-addr-addlarge b/testcases/network/stress/interface/if-addr-addlarge
index 9e550068b..1bfa1b761 100644
--- a/testcases/network/stress/interface/if-addr-addlarge
+++ b/testcases/network/stress/interface/if-addr-addlarge
@@ -100,8 +100,7 @@ test_body()
 			return
 		fi
 
-		# Check the connectivity
-		check_connectivity $cnt || return
+		check_connectivity_interval $cnt || return
 
 		# Check the background TCP traffic
 		pgrep -x netstress > /dev/null || make_background_tcp_traffic
diff --git a/testcases/network/stress/interface/if-lib.sh b/testcases/network/stress/interface/if-lib.sh
index 4168dd09f..831b65209 100644
--- a/testcases/network/stress/interface/if-lib.sh
+++ b/testcases/network/stress/interface/if-lib.sh
@@ -18,7 +18,7 @@
 
 TST_CLEANUP="cleanup"
 
-. test_net.sh
+. test_stress_net.sh
 
 ipver=${TST_IPV6:-4}
 
@@ -46,28 +46,26 @@ make_background_tcp_traffic()
 	tst_rhost_run -b -c "netstress -l -H $(tst_ipaddr) -g $port"
 }
 
-check_connectivity()
+restore_ipaddr()
+{
+	tst_restore_ipaddr || return $?
+	tst_wait_ipv6_dad
+}
+
+# check_connectivity_interval [CNT] [RESTORE]
+# CNT: loop step
+# RESTORE: whether restore ip addr (not required, default false)
+check_connectivity_interval()
 {
 	local cnt="$1"
-	local restore="$2"
+	local restore="${2:-}"
 
 	[ $CHECK_INTERVAL -eq 0 ] && return
 	[ $(($cnt % $CHECK_INTERVAL)) -ne 0 ] && return
 
-	tst_resm TINFO "check connectivity through $(tst_iface) on step $cnt"
-
+	tst_resm TINFO "check connectivity step $cnt"
 	[ -n "$restore" ] && restore_ipaddr
 
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
+	check_connectivity
+	return $?
 }
diff --git a/testcases/network/stress/interface/if-route-adddel b/testcases/network/stress/interface/if-route-adddel
index 451674178..6f45f4e03 100644
--- a/testcases/network/stress/interface/if-route-adddel
+++ b/testcases/network/stress/interface/if-route-adddel
@@ -86,7 +86,7 @@ test_body()
 			return
 		fi
 
-		check_connectivity $cnt || return
+		check_connectivity_interval $cnt || return
 
 		# Check the background TCP traffic
 		pgrep -x netstress > /dev/null || make_background_tcp_traffic
diff --git a/testcases/network/stress/interface/if-route-addlarge b/testcases/network/stress/interface/if-route-addlarge
index e83cf60a7..2ea30e461 100644
--- a/testcases/network/stress/interface/if-route-addlarge
+++ b/testcases/network/stress/interface/if-route-addlarge
@@ -93,7 +93,7 @@ test_body()
 			return
 		fi
 
-		check_connectivity $cnt || return
+		check_connectivity_interval $cnt || return
 
 		# Check the background TCP traffic
 		pgrep -x netstress > /dev/null || make_background_tcp_traffic
diff --git a/testcases/network/stress/interface/if-updown b/testcases/network/stress/interface/if-updown
index deefef639..681d3989a 100644
--- a/testcases/network/stress/interface/if-updown
+++ b/testcases/network/stress/interface/if-updown
@@ -59,7 +59,7 @@ test_body()
 			return
 		fi
 
-		check_connectivity $cnt restore_ip || return
+		check_connectivity_interval $cnt restore_ip || return
 
 		cnt=$(($cnt + 1))
 	done
diff --git a/testcases/network/stress/ns-tools/Makefile b/testcases/network/stress/ns-tools/Makefile
index 61f85634a..5316efae7 100644
--- a/testcases/network/stress/ns-tools/Makefile
+++ b/testcases/network/stress/ns-tools/Makefile
@@ -29,7 +29,7 @@ INSTALL_TARGETS		:= check_envval get_ifname initialize_if set_ipv4addr \
 			   check_icmpv6_connectivity check_netem check_setkey \
 			   create_file find_portbundle killall_icmp_traffic \
 			   killall_tcp_traffic killall_udp_traffic output_ipsec_conf \
-			   ns-echoclient
+			   ns-echoclient test_stress_net.sh
 
 FILTER_OUT_MAKE_TARGETS	:= ns-common
 
diff --git a/testcases/network/stress/ns-tools/test_stress_net.sh b/testcases/network/stress/ns-tools/test_stress_net.sh
new file mode 100644
index 000000000..3c890fe47
--- /dev/null
+++ b/testcases/network/stress/ns-tools/test_stress_net.sh
@@ -0,0 +1,136 @@
+#!/bin/sh
+# Copyright (c) International Business Machines  Corp., 2006
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
+
+# Library for all network/stress/ tests.
+
+# using variables IPV4_NETWORK LHOST_IPV4_HOST RHOST_IPV4_HOST and some functions
+. test_net.sh
+
+tst_check_cmds ifconfig killall
+
+# NOTE: More information about these network variables can be found
+# in testcases/network/stress/README
+
+# TODO: Test expects prefix to be 24, which can get wrong when called
+# with different prefix for IPV4_NETWORK.
+
+# Netmask of for the tested network
+IPV4_NETMASK="255.255.255.0"
+IPV4_NETMASK_NUM=24
+
+# Broadcast address of the tested network
+IPV4_BROADCAST=${IPV4_NETWORK}.255
+# Prefix of the Multicast Address
+MCAST_IPV4_ADDR_PREFIX="224.10"
+# Multicast Address
+MCAST_IPV4_ADDR="${MCAST_IPV4_ADDR_PREFIX}.10.1"
+
+LINK_NUM=${LINK_NUM:-0}
+
+init_if_lhost_rhost()
+{
+	local link_num="$1"
+	tst_init_iface lhost $link_num
+	tst_init_iface rhost $link_num
+}
+
+# Set an IPv4 address on local/remote interface.
+# TYPE: { lhost | rhost }.
+# LINK_NUM: link number starting from 0. Default value is '0'.
+# NETWORK_PART: network part of local and remote IP address
+# HOST_PART: host part of local and remote IP address
+set_ipv4addr_check()
+{
+	local type="${1}"
+	local link_num="$2"
+	local network_part="$3"
+	local host_part="$4"
+	local addr broadcast cmd ifname netmask ret
+
+	addr=${network_part}.${host_part}
+	netmask=$(echo $network_part | sed "s/[[:digit:]]*/255/g").$(echo $host_part | sed "s/[[:digit:]]*/0/g")
+	broadcast=${network_part}.$(echo $host_part | sed "s/[[:digit:]]*/255/g")
+	ifname=$(tst_iface $type $link_num)
+
+	# TODO: use tst_init_iface and tst_add_ipaddr (tst_add_ipaddr must be
+	# adjusted to take mask as parameter).
+	for cmd in "ifconfig $ifname up" \
+		"ifconfig $ifname $addr netmask $netmask broadcast $broadcast"; do
+		[ $type = "lhost" ] && sh -c "$cmd" || tst_rhost_run -c "$cmd"
+		ret=$?
+		[ $ret -ne 0 ] && tst_brkm TBROK "failed to set IP '$addr' to '$ifname' at $type ('$cmd': $ret)"
+	done
+}
+
+# Set an IPv4 address on local and remote interfaces.
+# LINK_NUM: link number starting from 0. Default value is '0'.
+# NETWORK_PART: network part of local and remote IP address
+# LHOST_PART: host part of local IP address
+# RHOST_PART: host part of remote IP address
+set_lhost_rhost_ipv4addr()
+{
+	local link_num="$1"
+	local network_part="$2"
+	local lhost_part="$3"
+	local rhost_part="$4"
+
+	set_ipv4addr_check lhost $link_num $network_part $lhost_part
+	set_ipv4addr_check rhost $link_num $network_part $rhost_part
+}
+
+# Check connectivity with tst_ping.
+# check_connectivity [IFACE] [DST ADDR]
+# IFACE: source interface name
+# DST ADDR: destination IPv4 or IPv6 address
+# CNT: loop step (not required)
+check_connectivity()
+{
+	local src_iface="${1:-$(tst_iface)}"
+	local dst_addr="${2:-$(tst_ipaddr rhost)}"
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
+# Kill process on local/remote host.
+# CMD: command to kill.
+# TYPE: { lhost | rhost }; Default value is 'lhost'.
+killall_sighup()
+{
+	local cmd="killall -q -SIGHUP $1"
+	local type="${2:-lhost}"
+	[ $type = "lhost" ] && $cmd || tst_rhost_run -c "$cmd"
+}
+
+# Kill process on remote host.
+# CMD: command to kill.
+killall_sighup_rhost()
+{
+	killall_sighup $1 rhost
+}
-- 
2.12.2

