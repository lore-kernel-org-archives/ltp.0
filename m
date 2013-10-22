Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1VYWaB-0005As-Ml
	for ltp-list@lists.sourceforge.net; Tue, 22 Oct 2013 07:40:51 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VYWa9-0002PY-DB
	for ltp-list@lists.sourceforge.net; Tue, 22 Oct 2013 07:40:51 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r9M7egQH020345
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Oct 2013 15:40:42 +0800
Message-ID: <52662BFB.9050105@cn.fujitsu.com>
Date: Tue, 22 Oct 2013 15:40:43 +0800
From: "Wang, Xiaoguang" <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] access(2): add ELOOP, ENOTDIR, EROFS error number test
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


access/access05.c: add ELOOP, ENOTDIR error number test

new access/access06.c: add EROFS error number test

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/syscalls                            |    1 +
 testcases/kernel/syscalls/.gitignore        |    1 +
 testcases/kernel/syscalls/access/access05.c |   22 ++++-
 testcases/kernel/syscalls/access/access06.c |  171 +++++++++++++++++++++++++++
 4 files changed, 194 insertions(+), 1 deletions(-)
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
diff --git a/testcases/kernel/syscalls/access/access05.c b/testcases/kernel/syscalls/access/access05.c
index 739b4b2..792692c 100644
--- a/testcases/kernel/syscalls/access/access05.c
+++ b/testcases/kernel/syscalls/access/access05.c
@@ -32,6 +32,10 @@
  *	if the specified file doesn't exist (or pathname is NULL).
  *   5. access() fails with -1 return value and sets errno to ENAMETOOLONG
  *      if the pathname size is > PATH_MAX characters.
+ *   6. access() fails with -1 return value and sets errno to ENOTDIR
+ *      if a component used as a directory in pathname is not a directory.
+ *   7. access() fails with -1 return value and sets errno to ELOOP
+ *      if too many symbolic links were encountered in resolving pathname.
  *
  *   07/2001 Ported by Wayne Boyer
  */
@@ -56,6 +60,8 @@
 #define TEST_FILE2	"test_file2"
 #define TEST_FILE3	"test_file3"
 #define TEST_FILE4	"test_file4"
+#define TEST_FILE5	"test_file5/test_file5"
+#define TEST_FILE6	"test_file6"
 
 
 #if !defined(UCLINUX)
@@ -79,12 +85,15 @@ static struct test_case_t {
 #endif
 	{"", W_OK, ENOENT},
 	{longpathname, R_OK, ENAMETOOLONG},
+	{TEST_FILE5, R_OK, ENOTDIR},
+	{TEST_FILE6, R_OK, ELOOP},
 };
 
 char *TCID = "access05";
 int TST_TOTAL = ARRAY_SIZE(test_cases);
 
-static int exp_enos[] = { EACCES, EFAULT, EINVAL, ENOENT, ENAMETOOLONG, 0 };
+static int exp_enos[] = { EACCES, EFAULT, EINVAL, ENOENT, ENAMETOOLONG,
+			  ENOTDIR, ELOOP, 0 };
 
 static const char nobody_uid[] = "nobody";
 static struct passwd *ltpuser;
@@ -172,6 +181,17 @@ static void setup(void)
 	 *the MAX length of PATH_MAX.
 	 */
 	memset(longpathname, 'a', sizeof(longpathname) - 1);
+
+	/* create test_file5 for test ENOTDIR. */
+	fd = SAFE_CREAT(cleanup, "test_file5", 0644);
+	SAFE_CLOSE(cleanup, fd);
+
+	/*
+	 * create two symbolic links who point to each other for
+	 * test ELOOP.
+	 */
+	SAFE_SYMLINK(cleanup, "test_file6", "test_file7");
+	SAFE_SYMLINK(cleanup, "test_file7", "test_file6");
 }
 
 static void access_verify(int i)
diff --git a/testcases/kernel/syscalls/access/access06.c b/testcases/kernel/syscalls/access/access06.c
new file mode 100644
index 0000000..5c00a9b
--- /dev/null
+++ b/testcases/kernel/syscalls/access/access06.c
@@ -0,0 +1,171 @@
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
+ *  1. access() fails with -1 return value and sets errno to EROFS
+ *     if write permission was requested for files on a read-only file system.
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
+#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+			 S_IXGRP|S_IROTH|S_IXOTH)
+#define MNT_POINT	"mntpoint"
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
+static struct test_case_t {
+	char *pathname;
+	int a_mode;
+	int exp_errno;
+} test_cases[] = {
+	{MNT_POINT, W_OK, EROFS}
+};
+
+char *TCID = "access06";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EROFS, 0 };
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
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	tst_require_root(NULL);
+
+	tst_mkfs(NULL, device, fstype, NULL);
+
+	tst_tmpdir();
+
+	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
+
+	TEST_PAUSE;
+
+	/*
+	 * mount a read-only file system for test EROFS
+	 */
+	if (mount(device, MNT_POINT, fstype, MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+}
+
+static void access_verify(int i)
+{
+	char *file_name;
+	int access_mode;
+
+	file_name = test_cases[i].pathname;
+	access_mode = test_cases[i].a_mode;
+
+	TEST(access(file_name, access_mode));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "access(%s, %#o) succeeded unexpectedly",
+			 file_name, access_mode);
+		return;
+	}
+
+	if (TEST_ERRNO == test_cases[i].exp_errno) {
+		tst_resm(TPASS | TTERRNO, "access failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "access failed unexpectedly; expected: "
+			 "%d - %s", test_cases[i].exp_errno,
+			 strerror(test_cases[i].exp_errno));
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
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
1.7.1

Regards,
Xiaogung Wang


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
