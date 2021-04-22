From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 22 Apr 2021 16:16:29 +0300
Subject: [LTP] [PATCH 2/3] network/virt: new test for generic udp
 encapsulation (gue)
In-Reply-To: <20210422131630.28565-1-alexey.kodanev@oracle.com>
References: <20210422131630.28565-1-alexey.kodanev@oracle.com>
Message-ID: <20210422131630.28565-3-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test sets up sit(IPv4) or ip6tnl(IPv6) virtual device using
Generic UDP Encapsulation for each side.

Then, it transmits TCP/UDP/UDP-Lite as inner packets with random
size payload in both directions (using virt_netperf_rand_sizes()).

The test will pass if the performance of encapsulation is not
significantly worse than without it. This is controlled by
VIRT_PERF_THRESHOLD.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.features               |  3 ++
 testcases/network/virt/gue01.sh    | 45 ++++++++++++++++++++++++++++++
 testcases/network/virt/virt_lib.sh | 17 +++++++++--
 3 files changed, 63 insertions(+), 2 deletions(-)
 create mode 100755 testcases/network/virt/gue01.sh

diff --git a/runtest/net.features b/runtest/net.features
index 617a6b91e..091cf9c55 100644
--- a/runtest/net.features
+++ b/runtest/net.features
@@ -60,6 +60,9 @@ gre_ipv6_01 gre01.sh -6
 gre_ipv4_02 gre02.sh
 gre_ipv6_02 gre02.sh -6
 
+gue01 gue01.sh
+gue01_ipv6 gue01.sh -6
+
 dctcp_ipv4_01 dctcp01.sh
 dctcp_ipv6_01 dctcp01.sh -6
 
diff --git a/testcases/network/virt/gue01.sh b/testcases/network/virt/gue01.sh
new file mode 100755
index 000000000..13ac03211
--- /dev/null
+++ b/testcases/network/virt/gue01.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 Oracle and/or its affiliates. All Rights Reserved.
+
+TST_TESTFUNC=virt_netperf_rand_sizes
+TST_SETUP=do_setup
+TST_CLEANUP=do_cleanup
+TST_NEEDS_TMPDIR=1
+
+virt_type="gue"
+. virt_lib.sh
+
+do_cleanup()
+{
+	if [ "$FOU_PORT" ]; then
+		tst_net_run -l $FOU_PORT -r $FOU_PORT_RMT \
+			"ip fou del gue ${TST_IPV6_FLAG} port"
+	fi
+
+	virt_cleanup_rmt
+	virt_cleanup
+}
+
+do_setup()
+{
+	local get_port_cmd="tst_get_unused_port ipv${TST_IPVER} dgram"
+	local encap_cmd="encap gue encap-sport auto encap-dport"
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
+		"ip fou add gue ${TST_IPV6_FLAG} port"
+
+	virt_setup "local $loc_ip remote $rmt_ip $encap_cmd $FOU_PORT_RMT" \
+		   "local $rmt_ip remote $loc_ip $encap_cmd $FOU_PORT"
+}
+
+tst_run
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index abf331428..f5c8bab09 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2018-2019 Petr Vorel <pvorel@suse.cz>
-# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2021 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # VxLAN
@@ -118,7 +118,7 @@ virt_add()
 		[ -z "$opt" ] && \
 			opt="remote $(tst_ipaddr rhost) dev $(tst_iface)"
 	;;
-	sit)
+	sit|gue)
 		[ -z "$opt" ] && opt="remote $(tst_ipaddr rhost) local $(tst_ipaddr)"
 	;;
 	esac
@@ -130,6 +130,12 @@ virt_add()
 	gre|ip6gre)
 		ip -f inet$TST_IPV6 tu add $vname mode $virt_type $opt
 	;;
+	gue)
+		local tnl=sit
+
+		[ -n "$TST_IPV6" ] && tnl="ip6tnl"
+		ip link add name $vname type $tnl $opt
+	;;
 	*)
 		ip li add link $(tst_iface) $vname type $virt_type $opt
 	;;
@@ -152,6 +158,13 @@ virt_add_rhost()
 		tst_rhost_run -s -c "ip -f inet$TST_IPV6 tu add ltp_v0 \
 				     mode $virt_type $@"
 	;;
+	gue)
+		local tnl=sit
+
+		[ -n "$TST_IPV6" ] && tnl="ip6tnl"
+
+		tst_rhost_run -s -c "ip link add name ltp_v0 type $tnl $@"
+	;;
 	*)
 		tst_rhost_run -s -c "ip li add link $(tst_iface rhost) ltp_v0 \
 				     type $virt_type $@"
-- 
2.25.1

