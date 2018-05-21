From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 21 May 2018 14:48:25 +0300
Subject: [LTP] [PATCH 1/6] network: rename dcctp dir to tcp_cc
In-Reply-To: <1526903310-2833-1-git-send-email-alexey.kodanev@oracle.com>
References: <1526903310-2833-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1526903310-2833-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This directory will include other TCP congestion control
related tests, not only dctcp algorithm.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/dctcp/Makefile    |   22 --------
 testcases/network/dctcp/dctcp01.sh  |   91 -----------------------------------
 testcases/network/tcp_cc/Makefile   |   22 ++++++++
 testcases/network/tcp_cc/dctcp01.sh |   91 +++++++++++++++++++++++++++++++++++
 4 files changed, 113 insertions(+), 113 deletions(-)
 delete mode 100644 testcases/network/dctcp/Makefile
 delete mode 100755 testcases/network/dctcp/dctcp01.sh
 create mode 100644 testcases/network/tcp_cc/Makefile
 create mode 100755 testcases/network/tcp_cc/dctcp01.sh

diff --git a/testcases/network/dctcp/Makefile b/testcases/network/dctcp/Makefile
deleted file mode 100644
index 82a6262..0000000
--- a/testcases/network/dctcp/Makefile
+++ /dev/null
@@ -1,22 +0,0 @@
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
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= dctcp01.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/dctcp/dctcp01.sh b/testcases/network/dctcp/dctcp01.sh
deleted file mode 100755
index 92ac97d..0000000
--- a/testcases/network/dctcp/dctcp01.sh
+++ /dev/null
@@ -1,91 +0,0 @@
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
-TCID=dctcp01
-TST_TOTAL=1
-TST_CLEANUP="cleanup"
-TST_NEEDS_TMPDIR=1
-def_alg="cubic"
-prev_alg=
-
-TST_USE_LEGACY_API=1
-. tst_net.sh
-
-set_cong_alg()
-{
-	local alg=$1
-	tst_resm TINFO "setting $alg"
-
-	tst_set_sysctl net.ipv4.tcp_congestion_control $alg safe
-}
-
-cleanup()
-{
-	if [ "$prev_cong_ctl" ]; then
-		tst_set_sysctl net.ipv4.tcp_congestion_control $prev_alg
-	fi
-	tst_rmdir
-	tc qdisc del dev $(tst_iface) root netem loss 0.03% ecn
-}
-
-setup()
-{
-	if tst_kvcmp -lt "3.18"; then
-		tst_brkm TCONF "test requires kernel 3.18 or newer"
-	fi
-
-	tst_require_root
-	tst_check_cmds sysctl tc
-
-	tst_resm TINFO "emulate congestion with packet loss 0.03% and ECN"
-	tc qdisc add dev $(tst_iface) root netem loss 0.03% ecn > /dev/null 2>&1
-	if [ $? -ne 0 ]; then
-		tst_brkm TCONF "netem doesn't support ECN"
-	fi
-
-	prev_alg="$(sysctl -n net.ipv4.tcp_congestion_control)"
-}
-
-test_run()
-{
-	tst_resm TINFO "compare '$def_alg' and 'dctcp' congestion alg. results"
-
-	set_cong_alg "$def_alg"
-
-	tst_netload -H $(tst_ipaddr rhost)
-	local res0="$(cat tst_netload.res)"
-
-	set_cong_alg "dctcp"
-
-	tst_netload -H $(tst_ipaddr rhost)
-	local res1="$(cat tst_netload.res)"
-
-	local per=$(( $res0 * 100 / $res1 - 100 ))
-
-	if [ "$per" -lt "10" ]; then
-		tst_resm TFAIL "dctcp performance $per %"
-	else
-		tst_resm TPASS "dctcp performance $per %"
-	fi
-}
-
-setup
-
-test_run
-
-tst_exit
diff --git a/testcases/network/tcp_cc/Makefile b/testcases/network/tcp_cc/Makefile
new file mode 100644
index 0000000..82a6262
--- /dev/null
+++ b/testcases/network/tcp_cc/Makefile
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
diff --git a/testcases/network/tcp_cc/dctcp01.sh b/testcases/network/tcp_cc/dctcp01.sh
new file mode 100755
index 0000000..92ac97d
--- /dev/null
+++ b/testcases/network/tcp_cc/dctcp01.sh
@@ -0,0 +1,91 @@
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
+TST_NEEDS_TMPDIR=1
+def_alg="cubic"
+prev_alg=
+
+TST_USE_LEGACY_API=1
+. tst_net.sh
+
+set_cong_alg()
+{
+	local alg=$1
+	tst_resm TINFO "setting $alg"
+
+	tst_set_sysctl net.ipv4.tcp_congestion_control $alg safe
+}
+
+cleanup()
+{
+	if [ "$prev_cong_ctl" ]; then
+		tst_set_sysctl net.ipv4.tcp_congestion_control $prev_alg
+	fi
+	tst_rmdir
+	tc qdisc del dev $(tst_iface) root netem loss 0.03% ecn
+}
+
+setup()
+{
+	if tst_kvcmp -lt "3.18"; then
+		tst_brkm TCONF "test requires kernel 3.18 or newer"
+	fi
+
+	tst_require_root
+	tst_check_cmds sysctl tc
+
+	tst_resm TINFO "emulate congestion with packet loss 0.03% and ECN"
+	tc qdisc add dev $(tst_iface) root netem loss 0.03% ecn > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_brkm TCONF "netem doesn't support ECN"
+	fi
+
+	prev_alg="$(sysctl -n net.ipv4.tcp_congestion_control)"
+}
+
+test_run()
+{
+	tst_resm TINFO "compare '$def_alg' and 'dctcp' congestion alg. results"
+
+	set_cong_alg "$def_alg"
+
+	tst_netload -H $(tst_ipaddr rhost)
+	local res0="$(cat tst_netload.res)"
+
+	set_cong_alg "dctcp"
+
+	tst_netload -H $(tst_ipaddr rhost)
+	local res1="$(cat tst_netload.res)"
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

