Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1WiL0G-0005QN-ES
	for ltp-list@lists.sourceforge.net; Thu, 08 May 2014 09:52:36 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WiL0F-0005WO-Gg
	for ltp-list@lists.sourceforge.net; Thu, 08 May 2014 09:52:36 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s489qQ8M018295
	for <ltp-list@lists.sourceforge.net>; Thu, 8 May 2014 17:52:27 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Thu, 8 May 2014 17:50:51 +0800
Message-ID: <1399542652-5795-1-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1396526450-22885-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1396526450-22885-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v5 1/2] lib/tst_path_has_mnt_flags.c: create a
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
To: ltp-list@lists.sourceforge.net

From: "gux.fnst@cn.fujitsu.com" <gux.fnst@cn.fujitsu.com>

Create a function tst_path_has_mnt_flags() for checking whether
a path is on a system that is mounted with specified flags.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 include/test.h               | 12 ++++++++
 lib/tst_path_has_mnt_flags.c | 71 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 lib/tst_path_has_mnt_flags.c

diff --git a/include/test.h b/include/test.h
index e32481c..be46674 100644
--- a/include/test.h
+++ b/include/test.h
@@ -302,6 +302,18 @@ int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount);
 unsigned short tst_get_unused_port(void (cleanup_fn)(void),
 	unsigned short family, int type);
 
+/* lib/tst_path_has_mnt_flags.c
+ *
+ * Check whether a path is on a filesystem that is mounted with
+ * specified flags
+ * @path: path to file
+ * @flags: NULL or NULL terminated array of mount flags
+ *
+ * Return: 0..n - number of flags matched
+ */
+int tst_path_has_mnt_flags(void (cleanup_fn)(void),
+		const char *path, const char *flags[]);
+
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
 #elif  TST_USE_NEWER64_SYSCALL
diff --git a/lib/tst_path_has_mnt_flags.c b/lib/tst_path_has_mnt_flags.c
new file mode 100644
index 0000000..031e225
--- /dev/null
+++ b/lib/tst_path_has_mnt_flags.c
@@ -0,0 +1,71 @@
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
+#include <stdio.h>
+#include <string.h>
+#include "test.h"
+
+/*
+ * Check whether a path is on a filesystem that is mounted with
+ * specified flags.
+ */
+int tst_path_has_mnt_flags(void (cleanup_fn)(void),
+		const char *path, const char *flags[])
+{
+	struct mntent *mnt;
+	size_t prefix_max = 0, prefix_len;
+	int flags_matched = 0;
+	FILE *f;
+	int i;
+
+	if (access(path, F_OK) == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			"tst_path_has_mnt_flags: path %s doesn't exist", path);
+	}
+
+	f = setmntent("/proc/mounts", "r");
+	if (f == NULL) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			"tst_path_has_mnt_flags: failed to open /proc/mounts");
+	}
+
+	while ((mnt = getmntent(f))) {
+		/* ignore all pseudo fs */
+		if (mnt->mnt_fsname[0] != '/')
+			continue;
+
+		prefix_len = strlen(mnt->mnt_dir);
+
+		if (strncmp(path, mnt->mnt_dir, prefix_len) == 0
+				&& prefix_len > prefix_max) {
+			prefix_max = prefix_len;
+			flags_matched = 0;
+			i = 0;
+			while (flags[i] != NULL) {
+				if (hasmntopt(mnt, flags[i]) != NULL)
+					flags_matched++;
+				i++;
+			}
+		}
+	}
+
+	endmntent(f);
+
+	return flags_matched;
+}
-- 
1.9.0


------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
