From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 29 Oct 2018 16:03:22 +0300
Subject: [LTP] [PATCH 6/6] network/mpls04: new test with mpls over sit tunnel
In-Reply-To: <1540818202-11247-1-git-send-email-alexey.kodanev@oracle.com>
References: <1540818202-11247-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1540818202-11247-7-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The same as in mpls03 but with sit tunnel.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.features             |    1 +
 testcases/network/mpls/mpls04.sh |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100755 testcases/network/mpls/mpls04.sh

diff --git a/runtest/net.features b/runtest/net.features
index 6076e2a..b37104b 100644
--- a/runtest/net.features
+++ b/runtest/net.features
@@ -66,4 +66,5 @@ mpls02 mpls02.sh
 mpls02_ipv6 mpls02.sh -6
 mpls03 mpls03.sh
 mpls03_ipv6 mpls03.sh -6
+mpls04 mpls04.sh
 
diff --git a/testcases/network/mpls/mpls04.sh b/testcases/network/mpls/mpls04.sh
new file mode 100755
index 0000000..639a13e
--- /dev/null
+++ b/testcases/network/mpls/mpls04.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Oracle and/or its affiliates. All Rights Reserved.
+
+TST_SETUP="setup"
+TST_TESTFUNC="mpls_virt_test"
+TST_CLEANUP="mpls_virt_cleanup"
+
+. virt_lib.sh
+. mpls_lib.sh
+
+setup()
+{
+	virt_type="sit"
+
+	mpls_virt_setup
+}
+
+tst_run
-- 
1.7.1

