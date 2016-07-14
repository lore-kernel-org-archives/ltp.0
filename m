From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 14 Jul 2016 14:11:04 +0800
Subject: [LTP] [PATCH] commands/passwd: Added new testcase to test passwd
Message-ID: <1468476664-16364-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test the basic functionality of passwd(1) command.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/commands                       |   1 +
 testcases/commands/passwd/Makefile     |  22 +++++++
 testcases/commands/passwd/check_passwd |  67 +++++++++++++++++++++
 testcases/commands/passwd/passwd01.sh  | 107 +++++++++++++++++++++++++++++++++
 4 files changed, 197 insertions(+)
 create mode 100644 testcases/commands/passwd/Makefile
 create mode 100755 testcases/commands/passwd/check_passwd
 create mode 100755 testcases/commands/passwd/passwd01.sh

diff --git a/runtest/commands b/runtest/commands
index 04b4280..0dd7093 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -43,3 +43,4 @@ which01 which01.sh
 lsmod01 lsmod01.sh
 insmod01 insmod01.sh
 wc01 wc01.sh
+passwd01 passwd01.sh
diff --git a/testcases/commands/passwd/Makefile b/testcases/commands/passwd/Makefile
new file mode 100644
index 0000000..51fe2c9
--- /dev/null
+++ b/testcases/commands/passwd/Makefile
@@ -0,0 +1,22 @@
+#
+# Copyright (c) 2016 Fujitsu Ltd.
+# Author:Xiao Yang <yangx.jy@cn.fujitsu.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= passwd01.sh check_passwd
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/passwd/check_passwd b/testcases/commands/passwd/check_passwd
new file mode 100755
index 0000000..1d27c7e
--- /dev/null
+++ b/testcases/commands/passwd/check_passwd
@@ -0,0 +1,67 @@
+#!/usr/bin/expect -f
+#
+# Copyright (c) 2016 Fujitsu Ltd.
+# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
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
+# Test passwd command with some basic options.
+#
+
+set test_res 0
+set user_init [ lindex $argv 0 ]
+set cmd [ lindex $argv 1 ]
+set user_test [ lindex $argv 2 ]
+set passwd_test [ lindex $argv 3 ]
+
+set who_bf [ exec whoami ]
+if { $who_bf!=$user_init } {
+	send_user "ERROR: You must be not a root user before testing\n"
+	exit 1
+}
+
+if { $cmd==2 } {
+        spawn /bin/su $user_test
+        expect "Password:" {
+                send "$passwd_test\n"
+                expect {
+			"su: Authentication failure" { set test_res 1 }
+			"su: incorrect password" { set test_res 1 }
+		}
+        }
+}
+
+if { $cmd==1 } {
+	spawn /bin/su $user_test
+	expect "Password:" {
+		send "$passwd_test\n"
+		expect "$user_test" { set test_res 1 }
+	}
+}
+
+if { $cmd==0 } {
+	spawn /bin/su $user_test
+	expect "$user_test" { set test_res 1 }
+}
+
+set who_af [ exec whoami ]
+if { $who_af!=$user_init } {
+        send_user "ERROR: You must be not a root user after testing\n"
+        exit 1
+}
+
+if { $test_res==1 } {
+	send_user "test passes as expected\n"
+	exit 0
+} else {
+	send_user "test fails unexpectedly\n"
+	exit 1
+}
diff --git a/testcases/commands/passwd/passwd01.sh b/testcases/commands/passwd/passwd01.sh
new file mode 100755
index 0000000..8a304ce
--- /dev/null
+++ b/testcases/commands/passwd/passwd01.sh
@@ -0,0 +1,107 @@
+#!/bin/sh
+#
+# Copyright (c) 2016 Fujitsu Ltd.
+# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
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
+# Test passwd command with some basic options.
+#
+
+TCID=passwd01.sh
+TST_TOTAL=11
+. test.sh
+
+setup()
+{
+	tst_require_root
+
+	tst_check_cmds useradd userdel passwd su expect
+
+	tst_tmpdir
+
+	TST_CLEANUP="cleanup"
+
+	useradd ltp_init
+	if [ $? -ne 0 ] && [ ! -d /home/ltp_test ]; then
+		tst_brkm TBROK "useradd failed"
+	fi
+
+	useradd ltp_test
+	if [ $? -ne 0 ] && [ ! -d /home/ltp_test ]; then
+		tst_brkm TBROK "useradd failed"
+	fi
+}
+
+cleanup()
+{
+	userdel -r ltp_init
+	if [ $? -ne 0 ] && [ -d /home/ltp_test ]; then
+		tst_brkm TBROK "userdel -r failed"
+	fi
+
+	userdel -r ltp_test
+	if [ $? -ne 0 ] && [ -d /home/ltp_test ]; then
+		tst_brkm TBROK "userdel -r failed"
+	fi
+
+	tst_rmdir
+}
+
+passwd_test()
+{
+	local pw_cmd="$1 $2 $3"
+	local opt="$2"
+	local check_opt="$4 $3 $5"
+
+	eval $pw_cmd > temp1 2>&1
+	if [ $? -ne 0 ]; then
+		grep -q -E "unrecognized option|invalid option|unknown option" temp1
+		if [ $? -eq 0 ]; then
+			tst_resm TCONF "$pw_cmd not supported"
+		else
+			tst_resm TFAIL "$pw_cmd failed"
+		fi
+		return
+	fi
+
+	if [ $# -ge 4 ]; then
+		su ltp_init -c "check_passwd ltp_init $check_opt" > temp2 2>&1
+		if [ $? -eq 0 ]; then
+			grep -q "test passes as expected" temp2
+			if [ $? -ne 0 ]; then
+				tst_resm TFAIL "passwd failed with $opt option."
+				return
+			fi
+		else
+			tst_resm TFAIL "passwd failed with $opt option."
+			return
+		fi
+	fi
+
+	tst_resm TPASS "passwd passed with $opt option."
+}
+
+setup
+
+passwd_test "passwd" "-d" "ltp_test" "0"
+passwd_test "echo test | passwd" "--stdin" "ltp_test" "1" "test"
+passwd_test "passwd" "-l" "ltp_test" "2" "test"
+passwd_test "passwd" "-u" "ltp_test" "1" "test"
+passwd_test "passwd" "--lock" "ltp_test" "2" "test"
+passwd_test "passwd" "--unlock" "ltp_test" "1" "test"
+passwd_test "passwd" "--delete" "ltp_test" "0"
+passwd_test "passwd" "-S" "ltp_test"
+passwd_test "passwd" "--status" "ltp_test"
+passwd_test "passwd" "--help"
+passwd_test "passwd" "--usage"
+
+tst_exit
-- 
1.8.3.1



