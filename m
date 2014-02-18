Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WFmNp-0003yw-3m
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 15:14:53 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WFmNm-0001J5-NU
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 15:14:52 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1IEuYpJ008345
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Feb 2014 22:56:34 +0800
Message-ID: <1392735392.2654.11.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 18 Feb 2014 22:56:32 +0800
In-Reply-To: <1390373070.1960.31.camel@G08JYZSD130126>
References: <1390373070.1960.31.camel@G08JYZSD130126>
Mime-Version: 1.0
Subject: [LTP] [PATCH v2] mkdirat/mkdirat02.c: add new error number tests
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Add ELOOP and EROFS error number tests for mkdirat(2)

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/.gitignore          |   1 +
 testcases/kernel/syscalls/mkdirat/mkdirat02.c | 191 ++++++++++++++++++++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mkdirat/mkdirat02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index afa7976..2263a74 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -539,6 +539,7 @@ mkdir09 mkdir09
 
 #mkdirat test cases
 mkdirat01 mkdirat01
+mkdirat02 mkdirat02 -D $LTP_DEV -T $LTP_DEV_FS_TYPE
 
 mknod01 mknod01
 mknod02 mknod02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 91cf0f1..369b77e 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -486,6 +486,7 @@
 /mkdir/mkdir08
 /mkdir/mkdir09
 /mkdirat/mkdirat01
+/mkdirat/mkdirat02
 /mknod/mknod01
 /mknod/mknod02
 /mknod/mknod03
diff --git a/testcases/kernel/syscalls/mkdirat/mkdirat02.c b/testcases/kernel/syscalls/mkdirat/mkdirat02.c
new file mode 100644
index 0000000..dc126b9
--- /dev/null
+++ b/testcases/kernel/syscalls/mkdirat/mkdirat02.c
@@ -0,0 +1,191 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
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
+/*
+ * DESCRIPTION
+ *	check mkdirat() with various error conditions that should produce
+ *	ELOOP and EROFS.
+ */
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <sys/mount.h>
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "linux_syscall_numbers.h"
+
+#ifndef AT_FDCWD
+# define AT_FDCWD -100
+#endif
+
+static void setup(void);
+static void cleanup(void);
+static void help(void);
+
+#define TEST_FILE1	"mntpoint/test_file1"
+#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+			 S_IXGRP|S_IROTH|S_IXOTH)
+
+char *TCID = "mkdirat02";
+
+static int dir_fd;
+static int cur_fd = AT_FDCWD;
+static char test_file2[PATH_MAX] = ".";
+static char *fstype = "ext2";
+static char *device;
+static int mount_flag_dir;
+static int mount_flag_cur;
+
+static option_t options[] = {
+	{"T:", NULL, &fstype},
+	{"D:", NULL, &device},
+	{NULL, NULL, NULL}
+};
+static int exp_enos[] = { ELOOP, EROFS, 0 };
+
+static struct test_case_t {
+	int *dirfd;
+	char *pathname;
+	int exp_errno;
+} TC[] = {
+	{&dir_fd, TEST_FILE1, EROFS},
+	{&cur_fd, TEST_FILE1, EROFS},
+	{&dir_fd, test_file2, ELOOP},
+	{&cur_fd, test_file2, ELOOP},
+};
+
+int TST_TOTAL = ARRAY_SIZE(TC);
+static void mkdirat_verify(const struct test_case_t *);
+
+int main(int ac, char **av)
+{
+	int lc;
+	int i;
+	char *msg;
+
+	msg = parse_opts(ac, av, options, help);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	if (!device) {
+		tst_brkm(TBROK, NULL,
+			 "you must specify the device used for mounting with "
+			 "-D option");
+	}
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+		for (i = 0; i < TST_TOTAL; i++)
+			mkdirat_verify(&TC[i]);
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
+	tst_require_root(NULL);
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	SAFE_MKDIR(cleanup, "test_dir", DIR_MODE);
+	dir_fd = SAFE_OPEN(cleanup, "test_dir", O_DIRECTORY);
+
+	SAFE_MKDIR(cleanup, "test_eloop", DIR_MODE);
+	SAFE_SYMLINK(cleanup, "../test_eloop", "test_eloop/test_eloop");
+
+	SAFE_MKDIR(cleanup, "test_dir/test_eloop", DIR_MODE);
+	SAFE_SYMLINK(cleanup, "../test_eloop",
+		     "test_dir/test_eloop/test_eloop");
+
+	for (i = 0; i < 43; i++)
+		strcat(test_file2, "/test_eloop");
+
+	tst_mkfs(NULL, device, fstype, NULL);
+
+	SAFE_MKDIR(cleanup, "test_dir/mntpoint", DIR_MODE);
+	if (mount(device, "test_dir/mntpoint", fstype, MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag_dir = 1;
+
+	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
+	if (mount(device, "mntpoint", fstype, MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag_cur = 1;
+
+	TEST_EXP_ENOS(exp_enos);
+}
+
+static void mkdirat_verify(const struct test_case_t *test)
+{
+	TEST(ltp_syscall(__NR_mkdirat, *test->dirfd,
+			 test->pathname, 0777));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "mkdirat() returned %ld, expected -1, errno=%d",
+			 TEST_RETURN, test->exp_errno);
+		return;
+	}
+
+	TEST_ERROR_LOG(TEST_ERRNO);
+
+	if (TEST_ERRNO == test->exp_errno) {
+		tst_resm(TPASS | TTERRNO, "mkdirat() failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "mkdirat() failed unexpectedly; expected: %d - %s",
+			 test->exp_errno, strerror(test->exp_errno));
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	if (mount_flag_dir && umount("mntpoint") < 0)
+		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
+
+	if (mount_flag_cur && umount("test_dir/mntpoint") < 0)
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
1.8.4.2




------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
