From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  8 Sep 2016 10:34:16 +0300
Subject: [LTP] [PATCH 1/3] network/ping01: rename file and update runtest
	files
Message-ID: <1473320058-13205-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.ipv6                          |    2 +-
 runtest/net.tcp_cmds                      |    2 +-
 testcases/network/tcp_cmds/ping/Makefile  |    2 +-
 testcases/network/tcp_cmds/ping/ping01    |   61 -----------------------------
 testcases/network/tcp_cmds/ping/ping01.sh |   61 +++++++++++++++++++++++++++++
 5 files changed, 64 insertions(+), 64 deletions(-)
 delete mode 100755 testcases/network/tcp_cmds/ping/ping01
 create mode 100755 testcases/network/tcp_cmds/ping/ping01.sh

diff --git a/runtest/net.ipv6 b/runtest/net.ipv6
index 5f42e01..76d8658 100644
--- a/runtest/net.ipv6
+++ b/runtest/net.ipv6
@@ -1,5 +1,5 @@
 #DESCRIPTION:IPV6 related tests
-ping601 ping01 -6
+ping601 ping01.sh -6
 sendfile601 sendfile01 -6
 tcpdump601 tcpdump01 -6
 tracepath601 tracepath01.sh -6
diff --git a/runtest/net.tcp_cmds b/runtest/net.tcp_cmds
index 9801fef..24cdbb5 100644
--- a/runtest/net.tcp_cmds
+++ b/runtest/net.tcp_cmds
@@ -10,7 +10,7 @@ finger finger01
 ftp export TCbin=$LTPROOT/testcases/network/tcp_cmds/ftp; ftp01
 host host01
 netstat netstat01
-ping export LTPROOT; ping01
+ping01 ping01.sh
 rcp export TCbin=$LTPROOT/testcases/network/tcp_cmds/rcp; rcp01
 rdist export TCbin=$LTPROOT/testcases/network/tcp_cmds/rdist; rdist01
 rlogin rlogin01
diff --git a/testcases/network/tcp_cmds/ping/Makefile b/testcases/network/tcp_cmds/ping/Makefile
index 3bfc37a..6e26ac9 100644
--- a/testcases/network/tcp_cmds/ping/Makefile
+++ b/testcases/network/tcp_cmds/ping/Makefile
@@ -24,7 +24,7 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS		:= ping01
+INSTALL_TARGETS		:= ping01.sh
 
 MAKE_TARGETS		:=
 
diff --git a/testcases/network/tcp_cmds/ping/ping01 b/testcases/network/tcp_cmds/ping/ping01
deleted file mode 100755
index e188c3a..0000000
--- a/testcases/network/tcp_cmds/ping/ping01
+++ /dev/null
@@ -1,61 +0,0 @@
-#! /bin/sh
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) International Business Machines  Corp., 2000
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
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-#  PURPOSE: To test the basic functionality of the `ping` command.
-#
-#  SETUP: If "RHOST" is not exported, then the local hostname is used.
-#
-#  HISTORY:
-#    06/06/03 Manoj Iyer manjo@mail.utexas.edu
-#    - Modified testcase to use test APIs and also fixed minor bugs
-#    03/01 Robbie Williamson (robbiew@us.ibm.com)
-#      -Ported
-
-TST_TOTAL=1
-TCID="ping01"
-
-. test_net.sh
-
-do_setup()
-{
-	COUNT=${COUNT:-3}
-	PACKETSIZES=${PACKETSIZES:-"8 16 32 64 128 256 512 1024 2048 4064"}
-
-	PING_CMD=ping${TST_IPV6}
-
-	tst_check_cmds $PING_CMD
-}
-
-do_test()
-{
-	tst_resm TINFO "$PING_CMD with $PACKETSIZES ICMP packets"
-	local ipaddr=$(tst_ipaddr rhost)
-	for packetsize in $PACKETSIZES; do
-		tst_resm TINFO "call $PING_CMD with packet size = $packetsize"
-		$PING_CMD -c $COUNT -s $packetsize $ipaddr > /dev/null 2>&1
-		if [ $? -ne 0 ]; then
-			tst_resm TFAIL "$PING_CMD -c $COUNT -s $packetsize $ipaddr"
-			return
-		fi
-	done
-}
-
-do_setup
-do_test
-
-tst_exit
diff --git a/testcases/network/tcp_cmds/ping/ping01.sh b/testcases/network/tcp_cmds/ping/ping01.sh
new file mode 100755
index 0000000..e188c3a
--- /dev/null
+++ b/testcases/network/tcp_cmds/ping/ping01.sh
@@ -0,0 +1,61 @@
+#! /bin/sh
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2000
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
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+#  PURPOSE: To test the basic functionality of the `ping` command.
+#
+#  SETUP: If "RHOST" is not exported, then the local hostname is used.
+#
+#  HISTORY:
+#    06/06/03 Manoj Iyer manjo@mail.utexas.edu
+#    - Modified testcase to use test APIs and also fixed minor bugs
+#    03/01 Robbie Williamson (robbiew@us.ibm.com)
+#      -Ported
+
+TST_TOTAL=1
+TCID="ping01"
+
+. test_net.sh
+
+do_setup()
+{
+	COUNT=${COUNT:-3}
+	PACKETSIZES=${PACKETSIZES:-"8 16 32 64 128 256 512 1024 2048 4064"}
+
+	PING_CMD=ping${TST_IPV6}
+
+	tst_check_cmds $PING_CMD
+}
+
+do_test()
+{
+	tst_resm TINFO "$PING_CMD with $PACKETSIZES ICMP packets"
+	local ipaddr=$(tst_ipaddr rhost)
+	for packetsize in $PACKETSIZES; do
+		tst_resm TINFO "call $PING_CMD with packet size = $packetsize"
+		$PING_CMD -c $COUNT -s $packetsize $ipaddr > /dev/null 2>&1
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "$PING_CMD -c $COUNT -s $packetsize $ipaddr"
+			return
+		fi
+	done
+}
+
+do_setup
+do_test
+
+tst_exit
-- 
1.7.1

