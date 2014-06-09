Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WtuBW-0003D3-HS
	for ltp-list@lists.sourceforge.net; Mon, 09 Jun 2014 07:40:02 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WtuBS-0007EP-L0
	for ltp-list@lists.sourceforge.net; Mon, 09 Jun 2014 07:40:01 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s597dpbh008666
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Jun 2014 15:39:51 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Mon, 9 Jun 2014 15:37:10 +0800
Message-ID: <1402299431-2045-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 1/2] lib: add tst_fs_link_count.c
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

Add two test interfaces:
int tst_fs_fill_hardlinks(void (*cleanup) (void), const char *dir);
We can use tst_fs_fill_hardlinks() to get maximum number of hard links to
regular file in a mounted file system, which @dir is in.

int tst_fs_fill_subdirs(void (*cleanup) (void), const char *dir);
We can use tst_fs_fill_subdirs() to get maximum number of subdirectories
under directory @dir in a mounted file system.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 include/test.h          |  34 ++++++++++++
 lib/tst_fs_link_count.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+)
 create mode 100644 lib/tst_fs_link_count.c

diff --git a/include/test.h b/include/test.h
index 43fdc8b..348e5f4 100644
--- a/include/test.h
+++ b/include/test.h
@@ -321,6 +321,40 @@ const char *tst_strerrno(int err);
 int tst_path_has_mnt_flags(void (cleanup_fn)(void),
 		const char *path, const char *flags[]);
 
+/*
+ * lib/tst_fs_link_count.c
+ * Try to get maximum number of hard links to regular file in a mounted file
+ * system, which @dir is in.
+ * In its implementation, it uses link(2) to create hard links to a same file,
+ * try to reach the limit and will try at most 65535 times. If EMLINK is hit,
+ * we can think that the maximum number has been reached, return this number.
+ * Meanwhile under directory @dir: there will be numbers of files, which will
+ * point to the same inode on disk. Like below:
+ * testfile1, testfile2, testfile3, ..., testfile${returned number}.
+ * If some errors(ENOSPC, EDQUOT) occur or no error at all, we can think that
+ * the maximum number of hard links is infinite or not reachable because of
+ * filesystem's free space, for this case, return 0.
+ * If some other errors occur, we call tst_brkm(TBROK, ...).
+ */
+int tst_fs_fill_hardlinks(void (*cleanup) (void), const char *dir);
+
+/*
+ * lib/tst_fs_link_count.c
+ * Try to get maximum number of subdirectories under directory @dir in a
+ * mounted file system.
+ * In its implementation, it uses mkdir(2) to create numbers of subdirectories
+ * in @dir, try to reach the limit and will try at most 65535 times. If EMLINK
+ * is hit, we can think the maximum number has been reached, return this number.
+ * Meanwhile under directory @dir: there will be numbers of subdirectories,
+ * Like below:
+ * testdir1, testdir2, testdir3, ..., testdir${returned number}.
+ * If some errors(ENOSPC, EDQUOT) occur or no errors at all, we can think that
+ * the maximum number of subdirectories is infinite or not reachable because
+ * of filesystem's free space, for this case, return 0.
+ * If some other errors occur, we call tst_brkm(TBROK, ...).
+ */
+int tst_fs_fill_subdirs(void (*cleanup) (void), const char *dir);
+
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
 #elif  TST_USE_NEWER64_SYSCALL
diff --git a/lib/tst_fs_link_count.c b/lib/tst_fs_link_count.c
new file mode 100644
index 0000000..720d9b7
--- /dev/null
+++ b/lib/tst_fs_link_count.c
@@ -0,0 +1,136 @@
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
+#include <string.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+#define MAX_SANE_HARD_LINKS	65535
+
+int tst_fs_fill_hardlinks(void (*cleanup) (void), const char *dir)
+{
+	unsigned int i, j;
+	char base_filename[PATH_MAX], link_filename[PATH_MAX];
+	struct stat s;
+
+	SAFE_STAT(cleanup, dir, &s);
+	if ((s.st_mode & S_IFMT) != S_IFDIR)
+		tst_brkm(TBROK, cleanup, "%s is not directory", dir);
+
+	sprintf(base_filename, "%s/testfile1", dir);
+	SAFE_TOUCH(cleanup, base_filename, 0644, NULL);
+
+	for (i = 2; i <= MAX_SANE_HARD_LINKS; i++) {
+		sprintf(link_filename, "%s/testfile%d", dir, i);
+
+		if (link(base_filename, link_filename) == 0)
+			continue;
+
+		switch (errno) {
+		case EMLINK:
+			SAFE_STAT(cleanup, base_filename, &s);
+			if (s.st_nlink != (i - 1)) {
+				tst_brkm(TBROK, cleanup, "wrong number of "
+					 "hard links for %s have %i, should be"
+					 " %d", base_filename,
+					 (int)s.st_nlink, i - 1);
+			} else {
+				tst_resm(TINFO, "the maximum number of hard "
+					 "links to %s is hit: %d",
+					 base_filename, (int)s.st_nlink);
+				return s.st_nlink;
+			}
+		case ENOSPC:
+		case EDQUOT:
+			fprintf(stderr, "link(%s, %s) failed:%s\n",
+				base_filename, link_filename,
+				strerror(errno));
+			goto max_hardlinks_cleanup;
+		default:
+			tst_brkm(TBROK, cleanup, "link(%s, %s) failed"
+				 "unexpectedly: %s", base_filename,
+				 link_filename, strerror(errno));
+		}
+	}
+
+max_hardlinks_cleanup:
+	for (j = 1; j < i; j++) {
+		sprintf(link_filename, "%s/testfile%d", dir, j);
+		SAFE_UNLINK(cleanup, link_filename);
+	}
+
+	return 0;
+}
+
+int tst_fs_fill_subdirs(void (*cleanup) (void), const char *dir)
+{
+	unsigned int i, j;
+	char dirname[PATH_MAX];
+	struct stat s;
+
+	SAFE_STAT(cleanup, dir, &s);
+	if ((s.st_mode & S_IFMT) != S_IFDIR)
+		tst_brkm(TBROK, cleanup, "%s is not directory", dir);
+
+	for (i = 1; i <= MAX_SANE_HARD_LINKS; i++) {
+		sprintf(dirname, "%s/testdir%d", dir, i);
+
+		if (mkdir(dirname, 0755) == 0)
+			continue;
+
+		switch (errno) {
+		case EMLINK:
+			SAFE_STAT(cleanup, dir, &s);
+			/*
+			 * here i+1 is calculated by i-1+2(contain '.' and dir)
+			 */
+			if (s.st_nlink != (i + 1)) {
+				tst_brkm(TBROK, cleanup, "%s link counts have"
+					 "%d, should be %d", dir,
+					 (int)s.st_nlink, i + 1);
+			} else {
+				tst_resm(TINFO, "the maximum subdirectories in "
+				 "%s is hit: %d", dir, (int)s.st_nlink);
+				return s.st_nlink;
+			}
+		case ENOSPC:
+		case EDQUOT:
+			fprintf(stderr, "mkdir(%s, 0755) failed: %s\n",
+				dirname, strerror(errno));
+			goto max_subdirs_cleanup;
+		default:
+			tst_brkm(TBROK, cleanup, "mkdir(%s, 0755) failed"
+				 "unexpectedly: %s", dirname,
+				 strerror(errno));
+		}
+
+	}
+
+max_subdirs_cleanup:
+	for (j = 1; j < i; j++) {
+		sprintf(dirname, "%s/testdir%d", dir, j);
+		SAFE_RMDIR(cleanup, dirname);
+	}
+
+	return 0;
+}
-- 
1.8.2.1


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://www.hpccsystems.com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
