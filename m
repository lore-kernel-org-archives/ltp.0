Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1YdcTW-0007Fg-VN
	for ltp-list@lists.sourceforge.net; Thu, 02 Apr 2015 10:35:50 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YdcTU-0007lR-R6
	for ltp-list@lists.sourceforge.net; Thu, 02 Apr 2015 10:35:50 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t32AYbvH020989
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Apr 2015 18:34:37 +0800
Message-ID: <1427970931.19106.8.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 2 Apr 2015 18:35:31 +0800
MIME-Version: 1.0
Subject: [LTP] [RFC PATCH] commands/du: Added new testcase to test du(1)
	command.
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

Test du(1) command with some basic options.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/commands               |   1 +
 testcases/commands/du/Makefile |  21 +++++++++
 testcases/commands/du/du01.sh  | 104 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 testcases/commands/du/Makefile
 create mode 100755 testcases/commands/du/du01.sh

diff --git a/runtest/commands b/runtest/commands
index b711294..06291f0 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -20,3 +20,4 @@ size01 size01
 sssd01 sssd01
 sssd02 sssd02
 sssd03 sssd03
+du01 du01.sh
diff --git a/testcases/commands/du/Makefile b/testcases/commands/du/Makefile
new file mode 100644
index 0000000..af3b703From 35878f9f8a97d35571ec2937bfb5fce9df4c4820 Mon Sep 17 00:00:00 2001
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 2 Apr 2015 18:24:40 +0800
Subject: [PATCH] commands/du: Added new testcase to test du(1) command.

--- /dev/null
+++ b/testcases/commands/du/Makefile
@@ -0,0 +1,21 @@
+#
+#  Copyright (c) 2015 Fujitsu Ltd.
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= du01.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/du/du01.sh b/testcases/commands/du/du01.sh
new file mode 100755
index 0000000..4bd7c9c
--- /dev/null
+++ b/testcases/commands/du/du01.sh
@@ -0,0 +1,104 @@
+#!/bin/sh
+#
+# Copyright (c) 2015 Fujitsu Ltd.
+# Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
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
+# Test du command with some basic options.
+#
+
+TCID=du01
+
+TEST_FILE="du_test.file"
+test_cases=(
+	[1]=""
+	[2]="$TEST_FILE"
+	[3]="-0"
+	[4]="--null"
+	[5]="-a"
+	[6]="--all"
+	[7]="-B 20"
+	[8]="--block-size=20"
+	[9]="-b"
+	[10]="--bytes"
+	[11]="-c"
+	[12]="--total"
+	[13]="-D dir1/${TEST_FILE}"
+	[14]="--dereference-args dir1/${TEST_FILE}"
+	[15]="--max-depth=1"
+	[16]="-H dir1/${TEST_FILE}"
+	[17]="-h"
+	[18]="--human-readable"
+	[19]="-k"
+	[20]="-L dir1/"
+	[21]="--dereference dir1/"
+	[22]="-m"
+	[23]="-P"
+	[24]="--no-dereference"
+	[25]="--si"
+	[26]="-s"
+	[27]="--summarize"
+	[28]="--exclude=${TEST_FILE}"
+)
+
+TST_TOTAL=${#test_cases[@]}
+
+. test.sh
+
+export TEST_RETURN
+TEST()
+{
+	$@ >${TCID}.temp 2>&1
+	TEST_RETURN=$?
+}
+
+setup()
+{
+	tst_check_cmds du
+
+	tst_tmpdir
+
+	echo "test for du" > du_test.file
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "create du_test.file failed."
+	fi
+
+	mkdir -p dir1
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "mkdir dir1 failed."
+	fi
+
+	ln -s $(pwd)/du_test.file dir1/du_test.file
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "ln -s $(pwd)/du_test.file dir1/du_test.file"
+	fi
+}
+
+cleanup()
+{
+	tst_rmdir
+}
+
+setup
+TST_CLEANUP=cleanup
+
+for i in $(seq 1 ${#test_cases[@]})
+do
+	TEST du ${test_cases[$i]}
+	if [ ${TEST_RETURN} -eq 0 ]; then
+		tst_resm TPASS "du(option: ${test_cases[$i]}) succeeded."
+	else
+		tst_resm TFAIL "du(option: ${test_cases[$i]}) failed."
+	fi
+done
+
+tst_exit
-- 
1.9.3




------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
