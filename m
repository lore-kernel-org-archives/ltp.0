Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WdVV6-0008U5-Jc
	for ltp-list@lists.sourceforge.net; Fri, 25 Apr 2014 02:04:28 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WdVV4-0002fq-6e
	for ltp-list@lists.sourceforge.net; Fri, 25 Apr 2014 02:04:28 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s3P24Fic032479
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Apr 2014 10:04:15 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Fri, 25 Apr 2014 10:02:07 +0800
Message-ID: <1398391328-13711-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 1/2] lib/tst_fs_has_free.c: add tst_fs_has_free()
	to determine filesystem's free space
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

The existing lib/tst_cwd_has_free.c only determines the filesystem, which
the current directory is in. And I think tst_cwd_has_free() is not entirely
correct. See this code in tst_cwd_has_free():
	return ((float)sf.f_bfree) / (1024 / sf.f_bsize) >=
		 required_kib ? 1 : 0;
if sf.f_bsize is greater than 1024, this code is wrong.

I choose to remove tst_cwd_has_free.c and add lib/tst_fs_has_free.c.
The prototype is below:
	int tst_fs_has_free(void (*cleanup)(void), const char *path,
		unsigned int size, unsigned int mult);

User can specify the path to determine the corresponding filesystem.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 include/test.h                                | 17 +++++++++--
 lib/tst_cwd_has_free.c                        | 22 --------------
 lib/tst_fs_has_free.c                         | 42 +++++++++++++++++++++++++++
 testcases/kernel/syscalls/swapoff/swapoff01.c |  2 +-
 testcases/kernel/syscalls/swapoff/swapoff02.c |  2 +-
 testcases/kernel/syscalls/swapon/libswapon.c  |  3 +-
 6 files changed, 61 insertions(+), 27 deletions(-)
 delete mode 100644 lib/tst_cwd_has_free.c
 create mode 100644 lib/tst_fs_has_free.c

diff --git a/include/test.h b/include/test.h
index f5c602b..558575c 100644
--- a/include/test.h
+++ b/include/test.h
@@ -39,6 +39,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <stdlib.h>
+#include <stdint.h>
 
 #include "compiler.h"
 
@@ -204,8 +205,20 @@ struct tst_kern_exv {
 
 int tst_kvercmp2(int r1, int r2, int r3, struct tst_kern_exv *vers);
 
-/* lib/tst_cwd_has_free.c */
-int tst_cwd_has_free(int required_kib);
+enum {
+	TST_KB = 1024,
+	TST_MB = 1048576,
+	TST_GB = 1073741824,
+};
+
+/* lib/tst_fs_has_free.c
+ *
+ * @path: path is the pathname of any file within the mounted file system
+ * @mult: mult should be TST_KB, TST_MB or TST_GB
+ * the required free space is calculated by @size * @mult
+ */
+int tst_fs_has_free(void (*cleanup)(void), const char *path,
+		    unsigned int size, unsigned int mult);
 
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
index 0000000..9a84e45
--- /dev/null
+++ b/lib/tst_fs_has_free.c
@@ -0,0 +1,42 @@
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
+#include <stdint.h>
+#include <sys/vfs.h>
+#include "test.h"
+
+int tst_fs_has_free(void (*cleanup)(void), const char *path,
+		    unsigned int size, unsigned int mult)
+{
+	struct statfs sf;
+
+	if (statfs(path, &sf)) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "tst_fs_has_free: failed to statfs(%s)", path);
+	}
+
+	if ((uint64_t)sf.f_bfree * sf.f_bsize > (uint64_t)size * mult)
+		return 1;
+	else
+		return 0;
+}
diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index b4d19de..96b52ae 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -99,7 +99,7 @@ static void setup(void)
 	break;
 	}
 
-	if (!tst_cwd_has_free(65536)) {
+	if (!tst_fs_has_free(NULL, ".", 64, TST_KB)) {
 		tst_brkm(TBROK, cleanup,
 			 "Insufficient disk space to create swap file");
 	}
diff --git a/testcases/kernel/syscalls/swapoff/swapoff02.c b/testcases/kernel/syscalls/swapoff/swapoff02.c
index 978dc01..f5929cc 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff02.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff02.c
@@ -157,7 +157,7 @@ static void setup(void)
 	break;
 	}
 
-	if (!tst_cwd_has_free(1)) {
+	if (!tst_fs_has_free(NULL, ".", 1, TST_KB)) {
 		tst_brkm(TBROK, cleanup,
 			 "Insufficient disk space to create swap file");
 	}
diff --git a/testcases/kernel/syscalls/swapon/libswapon.c b/testcases/kernel/syscalls/swapon/libswapon.c
index 8eca7dc..4c5f045 100644
--- a/testcases/kernel/syscalls/swapon/libswapon.c
+++ b/testcases/kernel/syscalls/swapon/libswapon.c
@@ -27,7 +27,8 @@
  */
 void make_swapfile(void (cleanup)(void), const char *swapfile)
 {
-	if (!tst_cwd_has_free(sysconf(_SC_PAGESIZE)*10)) {
+	if (!tst_fs_has_free(NULL, ".", sysconf(_SC_PAGESIZE) * 10 / TST_KB,
+	    TST_KB)) {
 		tst_brkm(TBROK, cleanup,
 			"Insufficient disk space to create swap file");
 	}
-- 
1.8.2.1


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
