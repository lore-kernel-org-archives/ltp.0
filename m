Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1W5rYM-0007B6-Gb
	for ltp-list@lists.sourceforge.net; Wed, 22 Jan 2014 06:44:46 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W5rYK-0007Zy-JG
	for ltp-list@lists.sourceforge.net; Wed, 22 Jan 2014 06:44:46 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s0M6iXF9019752
	for <ltp-list@lists.sourceforge.net>; Wed, 22 Jan 2014 14:44:36 +0800
Message-ID: <1390373070.1960.31.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Wed, 22 Jan 2014 14:44:30 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH] mkdirat/mkdirat02.c: add new error number tests
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
 testcases/kernel/syscalls/mkdirat/mkdirat02.c | 201 ++++++++++++++++++++++++++
 3 files changed, 203 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mkdirat/mkdirat02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index afa7976..b5cc161 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -539,6 +539,7 @@ mkdir09 mkdir09
 
 #mkdirat test cases
 mkdirat01 mkdirat01
+mkdirat02 mkdirat02 -D DEVICE -T DEVICE_FS_TYPE
 
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
index 0000000..a05cf63
--- /dev/null
+++ b/testcases/kernel/syscalls/mkdirat/mkdirat02.c
@@ -0,0 +1,201 @@
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
+static void setup(int ac, char **av);
+static void mkdirat_verify(int);
+static void cleanup(void);
+static void help(void);
+
+#define TST_EROFS	"mntpoint/tst_erofs"
+#define MODE		0777
+#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+			 S_IXGRP|S_IROTH|S_IXOTH)
+
+char *TCID = "mkdirat02";
+
+static int dir_fd;
+static int cur_fd;
+static char tst_eloop[PATH_MAX];
+static char *fstype = "ext2";
+static char *device;
+static int dflag;
+static int mount_flag1;
+static int mount_flag2;
+
+static option_t options[] = {
+	{"T:", NULL, &fstype},
+	{"D:", &dflag, &device},
+	{NULL, NULL, NULL}
+};
+static int exp_enos[] = { ELOOP, EROFS, 0 };
+
+static struct test_case_t {
+	int *dirfd;
+	char *pathname;
+	int mode;
+	int exp_errno;
+} TC[] = {
+	{&dir_fd, tst_eloop, MODE, ELOOP},
+	{&cur_fd, tst_eloop, MODE, ELOOP},
+	{&dir_fd, TST_EROFS, MODE, EROFS},
+	{&cur_fd, TST_EROFS, MODE, EROFS},
+};
+
+int TST_TOTAL = ARRAY_SIZE(TC);
+
+int main(int ac, char **av)
+{
+	int lc;
+	int i;
+
+	setup(ac, av);
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)
+
+			mkdirat_verify(i);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(int ac, char **av)
+{
+	char *msg;
+	int i;
+
+	msg = parse_opts(ac, av, options, help);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	if (!dflag) {
+		tst_brkm(TBROK, NULL,
+			 "you must specify the device used for mounting with "
+			 "-D option");
+	}
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	SAFE_MKDIR(cleanup, "test_dir", DIR_MODE);
+	dir_fd = SAFE_OPEN(cleanup, "test_dir", O_DIRECTORY);
+	cur_fd = AT_FDCWD;
+
+	SAFE_MKDIR(cleanup, "test_eloop", DIR_MODE);
+	SAFE_SYMLINK(cleanup, "../test_eloop", "test_eloop/test_eloop");
+
+	SAFE_MKDIR(cleanup, "test_dir/test_eloop", DIR_MODE);
+	SAFE_SYMLINK(cleanup, "../test_eloop",
+		     "test_dir/test_eloop/test_eloop");
+
+	strcpy(tst_eloop, ".");
+	for (i = 0; i < 43; i++)
+		strcat(tst_eloop, "/test_eloop");
+
+	tst_mkfs(NULL, device, fstype, NULL);
+
+	SAFE_MKDIR(cleanup, "test_dir/mntpoint", DIR_MODE);
+	if (mount(device, "test_dir/mntpoint", fstype, MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag1 = 1;
+
+	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
+	if (mount(device, "mntpoint", fstype, MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag2 = 1;
+
+	TEST_EXP_ENOS(exp_enos);
+}
+
+static void mkdirat_verify(int i)
+{
+	TEST(ltp_syscall(__NR_mkdirat, *TC[i].dirfd,
+			 TC[i].pathname, TC[i].mode));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "mkdirat() returned %ld, expected -1, errno=%d",
+			 TEST_RETURN, TC[i].exp_errno);
+		return;
+	}
+
+	TEST_ERROR_LOG(TEST_ERRNO);
+
+	if (TEST_ERRNO == TC[i].exp_errno) {
+		tst_resm(TPASS | TTERRNO, "mkdirat() failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "mkdirat() failed unexpectedly; expected: %d - %s",
+			 TC[i].exp_errno, strerror(TC[i].exp_errno));
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	if (mount_flag1 && umount("mntpoint") < 0) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "umount device:%s failed", device);
+	}
+
+	if (mount_flag2 && umount("test_dir/mntpoint") < 0) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "umount device:%s failed", device);
+	}
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
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
