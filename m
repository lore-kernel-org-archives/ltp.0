Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1YJeYB-00024A-BG
	for ltp-list@lists.sourceforge.net; Fri, 06 Feb 2015 08:46:07 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YJeYA-0007eM-49
	for ltp-list@lists.sourceforge.net; Fri, 06 Feb 2015 08:46:07 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t168irnO028868
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Feb 2015 16:44:53 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Fri, 6 Feb 2015 16:41:28 +0800
Message-ID: <1423212090-24164-4-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1423212090-24164-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1423212090-24164-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 4/6] power_management: add uclinux check and move
	some check
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
To: ltp-list@lists.sourceforge.net

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/power_management/pm_check_env.sh  | 41 ++++++++++++++++++++++
 .../kernel/power_management/pm_check_uclinux.c     | 29 +++++++++++++++
 testcases/kernel/power_management/runpwtests.sh    | 17 ++-------
 3 files changed, 72 insertions(+), 15 deletions(-)
 create mode 100755 testcases/kernel/power_management/pm_check_env.sh
 create mode 100644 testcases/kernel/power_management/pm_check_uclinux.c

diff --git a/testcases/kernel/power_management/pm_check_env.sh b/testcases/kernel/power_management/pm_check_env.sh
new file mode 100755
index 0000000..ebfaf08
--- /dev/null
+++ b/testcases/kernel/power_management/pm_check_env.sh
@@ -0,0 +1,41 @@
+#
+# Copyright (c) 2015 Fujitsu Ltd.
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
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+check_env() {
+	# Checking the system type
+	./pm_check_uclinux; rc=$?
+	if [ $rc -eq 1 ]; then
+		tst_brkm TCONF "UCLINUX not supported; not running testcases"
+	fi
+
+	# Checking required kernel version and architecture
+	tst_kvercmp 2 6 21; rc=$?
+	if [ $rc -ne 1 -a $rc -ne 2 ] ; then
+		tst_brkm TCONF "Kernel version not supported; not running \
+			testcases"
+	else
+		case "$(uname -m)" in
+		i[4-6]86|x86_64)
+			;;
+		*)
+			tst_brkm TCONF "Arch not supported; not running \
+				testcases"
+			;;
+		esac
+	fi
+}
diff --git a/testcases/kernel/power_management/pm_check_uclinux.c b/testcases/kernel/power_management/pm_check_uclinux.c
new file mode 100644
index 0000000..e3823b1
--- /dev/null
+++ b/testcases/kernel/power_management/pm_check_uclinux.c
@@ -0,0 +1,29 @@
+/*
+ * Copyright (c) 2015 Fujitsu Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/* Check wether the current system is uclinux. */
+int main(int argc, char **argv)
+{
+	int chkcmp;
+#ifdef UCLINUX
+	chkcmp = 1;
+#else
+	chkcmp = 0;
+#endif
+	return chkcmp;
+}
diff --git a/testcases/kernel/power_management/runpwtests.sh b/testcases/kernel/power_management/runpwtests.sh
index 9055964..0a66dc4 100755
--- a/testcases/kernel/power_management/runpwtests.sh
+++ b/testcases/kernel/power_management/runpwtests.sh
@@ -42,6 +42,7 @@ YES=0
 NO=1
 #List of reusable functions defined in pm_include.sh
 . pm_include.sh
+. pm_check_env.sh
 
 # Function:     main
 #
@@ -52,21 +53,7 @@ NO=1
 #
 RC=0		#Return status
 
-# Checking required kernel version and architecture
-tst_kvercmp 2 6 21; rc=$?
-if [ $rc -ne 1 -a $rc -ne 2 ] ; then
-	tst_resm TCONF "Kernel version not supported; not running testcases"
-	exit 0
-else
-	case "$(uname -m)" in
-	i[4-6]86|x86_64)
-		;;
-	*)
-		tst_resm TCONF "Arch not supported; not running testcases"
-		exit 0
-		;;
-	esac
-fi
+check_env
 
 tst_kvercmp 2 6 29; rc=$?
 if [ $rc -eq 2 ] ; then
-- 
1.9.3


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
