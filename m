From: Elif Aslan <elas@linux.vnet.ibm.com>
Date: Thu,  7 Mar 2019 14:42:28 +0100
Subject: [LTP] [PATCH] added vmcp testcase
Message-ID: <20190307134228.2861-1-elas@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

---
 runtest/s390x_tests               |  2 ++
 testcases/commands/vmcp/vmcp_m.sh | 51 +++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 runtest/s390x_tests
 create mode 100644 testcases/commands/vmcp/vmcp_m.sh

diff --git a/runtest/s390x_tests b/runtest/s390x_tests
new file mode 100644
index 000000000..0c2bf05a5
--- /dev/null
+++ b/runtest/s390x_tests
@@ -0,0 +1,2 @@
+# Those tests are designed to be executed in s390x environment (zVM or LPAR)
+vmcp vmcp_m.sh
diff --git a/testcases/commands/vmcp/vmcp_m.sh b/testcases/commands/vmcp/vmcp_m.sh
new file mode 100644
index 000000000..6702094e8
--- /dev/null
+++ b/testcases/commands/vmcp/vmcp_m.sh
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# vmcp tool and module test
+#
+# The tool allows Linux users to send commands to the z/VM control program (CP).
+# The normal usage is to invoke vmcp with the command you want to execute.
+#
+# The test case contains one shell script:
+#
+#    vmcp_m.sh: basically executes the vmcp tool with different parameters and verifies that
+#               output and exitcodes are as expected
+#
+
+#!/bin/sh
+
+TST_CNT=2
+TST_TESTFUNC=vmcp_main
+TST_NEEDS_CMDS="vmcp"
+. tst_test.sh
+
+vmcp_run()
+{
+
+        $2
+        if [ $? -eq $1 ]; then
+            tst_res TPASS "'$2' returned '$1'"
+        else
+            tst_res TFAIL "'$2' did not return '$1'"
+        fi
+}
+
+vmcp_main1()
+{
+        tst_res TINFO "Verify basic VMCP commands"
+        vmcp_run 0 "vmcp --version";
+        vmcp_run 0 "vmcp --help";
+        vmcp_run 0 "vmcp -v";
+        vmcp_run 0 "vmcp -h";
+        vmcp_run 0 "vmcp q dasd";
+}
+
+vmcp_main2()
+{
+        tst_res TINFO "Verify error conditions"
+        vmcp_run 4 "vmcp -L"
+        vmcp_run 4 "vmcp -m q dasd"
+        vmcp_run 1 "vmcp dasddasddasd"
+}
+
+
+tst_run
-- 
2.17.2 (Apple Git-113)

