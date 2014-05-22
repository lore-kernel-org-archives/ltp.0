Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WnPXo-0003fq-Lz
	for ltp-list@lists.sourceforge.net; Thu, 22 May 2014 09:44:12 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WnPXl-0000Hc-NH
	for ltp-list@lists.sourceforge.net; Thu, 22 May 2014 09:44:12 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s4M9heo0019965
	for <ltp-list@lists.sourceforge.net>; Thu, 22 May 2014 17:43:40 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Thu, 22 May 2014 17:41:06 +0800
Message-ID: <1400751666-30218-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] lib/tst_fs_link_count.c: add two new test interfaces
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

If you want to get the maximum number of hard links to one file in
specified filesystem, using the below interface. if there is no such
limits, return -1
    int tst_fs_get_max_hardlinks(const char *filesystem);

If you want to get the maximum subdirectories per directory in
specified filesystem, using the below interface. if there is no such
limits, return -1.
    int tst_fs_max_subdirs_per_dir(const char *filesystem);

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 configure.ac             |  1 +
 include/test.h           | 15 ++++++++++
 lib/tst_fs_link_count.c  | 71 ++++++++++++++++++++++++++++++++++++++++++++++++
 m4/ltp-ext-filesystem.m4 | 38 ++++++++++++++++++++++++++
 4 files changed, 125 insertions(+)
 create mode 100644 lib/tst_fs_link_count.c
 create mode 100644 m4/ltp-ext-filesystem.m4

diff --git a/configure.ac b/configure.ac
index 8698c47..5a5d7b5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -182,5 +182,6 @@ LTP_CHECK_FALLOCATE
 LTP_CHECK_SYSCALL_FCNTL
 LTP_CHECK_SYSCALL_PERF_EVENT_OPEN
 LTP_CHECK_TIRPC
+LTP_CHECK_EXT_FILESYSTEM
 
 AC_OUTPUT
diff --git a/include/test.h b/include/test.h
index 43fdc8b..6077a4f 100644
--- a/include/test.h
+++ b/include/test.h
@@ -321,6 +321,21 @@ const char *tst_strerrno(int err);
 int tst_path_has_mnt_flags(void (cleanup_fn)(void),
 		const char *path, const char *flags[]);
 
+/*
+ * lib/tst_fs_link_count.c
+ * Return the maximum number of hard links to one file in specified filesystem.
+ * If the filesystem does not have such limits or currently we do not have
+ * knowledge about the filesystem, return -1.
+ */
+int tst_fs_get_max_hardlinks(const char *filesystem);
+
+/* lib/tst_fs_link_count.c
+ * Return the maximum subdirectories per directory in specified filesystem.
+ * If the filesystem does not have such limits or currently we do not have
+ * knowledge about the filesystem, return -1.
+ */
+int tst_fs_max_subdirs_per_dir(const char *filesystem);
+
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
 #elif  TST_USE_NEWER64_SYSCALL
diff --git a/lib/tst_fs_link_count.c b/lib/tst_fs_link_count.c
new file mode 100644
index 0000000..16722e0
--- /dev/null
+++ b/lib/tst_fs_link_count.c
@@ -0,0 +1,71 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include "test.h"
+
+int tst_fs_get_max_hardlinks(const char *filesystem)
+{
+	if (strcmp(filesystem, "ext2") == 0 ||
+	    strcmp(filesystem, "ext3") == 0) {
+#if defined(HAVE_EXT4_USE_FOR_EXT23)
+		tst_resm(TINFO, "kernel config option CONFIG_EXT4_USE_FOR_EXT23"
+			 " is enabled, so ext4 file system driver will be used "
+			 "for %s file system mounts", filesystem);
+		return 65000;
+#else
+		return 32000;
+#endif
+	} else if (strcmp(filesystem, "ext4") == 0) {
+		return 65000;
+	} else if (strcmp(filesystem, "xfs") == 0) {
+		return -1;
+	} else if (strcmp(filesystem, "btrfs") == 0) {
+		return 65535;
+	} else {
+		tst_resm(TINFO, "Currently we do not have knowledge about "
+			 "filesystem %s, or it is not a valid filesystem "
+			 "name", filesystem);
+		return -1;
+	}
+}
+
+int tst_fs_max_subdirs_per_dir(const char *filesystem)
+{
+	if (strcmp(filesystem, "ext2") == 0 ||
+	    strcmp(filesystem, "ext3") == 0) {
+#if defined(HAVE_EXT4_USE_FOR_EXT23)
+		tst_resm(TINFO, "kernel config option CONFIG_EXT4_USE_FOR_EXT23"
+			 " is enabled, so ext4 file system driver will be used "
+			 "for %s file system mounts", filesystem);
+		return -1;
+#else
+		return 32000;
+#endif
+	} else if (strcmp(filesystem, "ext4") == 0) {
+		return -1;
+	} else if (strcmp(filesystem, "xfs") == 0) {
+		return -1;
+	} else if (strcmp(filesystem, "btrfs") == 0) {
+		return -1;
+	} else {
+		tst_resm(TINFO, "for filesystem:%s, currently there is no "
+			 "exact information about the max subdirectories per"
+			 " directory or this is not a valid filesystem name",
+			 filesystem);
+		return -1;
+	}
+}
diff --git a/m4/ltp-ext-filesystem.m4 b/m4/ltp-ext-filesystem.m4
new file mode 100644
index 0000000..bbc0a54
--- /dev/null
+++ b/m4/ltp-ext-filesystem.m4
@@ -0,0 +1,38 @@
+dnl
+dnl Copyright (c) 2014 Fujitsu Ltd.
+dnl Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program;  if not, write to the Free Software
+dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+dnl
+
+dnl
+dnl LTP_CHECK_EXT_FILESYSTEM
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_EXT_FILESYSTEM],[dnl
+	AC_MSG_CHECKING([check kernel config option CONFIG_EXT4_USE_FOR_EXT23])
+
+	has_ext4_use_for_ext23=no
+	if grep "CONFIG_EXT4_USE_FOR_EXT23=y" /boot/config-$(uname -r); then
+		has_ext4_use_for_ext23=yes
+	fi
+
+	if test "$has_ext4_use_for_ext23" = "yes"; then
+		AC_DEFINE(HAVE_EXT4_USE_FOR_EXT23,1,[Define to 1 if kernel config option CONFIG_EXT4_USE_FOR_EXT23 is defined])
+		AC_MSG_RESULT(yes)
+	else
+		AC_MSG_RESULT(no)
+	fi
+])
-- 
1.8.2.1


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
