From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 15 Mar 2018 16:22:34 +0800
Subject: [LTP] [PATCH v3] commands/sysctl: Add new regression test for
	invalid sched_time_avg
In-Reply-To: <20180314170148.GC27794@rei>
References: <20180314170148.GC27794@rei>
Message-ID: <1521102154-4307-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The kernel bug has been fixed in kernel:
'5ccba44ba118("sched/sysctl: Check user input value of sysctl_sched_time_avg")'

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/commands                      |  1 +
 testcases/commands/sysctl/Makefile    | 25 ++++++++++++++++
 testcases/commands/sysctl/sysctl01.sh | 55 +++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 testcases/commands/sysctl/Makefile
 create mode 100755 testcases/commands/sysctl/sysctl01.sh

diff --git a/runtest/commands b/runtest/commands
index 92df3af..fde8063 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -44,3 +44,4 @@ wc01 wc01.sh
 keyctl01 keyctl01.sh
 gdb01 gdb01.sh
 unshare01 unshare01.sh
+sysctl01 sysctl01.sh
diff --git a/testcases/commands/sysctl/Makefile b/testcases/commands/sysctl/Makefile
new file mode 100644
index 0000000..61ff705
--- /dev/null
+++ b/testcases/commands/sysctl/Makefile
@@ -0,0 +1,25 @@
+#
+# Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+# General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, see <http://www.gnu.org/licenses/>.
+#
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= *.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/sysctl/sysctl01.sh b/testcases/commands/sysctl/sysctl01.sh
new file mode 100755
index 0000000..7522da5
--- /dev/null
+++ b/testcases/commands/sysctl/sysctl01.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+# Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+#
+# This program is free software;  you can redistribute it and#or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+# or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+# for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, see <http://www.gnu.org/licenses/>.
+#
+# Description:
+# This is a regression test for invalid value of sysctl_sched_time_avg.
+# System will hang if user set sysctl_sched_time_avg to 0 on buggy kernel.
+#
+# The kernel bug has been fixed in kernel:
+# '5ccba44ba118("sched/sysctl: Check user input value of sysctl_sched_time_avg")'
+
+TST_TESTFUNC=sysctl_test
+TST_NEEDS_ROOT=1
+TST_NEEDS_CMDS="sysctl"
+
+. tst_test.sh
+
+sysctl_test()
+{
+	# With commit d00535d, sched_time_avg was renamed as sched_time_avg_ms
+	local dir="/proc/sys/kernel/"
+	[ -e "$dir""sched_time_avg_ms" ] && local name="sched_time_avg_ms"
+	[ -e "$dir""sched_time_avg" ] && local name="sched_time_avg"
+	[ -z "$name" ] && tst_brk TCONF \
+		"sched_time_avg(_ms) was not supported"
+
+	local orig_value=$(cat "$dir""$name")
+
+	sysctl -w "kernel.""$name"=0 >/dev/null 2>&1
+
+	local test_value=$(cat "$dir""$name")
+
+	if [ ${test_value} -eq ${orig_value} ]; then
+		tst_res TPASS "Setting $name failed"
+	else
+		tst_res TFAIL "Setting $name succeeded"
+		sysctl -w "kernel.""$name"=${orig_value} >/dev/null 2>&1
+	fi
+}
+
+tst_run
-- 
1.8.3.1



