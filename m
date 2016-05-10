From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 10 May 2016 18:19:01 +0800
Subject: [LTP] [PATCH 2/2] commands/passwd: Added new testcase to test passwd
In-Reply-To: <1462875541-7474-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1462875541-7474-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1462875541-7474-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test the basic functionality of passwd(1) command.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/commands                      |   1 +
 testcases/commands/passwd/Makefile    |  22 +++++
 testcases/commands/passwd/passwd01.sh | 155 ++++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 testcases/commands/passwd/Makefile
 create mode 100755 testcases/commands/passwd/passwd01.sh

diff --git a/runtest/commands b/runtest/commands
index 5aced8b..359b1ef 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -42,3 +42,4 @@ mkswap01 mkswap01.sh
 which01 which01.sh
 lsmod01 lsmod01.sh
 wc01 wc01.sh
+passwd01 passwd01.sh
diff --git a/testcases/commands/passwd/Makefile b/testcases/commands/passwd/Makefile
new file mode 100644
index 0000000..3bdd21c
--- /dev/null
+++ b/testcases/commands/passwd/Makefile
@@ -0,0 +1,22 @@
+#
+#    Copyright (c) 2016 Fujitsu Ltd.
+#    Author:Xiao Yang <yangx.jy@cn.fujitsu.com>
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
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= passwd01.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/passwd/passwd01.sh b/testcases/commands/passwd/passwd01.sh
new file mode 100755
index 0000000..d70f402
--- /dev/null
+++ b/testcases/commands/passwd/passwd01.sh
@@ -0,0 +1,155 @@
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
+TST_TOTAL=22
+. test.sh
+
+setup()
+{
+	tst_check_cmds useradd userdel passwd
+
+	tst_tmpdir
+
+	TST_CLEANUP="cleanup"
+
+	useradd ltp_test
+	if [ $? -ne 0 ] && [ ! -d /home/ltp_test ]; then
+		tst_brkm TBROK "useradd failed"
+	fi
+}
+
+cleanup()
+{
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
+	local opt=`echo "$2" | awk -F ' ' '{print $1}'`
+	local value=`echo "$2" | awk -F ' ' '{print $2}'`
+	local name=$3
+	local pw_cmd="$1 $2 $3"
+
+	eval $pw_cmd > temp 2>&1
+	if [ $? -ne 0 ]; then
+		grep -q -E "unrecognized option|invalid option|unknown option" temp
+		if [ $? -eq 0 ]; then
+			tst_resm TCONF "$pw_cmd not supported"
+		else
+			tst_resm TFAIL "$pw_cmd failed"
+		fi
+		return
+	fi
+
+	if [ "$name" != "" ]; then
+		local pw=`grep "$name" /etc/shadow | awk -F ':' '{print $2}'`
+		local mod=`grep "$name" /etc/shadow | awk -F ':' '{print $3}'`
+		local min=`grep "$name" /etc/shadow | awk -F ':' '{print $4}'`
+		local max=`grep "$name" /etc/shadow | awk -F ':' '{print $5}'`
+		local war=`grep "$name" /etc/shadow | awk -F ':' '{print $6}'`
+		local ina=`grep "$name" /etc/shadow | awk -F ':' '{print $7}'`
+	fi
+
+	case $opt in
+		-d|--delete)
+			if [ "$pw" != "" ]; then
+				tst_resm TFAIL "passwd failed with $opt option."
+				return
+			fi
+			;;
+		-l|--lock)
+			echo "$pw" | grep -q "!!" > temp 2>&1
+			if [ $? -ne 0 ]; then
+				tst_resm TFAIL "passwd failed with $opt option."
+				return
+			fi
+			;;
+		-u|--unlock)
+			echo "$pw" | grep -q "!!" > temp 2>&1
+			if [ $? -eq 0 ]; then
+				tst_resm TFAIL "passwd failed with $opt option."
+				return
+			fi
+			;;
+		-n|--minimum)
+			if [ $min -ne $value ]; then
+				tst_resm TFAIL "passwd failed with $opt option."
+				return
+			fi
+			;;
+		-x|--maximum)
+			if [ $max -ne $value ]; then
+				tst_resm TFAIL "passwd failed with $opt option."
+				return
+			fi
+			;;
+		-w|--warning)
+			if [ $war -ne $value ]; then
+				tst_resm TFAIL "passwd failed with $opt option."
+				return
+			fi
+			;;
+		-i|--inactive)
+			if [ $ina -ne $value ]; then
+				tst_resm TFAIL "passwd failed with $opt option."
+				return
+			fi
+			;;
+		-e|--expire)
+			if [ $mod -ne 0 ]; then
+				tst_resm TFAIL "passwd failed with $opt option."
+				return
+			fi
+			;;
+	esac
+
+	tst_resm TPASS "passwd passed with $opt option."
+}
+
+setup
+
+passwd_test "passwd" "-d" ltp_test
+passwd_test "passwd" "--delete" ltp_test
+passwd_test "echo test | passwd" "--stdin" ltp_test
+passwd_test "passwd" "-l" ltp_test
+passwd_test "passwd" "-u" ltp_test
+passwd_test "passwd" "--lock" ltp_test
+passwd_test "passwd" "--unlock" ltp_test
+passwd_test "passwd" "-n 1" ltp_test
+passwd_test "passwd" "--minimum 2" ltp_test
+passwd_test "passwd" "-x 11" ltp_test
+passwd_test "passwd" "--maximum 12" ltp_test
+passwd_test "passwd" "-w 5" ltp_test
+passwd_test "passwd" "--warning 6" ltp_test
+passwd_test "passwd" "-i 15" ltp_test
+passwd_test "passwd" "--inactive 16" ltp_test
+passwd_test "passwd" "-e " ltp_test
+passwd_test "passwd" "--expire" ltp_test
+passwd_test "passwd" "-S" ltp_test
+passwd_test "passwd" "--status" ltp_test
+passwd_test "passwd" "--help"
+passwd_test "passwd" "-?"
+passwd_test "passwd" "--usage"
+
+tst_exit
-- 
1.8.3.1



