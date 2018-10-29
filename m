From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 29 Oct 2018 16:03:18 +0300
Subject: [LTP] [PATCH 2/6] network/sit01: new test for sit tunnel
In-Reply-To: <1540818202-11247-1-git-send-email-alexey.kodanev@oracle.com>
References: <1540818202-11247-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1540818202-11247-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.features            |    2 ++
 testcases/network/virt/sit01.sh |   23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)
 create mode 100755 testcases/network/virt/sit01.sh

diff --git a/runtest/net.features b/runtest/net.features
index eac1b2b..de49e76 100644
--- a/runtest/net.features
+++ b/runtest/net.features
@@ -58,3 +58,5 @@ dctcp_ipv6_01 dctcp01.sh -6
 
 geneve01 geneve01.sh
 geneve01_ipv6 geneve01.sh -6
+
+sit01 sit01.sh
diff --git a/testcases/network/virt/sit01.sh b/testcases/network/virt/sit01.sh
new file mode 100755
index 0000000..4ecc1f8
--- /dev/null
+++ b/testcases/network/virt/sit01.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Oracle and/or its affiliates.
+
+TST_NEEDS_TMPDIR=1
+TST_TESTFUNC=virt_netperf_msg_sizes
+TST_SETUP=do_setup
+TST_CLEANUP=virt_cleanup
+virt_type="sit"
+. virt_lib.sh
+
+do_setup()
+{
+	[ -n "$TST_IPV6" ] && tst_res TBROK "invalid option '-6' for sit tunnel"
+
+	virt_lib_setup
+
+	tst_res TINFO "test $virt_type"
+	virt_setup "local $(tst_ipaddr) remote $(tst_ipaddr rhost)" \
+		   "local $(tst_ipaddr rhost) remote $(tst_ipaddr)"
+}
+
+tst_run
-- 
1.7.1

