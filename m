From: Cui Bixuan <cuibixuan@huawei.com>
Date: Fri, 23 Oct 2015 01:08:48 +0000
Subject: [LTP] [PATCH]  commans/sar: Add new testcases for sar
Message-ID: <1445562528-228220-1-git-send-email-cuibixuan@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add new testcases for sar

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 runtest/commands                    |    1 +
 testcases/commands/sar/Makefile     |   29 +++++++
 testcases/commands/sar/sar_tests.sh |  153 +++++++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+), 0 deletions(-)
 create mode 100644 testcases/commands/sar/Makefile
 create mode 100755 testcases/commands/sar/sar_tests.sh

diff --git a/runtest/commands b/runtest/commands
index e5260ba..56a326b 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -16,6 +16,7 @@ cp_tests01 cp_tests.sh
 ln_tests01 ln_tests.sh
 mkdir_tests01 mkdir_tests.sh
 mv_tests01 mv_tests.sh
+sar01 sar_tests.sh
 size01 size01
 sssd01 sssd01
 sssd02 sssd02
diff --git a/testcases/commands/sar/Makefile b/testcases/commands/sar/Makefile
new file mode 100644
index 0000000..ebec180
--- /dev/null
+++ b/testcases/commands/sar/Makefile
@@ -0,0 +1,29 @@
+#
+#    commands/sar testcases Makefile.
+#
+#    Copyright (C) 2015, Cui Bixuan <cuibixuan@huawei.com>.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= sar_tests.sh
+
+MAKE_TARGETS		:=
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/sar/sar_tests.sh b/testcases/commands/sar/sar_tests.sh
new file mode 100755
index 0000000..afc9cc7
--- /dev/null
+++ b/testcases/commands/sar/sar_tests.sh
@@ -0,0 +1,153 @@
+#!/bin/sh
+#
+# Copyright (c) 2015 Cui Bixuan <cuibixuan@huawei.com>.
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
+# Test sar command with some basic options.
+#
+
+TCID=sar01
+TST_TOTAL=19
+. test.sh
+
+setup()
+{
+	tst_check_cmds sar
+
+	tst_tmpdir
+}
+
+cleanup()
+{
+	tst_rmdir
+}
+
+sar_test()
+{
+	$1 >${TCID}.temp 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "'$1' failed."
+		return
+	fi
+
+	grep $2 ${TCID}.temp >/dev/null
+	if [ $? -eq 0 ]; then
+		tst_resm TPASS "'$1' passed."
+	else
+		tst_resm TFAIL "'$1' failed."
+	fi
+}
+
+test1()
+{
+	sar_test "sar -A 1 1" "CPU"
+}
+
+test2()
+{
+	sar_test "sar -b 1 1" "tps"
+}
+
+test3()
+{
+	sar_test "sar -B 1 1" "pgpgin"
+}
+
+test4()
+{
+	sar_test "sar -C 1 1" "CPU"
+}
+
+test5()
+{
+	sar_test "sar -d 1 1" "tps"
+}
+
+test6()
+{
+	sar_test "sar -p 1 1" "user"
+}
+
+test7()
+{
+	sar_test "sar -q 1 1" "plist-sz"
+}
+
+test8()
+{
+	sar_test "sar -r 1 1" "kbmemfree"
+}
+
+test9()
+{
+	sar_test "sar -R 1 1" "frmpg"
+}
+
+test10()
+{
+	sar_test "sar -S 1 1" "kbswpfree"
+}
+
+test11()
+{
+	sar_test "sar -t 1 1" "CPU"
+}
+
+test12()
+{
+	sar_test "sar -u ALL 1 1" "CPU"
+}
+
+test13()
+{
+	sar_test "sar -u -v 1 1" "CPU"
+}
+
+test14()
+{
+	sar_test "sar -u -w 1 1" "CPU"
+}
+
+test15()
+{
+	sar_test "sar -u -W 1 1" "CPU"
+}
+
+test16()
+{
+	sar_test "sar -u -y 1 1" "CPU"
+}
+
+test17()
+{
+	sar_test "sar -I ALL 1 1" "INTR"
+}
+
+test18()
+{
+	sar_test "sar -P ALL 1 1" "CPU"
+}
+
+test19()
+{
+	sar_test "sar -A 1 1 -o sar_tmpfile" "CPU"
+}
+
+setup
+TST_CLEANUP="cleanup"
+
+for i in $(seq 1 ${TST_TOTAL})
+do
+	test$i
+done
+
+tst_exit
-- 
1.6.0.2

