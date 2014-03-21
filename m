Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WQza8-0003Et-11
	for ltp-list@lists.sourceforge.net; Fri, 21 Mar 2014 13:33:56 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WQza5-0005jA-K5
	for ltp-list@lists.sourceforge.net; Fri, 21 Mar 2014 13:33:55 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s2LDXegY003865
	for <ltp-list@lists.sourceforge.net>; Fri, 21 Mar 2014 21:33:42 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Fri, 21 Mar 2014 19:43:59 +0800
Message-Id: <1395402240-6619-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1395402240-6619-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1395402240-6619-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH 1/2] lib/tst_fs_has_free.c: add tst_fs_has_free() to
	determine filesystem's free space
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

The existing lib/tst_cwd_has_free.c only determines the filesystem, which
the current directory is in. And I think tst_cwd_has_free() is not entirely
correct. See this code in tst_cwd_has_free():
	return ((float)sf.f_bfree) / (1024 / sf.f_bsize) >=
		 required_kib ? 1 : 0;
if sf.f_bsize is greater than 1024, this code is wrong.

I choose to remove tst_cwd_has_free.c and add lib/tst_fs_has_free.c.
The prototype is below:
	int tst_fs_has_free(void (*cleanup)(void), const char *path,
			    int required_kib)
User can specify the path to determine the corresponding filesystem.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 include/test.h                                |  8 ++++--
 lib/tst_cwd_has_free.c                        | 22 ----------------
 lib/tst_fs_has_free.c                         | 37 +++++++++++++++++++++++++++
 testcases/kernel/syscalls/swapoff/swapoff01.c |  2 +-
 testcases/kernel/syscalls/swapoff/swapoff02.c |  2 +-
 testcases/kernel/syscalls/swapon/libswapon.c  |  2 +-
 6 files changed, 46 insertions(+), 27 deletions(-)
 delete mode 100644 lib/tst_cwd_has_free.c
 create mode 100644 lib/tst_fs_has_free.c

diff --git a/include/test.h b/include/test.h
index 32b9680..ce7e0a6 100644
--- a/include/test.h
+++ b/include/test.h
@@ -204,8 +204,12 @@ struct tst_kern_exv {
 
 int tst_kvercmp2(int r1, int r2, int r3, struct tst_kern_exv *vers);
 
-/* lib/tst_cwd_has_free.c */
-int tst_cwd_has_free(int required_kib);
+/* lib/tst_fs_has_free.c
+ *
+ * @path: path is the pathname of any file within the mounted file system
+ * @required_kib: the required free space(count in KB)
+ */
+int tst_fs_has_free(void (*cleanup)(void), const char *path, int required_kib);
 
 int tst_is_virt(int virt_type);
 
diff --git a/lib/tst_cwd_has_free.c b/lib/tst_cwd_has_free.c
deleted file mode 100644
index e44c31f..0000000
--- a/lib/tst_cwd_has_free.c
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- *    AUTHOR
- *    	Ricky Ng-Adam <rngadam@yahoo.com>, 2005-01-01
- *
- *    DESCRIPTION
- * 	Check if there is enough blocks to fill number of KiB specified
- * 	If current directory has enough blocks, return 1
- * 	If current directory has NOT enough blocks, return 0
- *
- *
- */
-#include <sys/vfs.h>
-
-int tst_cwd_has_free(int required_kib)
-{
-	struct statfs sf;
-	statfs(".", &sf);
-
-	/* check that we have enough blocks to create swap file */
-	return ((float)sf.f_bfree) / (1024 / sf.f_bsize) >=
-	    required_kib ? 1 : 0;
-}
diff --git a/lib/tst_fs_has_free.c b/lib/tst_fs_has_free.c
new file mode 100644
index 0000000..ba14912
--- /dev/null
+++ b/lib/tst_fs_has_free.c
@@ -0,0 +1,37 @@
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
+/*
+ * DESCRIPTION
+ * 	Check if the mounted file system has enough free space,
+ * 	if it is, tst_fs_has_free() returns 1, otherwise 0.
+ */
+
+#include <sys/vfs.h>
+#include "test.h"
+
+int tst_fs_has_free(void (*cleanup)(void), const char *path, int required_kib)
+{
+	struct statfs sf;
+
+	if (statfs(path, &sf)) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "tst_fs_has_free: failed to statfs(%s)", path);
+	}
+
+	return (sf.f_bfree * sf.f_bsize / 1024) >= required_kib ? 1 : 0;
+}
diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index b4d19de..8d1c435 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -99,7 +99,7 @@ static void setup(void)
 	break;
 	}
 
-	if (!tst_cwd_has_free(65536)) {
+	if (!tst_fs_has_free(NULL, ".", 65536)) {
 		tst_brkm(TBROK, cleanup,
 			 "Insufficient disk space to create swap file");
 	}
diff --git a/testcases/kernel/syscalls/swapoff/swapoff02.c b/testcases/kernel/syscalls/swapoff/swapoff02.c
index 978dc01..fb1f6f8 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff02.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff02.c
@@ -157,7 +157,7 @@ static void setup(void)
 	break;
 	}
 
-	if (!tst_cwd_has_free(1)) {
+	if (!tst_fs_has_free(NULL, ".", 1)) {
 		tst_brkm(TBROK, cleanup,
 			 "Insufficient disk space to create swap file");
 	}
diff --git a/testcases/kernel/syscalls/swapon/libswapon.c b/testcases/kernel/syscalls/swapon/libswapon.c
index 8eca7dc..ffb23a8 100644
--- a/testcases/kernel/syscalls/swapon/libswapon.c
+++ b/testcases/kernel/syscalls/swapon/libswapon.c
@@ -27,7 +27,7 @@
  */
 void make_swapfile(void (cleanup)(void), const char *swapfile)
 {
-	if (!tst_cwd_has_free(sysconf(_SC_PAGESIZE)*10)) {
+	if (!tst_fs_has_free(NULL, ".", sysconf(_SC_PAGESIZE)*10)) {
 		tst_brkm(TBROK, cleanup,
 			"Insufficient disk space to create swap file");
 	}
-- 
1.8.2.1


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
