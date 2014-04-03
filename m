Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1WVgKH-0000hs-FM
	for ltp-list@lists.sourceforge.net; Thu, 03 Apr 2014 12:00:57 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WVgKE-00069U-U2
	for ltp-list@lists.sourceforge.net; Thu, 03 Apr 2014 12:00:57 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s33C0jPb013738
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Apr 2014 20:00:45 +0800
From: "gux.fnst@cn.fujitsu.com" <gux.fnst@cn.fujitsu.com>
Date: Thu, 3 Apr 2014 12:00:44 +0000
Message-ID: <1396526450-22885-1-git-send-email-gux.fnst@cn.fujitsu.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 1/2] lib/tst_path_has_mnt_flags.c: create a
 function tst_path_has_mnt_flags()
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Create a function tst_path_has_mnt_flags() for checking whether
a path is on a system that is mounted with specified flags.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 include/test.h               |  9 ++++
 lib/tst_path_has_mnt_flags.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 lib/tst_path_has_mnt_flags.c

diff --git a/include/test.h b/include/test.h
index baa3ef6..39bc5a1 100644
--- a/include/test.h
+++ b/include/test.h
@@ -295,6 +295,15 @@ gid_t tst_get_unused_gid(void);
 unsigned short tst_get_unused_port(void (cleanup_fn)(void),
 	unsigned short family, int type);
 
+/* lib/tst_path_has_mnt_flags.c
+ *
+ * Check whether a path is on a filesystem that is mounted with
+ * specified flags.
+ * @path: path to file
+ * @flags: mount flags
+ */
+int tst_path_has_mnt_flags(const char *path, const char *flags[]);
+
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
 #elif  TST_USE_NEWER64_SYSCALL
diff --git a/lib/tst_path_has_mnt_flags.c b/lib/tst_path_has_mnt_flags.c
new file mode 100644
index 0000000..257b8a4
--- /dev/null
+++ b/lib/tst_path_has_mnt_flags.c
@@ -0,0 +1,99 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Xing Gu <gux.fnst@cn.fujitsu.com>
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
+#include <unistd.h>
+#include <mntent.h>
+#include "test.h"
+
+/*
+ * Returns if prefix is prefix of a string and the lenght of prefix.
+ */
+int strpref(const char *str, const char *pref)
+{
+	int i;
+
+	for (i = 0; pref[i] != '\0'; i++) {
+		/* string ended too soon */
+		if (str[i] == 0)
+			return -1;
+
+		/* string is diferent */
+		if (str[i] != pref[i])
+			return -1;
+	}
+
+	/* returns lenght of prefix */
+	return i;
+}
+
+/*
+ * Check whether a path is on a filesystem that is mounted with
+ * specified flags.
+ *
+ * Returns:
+ *   -1 - an error has occurred
+ *   0 - the filesystem does not have any specified flags
+ *   1 - the filesystem has at least one flag matched
+ */
+int tst_path_has_mnt_flags(const char *path, const char *flags[])
+{
+	struct mntent *mnt;
+	int prefix_max = 0, prefix;
+	int has_flags = 0, has_opt;
+	FILE *f;
+	int i;
+
+	if (path == NULL) {
+		printf("The path is NULL.\n");
+		return -1;
+	}
+
+	if (access(path, F_OK) == -1) {
+		printf("The path %s doesn't exist.\n", path);
+		return -1;
+	}
+
+	f = setmntent("/proc/mounts", "r");
+
+	if (f == NULL) {
+		printf("Couldn't mount /proc/mounts.\n");
+		return -1;
+	}
+
+	while ((mnt = getmntent(f))) {
+		/* ignore all pseudo fs */
+		if (mnt->mnt_fsname[0] != '/')
+			continue;
+
+		prefix = strpref(path, mnt->mnt_dir);
+
+		if (prefix > prefix_max) {
+			prefix_max = prefix;
+			has_opt = 0;
+			i = 0;
+			while ((has_opt == 0) && (flags[i] != NULL)) {
+				has_opt = hasmntopt(mnt, flags[i]) != NULL;
+				i++;
+			}
+			has_flags = has_opt;
+		}
+	}
+
+	endmntent(f);
+
+	return has_flags;
+}
-- 
1.8.3.1
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
