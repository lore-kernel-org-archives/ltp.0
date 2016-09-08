From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  8 Sep 2016 10:34:18 +0300
Subject: [LTP] [PATCH 3/3] network/ping02: add new flood ping test
In-Reply-To: <1473320058-13205-1-git-send-email-alexey.kodanev@oracle.com>
References: <1473320058-13205-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1473320058-13205-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* test sends packets without delay;
* packets filled out with a predefined pattern.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.ipv6                          |    1 +
 runtest/net.tcp_cmds                      |    1 +
 testcases/network/tcp_cmds/ping/Makefile  |    3 +-
 testcases/network/tcp_cmds/ping/ping02.sh |   50 +++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 1 deletions(-)
 create mode 100755 testcases/network/tcp_cmds/ping/ping02.sh

diff --git a/runtest/net.ipv6 b/runtest/net.ipv6
index 76d8658..0e63467 100644
--- a/runtest/net.ipv6
+++ b/runtest/net.ipv6
@@ -1,5 +1,6 @@
 #DESCRIPTION:IPV6 related tests
 ping601 ping01.sh -6
+ping602 ping02.sh -6
 sendfile601 sendfile01 -6
 tcpdump601 tcpdump01 -6
 tracepath601 tracepath01.sh -6
diff --git a/runtest/net.tcp_cmds b/runtest/net.tcp_cmds
index 24cdbb5..66262f8 100644
--- a/runtest/net.tcp_cmds
+++ b/runtest/net.tcp_cmds
@@ -11,6 +11,7 @@ ftp export TCbin=$LTPROOT/testcases/network/tcp_cmds/ftp; ftp01
 host host01
 netstat netstat01
 ping01 ping01.sh
+ping02 ping02.sh
 rcp export TCbin=$LTPROOT/testcases/network/tcp_cmds/rcp; rcp01
 rdist export TCbin=$LTPROOT/testcases/network/tcp_cmds/rdist; rdist01
 rlogin rlogin01
diff --git a/testcases/network/tcp_cmds/ping/Makefile b/testcases/network/tcp_cmds/ping/Makefile
index 6e26ac9..29429e7 100644
--- a/testcases/network/tcp_cmds/ping/Makefile
+++ b/testcases/network/tcp_cmds/ping/Makefile
@@ -24,7 +24,8 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS		:= ping01.sh
+INSTALL_TARGETS		:= ping01.sh \
+			   ping02.sh
 
 MAKE_TARGETS		:=
 
diff --git a/testcases/network/tcp_cmds/ping/ping02.sh b/testcases/network/tcp_cmds/ping/ping02.sh
new file mode 100755
index 0000000..2cfdff8
--- /dev/null
+++ b/testcases/network/tcp_cmds/ping/ping02.sh
@@ -0,0 +1,50 @@
+#! /bin/sh
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
+
+TST_TOTAL=1
+TCID="ping02"
+
+. test_net.sh
+
+do_setup()
+{
+	COUNT=${COUNT:-3}
+	PACKETSIZES=${PACKETSIZES:-"8 16 32 64 128 256 512 1024 2048 4064"}
+
+	PING=ping${TST_IPV6}
+
+	tst_check_cmds $PING
+}
+
+do_test()
+{
+	local pat="000102030405060708090a0b0c0d0e0f"
+
+	tst_resm TINFO "flood $PING: ICMP packets filled with pattern '$pat'"
+
+	local ipaddr=$(tst_ipaddr rhost)
+	for psize in $PACKETSIZES; do
+		tst_resm TINFO "call $PING with packet size = $psize"
+		ROD_SILENT $PING -c $COUNT -f -s $psize $ipaddr -p "$pat"
+	done
+
+	tst_resm TPASS "flood $PING test completed"
+}
+
+do_setup
+do_test
+
+tst_exit
-- 
1.7.1

