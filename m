Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1VWeaC-0007RT-Nb
	for ltp-list@lists.sourceforge.net; Thu, 17 Oct 2013 03:49:08 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VWeaA-00058j-ND
	for ltp-list@lists.sourceforge.net; Thu, 17 Oct 2013 03:49:08 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r9H3mxFC026399
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Oct 2013 11:49:00 +0800
Message-ID: <525F5E29.6070507@cn.fujitsu.com>
Date: Thu, 17 Oct 2013 11:48:57 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2]  access/access06.c: add ELOOP, ENOTDIR,
 EROFS error number test for access(2)
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

create a case to test ELOOP, ENOTDIR, EROFS error number for access(2)

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/syscalls                            |    1 +
 testcases/kernel/syscalls/.gitignore        |    1 +
 testcases/kernel/syscalls/access/access06.c |  194 +++++++++++++++++++++++++++
 3 files changed, 196 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/access/access06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 09e5f7f..791de7c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -9,6 +9,7 @@ access02 access02
 access03 access03
 access04 access04
 access05 access05
+access06 access06 -D DEVICE -T DEVICE_FS_TYPE
 
 acct01 acct01
 acct02 acct02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index ad23c2e..c005111 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -6,6 +6,7 @@
 /access/access03
 /access/access04
 /access/access05
+/access/access06
 /acct/acct01
 /acct/acct02
 /add_key/add_key01
diff --git a/testcases/kernel/syscalls/access/access06.c b/testcases/kernel/syscalls/access/access06.c
new file mode 100644
index 0000000..75a1a00
--- /dev/null
+++ b/testcases/kernel/syscalls/access/access06.c
@@ -0,0 +1,194 @@
+/*
+ * Copyright (c) 2013 Fujitsu Ltd.
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
+ * Description:
+ * Verify that,
+ *  1.access() fails with -1 return value and sets errno to ENOTDIR
+ *    if a component used as a directory in pathname is not a directory.
+ *  2.access() fails with -1 return value and sets errno to ELOOP
+ *    if too many symbolic links were encountered in resolving pathname.
+ *  3.access() fails with -1 return value and sets errno to EROFS
+ *    if write permission was requested for a file on a read-only file system.
+ */
+
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <sys/mount.h>
+#include <pwd.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+
+static void setup(void);
+static void access_verify(int i);
+static void cleanup(void);
+static void help(void);
+
+#define DIR_MODE        (S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+			 S_IXGRP|S_IROTH|S_IXOTH)
+#define TEST_FILE1	"test_file1/test_file2"
+#define TEST_FILE2	"test_file3"
+#define TEST_FILE3	"mntpoint"
+
+static char *mntpoint = "mntpoint";
+static char *fstype = "ext2";
+static char *device;
+static int dflag;
+static int mount_flag;
+
+static option_t options[] = {
+	{"T:", NULL, &fstype},
+	{"D:", &dflag, &device},
+	{NULL, NULL, NULL}
+};
+
+static struct test_case_t {
+	char *pathname;
+	int a_mode;
+	int exp_errno;
+} test_cases[] = {
+	{TEST_FILE1, R_OK, ENOTDIR},
+	{TEST_FILE2, R_OK, ELOOP},
+	{TEST_FILE3, W_OK, EROFS}
+};
+
+char *TCID = "access06";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { ENOTDIR, ELOOP, EROFS, 0 };
+
+int main(int ac, char **av)
+{
+	int lc;
+	char *msg;
+	int i;
+
+	msg = parse_opts(ac, av, options, help);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	/* Check for mandatory option of the testcase */
+	if (!dflag) {
+		tst_brkm(TBROK, NULL, "you must specify the device "
+			 "used for mounting with -D option");
+	}
+
+	setup();
+
+	TEST_EXP_ENOS(exp_enos);
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)
+			access_verify(i);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	int fd;
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	tst_require_root(NULL);
+
+	tst_mkfs(NULL, device, fstype, NULL);
+
+	tst_tmpdir();
+
+	SAFE_MKDIR(cleanup, mntpoint, DIR_MODE);
+
+	TEST_PAUSE;
+
+	/*
+	 * create two regular files: test_file1 and test_file2 for
+	 * test ENOTDIR.
+	 */
+	fd = SAFE_CREAT(cleanup, "test_file1", 0644);
+	SAFE_CLOSE(cleanup, fd);
+
+	fd = SAFE_CREAT(cleanup, "test_file2", 0644);
+	SAFE_CLOSE(cleanup, fd);
+
+	/*
+	 * create two symbolic links who point to each other for
+	 * test ELOOP.
+	 */
+	SAFE_SYMLINK(cleanup, "test_file3", "test_file4");
+	SAFE_SYMLINK(cleanup, "test_file4", "test_file3");
+
+	/*
+	 * mount a read-only file system for test EROFS
+	 */
+	if (mount(device, mntpoint, fstype, MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+}
+
+static void access_verify(int i)
+{
+	char *file_name = test_cases[i].pathname;
+	int access_mode = test_cases[i].a_mode;
+
+	TEST(access(file_name, access_mode));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "access(%s, %#o) succeeded unexpectedly",
+			 file_name, access_mode);
+		return;
+	}
+	if (TEST_ERRNO == test_cases[i].exp_errno) {
+		tst_resm(TPASS | TTERRNO, "access failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO, "access failed unexpectedly; "
+			 "expected: %d - %s", test_cases[i].exp_errno,
+			 strerror(test_cases[i].exp_errno));
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	if (mount_flag && umount(mntpoint) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "umount device:%s failed", device);
+	}
+	tst_rmdir();
+}
+
+static void help(void)
+{
+	printf("-T type	  : specifies the type of filesystem to be mounted. "
+	       "Default ext2.\n");
+	printf("-D device : device used for mounting.\n");
+}
-- 
1.7.1

Regards,
Xiaoguang Wang



------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
