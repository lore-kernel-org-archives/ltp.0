From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 23 Mar 2017 19:12:36 +0300
Subject: [LTP] [PATCH v2 4/5] sctp: new performance test for SCTP protocol
In-Reply-To: <1490285557-18122-1-git-send-email-alexey.kodanev@oracle.com>
References: <1490285557-18122-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1490285557-18122-4-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Compares TCP with SCTP. Server closes connection after three
conseqent requests.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---

v2: new test in v2

 runtest/net.features             |    3 ++
 testcases/network/sctp/Makefile  |   22 ++++++++++++++
 testcases/network/sctp/sctp01.sh |   58 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 0 deletions(-)
 create mode 100644 testcases/network/sctp/Makefile
 create mode 100755 testcases/network/sctp/sctp01.sh

diff --git a/runtest/net.features b/runtest/net.features
index f7f4b87..7f2c889 100644
--- a/runtest/net.features
+++ b/runtest/net.features
@@ -14,6 +14,9 @@ busy_poll03_ipv6 busy_poll03.sh -6
 dccp01 dccp01.sh
 dccp01_ipv6 dccp01.sh -6
 
+sctp01 sctp01.sh
+sctp01_ipv6 sctp01.sh -6
+
 tcp_fastopen tcp_fastopen_run.sh
 tcp_fastopen6 tcp_fastopen_run.sh -6
 
diff --git a/testcases/network/sctp/Makefile b/testcases/network/sctp/Makefile
new file mode 100644
index 0000000..914e389
--- /dev/null
+++ b/testcases/network/sctp/Makefile
@@ -0,0 +1,22 @@
+# Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
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
+INSTALL_TARGETS		:= sctp01.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/sctp/sctp01.sh b/testcases/network/sctp/sctp01.sh
new file mode 100755
index 0000000..1d9bcb8
--- /dev/null
+++ b/testcases/network/sctp/sctp01.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+# Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
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
+TCID=sctp01
+TST_TOTAL=3
+TST_CLEANUP="cleanup"
+
+. test_net.sh
+
+cleanup()
+{
+	tst_rmdir
+}
+
+setup()
+{
+	tst_require_root
+	tst_tmpdir
+}
+
+test_run()
+{
+	tst_resm TINFO "compare TCP/SCTP performance"
+
+	tst_netload -H $(tst_ipaddr rhost) -a 3 -R 3 -T tcp
+	local res0="$(cat tst_netload.res)"
+
+	tst_netload -H $(tst_ipaddr rhost) -a 3 -R 3 -T sctp
+	local res1="$(cat tst_netload.res)"
+
+	local per=$(( $res0 * 100 / $res1 - 100 ))
+
+	if [ "$per" -gt "100" -o "$per" -lt "-100" ]; then
+		tst_resm TFAIL "sctp performance $per %"
+	else
+		tst_resm TPASS "sctp performance $per % in range -100 ... 100 %"
+	fi
+}
+
+setup
+test_run
+
+tst_exit
-- 
1.7.1

