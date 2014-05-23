Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WnnkC-0006Xt-Uf
	for ltp-list@lists.sourceforge.net; Fri, 23 May 2014 11:34:36 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WnnkA-0005JH-RW
	for ltp-list@lists.sourceforge.net; Fri, 23 May 2014 11:34:36 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s4NBYMdJ028041
	for <ltp-list@lists.sourceforge.net>; Fri, 23 May 2014 19:34:22 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Fri, 23 May 2014 19:31:58 +0800
Message-ID: <1400844718-26556-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] lib: add tst_fs_link_count.c
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

We can use tst_fs_get_max_hardlinks() to get the maximum number of hard
links to one file. In its implementation, it uses link() to try to reach
the limit and will try at most 65535 times. If the EMLINK error is hit,
we think the maximum number has been reached, return this number. If some
other errors occur, we think it is infinite and returns -1.
    int tst_fs_get_max_hardlinks(void (*cleanup_fn) (void), const char *path,
        const char *dir);
Note: if @dir is NULL, we do link() in the same directory as @path, if not, we do
it in directory @dir.

If tst_fs_get_max_hardlinks() returns a valid limit, files created by link() will
not be deleted, then you can have some EMLINK test in one of these files. At last,
you can use tst_fs_get_max_hardlinks_clean() to remove the generated files.

We can also use tst_fs_max_subdirs_per_dir() to get the maximum subdirectories
in one directory. In its implementation, it uses mkdir() to try to reach
the limit and will try at most 65535 times. If the EMLINK error is hit,
we think the maximum number has been reached. If some other errors occur,
we think it is infinite and returns -1.
    int tst_fs_max_subdirs_per_dir(void (*cleanup_fn) (void), const char *dir);

If tst_fs_max_subdirs_per_dir() returns a valid limit, directories created by mkdir()
will not be deleted, then you can have some EMLINK test in @dir. At last, you can use
tst_fs_max_subdirs_per_dir_clean() to remove the generated directories.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 include/test.h          |  40 ++++++++++++
 lib/tst_fs_link_count.c | 157 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 197 insertions(+)
 create mode 100644 lib/tst_fs_link_count.c

diff --git a/include/test.h b/include/test.h
index 43fdc8b..8196f5f 100644
--- a/include/test.h
+++ b/include/test.h
@@ -321,6 +321,46 @@ const char *tst_strerrno(int err);
 int tst_path_has_mnt_flags(void (cleanup_fn)(void),
 		const char *path, const char *flags[]);
 
+/*
+ * lib/tst_fs_link_count.c
+ * Return the maximum number of hard links to @path. In its implementation,
+ * it uses link() to try to reach the limit and will try at most 65535 times.
+ * If EMLINK error is hit, we can think the maximum number has been reached,
+ * return this number. If some other errors occur, we think it is infinite
+ * and returns -1.
+ * Note: if @dir is NULL, we do link() in the same directory as @path, if not,
+ * we do it in directory @dir.
+ */
+int tst_fs_get_max_hardlinks(void (*cleanup_fn) (void), const char *path,
+	const char *dir);
+/*
+ * If tst_fs_get_max_hardlinks() returns a valid limit, files created by link()
+ * will not be deleted, then you can have some EMLINK test in one of these files.
+ * At last, you can use tst_fs_get_max_hardlinks_clean() to remove generated files.
+ * @path and @dir are same to values passed to tst_fs_get_max_hardlinks.
+ * @limit is the value returned by tst_fs_get_max_hardlinks().
+ */
+void tst_fs_get_max_hardlinks_clean(void (*cleanup_fn) (void),
+	const char *path, const char *dir, int limit);
+
+/* lib/tst_fs_link_count.c
+ * Return the maximum subdirectories in directory specified by @dir. In its
+ * implementation, it uses mkdir() to try to reach the limit and will try at most
+ * 65535 times. If EMLINK error is hit, we can think the maximum number has been
+ * reached, if some other errors occur, we think it is infinite and returns -1.
+ */
+int tst_fs_max_subdirs_per_dir(void (*cleanup_fn) (void), const char *dir);
+
+/* lib/tst_fs_link_count.c
+ * If tst_fs_max_subdirs_per_dir() returns a valid limit, directories created by
+ * mkdir() will not be deleted, then you can have some EMLINK test in @dir.
+ * At last, you can use tst_fs_max_subdirs_per_dir_clean() to remove the generated
+ * directories.
+ * @dir is same to value passed to tst_fs_max_subdirs_per_dir().
+ * @limit is the value returned by tst_fs_max_subdirs_per_dir(). 
+ */
+void tst_fs_max_subdirs_per_dir_clean(const char *dir, int limit);
+
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
 #elif  TST_USE_NEWER64_SYSCALL
diff --git a/lib/tst_fs_link_count.c b/lib/tst_fs_link_count.c
new file mode 100644
index 0000000..bce9fe65
--- /dev/null
+++ b/lib/tst_fs_link_count.c
@@ -0,0 +1,157 @@
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
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+#define MAX_SANE_HARD_LINKS	65535
+#define DIR_BASE_NAME_MAGIC	"43xlegeEmApdr23aopGzK"
+#define FILE_BASE_NAME_MAGIC	"dc4wssd490wAD383s9sfb"
+
+int tst_fs_get_max_hardlinks(void (*cleanup_fn) (void), const char *path,
+	const char *dir)
+{
+	int i, j, index = 0;
+	char filename[PATH_MAX], *pathbase, *pathdir;
+	char *pathc, *dirc;
+	struct stat s;
+
+	pathc = strdup(path);
+	dirc = strdup(path);
+
+	pathbase = SAFE_BASENAME(cleanup_fn, pathc);
+	if (dir != NULL) {
+		index = sprintf(filename, "%s/", dir);
+	} else {
+		pathdir = dirname(dirc);
+		index = sprintf(filename, "%s/", pathdir);
+	}
+
+	for (i = 1; i <= MAX_SANE_HARD_LINKS; i++) {
+		sprintf(filename + index, "%s%s%d", pathbase,
+			FILE_BASE_NAME_MAGIC, i);
+
+		if (link(path, filename) < 0) {
+			if (errno == EMLINK) {
+				SAFE_STAT(cleanup_fn, path, &s);
+				tst_resm(TINFO, "the maximum number of hard "
+					 "links to %s is hit: %d",
+					 path, (int)s.st_nlink);
+				return s.st_nlink;
+			} else {
+				fprintf(stderr, "link(%s, %s) failed:%s\n",
+					path, filename, strerror(errno));
+				goto max_hardlinks_cleanup;
+			}
+		}
+
+	}
+
+max_hardlinks_cleanup:
+	for (j = 1; j < i; j++) {
+		sprintf(filename + index, "%s%s%d", pathbase,
+			FILE_BASE_NAME_MAGIC, j);
+		if (unlink(filename) < 0 && errno != ENOENT) {
+			fprintf(stderr, "unlink(%s) failed: %s", filename,
+				strerror(errno));
+		}
+	}
+
+	return -1;
+}
+
+void tst_fs_get_max_hardlinks_clean(void (*cleanup_fn) (void), const char *path,
+	const char *dir, int limit)
+{
+	int i, index = 0;
+	char filename[PATH_MAX], *pathbase, *pathdir;
+	char *pathc, *dirc;
+
+	pathc = strdup(path);
+	dirc = strdup(path);
+
+	pathbase = SAFE_BASENAME(cleanup_fn, pathc);
+	if (dir != NULL) {
+		index = sprintf(filename, "%s/", dir);
+	} else {
+		pathdir = dirname(dirc);
+		index = sprintf(filename, "%s/", pathdir);
+	}
+
+	for (i = 1; i < limit; i++) {
+		sprintf(filename + index, "%s%s%d", pathbase,
+			FILE_BASE_NAME_MAGIC, i);
+		if (unlink(filename) < 0 && errno != ENOENT) {
+			fprintf(stderr, "unlink(%s) failed: %s", filename,
+				strerror(errno));
+		}
+	}
+}
+
+int tst_fs_max_subdirs_per_dir(void (*cleanup_fn) (void), const char *dir)
+{
+	int i, j;
+	char dirname[PATH_MAX];
+	struct stat s;
+
+	for (i = 1; i <= MAX_SANE_HARD_LINKS; i++) {
+		sprintf(dirname, "%s/%s%d", dir, DIR_BASE_NAME_MAGIC, i);
+
+		if (mkdir(dirname, 0755) < 0) {
+			if (errno == EMLINK) {
+				SAFE_STAT(cleanup_fn, dir, &s);
+				tst_resm(TINFO, "the maximum subdirectories in "
+					 "%s is hit: %d", dir, (int)s.st_nlink);
+				return s.st_nlink;
+			} else {
+				fprintf(stderr, "mkdir(%s, 0755) failed: %s\n",
+					dirname, strerror(errno));
+				goto max_subdirs_cleanup;
+			}
+		}
+
+	}
+
+max_subdirs_cleanup:
+	for (j = 1; j < i; j++) {
+		sprintf(dirname, "%s/%s%d", dir, DIR_BASE_NAME_MAGIC, j);
+		 if (rmdir(dirname) < 0 && errno != ENOENT) {
+			fprintf(stderr, "rmdir(%s) failed: %s", dirname,
+				strerror(errno));
+		}
+	}
+
+	return -1;
+}
+
+void tst_fs_max_subdirs_per_dir_clean(const char *dir, int limit)
+{
+	int i;
+	char dirname[PATH_MAX];
+
+	for (i = 1; i < limit; i++) {
+		sprintf(dirname, "%s/%s%d", dir, DIR_BASE_NAME_MAGIC, i);
+		if (rmdir(dirname) < 0 && errno != ENOENT) {
+			fprintf(stderr, "rmdir(%s) failed: %s", dirname,
+				strerror(errno));
+		}
+	}
+}
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
