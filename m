From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 22 Apr 2021 16:16:30 +0300
Subject: [LTP] [PATCH 3/3] network/virt: new foo over udp (fou) tunneling
 test
In-Reply-To: <20210422131630.28565-1-alexey.kodanev@oracle.com>
References: <20210422131630.28565-1-alexey.kodanev@oracle.com>
Message-ID: <20210422131630.28565-4-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test sets up GRE(IPv4 and IPv6) virtual device using Foo
over UDP for each side.

Then, it transmits TCP/UDP/UDP-Lite as inner packets with random
size payload in both directions (using virt_netperf_rand_sizes()).

The test will pass if the performance of encapsulation is not
significantly worse than without it. This is controlled by
VIRT_PERF_THRESHOLD.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.features               |  3 ++
 testcases/network/virt/fou01.sh    | 48 ++++++++++++++++++++++++++++++
 testcases/network/virt/virt_lib.sh | 31 +++++++++++--------
 3 files changed, 70 insertions(+), 12 deletions(-)
 create mode 100755 testcases/network/virt/fou01.sh

diff --git a/runtest/net.features b/runtest/net.features
index 091cf9c55..4e1504df5 100644
--- a/runtest/net.features
+++ b/runtest/net.features
@@ -63,6 +63,9 @@ gre_ipv6_02 gre02.sh -6
 gue01 gue01.sh
 gue01_ipv6 gue01.sh -6
 
+fou01 fou01.sh
+fou01_ipv6 fou01.sh -6
+
 dctcp_ipv4_01 dctcp01.sh
 dctcp_ipv6_01 dctcp01.sh -6
 
diff --git a/testcases/network/virt/fou01.sh b/testcases/network/virt/fou01.sh
new file mode 100755
index 000000000..77521e260
--- /dev/null
+++ b/testcases/network/virt/fou01.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 Oracle and/or its affiliates. All Rights Reserved.
+
+TST_TESTFUNC=virt_netperf_rand_sizes
+TST_SETUP=do_setup
+TST_CLEANUP=do_cleanup
+TST_NEEDS_TMPDIR=1
+
+virt_type="fou"
+. virt_lib.sh
+
+# GRE IP protocol number
+PROTO=47
+
+do_cleanup()
+{
+	if [ "$FOU_PORT" ]; then
+		tst_net_run -l $FOU_PORT -r $FOU_PORT_RMT \
+			"ip fou del ipproto $PROTO ${TST_IPV6_FLAG} port"
+	fi
+
+	virt_cleanup_rmt
+	virt_cleanup
+}
+
+do_setup()
+{
+	local get_port_cmd="tst_get_unused_port ipv${TST_IPVER} dgram"
+	local encap_cmd="encap fou encap-sport auto encap-dport"
+	local loc_ip=$(tst_ipaddr)
+	local rmt_ip=$(tst_ipaddr rhost)
+	local fou="fou$TST_IPV6"
+
+	tst_require_drivers $fou
+	tst_net_run -s modprobe $fou
+
+	FOU_PORT=$($get_port_cmd)
+	FOU_PORT_RMT=$(tst_rhost_run -c "$get_port_cmd")
+
+	tst_net_run -s -l $FOU_PORT -r $FOU_PORT_RMT \
+		"ip fou add ipproto $PROTO ${TST_IPV6_FLAG} port"
+
+	virt_setup "local $loc_ip remote $rmt_ip $encap_cmd $FOU_PORT_RMT" \
+		   "local $rmt_ip remote $loc_ip $encap_cmd $FOU_PORT"
+}
+
+tst_run
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index f5c8bab09..f511d3f92 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -99,6 +99,19 @@ virt_cleanup()
 	virt_cleanup_rmt
 }
 
+_get_gue_fou_tnl()
+{
+	local enc_type="$1"
+	local tnl=sit
+
+	if [ "$enc_type" = "gue" ]; then
+		[ -n "$TST_IPV6" ] && tnl="ip6tnl"
+	else
+		[ -n "$TST_IPV6" ] && tnl="ip6gre" || tnl="gre"
+	fi
+	echo "$tnl"
+}
+
 virt_add()
 {
 	local vname=$1
@@ -118,7 +131,7 @@ virt_add()
 		[ -z "$opt" ] && \
 			opt="remote $(tst_ipaddr rhost) dev $(tst_iface)"
 	;;
-	sit|gue)
+	sit|gue|fou)
 		[ -z "$opt" ] && opt="remote $(tst_ipaddr rhost) local $(tst_ipaddr)"
 	;;
 	esac
@@ -130,11 +143,8 @@ virt_add()
 	gre|ip6gre)
 		ip -f inet$TST_IPV6 tu add $vname mode $virt_type $opt
 	;;
-	gue)
-		local tnl=sit
-
-		[ -n "$TST_IPV6" ] && tnl="ip6tnl"
-		ip link add name $vname type $tnl $opt
+	gue|fou)
+		ip link add name $vname type $(_get_gue_fou_tnl $virt_type) $opt
 	;;
 	*)
 		ip li add link $(tst_iface) $vname type $virt_type $opt
@@ -158,12 +168,9 @@ virt_add_rhost()
 		tst_rhost_run -s -c "ip -f inet$TST_IPV6 tu add ltp_v0 \
 				     mode $virt_type $@"
 	;;
-	gue)
-		local tnl=sit
-
-		[ -n "$TST_IPV6" ] && tnl="ip6tnl"
-
-		tst_rhost_run -s -c "ip link add name ltp_v0 type $tnl $@"
+	gue|fou)
+		tst_rhost_run -s -c "ip link add name ltp_v0 \
+				     type $(_get_gue_fou_tnl $virt_type) $@"
 	;;
 	*)
 		tst_rhost_run -s -c "ip li add link $(tst_iface rhost) ltp_v0 \
-- 
2.25.1

