Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fenggw-fnst@cn.fujitsu.com>) id 1ZFIAt-0006cO-4T
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2015 08:36:19 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZFIAr-0000jo-Hp
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2015 08:36:19 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t6F8YNpF027523
	for <ltp-list@lists.sourceforge.net>; Wed, 15 Jul 2015 16:34:23 +0800
From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 15 Jul 2015 16:36:03 +0800
Message-ID: <1436949363-8356-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
In-Reply-To: <1436949363-8356-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1436949363-8356-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 3/3] umount2/umount2_03.c: add new test
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

Add new testcase to verify the flag UMOUNT_NOFOLLOW of umount2(2).

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/ltplite                                |   1 +
 runtest/syscalls                               |   1 +
 testcases/kernel/syscalls/.gitignore           |   1 +
 testcases/kernel/syscalls/umount2/umount2_03.c | 138 +++++++++++++++++++++++++
 4 files changed, 141 insertions(+)
 create mode 100644 testcases/kernel/syscalls/umount2/umount2_03.c

diff --git a/runtest/ltplite b/runtest/ltplite
index f5a8a52..083e48e 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -967,6 +967,7 @@ unlink08 unlink08
 
 umount2_01 umount2_01
 umount2_02 umount2_02
+umount2_03 umount2_03
 
 ustat01 ustat01
 ustat02 ustat02
diff --git a/runtest/syscalls b/runtest/syscalls
index 92716d2..2fbf4de 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1316,6 +1316,7 @@ umount03 umount03
 
 umount2_01 umount2_01
 umount2_02 umount2_02
+umount2_03 umount2_03
 
 ustat01 ustat01
 ustat02 ustat02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 4ee0b0d..046c909 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -1004,6 +1004,7 @@
 /umount/umount03
 /umount2/umount2_01
 /umount2/umount2_02
+/umount2/umount2_03
 /uname/uname01
 /uname/uname02
 /uname/uname03
diff --git a/testcases/kernel/syscalls/umount2/umount2_03.c b/testcases/kernel/syscalls/umount2/umount2_03.c
new file mode 100644
index 0000000..ecfc775
--- /dev/null
+++ b/testcases/kernel/syscalls/umount2/umount2_03.c
@@ -0,0 +1,138 @@
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
+ *  Test for feature UMOUNT_NOFOLLOW of umount2().
+ *  "Don't dereference target if it is a symbolic link,
+ *   and fails with the error EINVAL."
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
+static void cleanup(void);
+
+char *TCID = "umount2_03";
+int TST_TOTAL = 1;
+
+#define DIR_MODE	(S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH)
+#define MNTPOINT	"mntpoint"
+#define SYMLINK	"symlink"
+
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
+	if ((tst_kvercmp(2, 6, 34)) < 0) {
+		tst_brkm(TCONF, NULL, "This test can only run on kernels "
+			"that are 2.6.34 or higher");
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
+	SAFE_SYMLINK(cleanup, MNTPOINT, SYMLINK);
+
+	TEST_PAUSE;
+}
+
+static void umount2_verify(void)
+{
+	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
+	mount_flag = 1;
+
+	TEST(umount2(SYMLINK, UMOUNT_NOFOLLOW));
+
+	if (TEST_RETURN == 0 || TEST_ERRNO != EINVAL) {
+		tst_resm(TFAIL | TTERRNO,
+			"umount2(2) UMOUNT_NOFOLLOW flag "
+			"performed abnormally "
+			"expected error = %d : %s",
+			EINVAL, strerror(EINVAL));
+		if (TEST_RETURN == 0)
+			mount_flag = 0;
+		goto EXIT;
+	}
+
+	TEST(umount2(MNTPOINT, UMOUNT_NOFOLLOW));
+
+	if (TEST_RETURN != 0) {
+		tst_resm(TFAIL | TTERRNO, "umount2(2) Failed");
+		goto EXIT;
+	}
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
+static void cleanup(void)
+{
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
