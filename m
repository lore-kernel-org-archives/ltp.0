Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Yn3Qr-0003XC-Ab
	for ltp-list@lists.sourceforge.net; Tue, 28 Apr 2015 11:12:05 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Yn3Qp-0008WN-9b
	for ltp-list@lists.sourceforge.net; Tue, 28 Apr 2015 11:12:05 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t3SBAfRt018370
	for <ltp-list@lists.sourceforge.net>; Tue, 28 Apr 2015 19:10:41 +0800
Message-ID: <1430219455.7745.4.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 28 Apr 2015 19:10:55 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH] commands/df: Added new testcase to test df(1) command.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

Test df(1) command with some basic options.

Signed-off-by: Zhang Jin <jy_zhangjin@cn.fujitsu.com>
---
 runtest/commands               |   1 +
 testcases/commands/df/Makefile |  28 ++++++
 testcases/commands/df/df01.sh  | 191 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+)
 create mode 100644 testcases/commands/df/Makefile
 create mode 100755 testcases/commands/df/df01.sh

diff --git a/runtest/commands b/runtest/commands
index b711294..da8d92c 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -20,3 +20,4 @@ size01 size01
 sssd01 sssd01
 sssd02 sssd02
 sssd03 sssd03
+df01 df01.sh
diff --git a/testcases/commands/df/Makefile b/testcases/commands/df/Makefile
new file mode 100644
index 0000000..6d3c7fd
--- /dev/null
+++ b/testcases/commands/df/Makefile
@@ -0,0 +1,28 @@
+#
+#    commands/df testcases Makefile.
+#
+#    Copyright (C) 2015 Fujitsu Ltd.
+#    Author:Zhang Jin <jy_zhangjin@cn.fujitsu.com>
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
+INSTALL_TARGETS		:= df01.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
new file mode 100755
index 0000000..b3b592f
--- /dev/null
+++ b/testcases/commands/df/df01.sh
@@ -0,0 +1,191 @@
+#!/bin/bash
+#
+# Copyright (c) 2015 Fujitsu Ltd.
+# Author: Zhang Jin <jy_zhangjin@cn.fujitsu.com>
+#
+# This program is free software;  you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY;  without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+# the GNU General Public License for more details.
+#
+# Test df command with some basic options.
+#
+
+TCID=df01
+TST_TOTAL=12
+. test.sh
+
+setup()
+{
+	tst_require_root
+
+	tst_check_cmds df
+
+	tst_tmpdir
+
+	dd if=/dev/zero of=test.img bs=1M count=20 >/dev/null 2>&1
+	if [ $? -ne 0 ];then
+		tst_brkm TBROK "dd failed."
+	fi
+
+	device_name=$(/sbin/losetup -f)
+	if [ $? -ne 0 ];then
+		tst_brkm TBROK "device_name failed."
+	fi
+
+	losetup ${device_name} test.img
+	if [ $? -ne 0 ];then
+		tst_brkm TBROK "losetup failed."
+	fi
+
+	mkfs.ext2 ${device_name} >/dev/null 2>&1
+	if [ $? -ne 0 ];then
+		tst_brkm TBROK "mkfs.ext2 failed."
+	fi
+
+	mkdir mntpoint
+	if [ $? -ne 0 ];then
+		tst_brkm TBROK "mkdir testdir failed."
+	fi
+
+	mount ${device_name} mntpoint
+	if [ $? -ne 0 ];then
+		tst_brkm TBROK "mount failed."
+	fi
+}
+
+cleanup()
+{
+	umount -d mntpoint
+	if [ $? -ne 0 ];then
+		tst_resm TINFO "umount error."
+	fi
+
+	tst_rmdir
+}
+
+df_test()
+{
+	$1 >${TCID}.temp 2>&1
+	if [ $? -ne 0 ]; then
+		grep -q -E "unrecognized option | invalid option" ${TCID}.temp
+		if [ $? -eq 0 ]; then
+			tst_resm TCONF "'$1' not supported."
+			return
+		else
+			tst_resm TFAIL "'$1' failed."
+			return
+		fi
+	fi
+
+	grep ${device_name} ${TCID}.temp | grep mntpoint | grep -q $2
+	if [ $? -eq 0 ]; then
+		tst_resm TPASS "'$1' passed."
+	else
+		tst_resm TFAIL "'$1' failed."
+	fi
+}
+
+test1()
+{
+	df_test "df" "19827"
+}
+
+test2()
+{
+	df_test "df -a" "19827"
+}
+
+test3()
+{
+	df_test "df -h" "20M"
+}
+
+test4()
+{
+	df_test "df -H" "21M"
+}
+
+test5()
+{
+	df_test "df -i" "5136"
+}
+
+test6()
+{
+	df_test "df -k" "19827"
+}
+
+test7()
+{
+	df_test "df -m" "20"
+}
+
+test8()
+{
+	df_test "df -t ext2" "19827"
+}
+
+test9()
+{
+	df_test "df -T" "19827"
+}
+
+test10()
+{
+	df_test "df -v mntpoint" "19827"
+}
+
+test11()
+{
+	df -x ext2 >${TCID}.temp 2>&1
+	if [ $? -ne 0 ]; then
+		grep -q -E "unrecognized option | invalid option" ${TCID}.temp
+		if [ $? -eq 0 ]; then
+			tst_resm TCONF "'df -x ext2' not supported."
+			return
+		else
+			tst_resm TFAIL "'df -x ext2' failed."
+			return
+		fi
+	fi
+
+	grep ${device_name} ${TCID}.temp | grep -q mntpoint
+	if [ $? -ne 0 ]; then
+		tst_resm TPASS "'df -x ext2' passed."
+	else
+		tst_resm TFAIL "'df -x ext2' failed."
+	fi
+}
+
+test12()
+{
+	df --version >${TCID}.temp 2>&1
+	if [ $? -ne 0 ]; then
+		grep -q -E "unrecognized option | invalid option" ${TCID}.temp
+		if [ $? -eq 0 ]; then
+			tst_resm TCONF "'df --version' not supported."
+			return
+		else
+			tst_resm TFAIL "'df --version' failed."
+			return
+		fi
+	else
+		tst_resm TPASS "'df --version' passed."
+	fi
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
2.4.0-rc1




------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
