From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Wed, 7 Jul 2021 17:22:26 +0800
Subject: [LTP] [PATCH] network/tc01.sh: Add a regression test for tc qdisc
 command
Message-ID: <1625649746-11987-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/net.tcp_cmds                   |  1 +
 testcases/network/tcp_cmds/tc/Makefile | 13 +++++++
 testcases/network/tcp_cmds/tc/tc01.sh  | 51 ++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 testcases/network/tcp_cmds/tc/Makefile
 create mode 100755 testcases/network/tcp_cmds/tc/tc01.sh

diff --git a/runtest/net.tcp_cmds b/runtest/net.tcp_cmds
index db47dfd5b..7e142de11 100644
--- a/runtest/net.tcp_cmds
+++ b/runtest/net.tcp_cmds
@@ -12,6 +12,7 @@ netstat netstat01.sh
 ping01 ping01.sh
 ping02 ping02.sh
 sendfile sendfile01.sh
+tc01 tc01.sh
 tcpdump tcpdump01.sh
 telnet telnet01.sh
 iptables iptables01.sh
diff --git a/testcases/network/tcp_cmds/tc/Makefile b/testcases/network/tcp_cmds/tc/Makefile
new file mode 100644
index 000000000..60150a1ce
--- /dev/null
+++ b/testcases/network/tcp_cmds/tc/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
+# Ngie Cooper, July 2009
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= tc01.sh
+
+MAKE_TARGETS		:=
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/tcp_cmds/tc/tc01.sh b/testcases/network/tcp_cmds/tc/tc01.sh
new file mode 100755
index 000000000..0a241843b
--- /dev/null
+++ b/testcases/network/tcp_cmds/tc/tc01.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+# Author: Yang Xu<xuyang2018.jy@fujitsu.com>
+#
+# When using "tc qdisc add dev teql0 root teql0 command", qdisc_create()
+# calls teql_qdisc_init() it imediately fails after check "if (m->dev == dev)"
+# because both devices are teql0, and it does not set qdisc_priv(sch)->m
+# leaving it zero on error path, then qdisc_create() imediately calls
+# teql_destroy() which does not expect zero master pointer and we get OOPS
+# on unpatched kernel.
+#
+# If we enable panic_on_oops, this case may crash.
+#
+# This kernel bug was introduced by
+# commit 87b60cfacf9f ("net_sched: fix error recovery at qdisc creation")
+# and has been fixed by
+# commit 1ffbc7ea9160 ("net: sched: sch_teql: fix null-pointer dereference")
+#
+
+TST_TESTFUNC="do_test"
+TST_NEEDS_ROOT=1
+TST_NEEDS_DRIVERS="sch_teql"
+TST_NEEDS_CMDS="tc modprobe"
+sys_file="/proc/sys/kernel/panic_on_oops"
+. tst_test.sh
+
+do_test()
+{
+	[ ! -f "$sys_file" ] && tst_brk TCONF "$sys_file not enabled"
+	orig_value=$(cat "$sys_file")
+	if [ $orig_value = "0" ]; then
+		echo 1 > $sys_file
+	fi
+
+	tst_res TINFO "Use tc qdisc command to trigger a null-pointer dereference"
+	modprobe $TST_NEEDS_DRIVERS
+
+	tc qdisc add dev teql0 root teql0 2>/dev/null
+	if [ $? -eq 0 ]; then
+		tst_res TFAIL "tc qdisc command succeeded unexpectedly"
+	else
+		tst_res TPASS "the bug was not reproduced"
+	fi
+
+	if [ $orig_value = "0" ]; then
+		 echo 0 > $sys_file
+	fi
+}
+
+tst_run
-- 
2.23.0

