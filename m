From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 21 May 2018 14:48:29 +0300
Subject: [LTP] [PATCH 5/6] network/tcp_cc: add new test bbr01
In-Reply-To: <1526903310-2833-1-git-send-email-alexey.kodanev@oracle.com>
References: <1526903310-2833-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1526903310-2833-6-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Emulates congestion with packet loss. The test expects that
'bbr' congestion-control algorithm not significantly worse
than 'cubic'.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.features              |    2 ++
 testcases/network/tcp_cc/bbr01.sh |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)
 create mode 100755 testcases/network/tcp_cc/bbr01.sh

diff --git a/runtest/net.features b/runtest/net.features
index df78c04..732c053 100644
--- a/runtest/net.features
+++ b/runtest/net.features
@@ -1,6 +1,8 @@
 #
 # Stress tests for various network features
 #
+bbr01 bbr01.sh
+bbr01_ipv6 bbr01.sh -6
 
 bind_noport01 bind_noport01.sh
 bind_noport01_ipv6 bind_noport01.sh -6
diff --git a/testcases/network/tcp_cc/bbr01.sh b/testcases/network/tcp_cc/bbr01.sh
new file mode 100755
index 0000000..3825c22
--- /dev/null
+++ b/testcases/network/tcp_cc/bbr01.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Oracle and/or its affiliates. All Rights Reserved.
+
+TST_SETUP="setup"
+TST_TESTFUNC="do_test"
+TST_CLEANUP="cleanup"
+TST_MIN_KVER="4.13"
+
+. tcp_cc_lib.sh
+
+cleanup()
+{
+	tc qdisc del dev $(tst_iface) root netem
+
+	tcp_cc_cleanup
+}
+
+setup()
+{
+	tcp_cc_setup
+
+	tst_res TINFO "emulate congestion with packet loss 0.5%"
+	ROD tc qdisc add dev $(tst_iface) root netem loss 0.5%
+}
+
+do_test()
+{
+	tcp_cc_test01 bbr -50
+}
+
+tst_run
-- 
1.7.1

