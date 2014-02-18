Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WFlDs-0000lg-Tn
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 14:00:32 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WFlDp-0007Ku-U9
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 14:00:32 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1IE0LHt008004
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Feb 2014 22:00:21 +0800
Message-ID: <1392732018.2654.7.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 18 Feb 2014 22:00:18 +0800
In-Reply-To: <1388049105.1587.22.camel@G08JYZSD130126>
References: <1388049105.1587.22.camel@G08JYZSD130126>
Mime-Version: 1.0
Subject: [LTP] [PATCH v2] link/link08.c: add new error tests
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

Add new error number tests for link(2):
* EPERM
* EXDEV
* EROFS
* ELOOP

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ltplite                         |   1 +
 runtest/stress.part3                    |   1 +
 runtest/syscalls                        |   1 +
 testcases/kernel/syscalls/.gitignore    |   1 +
 testcases/kernel/syscalls/link/link08.c | 191 ++++++++++++++++++++++++++++++++
 5 files changed, 195 insertions(+)
 create mode 100644 testcases/kernel/syscalls/link/link08.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 9a8a78c..81c99d3 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -381,6 +381,7 @@ link04 link04
 link05 link05
 link06 link06
 link07 link07
+link08 link08 -D $LTP_DEV -T $LTP_DEV_FS_TYPE
 
 listen01 listen01
 
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 458d267..28ec059 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -314,6 +314,7 @@ link04 link04
 link05 link05
 link06 link06
 link07 link07
+link08 link08 -D $LTP_DEV -T $LTP_DEV_FS_TYPE
 
 listen01 listen01
 
diff --git a/runtest/syscalls b/runtest/syscalls
index 794f140..b1c53d2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -484,6 +484,7 @@ link04 link04
 link05 link05
 link06 link06
 link07 link07
+link08 link08 -D $LTP_DEV -T $LTP_DEV_FS_TYPE
 
 #linkat test cases
 linkat01 linkat01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index cf446b0..43536fb 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -450,6 +450,7 @@
 /link/link05
 /link/link06
 /link/link07
+/link/link08
 /linkat/linkat01
 /listen/listen01
 /llseek/llseek01
diff --git a/testcases/kernel/syscalls/link/link08.c b/testcases/kernel/syscalls/link/link08.c
new file mode 100644
index 0000000..d6d63ef
--- /dev/null
+++ b/testcases/kernel/syscalls/link/link08.c
@@ -0,0 +1,191 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
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
+/*
+ * Test Description:
+ *  Verify that,
+ *   1. link() fails with -1 return value and sets errno to EPERM
+ *      if oldpath is a directory.
+ *   2. link() fails with -1 return value and sets errno to EXDEV
+ *      if oldpath and newpath are not on the same mounted file system( Linux
+ *      permits a file system to be mounted at multiple points, but link()
+ *      does not work across different mount points, even if the same
+ *      file system is mounted on both. ).
+ *   3. link() fails with -1 return value and sets errno to EROFS
+ *      if the file is on a read-only file system.
+ *   4. link() fails with -1 return value and sets errno to ELOOP
+ *      if too many symbolic links were encountered in resolving path.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <pwd.h>
+#include <sys/mount.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+			 S_IXGRP|S_IROTH|S_IXOTH)
+#define MNT_POINT	"mntpoint"
+#define TEST_FILE	"testfile"
+#define TEST_FILE1	"testfile1"
+#define TEST_FILE2	"mntpoint/testfile3"
+#define TEST_FILE3	"mntpoint/testfile4"
+
+static char test_file4[PATH_MAX] = ".";
+static void setup(void);
+static void cleanup(void);
+static void help(void);
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
+static struct test_case_t {
+	char *oldpath;
+	char *newpath;
+	int exp_errno;
+} test_cases[] = {
+	{TEST_FILE1, TEST_FILE, EPERM},
+	{TEST_FILE2, TEST_FILE, EXDEV},
+	{TEST_FILE2, TEST_FILE3, EROFS},
+	{test_file4, TEST_FILE, ELOOP},
+};
+
+static void link_verify(const struct test_case_t *);
+
+char *TCID = "link08";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EPERM, EXDEV, EROFS, 0 };
+
+int main(int ac, char **av)
+{
+	int i, lc;
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
+			link_verify(&test_cases[i]);
+	}
+
+	cleanup();
+	tst_exit();
+
+}
+
+static void link_verify(const struct test_case_t *tc)
+{
+	TEST(link(tc->oldpath, tc->newpath));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "link succeeded unexpectedly");
+		return;
+	}
+
+	if (TEST_ERRNO == tc->exp_errno) {
+		tst_resm(TPASS | TTERRNO, "link failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "link failed unexpectedly; expected: %d - %s",
+			 tc->exp_errno, strerror(tc->exp_errno));
+	}
+}
+
+
+static void setup(void)
+{
+	int i;
+
+	tst_require_root(NULL);
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_EXP_ENOS(exp_enos);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	SAFE_MKDIR(cleanup, TEST_FILE1, DIR_MODE);
+
+	SAFE_MKDIR(cleanup, "test_eloop", DIR_MODE);
+	SAFE_SYMLINK(cleanup, "../test_eloop", "test_eloop/test_eloop");
+	for (i = 0; i < 43; i++)
+		strcat(test_file4, "/test_eloop");
+
+	tst_mkfs(NULL, device, fstype, NULL);
+	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
+	if (mount(device, MNT_POINT, fstype, 0, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+
+	SAFE_TOUCH(cleanup, TEST_FILE2, 0644, NULL);
+	if (mount(device, MNT_POINT, fstype,
+		  MS_REMOUNT | MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	if (mount_flag && umount(MNT_POINT) < 0)
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
