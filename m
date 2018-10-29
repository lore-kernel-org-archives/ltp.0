From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 29 Oct 2018 16:03:20 +0300
Subject: [LTP] [PATCH 4/6] network/mpls02: new test with lwtunnel
In-Reply-To: <1540818202-11247-1-git-send-email-alexey.kodanev@oracle.com>
References: <1540818202-11247-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1540818202-11247-5-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Setup MPLS encapsulation over the default test network setup,
use ICMP, UDP and TCP inner protocols.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.features               |    2 +
 testcases/network/mpls/mpls02.sh   |   53 ++++++++++++++++++++++++++++++++++++
 testcases/network/mpls/mpls_lib.sh |   46 +++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 0 deletions(-)
 create mode 100755 testcases/network/mpls/mpls02.sh
 create mode 100755 testcases/network/mpls/mpls_lib.sh

diff --git a/runtest/net.features b/runtest/net.features
index f858421..29d5092 100644
--- a/runtest/net.features
+++ b/runtest/net.features
@@ -62,3 +62,5 @@ geneve01_ipv6 geneve01.sh -6
 sit01 sit01.sh
 
 mpls01 mpls01.sh
+mpls02 mpls02.sh
+mpls02_ipv6 mpls02.sh -6
diff --git a/testcases/network/mpls/mpls02.sh b/testcases/network/mpls/mpls02.sh
new file mode 100755
index 0000000..745a414
--- /dev/null
+++ b/testcases/network/mpls/mpls02.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Oracle and/or its affiliates. All Rights Reserved.
+
+TST_SETUP="setup"
+TST_TESTFUNC="do_test"
+TST_CLEANUP="cleanup"
+
+. mpls_lib.sh
+
+cleanup()
+{
+	ip route del $ip_rmt/$mask > /dev/null 2>&1
+	tst_rhost_run -c "ip route del $ip_loc/$mask" > /dev/null
+
+	[ -n "$ip_loc" ] && ip addr del $ip_loc/$mask dev lo > /dev/null 2>&1
+	[ -n "$ip_rmt" ] && tst_rhost_run -c "ip addr del $ip_rmt/$mask dev lo" > \
+					      /dev/null 2>&1
+
+	mpls_cleanup
+}
+
+setup()
+{
+	mpls_setup 61
+
+	ip_loc=$(tst_ipaddr_un)
+	ip_rmt=$(tst_ipaddr_un rhost)
+	[ -n "$TST_IPV6" ] && mask=128 || mask=32
+
+	ROD ip addr add $ip_loc/$mask dev lo
+	ROD ip route add $ip_rmt/$mask encap mpls 50 via inet$TST_IPV6 $(tst_ipaddr rhost)
+	ROD ip -f mpls route add 60 dev lo
+
+	tst_rhost_run -s -c "ip addr add $ip_rmt/$mask dev lo"
+	tst_rhost_run -s -c "ip route add $ip_loc/$mask encap mpls 60 via inet$TST_IPV6 $(tst_ipaddr)"
+	tst_rhost_run -s -c "ip -f mpls route add 50 dev lo"
+}
+
+do_test()
+{
+	local type=$2
+	local max_size=10000
+
+	if [ "$type" = "icmp" ]; then
+		tst_ping $ip_loc $ip_rmt 10 100 1000 2000 $max_size
+	else
+		tst_netload -S $ip_loc -H $ip_rmt -T $type -n 10 -N 10
+		tst_netload -S $ip_loc -H $ip_rmt -T $type -A $max_size
+	fi
+}
+
+tst_run
diff --git a/testcases/network/mpls/mpls_lib.sh b/testcases/network/mpls/mpls_lib.sh
new file mode 100755
index 0000000..87aec5c
--- /dev/null
+++ b/testcases/network/mpls/mpls_lib.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Oracle and/or its affiliates. All Rights Reserved.
+
+TST_MIN_KVER="4.3"
+TST_NEEDS_TMPDIR=1
+TST_NEEDS_ROOT=1
+TST_NEEDS_DRIVERS="mpls_router mpls_iptunnel"
+TST_NEEDS_CMDS="sysctl modprobe"
+TST_TEST_DATA="icmp tcp udp"
+
+. tst_net.sh
+
+mpls_cleanup()
+{
+	local flush_dev="ip -f mpls route flush dev"
+
+	$flush_dev lo > /dev/null 2>&1
+	tst_rhost_run -c "$flush_dev lo" > /dev/null
+
+	[ -n $rpf_loc ] && sysctl -q net.ipv4.conf.all.rp_filter=$rpf_loc
+	[ -n $rpf_rmt ] && tst_rhost_run -s -c "sysctl -q net.ipv4.conf.all.rp_filter=$rpf_rmt"
+}
+
+mpls_setup()
+{
+	local label="$1"
+
+	ROD modprobe mpls_router
+	ROD modprobe mpls_iptunnel
+	ROD modprobe mpls_gso
+	ROD sysctl -q net.mpls.conf.$(tst_iface).input=1
+	ROD sysctl -q net.mpls.conf.lo.input=1
+	ROD sysctl -q net.mpls.platform_labels=$label
+	rpf_loc="$(sysctl -n net.ipv4.conf.all.rp_filter)"
+	ROD sysctl -q net.ipv4.conf.all.rp_filter=2
+
+	tst_rhost_run -s -c "modprobe mpls_router"
+	tst_rhost_run -s -c "modprobe mpls_iptunnel"
+	tst_rhost_run -s -c "modprobe mpls_gso"
+	tst_rhost_run -s -c "sysctl -q net.mpls.conf.$(tst_iface rhost).input=1"
+	tst_rhost_run -s -c "sysctl -q net.mpls.conf.lo.input=1"
+	tst_rhost_run -s -c "sysctl -q net.mpls.platform_labels=$label"
+	rpf_rmt="$(tst_rhost_run -c 'sysctl -n net.ipv4.conf.all.rp_filter')"
+	tst_rhost_run -s -c "sysctl -q net.ipv4.conf.all.rp_filter=2"
+}
-- 
1.7.1

