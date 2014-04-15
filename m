Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1Wa1ef-0006u6-7e
	for ltp-list@lists.sourceforge.net; Tue, 15 Apr 2014 11:35:57 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wa1ed-00039S-3V
	for ltp-list@lists.sourceforge.net; Tue, 15 Apr 2014 11:35:57 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s3FBZJov018417
	for <ltp-list@lists.sourceforge.net>; Tue, 15 Apr 2014 19:35:19 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 15 Apr 2014 19:33:22 +0800
Message-ID: <1397561602-18935-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1397561602-18935-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1397561602-18935-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/2] syscalls/rename/rename11.c: add ELOOP,
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

Note: int rename(const char *old, const char *new);
For EMLINK error value test: the file named by old is a directory and the
link count of the parent directory of new would exceed {LINK_MAX}.

This test will work on ext2 and ext3 filesystem. But there is some difference in some
linux distributions.

For example, in fedora19 and RHEL7.0Beta, the kernel configs for ext2/ext3/ext4 filesystems
list below:
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT23=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y

If kernel has the above config, ext2 or ext3 is disabled. Then when we mount ext2 or
ext3 filesystem, the ext4 filesystem driver code will be used for ext2 or ext3 file
system mounts. This allows users to reduce their compiled kernel size by using one
file system driver for ext2, ext3, and ext4 file systems. That means though we mount
a block device with ext2 filesystem in it, the kernel will possibely use ext4 driver
code instead.

So for this EMLINK error value test, we have test in ext4 directly. But the max
subdirectories(per directory) in ext4 is unlimited default(When the link count exceeds
65,000, it is reset to 1 and no longer increases.). But EMLINK error value test
need the directory have a valid LINK_MAX, so for ext4, we use mkfs to clear "dir_index"
filesystem feature, then ext4 has a LINK_MAX:65000:
	mkfs.ext4 -O ^dir_index device

And we also need a big block device to have tests, the default provided by runltp
is 20MB, which is not big enough to hold more than 65000 directories.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/ltplite                             |   1 +
 runtest/stress.part3                        |   1 +
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/.gitignore        |   1 +
 testcases/kernel/syscalls/rename/rename11.c | 220 ++++++++++++++++++++++++++++
 5 files changed, 224 insertions(+)
 create mode 100644 testcases/kernel/syscalls/rename/rename11.c

diff --git a/runtest/ltplite b/runtest/ltplite
index ebe171e..7587d24 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -641,6 +641,7 @@ rename07 rename07
 rename08 rename08
 rename09 rename09
 rename10 rename10
+rename11 rename11
 rename12 rename12
 rename13 rename13
 rename14 rename14
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index b21e44b..bbef859 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -551,6 +551,7 @@ rename07 rename07
 rename08 rename08
 rename09 rename09
 rename10 rename10
+rename11 rename11
 rename12 rename12
 rename13 rename13
 rename14 rename14
diff --git a/runtest/syscalls b/runtest/syscalls
index fb3e59f..098b92d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -845,6 +845,7 @@ rename07 rename07
 rename08 rename08
 rename09 rename09
 rename10 rename10
+rename11 rename11
 rename12 rename12
 rename13 rename13
 rename14 rename14
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index d5c7bac..5abcb15 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -688,6 +688,7 @@
 /rename/rename08
 /rename/rename09
 /rename/rename10
+/rename/rename11
 /rename/rename12
 /rename/rename13
 /rename/rename14
diff --git a/testcases/kernel/syscalls/rename/rename11.c b/testcases/kernel/syscalls/rename/rename11.c
new file mode 100644
index 0000000..a211464
--- /dev/null
+++ b/testcases/kernel/syscalls/rename/rename11.c
@@ -0,0 +1,220 @@
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
+ *
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
+#define MNTPOINT	"mntpoint"
+#define TEST_EROFS	"mntpoint/test_erofs"
+#define TEST_NEW_EROFS	"mntpoint/new_test_erofs"
+
+#define TEST_EMLINK	"mntpoint/test_emlink"
+#define TEST_NEW_EMLINK	"mntpoint/test_parent_dir/test_emlink"
+
+#define TEST_NEW_ELOOP	"new_test_eloop"
+#define ELOPFILE	"/test_eloop"
+static char elooppathname[sizeof(ELOPFILE) * 43] = ".";
+
+static char *device;
+static int mount_flag;
+
+static void cleanup(void);
+static void setup(void);
+
+char *TCID = "rename11";
+
+static int exp_enos[] = { ELOOP, EROFS, EMLINK, 0 };
+
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
+	char *msg;
+
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
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
+	int i, ret;
+	unsigned long long link_max = 0;
+	char lname[PATH_MAX];
+	const char *const opts[] = { "-O", "^dir_index", NULL };
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_require_root(NULL);
+
+	device = getenv("LTP_BIG_DEV");
+	if (device == NULL) {
+		tst_brkm(TCONF, NULL,
+			 "you must specify a big blockdevice(>500MB)");
+	} else {
+		tst_mkfs(NULL, device, "ext4", opts);
+	}
+
+	tst_tmpdir();
+	TEST_EXP_ENOS(exp_enos);
+	TEST_PAUSE;
+
+	SAFE_MKDIR(cleanup, MNTPOINT, 0755);
+	/* we have tests in ext4 */
+	if (mount(device, MNTPOINT, "ext4", 0, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+
+	SAFE_TOUCH(cleanup, TEST_EROFS, 0644, NULL);
+
+	SAFE_MKDIR(cleanup, TEST_EMLINK, 0755);
+	SAFE_MKDIR(cleanup, "mntpoint/test_parent_dir", 0755);
+	while (1) {
+		sprintf(lname, "mntpoint/test_parent_dir/test%lld", ++link_max);
+		ret = mkdir(lname, 0755);
+		if (ret == -1) {
+			switch (errno) {
+			case EMLINK:
+				tst_resm(TINFO, "for ext4 the max links is"
+					" %lld", link_max + 1);
+				break;
+			default:
+				tst_brkm(TCONF | TERRNO, cleanup,
+					 "we do not hit the maximum number of "
+					 "links to dir test_parent_dir in ext4."
+					 "Unexpected error:");
+				break;
+			}
+			break;
+		}
+	}
+
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
+	if (mount(device, MNTPOINT, "ext4", MS_REMOUNT |
+	    MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "remount device:%s failed", device);
+	}
+
+	TEST(rename(TEST_EROFS, TEST_NEW_EROFS));
+	check_and_print(EROFS);
+
+	if (TEST_RETURN == 0)
+		SAFE_UNLINK(cleanup, TEST_NEW_EROFS);
+
+	if (mount(device, MNTPOINT, "ext4", MS_REMOUNT, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "remount device:%s failed", device);
+	}
+}
+
+static void test_emlink(void)
+{
+	TEST(rename(TEST_EMLINK, TEST_NEW_EMLINK));
+	check_and_print(EMLINK);
+
+	if (TEST_RETURN == 0)
+		SAFE_UNLINK(cleanup, TEST_NEW_EMLINK);
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
-- 
1.8.2.1


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
