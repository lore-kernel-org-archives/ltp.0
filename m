Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Vw6z1-0007UQ-T5
	for ltp-list@lists.sourceforge.net; Thu, 26 Dec 2013 09:11:59 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vw6z0-0007m4-GZ
	for ltp-list@lists.sourceforge.net; Thu, 26 Dec 2013 09:11:59 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rBQ9Bm0B020674
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Dec 2013 17:11:48 +0800
Message-ID: <1388049105.1587.22.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Thu, 26 Dec 2013 17:11:45 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH] link/link08.c: add new tests for link(2)
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
EPERM, EXDEV, EROFS

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ltplite                         |   1 +
 runtest/stress.part3                    |   1 +
 runtest/syscalls                        |   1 +
 testcases/kernel/syscalls/.gitignore    |   1 +
 testcases/kernel/syscalls/link/link08.c | 177 ++++++++++++++++++++++++++++++++
 5 files changed, 181 insertions(+)
 create mode 100644 testcases/kernel/syscalls/link/link08.c

diff --git a/runtest/ltplite b/runtest/ltplite
index c90bc48..9d733be 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -380,6 +380,7 @@ link04 link04
 link05 link05
 link06 link06
 link07 link07
+link08 link08 -D DEVICE -T DEVICE_FS_TYPE
 
 listen01 listen01
 
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index eac28d0..979054a 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -313,6 +313,7 @@ link04 link04
 link05 link05
 link06 link06
 link07 link07
+link08 link08 -D DEVICE -T DEVICE_FS_TYPE
 
 listen01 listen01
 
diff --git a/runtest/syscalls b/runtest/syscalls
index 5985a01..0017186 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -483,6 +483,7 @@ link04 link04
 link05 link05
 link06 link06
 link07 link07
+link08 link08 -D DEVICE -T DEVICE_FS_TYPE
 
 #linkat test cases
 linkat01 linkat01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index bbefb25..9f0aa1f 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -443,6 +443,7 @@
 /link/link05
 /link/link06
 /link/link07
+/link/link08
 /linkat/linkat01
 /listen/listen01
 /llseek/llseek01
diff --git a/testcases/kernel/syscalls/link/link08.c b/testcases/kernel/syscalls/link/link08.c
new file mode 100644
index 0000000..71ee562
--- /dev/null
+++ b/testcases/kernel/syscalls/link/link08.c
@@ -0,0 +1,177 @@
+/*
+ * Copyright (c) International Business Machines  Corp., 2007
+ * Copyright (c) 2013 Fujitsu Ltd.
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
+#define	TEST_FILE	"testfile"
+#define	TEST_FILE1	"testfile1"
+#define	TEST_FILE2	"mntpoint/testfile2"
+#define	TEST_FILE3	"mntpoint/testfile3"
+
+static void setup(void);
+static void cleanup(void);
+static void help(void);
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
+	char *oldpath;
+	char *newpath;
+	char *exp_errval;
+	int exp_errno;
+} test_cases[] = {
+	{TEST_FILE1, TEST_FILE, "EPERM", EPERM},
+	{TEST_FILE2, TEST_FILE, "EXDEV", EXDEV},
+	{TEST_FILE2, TEST_FILE3, "EROFS", EROFS},
+};
+
+char *TCID = "link08";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EPERM, EXDEV, EROFS, 0 };
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
+	if (!dflag) {
+		tst_brkm(TBROK, NULL,
+			 "you must specify the device used for mounting with "
+			 "-D option");
+	}
+
+	setup();
+
+	TEST_EXP_ENOS(exp_enos);
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++) {
+
+			TEST(link(test_cases[i].oldpath,
+				  test_cases[i].newpath));
+
+			if (TEST_RETURN != -1) {
+				tst_resm(TFAIL,
+					 "link() returned %ld, expected -1, "
+					 "errno=%d", TEST_RETURN,
+					 test_cases[i].exp_errno);
+			} else {
+				TEST_ERROR_LOG(TEST_ERRNO);
+
+				if (TEST_ERRNO == test_cases[i].exp_errno) {
+					tst_resm(TPASS,
+						 "link() fails with expected "
+						 "error %s errno:%d",
+						 test_cases[i].exp_errval,
+						 TEST_ERRNO);
+				} else {
+					tst_resm(TFAIL,
+						 "link() fails, %s, errno=%d, "
+						 "expected errno=%d",
+						 test_cases[i].exp_errval,
+						 TEST_ERRNO,
+						 test_cases[i].exp_errno);
+				}
+			}
+		}
+	}
+
+	cleanup();
+	tst_exit();
+
+}
+
+static void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	SAFE_MKDIR(cleanup, TEST_FILE1, DIR_MODE);
+
+	tst_mkfs(NULL, device, fstype, NULL);
+	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
+	if (mount(device, "mntpoint", fstype, 0, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+	SAFE_TOUCH(cleanup, TEST_FILE2, 0644, NULL);
+	if (mount(device, "mntpoint", fstype,
+		  MS_REMOUNT | MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	if (mount_flag && umount("mntpoint") < 0) {
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
1.8.2.1




------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
