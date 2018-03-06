From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  6 Mar 2018 14:57:32 +0300
Subject: [LTP] [PATCH] network: new regression test for over-sized chunks in
	SCTP
Message-ID: <1520337452-10137-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixed by upstream commit 07f2c7ab6f8d ("sctp: verify size of a
new chunk in _sctp_make_chunk()")

CVE-2018-5803

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.features             |    1 +
 testcases/network/sctp/Makefile  |    2 +-
 testcases/network/sctp/sctp02.sh |   66 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 1 deletions(-)
 create mode 100755 testcases/network/sctp/sctp02.sh

diff --git a/runtest/net.features b/runtest/net.features
index b9250dc..81e9a43 100644
--- a/runtest/net.features
+++ b/runtest/net.features
@@ -19,6 +19,7 @@ dccp01_ipv6 dccp01.sh -6
 
 sctp01 sctp01.sh
 sctp01_ipv6 sctp01.sh -6
+sctp02 sctp02.sh -6
 
 tcp_fastopen tcp_fastopen_run.sh
 tcp_fastopen6 tcp_fastopen_run.sh -6
diff --git a/testcases/network/sctp/Makefile b/testcases/network/sctp/Makefile
index 914e389..5f014d8 100644
--- a/testcases/network/sctp/Makefile
+++ b/testcases/network/sctp/Makefile
@@ -17,6 +17,6 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS		:= sctp01.sh
+INSTALL_TARGETS		:= *.sh
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/sctp/sctp02.sh b/testcases/network/sctp/sctp02.sh
new file mode 100755
index 0000000..f8386dd
--- /dev/null
+++ b/testcases/network/sctp/sctp02.sh
@@ -0,0 +1,66 @@
+#!/bin/sh
+# Copyright (c) 2018 Oracle and/or its affiliates.
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
+# Regression test for the crash caused by over-sized SCTP chunk, fixed by
+# commit 07f2c7ab6f8d ("sctp: verify size of a new chunk in _sctp_make_chunk()")
+#
+# CVE-2018-5803
+
+TCID=sctp02
+TST_TOTAL=1
+TST_CLEANUP="cleanup"
+TST_NEEDS_TMPDIR=1
+
+. test_net.sh
+
+cleanup()
+{
+	for i in $(seq 1 16); do
+		tst_rhost_run -s -c "ip a del $(tst_ipaddr_un -c $i rhost) \
+				     dev $(tst_iface rhost)"
+	done
+	for i in $(seq 17 3260); do
+		ROD ip a del $(tst_ipaddr_un -c $i lhost) dev $(tst_iface)
+	done
+}
+
+setup()
+{
+	tst_require_root
+
+	tst_resm TINFO "adding several addresses to remote host"
+	for i in $(seq 1 16); do
+		tst_rhost_run -s -c "ip a add $(tst_ipaddr_un -c $i rhost) \
+				     dev $(tst_iface rhost) nodad"
+	done
+
+	tst_resm TINFO "adding addresses to local host to make big INIT packet"
+	for i in $(seq 17 3260); do
+		ROD ip a add $(tst_ipaddr_un -c $i lhost) dev $(tst_iface) nodad
+	done
+}
+
+test_run()
+{
+	tst_resm TINFO "sending almost over-sized INIT packet to remote host"
+	tst_netload -H $(tst_ipaddr rhost) -T sctp
+	tst_resm TPASS "test doesn't cause the crash"
+}
+
+setup
+test_run
+
+tst_exit
-- 
1.7.1

