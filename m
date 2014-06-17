Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WwkHA-0006fA-Rc
	for ltp-list@lists.sourceforge.net; Tue, 17 Jun 2014 03:41:36 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WwkH8-0000Ux-FN
	for ltp-list@lists.sourceforge.net; Tue, 17 Jun 2014 03:41:36 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5H3fQdF015198
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Jun 2014 11:41:26 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 17 Jun 2014 11:38:41 +0800
Message-ID: <1402976321-18515-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] syscalls/rename/rename11.c: add ELOOP,
	EMLINK and EROFS error value tests
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

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/ltplite                             |   1 +
 runtest/stress.part3                        |   1 +
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/.gitignore        |   1 +
 testcases/kernel/syscalls/rename/rename11.c | 214 ++++++++++++++++++++++++++++
 5 files changed, 218 insertions(+)
 create mode 100644 testcases/kernel/syscalls/rename/rename11.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 6daf4c3..1d10b26 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -640,6 +640,7 @@ rename07 rename07
 rename08 rename08
 rename09 rename09
 rename10 rename10
+rename11 rename11 -D $LTP_DEV -T $LTP_DEV_FS_TYPE
 rename12 rename12
 rename13 rename13
 rename14 rename14
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 44b1081..6fbe41b 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -550,6 +550,7 @@ rename07 rename07
 rename08 rename08
 rename09 rename09
 rename10 rename10
+rename11 rename11 -D $LTP_DEV -T $LTP_DEV_FS_TYPE
 rename12 rename12
 rename13 rename13
 rename14 rename14
diff --git a/runtest/syscalls b/runtest/syscalls
index c132a69..0eec586 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -845,6 +845,7 @@ rename07 rename07
 rename08 rename08
 rename09 rename09
 rename10 rename10
+rename11 rename11 -D $LTP_DEV -T $LTP_DEV_FS_TYPE
 rename12 rename12
 rename13 rename13
 rename14 rename14
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 256cad0..d89ec8c 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -690,6 +690,7 @@
 /rename/rename08
 /rename/rename09
 /rename/rename10
+/rename/rename11
 /rename/rename12
 /rename/rename13
 /rename/rename14
diff --git a/testcases/kernel/syscalls/rename/rename11.c b/testcases/kernel/syscalls/rename/rename11.c
new file mode 100644
index 0000000..e2ab029
--- /dev/null
+++ b/testcases/kernel/syscalls/rename/rename11.c
@@ -0,0 +1,214 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+/*
+ * Test Description:
+ *  Verify that,
+ *   1. rename() fails with -1 return value and sets errno to ELOOP, if too
+ *      many symbolic links were encountered in resolving oldpath or newpath.
+ *   2. rename() fails with -1 return value and sets errno to EROFS,
+ *      if the file is on a read-only file system.
+ *   3. rename() fails with -1 return value and sets errno to EMLINK,
+ *   	if the file named by old is a directory and the link count of
+ *   	the parent directory of new would exceed {LINK_MAX}.
+ */
+
+#include <stdio.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/mount.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+char *TCID = "rename11";
+
+#define MNTPOINT	"mntpoint"
+#define TEST_EROFS	"mntpoint/test_erofs"
+#define TEST_NEW_EROFS	"mntpoint/new_test_erofs"
+
+#define TEST_EMLINK	"test_emlink"
+#define TEST_NEW_EMLINK	"emlink_dir/testdir"
+
+#define TEST_NEW_ELOOP	"new_test_eloop"
+#define ELOPFILE	"/test_eloop"
+static char elooppathname[sizeof(ELOPFILE) * 43] = ".";
+static int max_subdirs;
+
+static char *fstype = "ext2";
+static char *device;
+static int mount_flag;
+
+static option_t options[] = {
+	{"T:", NULL, &fstype},
+	{"D:", NULL, &device},
+	{NULL, NULL, NULL},
+};
+
+static int exp_enos[] = { ELOOP, EROFS, EMLINK, 0 };
+
+static void cleanup(void);
+static void setup(void);
+static void help(void);
+static void test_eloop(void);
+static void test_erofs(void);
+static void test_emlink(void);
+
+static void (*testfunc[])(void) = { test_eloop, test_erofs, test_emlink };
+
+int TST_TOTAL = ARRAY_SIZE(testfunc);
+
+int main(int ac, char **av)
+{
+	int lc, i;
+	const char *msg;
+
+	msg = parse_opts(ac, av, options, help);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	if (!device) {
+		tst_brkm(TBROK, NULL, "you must specify the device "
+			 "used for mounting with -D option");
+	}
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)
+			(*testfunc[i])();
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	int i;
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	tst_require_root(NULL);
+
+	tst_tmpdir();
+
+	TEST_EXP_ENOS(exp_enos);
+
+	TEST_PAUSE;
+
+	tst_mkfs(NULL, device, fstype, NULL);
+	SAFE_MKDIR(cleanup, MNTPOINT, 0755);
+	if (mount(device, MNTPOINT, fstype, 0, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+	SAFE_TOUCH(cleanup, TEST_EROFS, 0644, NULL);
+
+	SAFE_MKDIR(cleanup, TEST_EMLINK, 0755);
+	max_subdirs = tst_fs_fill_subdirs(cleanup, "emlink_dir");
+	/*
+	 * NOTE: the ELOOP test is written based on that the consecutive
+	 * symlinks limits in kernel is hardwired to 40.
+	 */
+	SAFE_MKDIR(cleanup, "test_eloop", 0644);
+	SAFE_SYMLINK(cleanup, "../test_eloop", "test_eloop/test_eloop");
+	for (i = 0; i < 43; i++)
+		strcat(elooppathname, ELOPFILE);
+}
+
+static void check_and_print(int expected_errno)
+{
+	if (TEST_RETURN == -1) {
+		if (TEST_ERRNO == expected_errno) {
+			tst_resm(TPASS | TTERRNO, "failed as expected");
+		} else {
+			tst_resm(TFAIL | TTERRNO,
+				 "failed unexpectedly; expected - %d : %s",
+				 expected_errno, strerror(expected_errno));
+		}
+	} else {
+		tst_resm(TFAIL, "rename succeeded unexpectedly");
+	}
+}
+
+static void test_eloop(void)
+{
+	TEST(rename(elooppathname, TEST_NEW_ELOOP));
+	check_and_print(ELOOP);
+
+	if (TEST_RETURN == 0)
+		SAFE_UNLINK(cleanup, TEST_NEW_ELOOP);
+}
+
+static void test_erofs(void)
+{
+	if (mount(device, MNTPOINT, fstype, MS_REMOUNT | MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+
+	TEST(rename(TEST_EROFS, TEST_NEW_EROFS));
+	check_and_print(EROFS);
+
+	if (TEST_RETURN == 0)
+		SAFE_UNLINK(cleanup, TEST_NEW_EROFS);
+
+	if (mount(device, MNTPOINT, fstype, MS_REMOUNT, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "remount device:%s failed", device);
+	}
+}
+
+static void test_emlink(void)
+{
+	if (max_subdirs == 0) {
+		tst_resm(TCONF, "EMLINK test is not appropriate");
+		return;
+	}
+
+	TEST(rename(TEST_EMLINK, TEST_NEW_EMLINK));
+	check_and_print(EMLINK);
+
+	if (TEST_RETURN == 0)
+		SAFE_RMDIR(cleanup, TEST_NEW_EMLINK);
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	if (mount_flag && umount(MNTPOINT) < 0)
+		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
+
+	tst_rmdir();
+}
+
+static void help(void)
+{
+	printf("-T type   : specifies the type of filesystem to be mounted. "
+	       "Default ext2.\n");
+	printf("-D device : device used for mounting.\n");
+}
-- 
1.8.2.1


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
