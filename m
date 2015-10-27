From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 27 Oct 2015 18:13:36 +0300
Subject: [LTP] [PATCH] network/dctcp: add dctcp congestion control algorithm
	test
Message-ID: <1445958816-27745-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test compares cubic and dctcp congestion control algorithms
performance. One of the hosts emulates packets congestion with netem
loss 0.03%. Also ECN is enabled on the host, which is required
for dctcp algorithm to work properly.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/network_stress.features    |    3 +
 testcases/network/dctcp/Makefile   |   22 ++++++++
 testcases/network/dctcp/dctcp01.sh |  100 ++++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+), 0 deletions(-)
 create mode 100644 testcases/network/dctcp/Makefile
 create mode 100755 testcases/network/dctcp/dctcp01.sh

diff --git a/runtest/network_stress.features b/runtest/network_stress.features
index 668f3da..bb907e5 100644
--- a/runtest/network_stress.features
+++ b/runtest/network_stress.features
@@ -31,3 +31,6 @@ ipvlan01 ipvlan01.sh
 
 gre_ipv4_01 gre01.sh
 gre_ipv6_01 gre01.sh -6
+
+dctcp_ipv4_01 dctcp01.sh
+dctcp_ipv6_01 dctcp01.sh -6
diff --git a/testcases/network/dctcp/Makefile b/testcases/network/dctcp/Makefile
new file mode 100644
index 0000000..82a6262
--- /dev/null
+++ b/testcases/network/dctcp/Makefile
@@ -0,0 +1,22 @@
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
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
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= dctcp01.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/dctcp/dctcp01.sh b/testcases/network/dctcp/dctcp01.sh
new file mode 100755
index 0000000..7181abc
--- /dev/null
+++ b/testcases/network/dctcp/dctcp01.sh
@@ -0,0 +1,100 @@
+#!/bin/sh
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
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
+TCID=dctcp01
+TST_TOTAL=1
+TST_CLEANUP="cleanup"
+def_alg="cubic"
+prev_alg=
+
+. test_net.sh
+
+set_cong_alg()
+{
+	local alg=$1
+	tst_resm TINFO "setting $alg"
+
+	ROD sysctl -q -w net.ipv4.tcp_congestion_control=$alg
+	tst_rhost_run -s -c "sysctl -q -w net.ipv4.tcp_congestion_control=$alg"
+}
+
+cleanup()
+{
+	if [ "$prev_cong_ctl" ]; then
+		sysctl -q -w net.ipv4.tcp_congestion_control=$prev_alg
+		tst_rhost_run -c \
+			"sysctl -q -w net.ipv4.tcp_congestion_control=$prev_alg"
+	fi
+	tst_rmdir
+	tc qdisc del dev $(tst_iface) root netem loss 0.03% ecn
+}
+
+setup()
+{
+	tst_require_root
+	tst_check_cmds ip sysctl tc
+
+	tst_resm TINFO "emulate congestion with packet loss 0.03% and ECN"
+	tc qdisc add dev $(tst_iface) root netem loss 0.03% ecn > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_brkm TCONF "netem doesn't support ECN"
+	fi
+
+	tst_tmpdir
+
+	prev_alg="$(cat /proc/sys/net/ipv4/tcp_congestion_control)"
+}
+
+test_run()
+{
+	tst_resm TINFO "compare '$def_alg' and 'dctcp' congestion alg. results"
+
+	set_cong_alg "$def_alg"
+
+	tst_netload $(tst_ipaddr rhost) tfo_res TFO
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "test with '$def_alg' has failed"
+		return
+	fi
+	local res0="$(cat tfo_res)"
+	tst_resm TINFO "$def_alg time '$res0' ms"
+
+	set_cong_alg "dctcp"
+
+	tst_netload $(tst_ipaddr rhost) tfo_res TFO
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "test with 'dctcp' has failed"
+		return
+	fi
+	local res1="$(cat tfo_res)"
+	tst_resm TINFO "dctcp time '$res1' ms"
+
+	local per=$(( $res0 * 100 / $res1 - 100 ))
+
+	if [ "$per" -lt "10" ]; then
+		tst_resm TFAIL "dctcp performance $per %"
+	else
+		tst_resm TPASS "dctcp performance $per %"
+	fi
+}
+
+setup
+
+test_run
+
+tst_exit
-- 
1.7.1

