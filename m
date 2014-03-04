Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WKivG-0001vP-LV
	for ltp-list@lists.sourceforge.net; Tue, 04 Mar 2014 06:33:50 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WKivE-0002XG-Hf
	for ltp-list@lists.sourceforge.net; Tue, 04 Mar 2014 06:33:50 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s246Xgo3032021
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Mar 2014 14:33:42 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 4 Mar 2014 14:32:00 +0800
Message-Id: <1393914721-5288-4-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1393914721-5288-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1393914721-5288-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH 3/4] mknodat/mknodat02.c: add ELOOP and EROFS error
	value test
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

And create mknodat.h to encapsulate mknodat syscall.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 configure.ac                                  |   1 +
 m4/ltp-mknodat.m4                             |  25 ++++
 runtest/syscalls                              |   3 +-
 testcases/kernel/syscalls/.gitignore          |   1 +
 testcases/kernel/syscalls/mknodat/mknodat.h   |  34 +++++
 testcases/kernel/syscalls/mknodat/mknodat01.c |  13 +-
 testcases/kernel/syscalls/mknodat/mknodat02.c | 207 ++++++++++++++++++++++++++
 7 files changed, 274 insertions(+), 10 deletions(-)
 create mode 100644 m4/ltp-mknodat.m4
 create mode 100644 testcases/kernel/syscalls/mknodat/mknodat.h
 create mode 100644 testcases/kernel/syscalls/mknodat/mknodat02.c

diff --git a/configure.ac b/configure.ac
index 59460b1..92b4745 100644
--- a/configure.ac
+++ b/configure.ac
@@ -173,5 +173,6 @@ LTP_CHECK_CLONE_SUPPORTS_7_ARGS
 LTP_CHECK_MKDIRAT
 LTP_CHECK_FCHOWNAT
 LTP_CHECK_FCNTL
+LTP_CHECK_MKNODAT
 
 AC_OUTPUT
diff --git a/m4/ltp-mknodat.m4 b/m4/ltp-mknodat.m4
new file mode 100644
index 0000000..1ec22c7
--- /dev/null
+++ b/m4/ltp-mknodat.m4
@@ -0,0 +1,25 @@
+dnl
+dnl Copyright (c) Linux Test Project, 2014
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program;  if not, write to the Free Software
+dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+dnl
+
+dnl
+dnl LTP_CHECK_MKNODAT
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_MKNODAT],[
+AC_CHECK_FUNCS(mknodat,,)
+])
diff --git a/runtest/syscalls b/runtest/syscalls
index 7031c41..7f8b8e5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -561,7 +561,8 @@ mknod08 mknod08
 mknod09 mknod09
 
 #mknodat test cases
-mknodat01 cd $LTPROOT/testcases/bin && chown root mknodat01 && chmod 04755 mknodat01 && mknodat01
+mknodat01 mknodat01
+mknodat02 mknodat02 -D $LTP_DEV -T $LTP_DEV_FS_TYPE
 
 mlock01 mlock01
 mlock02 mlock02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index dc380e3..5f20f3d 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -507,6 +507,7 @@
 /mknod/mknod08
 /mknod/mknod09
 /mknodat/mknodat01
+/mknodat/mknodat02
 /mlock/mlock01
 /mlock/mlock02
 /mlock/mlock03
diff --git a/testcases/kernel/syscalls/mknodat/mknodat.h b/testcases/kernel/syscalls/mknodat/mknodat.h
new file mode 100644
index 0000000..ac14157
--- /dev/null
+++ b/testcases/kernel/syscalls/mknodat/mknodat.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (c) International Business Machines  Corp., 2007
+ * Copyright (c) 2014 Fujitsu Ltd.
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU Library General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ */
+
+#ifndef MKNODAT_H
+#define MKNODAT_H
+
+#include <sys/types.h>
+#include "linux_syscall_numbers.h"
+
+#if !defined(HAVE_MKNODAT)
+int mknodat(int dirfd, const char *filename, mode_t mode, dev_t dev)
+{
+	return ltp_syscall(__NR_mknodat, dirfd, filename, mode, dev);
+}
+#endif
+
+#endif /* MKNODAT_H */
diff --git a/testcases/kernel/syscalls/mknodat/mknodat01.c b/testcases/kernel/syscalls/mknodat/mknodat01.c
index 28a8111..4dbbeb8 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat01.c
+++ b/testcases/kernel/syscalls/mknodat/mknodat01.c
@@ -55,11 +55,11 @@
 #include "test.h"
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
+#include "lapi/fcntl.h"
+#include "mknodat.h"
 
 #define TEST_CASES 5
-#ifndef AT_FDCWD
-#define AT_FDCWD -100
-#endif
+
 void setup();
 void cleanup();
 void setup_every_copy();
@@ -77,11 +77,6 @@ int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0 };
 
 dev_t dev;
 
-int mymknodat(int dirfd, const char *filename, mode_t mode, dev_t dev)
-{
-	return ltp_syscall(__NR_mknodat, dirfd, filename, mode, dev);
-}
-
 int main(int ac, char **av)
 {
 	int lc;
@@ -119,7 +114,7 @@ int main(int ac, char **av)
 		 */
 		for (i = 0; i < TST_TOTAL; i++) {
 
-			TEST(mymknodat(fds[i], filenames[i], S_IFREG, dev));
+			TEST(mknodat(fds[i], filenames[i], S_IFREG, dev));
 
 			/* check return code */
 			if (TEST_ERRNO == expected_errno[i]) {
diff --git a/testcases/kernel/syscalls/mknodat/mknodat02.c b/testcases/kernel/syscalls/mknodat/mknodat02.c
new file mode 100644
index 0000000..aacf6e8
--- /dev/null
+++ b/testcases/kernel/syscalls/mknodat/mknodat02.c
@@ -0,0 +1,207 @@
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
+#include "lapi/fcntl.h"
+#include "mknodat.h"
+
+static void setup(void);
+static void cleanup(void);
+static void help(void);
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
+static int mount_flag;
+
+static option_t options[] = {
+	{"T:", NULL, &fstype},
+	{"D:", NULL, &device},
+	{NULL, NULL, NULL}
+};
+
+static int dirfd;
+static int curfd = AT_FDCWD;
+
+#define ELOPFILE	"/test_eloop"
+static char elooppathname[sizeof(ELOPFILE) * 43] = ".";
+
+static struct test_case_t {
+	int *dirfd;
+	char *pathname;
+	mode_t mode;
+	int exp_errno;
+} test_cases[] = {
+	{ &curfd, "tnode1", FIFOMODE, 0 },
+	{ &curfd, "tnode2", FREGMODE, 0 },
+	{ &curfd, "tnode3", SOCKMODE, 0 },
+	{ &dirfd, "tnode4", FIFOMODE, EROFS },
+	{ &dirfd, "tnode5", FREGMODE, EROFS },
+	{ &dirfd, "tnode6", SOCKMODE, EROFS },
+	{ &curfd, elooppathname, FIFOMODE, ELOOP },
+	{ &curfd, elooppathname, FREGMODE, ELOOP },
+	{ &curfd, elooppathname, SOCKMODE, ELOOP },
+};
+
+static void mknodat_verify(struct test_case_t *tc);
+
+char *TCID = "mknodat";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EROFS, ELOOP, 0 };
+
+int main(int ac, char **av)
+{
+	int lc, i;
+	char *msg;
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
+			mknodat_verify(&test_cases[i]);
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
+	if (tst_kvercmp(2, 6, 16) < 0) {
+		tst_brkm(TCONF, NULL, "This test can only run on kernels "
+			 "that are 2.6.16 and higher");
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
+	/*
+	 * NOTE: the ELOOP test is written based on that the consecutive
+	 * symlinks limits in kernel is hardwired to 40.
+	 */
+	SAFE_MKDIR(cleanup, "test_eloop", DIR_MODE);
+	SAFE_SYMLINK(cleanup, "../test_eloop", "test_eloop/test_eloop");
+	for (i = 0; i < 43; i++)
+		strcat(elooppathname, ELOPFILE);
+}
+
+static void mknodat_verify(struct test_case_t *tc)
+{
+	int fd = *(tc->dirfd);
+	char *pathname = tc->pathname;
+	mode_t mode = tc->mode;
+
+	TEST(mknodat(fd, pathname, mode, 0));
+
+	if (TEST_ERRNO == tc->exp_errno) {
+		tst_resm(TPASS | TTERRNO,
+			 "mknodat() returned the expected value");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "mknodat() got unexpected return value; expected: "
+			 "%d - %s", tc->exp_errno,
+			 strerror(tc->exp_errno));
+	}
+
+	if (TEST_ERRNO == 0 &&
+	    ltp_syscall(__NR_unlinkat, fd, pathname, 0) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup, "unlinkat(%d, %s) "
+			 "failed.", fd, pathname);
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	if (dirfd > 0 && close(dirfd) < 0)
+		tst_resm(TWARN | TERRNO, "close(%d) failed", dirfd);
+	if (mount_flag && umount(MNT_POINT) < 0)
+		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
+
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
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
