From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 29 Jan 2018 14:41:16 +0300
Subject: [LTP] [PATCH 9/9] network: new test-case for IP_BIND_ADDRESS_NO_PORT
In-Reply-To: <1517226076-26436-1-git-send-email-alexey.kodanev@oracle.com>
References: <1517226076-26436-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1517226076-26436-10-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.features                       |    3 ++
 testcases/network/sockets/Makefile         |    2 +-
 testcases/network/sockets/bind_noport01.sh |   50 ++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletions(-)
 create mode 100755 testcases/network/sockets/bind_noport01.sh

diff --git a/runtest/net.features b/runtest/net.features
index 46c58f0..df78c04 100644
--- a/runtest/net.features
+++ b/runtest/net.features
@@ -2,6 +2,9 @@
 # Stress tests for various network features
 #
 
+bind_noport01 bind_noport01.sh
+bind_noport01_ipv6 bind_noport01.sh -6
+
 busy_poll01 busy_poll01.sh
 busy_poll01_ipv6 busy_poll01.sh -6
 
diff --git a/testcases/network/sockets/Makefile b/testcases/network/sockets/Makefile
index 057b353..a7c263a 100644
--- a/testcases/network/sockets/Makefile
+++ b/testcases/network/sockets/Makefile
@@ -24,7 +24,7 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS		:= ltpSockets.sh
+INSTALL_TARGETS		:= *.sh
 
 LDLIBS			+= -lpthread
 
diff --git a/testcases/network/sockets/bind_noport01.sh b/testcases/network/sockets/bind_noport01.sh
new file mode 100755
index 0000000..951712d
--- /dev/null
+++ b/testcases/network/sockets/bind_noport01.sh
@@ -0,0 +1,50 @@
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
+
+TST_TOTAL=1
+TCID="bind_noport"
+TST_NEEDS_TMPDIR=1
+
+. test_net.sh
+
+cleanup()
+{
+	tst_rmdir
+}
+
+if tst_kvcmp -lt "4.2"; then
+	tst_brkm TCONF "test must be run with kernel 4.2+"
+fi
+
+trap "tst_brkm TBROK 'test interrupted'" INT
+TST_CLEANUP="cleanup"
+
+do_test()
+{
+	local types="tcp udp udp_lite dccp"
+	TST_NETLOAD_CLN_NUMBER=10
+	TST_NETLOAD_CLN_REQUESTS=1000
+
+	tst_resm TINFO "test IP_BIND_ADDRESS_NO_PORT with $types sockets"
+
+	for t in $types; do
+		tst_netload -T $t -S $(tst_ipaddr) -H $(tst_ipaddr rhost)
+	done
+}
+
+do_test
+
+tst_exit
-- 
1.7.1

