From: Elif Aslan <elas@linux.vnet.ibm.com>
Date: Mon,  4 Feb 2019 17:13:28 +0100
Subject: [LTP] [PATCH] adding s390x tests to ltp
Message-ID: <20190204161328.4616-1-elas@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

---
 runtest/s390x_tools                           |  2 +
 testcases/commands/s390x_tools/vmcp/vmcp_m.sh | 58 +++++++++++++++++++
 2 files changed, 60 insertions(+)
 create mode 100644 runtest/s390x_tools
 create mode 100644 testcases/commands/s390x_tools/vmcp/vmcp_m.sh

diff --git a/runtest/s390x_tools b/runtest/s390x_tools
new file mode 100644
index 000000000..c88f0cac4
--- /dev/null
+++ b/runtest/s390x_tools
@@ -0,0 +1,2 @@
+#DESCRIPTION:s390x_tools tests
+vmcp vmcp_m.sh
diff --git a/testcases/commands/s390x_tools/vmcp/vmcp_m.sh b/testcases/commands/s390x_tools/vmcp/vmcp_m.sh
new file mode 100644
index 000000000..d1f7752de
--- /dev/null
+++ b/testcases/commands/s390x_tools/vmcp/vmcp_m.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+#
+# Copyright (C) 2018 IBM Corp.
+# 
+# Copying and distribution of this file, with or without modification,
+# are permitted in any medium without royalty provided the copyright
+# notice and this notice are preserved.  This file is offered as-is,
+# without any warranty.
+
+#set -x
+#
+
+TST_CNT=2
+TST_TESTFUNC=vmcp_main
+TST_USAGE=usage
+. tst_test.sh
+
+usage()
+{
+	cat << EOF
+usage: $0 
+
+OPTIONS
+EOF
+}
+
+vmcp_run()
+{
+
+	$2
+	if [ $? -eq $1 ]; then
+		tst_res TPASS "'$2' returned '$1'. Test passed"
+	else
+		tst_res TFAIL "'$2' did not return '$1'. Test failed"
+	fi
+}
+
+vmcp_main1()
+{
+	echo "verifyBasicVMCPCommands"
+	vmcp_run 0 "vmcp --version";
+	vmcp_run 0 "vmcp --help";
+	vmcp_run 0 "vmcp -v";
+	vmcp_run 0 "vmcp -h";
+	vmcp_run 0 "vmcp q dasd";
+}
+
+vmcp_main2()
+{
+	echo "verifyErrorCondition"
+	vmcp_run 4 "vmcp -L"
+	vmcp_run 4 "vmcp -m q dasd"
+	vmcp_run 1 "vmcp dasddasddasd"
+	
+}
+
+
+tst_run
-- 
2.17.2 (Apple Git-113)

