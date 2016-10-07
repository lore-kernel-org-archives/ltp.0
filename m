From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri,  7 Oct 2016 10:56:45 +0300
Subject: [LTP] [PATCH] network/geneve: add performance test for geneve tunnel
Message-ID: <1475827005-32327-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test is based on vxlan03 test and repeats the same steps,
but without additional options.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.features               |    3 ++
 testcases/network/virt/Makefile    |    1 +
 testcases/network/virt/geneve01.sh |   59 ++++++++++++++++++++++++++++++++++++
 testcases/network/virt/virt_lib.sh |   21 +++++++-----
 4 files changed, 75 insertions(+), 9 deletions(-)
 create mode 100755 testcases/network/virt/geneve01.sh

diff --git a/runtest/net.features b/runtest/net.features
index a64028b..963d8c5 100644
--- a/runtest/net.features
+++ b/runtest/net.features
@@ -37,3 +37,6 @@ gre_ipv6_01 gre01.sh -6
 
 dctcp_ipv4_01 dctcp01.sh
 dctcp_ipv6_01 dctcp01.sh -6
+
+geneve01 geneve01.sh
+geneve01_ipv6 geneve01.sh -6
diff --git a/testcases/network/virt/Makefile b/testcases/network/virt/Makefile
index 54e374f..9a97a82 100644
--- a/testcases/network/virt/Makefile
+++ b/testcases/network/virt/Makefile
@@ -19,6 +19,7 @@ top_srcdir		?= ../../..
 include $(top_srcdir)/include/mk/env_pre.mk
 
 INSTALL_TARGETS		:= ipvlan01.sh \
+			   geneve01.sh \
 			   gre01.sh \
 			   macvlan01.sh \
 			   macvtap01.sh \
diff --git a/testcases/network/virt/geneve01.sh b/testcases/network/virt/geneve01.sh
new file mode 100755
index 0000000..7d15098
--- /dev/null
+++ b/testcases/network/virt/geneve01.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+# Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
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
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+
+TCID=geneve01
+TST_TOTAL=1
+
+virt_type="geneve"
+start_id=16700000
+
+# Setting GENEVE tunnel with 'ip' command is very similar to VxLAN
+# that is why using here 'vxlan_*' library functions.
+vxlan_dst_addr="uni"
+
+. test_net.sh
+. virt_lib.sh
+
+VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-160}
+[ "$VIRT_PERF_THRESHOLD" -lt 160 ] && VIRT_PERF_THRESHOLD=160
+
+cleanup()
+{
+	cleanup_vifaces
+	tst_rhost_run -c "ip link delete ltp_v0 2>/dev/null"
+	if [ "$net_load" = "TFO" ]; then
+		tst_rhost_run -c "pkill -9 netstress\$"
+		pkill -9 "netstress\$"
+	fi
+}
+TST_CLEANUP="cleanup"
+
+if [ -z $ip_local -o -z $ip_remote ]; then
+	tst_brkm TBROK "you must specify IP address"
+fi
+
+tst_resm TINFO "the same VNI must work"
+# VNI is 24 bits long, so max value, which is not reserved, is 0xFFFFFE
+vxlan_setup_subnet_$vxlan_dst_addr "id 0xFFFFFE" "id 0xFFFFFE"
+virt_compare_netperf
+
+tst_resm TINFO "different VNI shall not work together"
+vxlan_setup_subnet_$vxlan_dst_addr "id 0xFFFFFE" "id 0xFFFFFD"
+virt_compare_netperf "fail"
+
+tst_exit
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 2a46076..1757698 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -110,6 +110,9 @@ virt_add()
 		[ -z "$opt" ] && opt="id 4094"
 		[ "$vxlan_dstport" -eq 1 ] && opt="dstport 0 $opt"
 	;;
+	geneve)
+		[ -z "$opt" ] && opt="id 4094 remote $(tst_ipaddr rhost)"
+	;;
 	gre|ip6gre)
 		[ -z "$opt" ] && \
 			opt="remote $(tst_ipaddr rhost) dev $(tst_iface)"
@@ -117,7 +120,7 @@ virt_add()
 	esac
 
 	case $virt_type in
-	vxlan)
+	vxlan|geneve)
 		ip li add $vname type $virt_type $opt
 	;;
 	gre|ip6gre)
@@ -133,7 +136,7 @@ virt_add_rhost()
 {
 	local opt=""
 	case $virt_type in
-	vxlan)
+	vxlan|geneve)
 		[ "$vxlan_dstport" -eq 1 ] && opt="dstport 0"
 		tst_rhost_run -s -c "ip li add ltp_v0 type $virt_type $@ $opt"
 	;;
@@ -237,7 +240,7 @@ vxlan_setup_subnet_uni()
 	tst_kvercmp 3 10 0 && \
 		tst_brkm TCONF "test must be run with kernel 3.10 or newer"
 
-	[ "$(ip li add type vxlan help 2>&1 | grep remote)" ] || \
+	[ "$(ip li add type $virt_type help 2>&1 | grep remote)" ] || \
 		tst_brkm TCONF "iproute doesn't support remote unicast address"
 
 	local opt="$1 remote $(tst_ipaddr rhost)"
@@ -301,13 +304,13 @@ virt_compare_netperf()
 	per6=$(( $vt6 * 100 / $lt - 100 ))
 
 	case "$virt_type" in
-	vxlan)
-		tst_resm TINFO "IPv4 VxLAN over IPv$ipver slower by $per %"
-		tst_resm TINFO "IPv6 VxLAN over IPv$ipver slower by $per6 %"
+	vxlan|geneve)
+		tst_resm TINFO "IP4 $virt_type over IP$ipver slower by $per %"
+		tst_resm TINFO "IP6 $virt_type over IP$ipver slower by $per6 %"
 	;;
 	*)
-		tst_resm TINFO "IPv4 $virt_type slower by $per %"
-		tst_resm TINFO "IPv6 $virt_type slower by $per6 %"
+		tst_resm TINFO "IP4 $virt_type slower by $per %"
+		tst_resm TINFO "IP6 $virt_type slower by $per6 %"
 	esac
 
 	if [ "$per" -ge "$VIRT_PERF_THRESHOLD" -o \
@@ -388,7 +391,7 @@ virt_test_02()
 tst_require_root
 
 case "$virt_type" in
-vxlan)
+vxlan|geneve)
 	tst_kvercmp 3 8 0 && \
 		tst_brkm TCONF "test must be run with kernel 3.8 or newer"
 
-- 
1.7.1

