Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fenggw-fnst@cn.fujitsu.com>) id 1ZFIAr-0002bX-Kd
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2015 08:36:17 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZFIAp-0002IA-PL
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2015 08:36:17 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t6F8YMvU027519
	for <ltp-list@lists.sourceforge.net>; Wed, 15 Jul 2015 16:34:22 +0800
From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 15 Jul 2015 16:36:02 +0800
Message-ID: <1436949363-8356-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
In-Reply-To: <1436949363-8356-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1436949363-8356-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 2/3] umount2/umount2_02.c: add new test
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

Add new testcase to verify the flag MNT_EXPIRE of umount2(2).

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/ltplite                                |   1 +
 runtest/syscalls                               |   1 +
 testcases/kernel/syscalls/.gitignore           |   1 +
 testcases/kernel/syscalls/umount2/umount2_02.c | 202 +++++++++++++++++++++++++
 4 files changed, 205 insertions(+)
 create mode 100644 testcases/kernel/syscalls/umount2/umount2_02.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 5f8ef8c..f5a8a52 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -966,6 +966,7 @@ unlink08 unlink08
 #umount03 umount03 -D /dev/...
 
 umount2_01 umount2_01
+umount2_02 umount2_02
 
 ustat01 ustat01
 ustat02 ustat02
diff --git a/runtest/syscalls b/runtest/syscalls
index 762730f..92716d2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1315,6 +1315,7 @@ umount02 umount02
 umount03 umount03
 
 umount2_01 umount2_01
+umount2_02 umount2_02
 
 ustat01 ustat01
 ustat02 ustat02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 542ec3b..4ee0b0d 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -1003,6 +1003,7 @@
 /umount/umount02
 /umount/umount03
 /umount2/umount2_01
+/umount2/umount2_02
 /uname/uname01
 /uname/uname02
 /uname/uname03
diff --git a/testcases/kernel/syscalls/umount2/umount2_02.c b/testcases/kernel/syscalls/umount2/umount2_02.c
new file mode 100644
index 0000000..7ec7758
--- /dev/null
+++ b/testcases/kernel/syscalls/umount2/umount2_02.c
@@ -0,0 +1,202 @@
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
+ *  Test for feature MNT_EXPIRE of umount2().
+ *  "Mark the mount point as expired.If a mount point is not currently
+ *   in use, then an initial call to umount2() with this flag fails with
+ *   the error EAGAIN, but marks the mount point as expired. The mount
+ *   point remains expired as long as it isn't accessed by any process.
+ *   A second umount2() call specifying MNT_EXPIRE unmounts an expired
+ *   mount point. This flag cannot be specified with either MNT_FORCE or
+ *   MNT_DETACH. (fails with the error EINVAL)"
+ */
+
+#include <errno.h>
+#include <sys/mount.h>
+
+#include "test.h"
+#include "safe_macros.h"
+#include "lapi/mount.h"
+
+static void setup(void);
+static void umount2_verify(void);
+static int umount2_verify_1(void);
+static int umount2_verify_2(void);
+static int umount2_verify_3(void);
+static void cleanup(void);
+
+char *TCID = "umount2_02";
+int TST_TOTAL = 1;
+
+#define DIR_MODE	(S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH)
+#define FILE_MODE	(S_IRWXU | S_IRWXG | S_IRWXO | S_ISUID | S_ISGID)
+#define MNTPOINT	"mntpoint"
+#define EXP_ERRNO	EAGAIN
+
+static int fd;
+static int mount_flag;
+
+static const char *device;
+static const char *fs_type;
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
+	if ((tst_kvercmp(2, 6, 8)) < 0) {
+		tst_brkm(TCONF, NULL, "This test can only run on kernels "
+			"that are 2.6.8 or higher");
+	}
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
+	if (umount2_verify_1())
+		goto EXIT;
+
+	if (umount2_verify_2())
+		goto EXIT;
+
+	/* a new accesse removes the expired mark of the mount point */
+	fd = SAFE_CREAT(cleanup, MNTPOINT "/file", FILE_MODE);
+
+	SAFE_CLOSE(cleanup, fd);
+	fd = 0;
+
+	if (umount2_verify_2())
+		goto EXIT;
+
+	if (umount2_verify_3())
+		goto EXIT;
+
+	mount_flag = 0;
+
+	tst_resm(TPASS, "umount2(2) Passed");
+
+EXIT:
+	if (mount_flag) {
+		SAFE_UMOUNT(cleanup, MNTPOINT);
+		mount_flag = 0;
+	}
+}
+
+/* MNT_EXPIRE cannot be specified with either MNT_FORCE or MNT_DETACH */
+static int umount2_verify_1(void)
+{
+	TEST(umount2(MNTPOINT, MNT_EXPIRE | MNT_FORCE));
+
+	if (TEST_RETURN == 0 || TEST_ERRNO != EINVAL) {
+		tst_resm(TFAIL | TTERRNO, "umount2(2) MNT_EXPIRE flag "
+			"performed abnormally "
+			"expected error = %d : %s",
+			EINVAL, strerror(EINVAL));
+		return 1;
+	}
+
+	TEST(umount2(MNTPOINT, MNT_EXPIRE | MNT_DETACH));
+
+	if (TEST_RETURN == 0 || TEST_ERRNO != EINVAL) {
+		tst_resm(TFAIL | TTERRNO, "umount2(2) MNT_EXPIRE flag "
+			"performed abnormally "
+			"expected error = %d : %s",
+			EINVAL, strerror(EINVAL));
+		return 1;
+	}
+
+	return 0;
+}
+
+/* the initial call to umount2() with MNT_EXPIRE flag */
+static int umount2_verify_2(void)
+{
+	TEST(umount2(MNTPOINT, MNT_EXPIRE));
+
+	if (TEST_RETURN == 0 || TEST_ERRNO != EAGAIN) {
+		tst_resm(TFAIL | TTERRNO, "umount2(2) MNT_EXPIRE flag "
+			"performed abnormally "
+			"expected error = %d : %s",
+			EAGAIN, strerror(EAGAIN));
+		return 1;
+	}
+
+	return 0;
+}
+
+/* the second call to umount2() with MNT_EXPIRE flag */
+static int umount2_verify_3(void)
+{
+	TEST(umount2(MNTPOINT, MNT_EXPIRE));
+
+	if (TEST_RETURN != 0) {
+		tst_resm(TFAIL | TTERRNO, "umount2(2) Failed");
+		return 1;
+	}
+
+	return 0;
+}
+
+static void cleanup(void)
+{
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
