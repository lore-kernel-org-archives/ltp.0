From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 29 Oct 2018 16:03:19 +0300
Subject: [LTP] [PATCH 3/6] network/mpls01: new test for mpls labels
In-Reply-To: <1540818202-11247-1-git-send-email-alexey.kodanev@oracle.com>
References: <1540818202-11247-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1540818202-11247-4-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Checks basic functionality (adds/deletes routes), related sysctl parameters.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.features             |    2 +
 testcases/network/mpls/Makefile  |   10 +++++
 testcases/network/mpls/mpls01.sh |   70 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 0 deletions(-)
 create mode 100644 testcases/network/mpls/Makefile
 create mode 100755 testcases/network/mpls/mpls01.sh

diff --git a/runtest/net.features b/runtest/net.features
index de49e76..f858421 100644
--- a/runtest/net.features
+++ b/runtest/net.features
@@ -60,3 +60,5 @@ geneve01 geneve01.sh
 geneve01_ipv6 geneve01.sh -6
 
 sit01 sit01.sh
+
+mpls01 mpls01.sh
diff --git a/testcases/network/mpls/Makefile b/testcases/network/mpls/Makefile
new file mode 100644
index 0000000..3a54269
--- /dev/null
+++ b/testcases/network/mpls/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Oracle and/or its affiliates. All Rights Reserved.
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+INSTALL_TARGETS		:= *.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/mpls/mpls01.sh b/testcases/network/mpls/mpls01.sh
new file mode 100755
index 0000000..c7788b5
--- /dev/null
+++ b/testcases/network/mpls/mpls01.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Oracle and/or its affiliates. All Rights Reserved.
+
+TST_SETUP="setup"
+TST_TESTFUNC="test"
+TST_CLEANUP="cleanup"
+TST_CNT=3
+TST_MIN_KVER="4.1"
+TST_NEEDS_TMPDIR=1
+TST_NEEDS_ROOT=1
+TST_NEEDS_DRIVERS="mpls_router"
+TST_NEEDS_CMDS="sysctl modprobe"
+
+. tst_net.sh
+
+cleanup()
+{
+	ip -f mpls route flush dev lo > /dev/null 2>&1
+	ip -f mpls route flush dev $(tst_iface) > /dev/null 2>&1
+}
+
+setup()
+{
+	ROD modprobe mpls_router
+}
+
+test1()
+{
+	ROD sysctl -q net.mpls.platform_labels=0xfffff
+	ROD ip -f mpls route add 0xffffe dev lo
+	ROD ip -f mpls route show \> /dev/null
+	ROD ip -f mpls route del 0xffffe dev lo
+	tst_res TPASS "added label 0xffffe to lo dev"
+}
+
+test2()
+{
+	ROD sysctl -q net.mpls.platform_labels=0xffffe
+	ip -f mpls route add 0xffffe dev lo > /dev/null 2>&1
+	if [ $? -eq 0 ]; then
+		tst_res TFAIL "can add label that is >= platform_labels"
+		return
+	fi
+
+	tst_res TPASS "can't add label >= platform_lables"
+}
+
+test3()
+{
+	local start=16
+	local end=$((start + NS_TIMES))
+
+	ROD sysctl -q net.mpls.platform_labels=$((end + 1))
+	tst_res TINFO "creating mpls routes with labels from $start..$end"
+	for l in $(seq $start $end); do
+		ROD ip -f mpls route add $l dev $(tst_iface)
+	done
+
+	tst_res TINFO "listing created routes"
+	ROD ip -f mpls route show \> /dev/null
+
+	tst_res TINFO "removing the routes"
+	for l in $(seq $start $end); do
+		ROD ip -f mpls route del $l dev $(tst_iface)
+	done
+	tst_res TPASS "created and removed mpls routes"
+}
+
+tst_run
-- 
1.7.1

