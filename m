From: vkabatov@redhat.com <vkabatov@redhat.com>
Date: Mon, 17 Jul 2017 13:25:46 +0200
Subject: [LTP]  [PATCH] gdb: Create a directory and a simple gdb testcase
Message-ID: <1500290746-3674-1-git-send-email-vkabatov@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Veronika Kabatova <vkabatov@redhat.com>

Create a testcase to verify gdb is able to attach to a process and
this process is able to run without issues. Since no gdb-related
tests are present, a directory and a makefie are created as well.

Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
---
 runtest/commands                |  1 +
 testcases/commands/gdb/Makefile | 26 ++++++++++++++++++++++++++
 testcases/commands/gdb/gdb01.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 testcases/commands/gdb/Makefile
 create mode 100755 testcases/commands/gdb/gdb01.sh

diff --git a/runtest/commands b/runtest/commands
index 4661643..00ae0d2 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -42,3 +42,4 @@ lsmod01 lsmod01.sh
 insmod01 insmod01.sh
 wc01 wc01.sh
 keyctl01 keyctl01.sh
+gdb01 gdb01.sh
diff --git a/testcases/commands/gdb/Makefile b/testcases/commands/gdb/Makefile
new file mode 100644
index 0000000..1ebbf65
--- /dev/null
+++ b/testcases/commands/gdb/Makefile
@@ -0,0 +1,26 @@
+#
+#    misc/gdb test suite Makefile.
+#
+#    Copyright (C) 2017 Red Hat, Inc.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+#    General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, see <http://www.gnu.org/licenses/>.
+#
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= *.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/gdb/gdb01.sh b/testcases/commands/gdb/gdb01.sh
new file mode 100755
index 0000000..07ae36f
--- /dev/null
+++ b/testcases/commands/gdb/gdb01.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+# Copyright (C) 2017 Red Hat, Inc.
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
+
+# Test description: See if gdb can successfully attach to a process and
+#                   this process exits normally.
+
+# Usage
+# ./gdb01.sh
+
+TST_TESTFUNC=simple_test
+TST_NEEDS_CMDS="gdb /bin/cat"
+
+. tst_test.sh
+
+simple_test()
+{
+	gdb /bin/cat -ex "run /etc/passwd" -ex quit
+	RC=$?
+	if [ $RC -eq 0 ] ; then
+		tst_res TPASS "gdb attached to process and completed run"
+	else
+		tst_res TFAIL "gdb test failed with" $RC
+	fi
+}
+
+tst_run
-- 
2.7.4

