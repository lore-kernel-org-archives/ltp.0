From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 15 Oct 2020 15:20:55 +0300
Subject: [LTP] [PATCH 4/5] network/virt: add wireguard01
In-Reply-To: <20201015122056.20715-1-alexey.kodanev@oracle.com>
References: <20201015122056.20715-1-alexey.kodanev@oracle.com>
Message-ID: <20201015122056.20715-4-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* performance tests with TCP traffic

* invalid configuration with allowed IPs, public key

* emulation of the lossy link for the underlying interface.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.features                    |  3 ++
 testcases/network/virt/virt_lib.sh      |  4 +-
 testcases/network/virt/wireguard01.sh   | 56 ++++++++++++++++++++
 testcases/network/virt/wireguard_lib.sh | 68 +++++++++++++++++++++++++
 4 files changed, 129 insertions(+), 2 deletions(-)
 create mode 100755 testcases/network/virt/wireguard01.sh
 create mode 100755 testcases/network/virt/wireguard_lib.sh

diff --git a/runtest/net.features b/runtest/net.features
index 44a974563..c5a1ba714 100644
--- a/runtest/net.features
+++ b/runtest/net.features
@@ -78,3 +78,6 @@ mpls03_ipv6 mpls03.sh -6
 mpls04 mpls04.sh
 
 fanout01 fanout01
+
+wireguard01 wireguard01.sh
+wireguard01_ipv6 wireguard01.sh -6
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index f62120347..abf331428 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -124,7 +124,7 @@ virt_add()
 	esac
 
 	case $virt_type in
-	vxlan|geneve|sit)
+	vxlan|geneve|sit|wireguard)
 		ip li add $vname type $virt_type $opt
 	;;
 	gre|ip6gre)
@@ -145,7 +145,7 @@ virt_add_rhost()
 		[ "$vxlan_dstport" -eq 1 ] && opt="$opt dstport 0"
 		tst_rhost_run -s -c "ip li add ltp_v0 type $virt_type $@ $opt"
 	;;
-	sit)
+	sit|wireguard)
 		tst_rhost_run -s -c "ip link add ltp_v0 type $virt_type $@"
 	;;
 	gre|ip6gre)
diff --git a/testcases/network/virt/wireguard01.sh b/testcases/network/virt/wireguard01.sh
new file mode 100755
index 000000000..ff0c7e92b
--- /dev/null
+++ b/testcases/network/virt/wireguard01.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020 Oracle and/or its affiliates. All Rights Reserved.
+
+TST_NEEDS_CMDS="tc"
+TST_SETUP=setup
+TST_CLEANUP=cleanup
+TST_TESTFUNC=test
+TST_CNT=3
+
+. wireguard_lib.sh
+
+setup()
+{
+	if [ -n "$LTP_NETNS" -a "$VIRT_PERF_THRESHOLD" -lt 700 ]; then
+		tst_res TINFO "Adjust threshold for veth (no encap/encrypt)"
+		VIRT_PERF_THRESHOLD=700
+	fi
+
+	local netem_opt="reorder 30% 50% delay 1"
+	tst_res TINFO "Use netem $netem_opt"
+	ROD tc qdisc add dev $(tst_iface) root netem $netem_opt
+	wireguard_lib_setup
+}
+
+cleanup()
+{
+	tc qdisc del dev $(tst_iface) root netem >/dev/null 2>&1
+	wireguard_lib_cleanup
+}
+
+test1()
+{
+	tst_res TINFO "Using correct wireguard configuration"
+	virt_netperf_msg_sizes
+	wireguard_lib_cleanup
+}
+
+test2()
+{
+	tst_res TINFO "Invalid configuration with allowed IPs"
+	wireguard_lib_setup invalid_allowed_ips
+	virt_minimize_timeout
+	virt_compare_netperf "fail"
+	wireguard_lib_cleanup
+}
+
+test3()
+{
+	tst_res TINFO "Invalid configuration with public keys"
+	wireguard_lib_setup invalid_pub_keys
+	virt_minimize_timeout
+	virt_compare_netperf "fail"
+}
+
+tst_run
diff --git a/testcases/network/virt/wireguard_lib.sh b/testcases/network/virt/wireguard_lib.sh
new file mode 100755
index 000000000..c6ea7334e
--- /dev/null
+++ b/testcases/network/virt/wireguard_lib.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020 Oracle and/or its affiliates. All Rights Reserved.
+
+TST_NEEDS_TMPDIR=1
+TST_NEEDS_CMDS="$TST_NEEDS_CMDS wg"
+TST_TESTFUNC=${TST_TESTFUNC:-virt_netperf_msg_sizes}
+TST_SETUP=${TST_SETUP:-wireguard_lib_setup}
+TST_CLEANUP=${TST_CLEANUP:-wireguard_lib_cleanup}
+TST_NEEDS_DRIVERS="wireguard"
+VIRT_PERF_THRESHOLD_MIN=${VIRT_PERF_THRESHOLD_MIN:-200}
+
+virt_type="wireguard"
+. virt_lib.sh
+
+# Usage: wireguard_lib_setup [TYPE]
+# TYPE: [ default | invalid_allowed_ips | invalid_pub_keys ]
+wireguard_lib_setup()
+{
+	local type="${1:-default}"
+	local pub_key0="$(wg genkey | tee wg0.key | wg pubkey)"
+	local pub_key1="$(wg genkey | tee wg1.key | wg pubkey)"
+
+	local port_loc="$(tst_get_unused_port ipv${TST_IPVER} dgram)"
+	local port_rmt=$(tst_rhost_run -c "tst_get_unused_port ipv${TST_IPVER} dgram")
+
+	# copy private key to remote host
+	tst_rhost_run -s -c "echo '$(cat wg1.key)' > wg1.key"
+
+	tst_res TINFO "setup wireguard UDPv${TST_IPVER} tunnel, port $port_loc/$port_rmt"
+	tst_res TINFO "lhost[$(tst_ipaddr)] <-> rhost[$(tst_ipaddr rhost)]"
+
+	virt_setup
+
+	local ka_opt="persistent-keepalive 1"
+	local allow_ip_loc="${ip_virt_local}/32,${ip6_virt_local}/128"
+	local allow_ip_rmt="${ip_virt_remote}/32,${ip6_virt_remote}/128"
+
+	case $type in
+	invalid_allowed_ips)
+		allow_ip_loc="${ip_virt_remote}/32,${ip6_virt_remote}/128"
+		allow_ip_rmt="${ip_virt_local}/32,${ip6_virt_local}/128"
+		tst_res TINFO "Allowed IPs are source IPs only"
+		;;
+	invalid_pub_keys)
+		pub_key0="$(wg genkey | wg pubkey)"
+		tst_res TINFO "Invalid peer public key of lhost"
+		;;
+	esac
+
+	ROD wg set ltp_v0 listen-port $port_loc private-key wg0.key
+	ROD wg set ltp_v0 peer $pub_key1 endpoint \
+		$(tst_ipaddr rhost):$port_rmt $ka_opt \
+		allowed-ips $allow_ip_rmt
+
+	tst_rhost_run -s -c \
+		"wg set ltp_v0 listen-port $port_rmt private-key wg1.key"
+	tst_rhost_run -s -c "wg set ltp_v0 peer $pub_key0 \
+		endpoint $(tst_ipaddr):$port_loc $ka_opt \
+		allowed-ips $allow_ip_loc"
+
+	tst_net_run -s "ip route add 128.0.0.0/1 dev ltp_v0"
+}
+
+wireguard_lib_cleanup()
+{
+	virt_cleanup
+}
-- 
2.20.1

