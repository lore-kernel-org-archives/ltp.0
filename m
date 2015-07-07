Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fenggw-fnst@cn.fujitsu.com>) id 1ZCHG4-0005rx-OF
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2015 01:01:12 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZCHG1-0000pz-Qg
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2015 01:01:12 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t670xL8T010530
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2015 08:59:21 +0800
From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 7 Jul 2015 09:01:20 +0800
Message-ID: <1436230882-3282-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/3] umount2/umount2_01.c: add new test
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

Add new testcase to verify the flag MNT_DETACH of umount2(2).

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 include/lapi/umount.h                          |  34 +++++
 runtest/ltplite                                |   2 +
 runtest/syscalls                               |   2 +
 testcases/kernel/syscalls/.gitignore           |   1 +
 testcases/kernel/syscalls/umount2/Makefile     |  23 ++++
 testcases/kernel/syscalls/umount2/umount2_01.c | 176 +++++++++++++++++++++++++
 6 files changed, 238 insertions(+)
 create mode 100644 include/lapi/umount.h
 create mode 100644 testcases/kernel/syscalls/umount2/Makefile
 create mode 100644 testcases/kernel/syscalls/umount2/umount2_01.c

diff --git a/include/lapi/umount.h b/include/lapi/umount.h
new file mode 100644
index 0000000..67858e1
--- /dev/null
+++ b/include/lapi/umount.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (c) 2015 Fujitsu Ltd.
+ * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
+ */
+
+#ifndef __LAPI_UMOUNT_H__
+#define __LAPI_UMOUNT_H__
+
+#ifndef MNT_DETACH
+#define MNT_DETACH 2
+#endif
+
+#ifndef MNT_EXPIRE
+#define MNT_EXPIRE 4
+#endif
+
+#ifndef UMOUNT_NOFOLLOW
+#define UMOUNT_NOFOLLOW 8
+#endif
+
+#endif /* __LAPI_UMOUNT_H__ */
diff --git a/runtest/ltplite b/runtest/ltplite
index 3bc681c..5f8ef8c 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -965,6 +965,8 @@ unlink08 unlink08
 #umount02 umount02 -D /dev/...
 #umount03 umount03 -D /dev/...
 
+umount2_01 umount2_01
+
 ustat01 ustat01
 ustat02 ustat02
 
diff --git a/runtest/syscalls b/runtest/syscalls
index 70d4945..762730f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1314,6 +1314,8 @@ umount01 umount01
 umount02 umount02
 umount03 umount03
 
+umount2_01 umount2_01
+
 ustat01 ustat01
 ustat02 ustat02
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 172aeec..542ec3b 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -1002,6 +1002,7 @@
 /umount/umount01
 /umount/umount02
 /umount/umount03
+/umount2/umount2_01
 /uname/uname01
 /uname/uname02
 /uname/uname03
diff --git a/testcases/kernel/syscalls/umount2/Makefile b/testcases/kernel/syscalls/umount2/Makefile
new file mode 100644
index 0000000..bbf0541
--- /dev/null
+++ b/testcases/kernel/syscalls/umount2/Makefile
@@ -0,0 +1,23 @@
+#
+#  Copyright (c) 2015 Fujitsu Ltd.
+#  Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
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
+#  You should have received a copy of the GNU General Public License
+#  along with this program.
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/umount2/umount2_01.c b/testcases/kernel/syscalls/umount2/umount2_01.c
new file mode 100644
index 0000000..7c59c06
--- /dev/null
+++ b/testcases/kernel/syscalls/umount2/umount2_01.c
@@ -0,0 +1,176 @@
+/*
+ * Copyright (c) 2015 Fujitsu Ltd.
+ * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License
+ * alone with this program.
+ */
+
+/*
+ * DESCRIPTION
+ *  Test for feature MNT_DETACH of umount2().
+ *  "Perform a lazy unmount: make the mount point unavailable for
+ *   new accesses, and actually perform the unmount when the mount
+ *   point ceases to be busy."
+ */
+
+#include <errno.h>
+#include <sys/mount.h>
+
+#include "test.h"
+#include "safe_macros.h"
+#include "lapi/umount.h"
+
+static void setup(void);
+static void umount2_verify(void);
+static void cleanup(void);
+
+char *TCID = "umount2_01";
+int TST_TOTAL = 1;
+
+#define DIR_MODE	(S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH)
+#define FILE_MODE	(S_IRWXU | S_IRWXG | S_IRWXO | S_ISUID | S_ISGID)
+#define MNTPOINT	"mntpoint"
+
+static int fd;
+static int fd_new;
+static int mount_flag;
+
+static char buf[256];
+
+static const char *device;
+static const char *fs_type;
+static const char *str = "abcdefghijklmnopqrstuvwxyz";
+
+int main(int ac, char **av)
+{
+	int lc;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		umount2_verify();
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_require_root(NULL);
+
+	tst_sig(NOFORK, DEF_HANDLER, NULL);
+
+	tst_tmpdir();
+
+	fs_type = tst_dev_fs_type();
+	device = tst_acquire_device(cleanup);
+
+	if (!device)
+		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
+
+	tst_mkfs(cleanup, device, fs_type, NULL);
+
+	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
+
+	TEST_PAUSE;
+}
+
+static void umount2_verify(void)
+{
+	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
+	mount_flag = 1;
+
+	fd = SAFE_CREAT(cleanup, MNTPOINT "/file", FILE_MODE);
+
+	do {
+		TEST(umount2(MNTPOINT, MNT_DETACH));
+
+		if (TEST_RETURN != 0) {
+			tst_resm(TFAIL, "umount2(2) Failed while "
+				"unmounting %s errno = %d : %s",
+				MNTPOINT, TEST_ERRNO,
+				strerror(TEST_ERRNO));
+			break;
+		}
+
+		mount_flag = 0;
+
+		/* check the unavailability for new access */
+		fd_new = open(MNTPOINT "/file", O_RDONLY);
+
+		if (fd_new != -1) {
+			tst_resm(TFAIL, "umount2(2) MNT_DETACH flag "
+				"performed abnormally "
+				"expected error = %d : %s",
+				ENOENT, strerror(ENOENT));
+			break;
+		}
+
+		/*
+		 * check the old fd still points to the file
+		 * in previous mount point and is available
+		 */
+		SAFE_WRITE(cleanup, 0, fd, str, strlen(str));
+
+		SAFE_CLOSE(cleanup, fd);
+
+		SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
+		mount_flag = 1;
+
+		fd = SAFE_OPEN(cleanup, MNTPOINT "/file", O_RDONLY);
+
+		SAFE_READ(cleanup, 0, fd, buf, 255);
+
+		if (strcmp(str, buf)) {
+			tst_resm(TFAIL, "umount2(2) MNT_DETACH flag "
+				"performed abnormally");
+			break;
+		}
+
+		tst_resm(TPASS, "umount2(2) Passed");
+	} while (0);
+
+	if (fd_new > 0) {
+		SAFE_CLOSE(cleanup, fd_new);
+		fd_new = 0;
+	}
+
+	SAFE_CLOSE(cleanup, fd);
+	fd = 0;
+
+	if (mount_flag) {
+		SAFE_UMOUNT(cleanup, MNTPOINT);
+		mount_flag = 0;
+	}
+}
+
+static void cleanup(void)
+{
+	if (fd_new > 0 && close(fd_new))
+		tst_resm(TWARN | TERRNO, "Failed to close file");
+
+	if (fd > 0 && close(fd))
+		tst_resm(TWARN | TERRNO, "Failed to close file");
+
+	if (mount_flag && tst_umount(MNTPOINT))
+		tst_resm(TWARN | TERRNO, "Failed to unmount");
+
+	if (device)
+		tst_release_device(NULL, device);
+
+	tst_rmdir();
+}
-- 
1.8.4.2


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
