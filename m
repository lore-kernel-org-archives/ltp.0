From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 21 May 2018 14:48:26 +0300
Subject: [LTP] [PATCH 2/6] dctcp01: convert to new API and move common code
	to a library
In-Reply-To: <1526903310-2833-1-git-send-email-alexey.kodanev@oracle.com>
References: <1526903310-2833-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1526903310-2833-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/tcp_cc/Makefile      |    2 +-
 testcases/network/tcp_cc/dctcp01.sh    |   80 +++++--------------------------
 testcases/network/tcp_cc/tcp_cc_lib.sh |   57 ++++++++++++++++++++++
 3 files changed, 71 insertions(+), 68 deletions(-)
 create mode 100755 testcases/network/tcp_cc/tcp_cc_lib.sh

diff --git a/testcases/network/tcp_cc/Makefile b/testcases/network/tcp_cc/Makefile
index 82a6262..a564eb4 100644
--- a/testcases/network/tcp_cc/Makefile
+++ b/testcases/network/tcp_cc/Makefile
@@ -17,6 +17,6 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS		:= dctcp01.sh
+INSTALL_TARGETS		:= *.sh
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/tcp_cc/dctcp01.sh b/testcases/network/tcp_cc/dctcp01.sh
index 92ac97d..02b27cf 100755
--- a/testcases/network/tcp_cc/dctcp01.sh
+++ b/testcases/network/tcp_cc/dctcp01.sh
@@ -1,91 +1,37 @@
 #!/bin/sh
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
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2015-2018 Oracle and/or its affiliates. All Rights Reserved.
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
-TCID=dctcp01
-TST_TOTAL=1
+TST_SETUP="setup"
+TST_TESTFUNC="do_test"
 TST_CLEANUP="cleanup"
-TST_NEEDS_TMPDIR=1
-def_alg="cubic"
-prev_alg=
+TST_MIN_KVER="3.18"
 
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
+. tcp_cc_lib.sh
 
 cleanup()
 {
-	if [ "$prev_cong_ctl" ]; then
-		tst_set_sysctl net.ipv4.tcp_congestion_control $prev_alg
-	fi
-	tst_rmdir
 	tc qdisc del dev $(tst_iface) root netem loss 0.03% ecn
+
+	tcp_cc_cleanup
 }
 
 setup()
 {
-	if tst_kvcmp -lt "3.18"; then
-		tst_brkm TCONF "test requires kernel 3.18 or newer"
-	fi
-
-	tst_require_root
-	tst_check_cmds sysctl tc
+	tcp_cc_setup
 
-	tst_resm TINFO "emulate congestion with packet loss 0.03% and ECN"
+	tst_res TINFO "emulate congestion with packet loss 0.03% and ECN"
 	tc qdisc add dev $(tst_iface) root netem loss 0.03% ecn > /dev/null 2>&1
 	if [ $? -ne 0 ]; then
 		tst_brkm TCONF "netem doesn't support ECN"
 	fi
-
-	prev_alg="$(sysctl -n net.ipv4.tcp_congestion_control)"
 }
 
-test_run()
+do_test()
 {
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
+	tcp_cc_test01 dctcp 10
 }
 
-setup
-
-test_run
-
-tst_exit
+tst_run
diff --git a/testcases/network/tcp_cc/tcp_cc_lib.sh b/testcases/network/tcp_cc/tcp_cc_lib.sh
new file mode 100755
index 0000000..b96c8af
--- /dev/null
+++ b/testcases/network/tcp_cc/tcp_cc_lib.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Oracle and/or its affiliates. All Rights Reserved.
+
+TST_NEEDS_TMPDIR=1
+TST_NEEDS_ROOT=1
+TST_NEEDS_CMDS="sysctl tc"
+
+. tst_net.sh
+
+def_alg="cubic"
+prev_alg=
+
+set_cong_alg()
+{
+	local alg=$1
+	tst_res TINFO "setting $alg"
+
+	tst_set_sysctl net.ipv4.tcp_congestion_control $alg safe
+}
+
+tcp_cc_cleanup()
+{
+	[ "$prev_cong_ctl" ] && \
+		tst_set_sysctl net.ipv4.tcp_congestion_control $prev_alg
+}
+
+tcp_cc_setup()
+{
+	prev_alg="$(sysctl -n net.ipv4.tcp_congestion_control)"
+}
+
+tcp_cc_test01()
+{
+	local alg=$1
+	local threshold=${2:-10}
+
+	tst_res TINFO "compare '$def_alg' and '$alg' congestion alg. results"
+
+	set_cong_alg "$def_alg"
+
+	tst_netload -H $(tst_ipaddr rhost) -A 15000
+	local res0="$(cat tst_netload.res)"
+
+	set_cong_alg "$alg"
+
+	tst_netload -H $(tst_ipaddr rhost) -A 15000
+	local res1="$(cat tst_netload.res)"
+
+	local per=$(( $res0 * 100 / $res1 - 100 ))
+
+	if [ "$per" -lt "$threshold" ]; then
+		tst_res TFAIL "$alg performance $per %"
+	else
+		tst_res TPASS "$alg performance $per %"
+	fi
+}
-- 
1.7.1

