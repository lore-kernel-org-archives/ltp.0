Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1W8LfO-0000Ni-Lv
	for ltp-list@lists.sourceforge.net; Wed, 29 Jan 2014 03:18:18 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W8LfM-0004ZH-J9
	for ltp-list@lists.sourceforge.net; Wed, 29 Jan 2014 03:18:18 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s0T3I85h023905
	for <ltp-list@lists.sourceforge.net>; Wed, 29 Jan 2014 11:18:09 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 29 Jan 2014 11:16:47 +0800
Message-Id: <1390965407-14199-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH] mknodat/mknodat02.c: add ELOOP and EROFS error value
	test
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

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/.gitignore          |   1 +
 testcases/kernel/syscalls/mknodat/mknodat02.c | 215 ++++++++++++++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mknodat/mknodat02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index afa7976..4490e8f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -552,6 +552,7 @@ mknod09 mknod09
 
 #mknodat test cases
 mknodat01 cd $LTPROOT/testcases/bin && chown root mknodat01 && chmod 04755 mknodat01 && mknodat01
+mknodat02 mknodat02 -D DEVICE -T DEVICE_FS_TYPE
 
 mlock01 mlock01
 mlock02 mlock02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 1caf8e3..32d9b79 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -496,6 +496,7 @@
 /mknod/mknod08
 /mknod/mknod09
 /mknodat/mknodat01
+/mknodat/mknodat02
 /mlock/mlock01
 /mlock/mlock02
 /mlock/mlock03
diff --git a/testcases/kernel/syscalls/mknodat/mknodat02.c b/testcases/kernel/syscalls/mknodat/mknodat02.c
new file mode 100644
index 0000000..3acb06c
--- /dev/null
+++ b/testcases/kernel/syscalls/mknodat/mknodat02.c
@@ -0,0 +1,215 @@
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
+ * Description:
+ * Verify that,
+ *  1) mknod(2) returns -1 and sets errno to EROFS if pathname refers to
+ *     a file on a read-only file system.
+ *  2) mknod(2) returns -1 and sets errno to ELOOP if Too many symbolic
+ *     links were encountered in resolving pathname.
+ */
+
+#define _GNU_SOURCE
+
+#include <sys/types.h>
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <error.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/mount.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "linux_syscall_numbers.h"
+
+#ifndef AT_FDCWD
+#define AT_FDCWD -100
+#endif
+
+static void setup(int ac, char *argv[]);
+static void mknodat_verify(int i);
+static void cleanup(void);
+static void help(void);
+static int mknodat(int dirfd, const char *filename, mode_t mode, dev_t dev);
+
+#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+			 S_IXGRP|S_IROTH|S_IXOTH)
+#define MNT_POINT	"mntpoint"
+
+#define FIFOMODE	(S_IFIFO | S_IRUSR | S_IRGRP | S_IROTH)
+#define FREGMODE	(S_IFREG | S_IRUSR | S_IRGRP | S_IROTH)
+#define SOCKMODE	(S_IFSOCK | S_IRUSR | S_IRGRP | S_IROTH)
+
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
+static int dirfd;
+static int curfd = AT_FDCWD;
+static char tst_eloop[PATH_MAX];
+
+static struct test_case_t {
+	int *dirfd;
+	char *pathname;
+	int mode;
+	int exp_errno;
+} test_cases[] = {
+	{ &curfd, "tnode1", FIFOMODE, 0 },
+	{ &curfd, "tnode2", FREGMODE, 0 },
+	{ &curfd, "tnode3", SOCKMODE, 0 },
+	{ &dirfd, "tnode4", FIFOMODE, EROFS },
+	{ &dirfd, "tnode5", FREGMODE, EROFS },
+	{ &dirfd, "tnode6", SOCKMODE, EROFS },
+	{ &curfd, tst_eloop, FIFOMODE, ELOOP },
+	{ &curfd, tst_eloop, FREGMODE, ELOOP },
+	{ &curfd, tst_eloop, SOCKMODE, ELOOP },
+};
+
+char *TCID = "mknodat";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EROFS, ELOOP, 0 };
+
+int main(int ac, char **av)
+{
+	int lc, i;
+
+	setup(ac, av);
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)
+			mknodat_verify(i);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(int ac, char *av[])
+{
+	int i;
+	char *msg;
+
+	if (tst_kvercmp(2, 6, 16) < 0) {
+		tst_brkm(TCONF, NULL, "This test can only run on kernels "
+			 "that are 2.6.16 and higher");
+		tst_exit();
+	}
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
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	tst_require_root(NULL);
+
+	TEST_EXP_ENOS(exp_enos);
+
+	tst_mkfs(NULL, device, fstype, NULL);
+
+	tst_tmpdir();
+
+	TEST_PAUSE;
+
+	/*
+	 * mount a read-only file system for EROFS test
+	 */
+	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
+	if (mount(device, MNT_POINT, fstype, MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+	dirfd = SAFE_OPEN(cleanup, MNT_POINT, O_DIRECTORY);
+
+	/* create this pathname for ELOOP test */
+	SAFE_MKDIR(cleanup, "test_eloop", DIR_MODE);
+	SAFE_SYMLINK(cleanup, "../test_eloop", "test_eloop/test_eloop");
+	strcpy(tst_eloop, ".");
+	for (i = 0; i < 50; i++)
+		strcat(tst_eloop, "/test_eloop");
+}
+
+static int mknodat(int dirfd, const char *filename, mode_t mode, dev_t dev)
+{
+	return ltp_syscall(__NR_mknodat, dirfd, filename, mode, dev);
+}
+
+static void mknodat_verify(int i)
+{
+	int fd = *test_cases[i].dirfd;
+	char *pathname = test_cases[i].pathname;
+	mode_t mode = test_cases[i].mode;
+
+	TEST(mknodat(fd, pathname, mode, 0));
+
+	if (TEST_ERRNO == test_cases[i].exp_errno) {
+		tst_resm(TPASS | TTERRNO,
+			 "mknodat() returned the expected errno");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "mknodat() failed unexpectedly; expected: "
+			 "%d - %s", test_cases[i].exp_errno,
+			 strerror(test_cases[i].exp_errno));
+	}
+
+	if (TEST_ERRNO == 0 && unlinkat(fd, pathname, 0) < 0) {
+			tst_brkm(TBROK | TERRNO, cleanup, "unlinkat(%d, %s) "
+				 "failed.", fd, pathname);
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	if (dirfd > 0)
+		SAFE_CLOSE(NULL, dirfd);
+
+	if (mount_flag && umount(MNT_POINT) < 0) {
+		tst_brkm(TBROK | TERRNO, NULL,
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
1.8.2.1


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
