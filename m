From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 29 Oct 2018 16:03:21 +0300
Subject: [LTP] [PATCH 5/6] network/mpls03: add MPLS over GRE and GREv6
In-Reply-To: <1540818202-11247-1-git-send-email-alexey.kodanev@oracle.com>
References: <1540818202-11247-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1540818202-11247-6-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Note, support for GREv6 was added in Linux 4.19.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.features               |    3 ++
 testcases/network/mpls/mpls03.sh   |   24 ++++++++++++++
 testcases/network/mpls/mpls_lib.sh |   59 ++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 0 deletions(-)
 create mode 100755 testcases/network/mpls/mpls03.sh

diff --git a/runtest/net.features b/runtest/net.features
index 29d5092..6076e2a 100644
--- a/runtest/net.features
+++ b/runtest/net.features
@@ -64,3 +64,6 @@ sit01 sit01.sh
 mpls01 mpls01.sh
 mpls02 mpls02.sh
 mpls02_ipv6 mpls02.sh -6
+mpls03 mpls03.sh
+mpls03_ipv6 mpls03.sh -6
+
diff --git a/testcases/network/mpls/mpls03.sh b/testcases/network/mpls/mpls03.sh
new file mode 100755
index 0000000..0db6dbf
--- /dev/null
+++ b/testcases/network/mpls/mpls03.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Oracle and/or its affiliates. All Rights Reserved.
+
+TST_SETUP="setup"
+TST_TESTFUNC="mpls_virt_test"
+TST_CLEANUP="mpls_virt_cleanup"
+
+. virt_lib.sh
+. mpls_lib.sh
+
+setup()
+{
+	virt_type="gre"
+	if [ -n "$TST_IPV6" ]; then
+		tst_kvcmp -lt "4.19" && \
+			tst_brk TCONF "mpls + ip6gre requires kernel 4.19+"
+		virt_type="ip6gre"
+	fi
+
+	mpls_virt_setup
+}
+
+tst_run
diff --git a/testcases/network/mpls/mpls_lib.sh b/testcases/network/mpls/mpls_lib.sh
index 87aec5c..36c2335 100755
--- a/testcases/network/mpls/mpls_lib.sh
+++ b/testcases/network/mpls/mpls_lib.sh
@@ -22,6 +22,17 @@ mpls_cleanup()
 	[ -n $rpf_rmt ] && tst_rhost_run -s -c "sysctl -q net.ipv4.conf.all.rp_filter=$rpf_rmt"
 }
 
+mpls_virt_cleanup()
+{
+	ip route del $ip_virt_remote/32 dev ltp_v0 > /dev/null 2>&1
+	ip route del $ip6_virt_remote/128 dev ltp_v0 > /dev/null 2>&1
+	tst_rhost_run -c "ip route del $ip_virt_local/32 dev ltp_v0" > /dev/null
+	tst_rhost_run -c "ip route del $ip6_virt_local/128 dev ltp_v0" > /dev/null
+
+	virt_cleanup
+	mpls_cleanup
+}
+
 mpls_setup()
 {
 	local label="$1"
@@ -44,3 +55,51 @@ mpls_setup()
 	rpf_rmt="$(tst_rhost_run -c 'sysctl -n net.ipv4.conf.all.rp_filter')"
 	tst_rhost_run -s -c "sysctl -q net.ipv4.conf.all.rp_filter=2"
 }
+
+mpls_setup_tnl()
+{
+	local ip_loc="$1"
+	local ip_rmt="$2"
+	local label="$3"
+	local mask
+
+	echo "$ip_loc" | grep -q ':' && mask=128 || mask=32
+
+	ROD ip route add $ip_rmt/$mask encap mpls $label dev ltp_v0
+	ROD ip -f mpls route add $((label + 1)) dev lo
+
+	tst_rhost_run -s -c "ip route add $ip_loc/$mask encap mpls $((label + 1)) dev ltp_v0"
+	tst_rhost_run -s -c "ip -f mpls route add $label dev lo"
+}
+mpls_virt_setup()
+{
+	mpls_setup 62
+
+	virt_lib_setup
+
+	tst_res TINFO "test $virt_type with MPLS"
+	virt_setup "local $(tst_ipaddr) remote $(tst_ipaddr rhost) dev $(tst_iface)" \
+		   "local $(tst_ipaddr rhost) remote $(tst_ipaddr) dev $(tst_iface rhost)"
+
+	mpls_setup_tnl $ip_virt_local $ip_virt_remote 60
+	mpls_setup_tnl $ip6_virt_local $ip6_virt_remote 50
+
+	ROD sysctl -q net.mpls.conf.ltp_v0.input=1
+	tst_rhost_run -s -c "sysctl -q net.mpls.conf.ltp_v0.input=1"
+}
+
+mpls_virt_test()
+{
+	local type=$2
+	local max_size=10000
+
+	if [ "$type" = "icmp" ]; then
+		tst_ping $ip_virt_local $ip_virt_remote 10 100 1000 2000 $max_size
+		tst_ping $ip6_virt_local $ip6_virt_remote 10 100 1000 2000 $max_size
+	else
+		tst_netload -S $ip_virt_local -H $ip_virt_remote -T $type -n 10 -N 10
+		tst_netload -S $ip6_virt_local -H $ip6_virt_remote -T $type -n 10 -N 10
+		tst_netload -S $ip_virt_local -H $ip_virt_remote -T $type -A $max_size
+		tst_netload -S $ip6_virt_local -H $ip6_virt_remote -T $type -A $max_size
+	fi
+}
-- 
1.7.1

