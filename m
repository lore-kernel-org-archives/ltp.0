From: Yihao Wu <wuyihao@linux.alibaba.com>
Date: Mon, 3 Jun 2019 12:44:01 +0800
Subject: [LTP]  [PATCH] commands: add test for chrt
Message-ID: <3e2f5f1b-3fb8-8c16-5c04-383221c175ed@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This test checks check whether chrt works properly

Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
---
 runtest/commands                  |  1 +
 testcases/commands/chrt/Makefile  | 21 ++++++++++++++++
 testcases/commands/chrt/chrt01.sh | 52 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)
 create mode 100644 testcases/commands/chrt/Makefile
 create mode 100755 testcases/commands/chrt/chrt01.sh

diff --git a/runtest/commands b/runtest/commands
index ac15e8b..74bd860 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -40,3 +40,4 @@ keyctl01_sh keyctl01.sh
 gdb01_sh gdb01.sh
 unshare01_sh unshare01.sh
 sysctl01_sh sysctl01.sh
+chrt01_sh chrt01.sh
diff --git a/testcases/commands/chrt/Makefile b/testcases/commands/chrt/Makefile
new file mode 100644
index 0000000..c6f931b
--- /dev/null
+++ b/testcases/commands/chrt/Makefile
@@ -0,0 +1,21 @@
+#
+# Copyright (c) 2019 Alibaba Inc
+# Author: Yihao Wu <wuyihao@linux.alibaba.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+# the GNU General Public License for more details.
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= chrt01.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/chrt/chrt01.sh b/testcases/commands/chrt/chrt01.sh
new file mode 100755
index 0000000..633b3c0
--- /dev/null
+++ b/testcases/commands/chrt/chrt01.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+# Copyright (c) 2019 Alibaba Inc
+# Author: Yihao Wu <wuyihao@linux.alibaba.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+# the GNU General Public License for more details.
+#
+# Test the basic functionality of chrt command.
+#
+TST_TESTFUNC=chrt_test
+TST_SETUP=setup
+TST_CLEANUP=cleanup
+TST_NEEDS_CMDS="chrt cgexec cgset cgget"
+TST_NEEDS_ROOT=1
+. tst_test.sh
+
+setup()
+{
+	old_rt_runtime_us=$(cgget -r cpu.rt_runtime_us / -vn)
+	old_rt_period_us=$(cgget -r cpu.rt_period_us / -vn)
+
+	cgset -r cpu.rt_runtime_us=10000 /
+	cgset -r cpu.rt_period_us=1000000 /
+}
+
+chrt_test()
+{
+	cgexec -g cpu:/ -g cpuset:/ sleep 4 &
+	PID=$!
+	cgexec -g cpu:/ -g cpuset:/ chrt -arp 50 ${PID}
+	SCHEDULER=$(chrt -p ${PID} | awk 'NR==1{print $6}')
+	if [ x"${SCHEDULER}" == x"SCHED_RR" ]; then
+		tst_res TPASS "'chrt' passed."
+	else
+		tst_res TFAIL "'chrt' failed to set scheduling policy."
+	fi
+}
+
+cleanup()
+{
+	cgset -r cpu.rt_runtime_us=${old_rt_runtime_us} /
+	cgset -r cpu.rt_period_us=${old_rt_period_us} /
+}
+
+tst_run
-- 
1.8.3.1

