Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Vw6y5-0002YB-9u
	for ltp-list@lists.sourceforge.net; Thu, 26 Dec 2013 09:11:01 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vw6y3-0007GN-Dc
	for ltp-list@lists.sourceforge.net; Thu, 26 Dec 2013 09:11:01 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rBQ9AomW020566
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Dec 2013 17:10:51 +0800
Message-ID: <1388049047.1587.21.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Thu, 26 Dec 2013 17:10:47 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH] lchown/lchown03.c: add EROFS error number test
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

Add EROFS error number test for fchown(2)
Add lchown03, lchown03_16 to .gitignore
Add '-D DEVICE -T DEVICE_FS_TYPE' for lchown03 and lchown03_16

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ltplite                             |   1 +
 runtest/stress.part3                        |   1 +
 runtest/syscalls                            |   2 +
 testcases/kernel/syscalls/.gitignore        |   2 +
 testcases/kernel/syscalls/lchown/lchown03.c | 162 ++++++++++++++++++++++++++++
 5 files changed, 168 insertions(+)
 create mode 100644 testcases/kernel/syscalls/lchown/lchown03.c

diff --git a/runtest/ltplite b/runtest/ltplite
index c90bc48..333d3f7 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -372,6 +372,7 @@ kill12 kill12
 
 lchown01 lchown01
 lchown02 lchown02
+lchown03 lchown03 -D DEVICE -T DEVICE_FS_TYPE
 
 link01 symlink01 -T link01
 link02 link02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index eac28d0..f4728a7 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -305,6 +305,7 @@ kill12 kill12
 
 lchown01 lchown01
 lchown02 lchown02
+lchown03 lchown03 -D DEVICE -T DEVICE_FS_TYPE
 
 link01 symlink01 -T link01
 link02 link02
diff --git a/runtest/syscalls b/runtest/syscalls
index c5bbe8f..7598d99 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -474,7 +474,9 @@ kill12 kill12
 lchown01 lchown01
 lchown01_16 lchown01_16
 lchown02  lchown02
+lchown03  lchown03 -D DEVICE -T DEVICE_FS_TYPE
 lchown02_16 lchown02_16
+lchown03_16 lchown03_16 -D DEVICE -T DEVICE_FS_TYPE
 
 link01 symlink01 -T link01
 link02 link02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index bbefb25..d06c83d 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -437,6 +437,8 @@
 /lchown/lchown01_16
 /lchown/lchown02
 /lchown/lchown02_16
+/lchown/lchown03
+/lchown/lchown03_16
 /link/link02
 /link/link03
 /link/link04
diff --git a/testcases/kernel/syscalls/lchown/lchown03.c b/testcases/kernel/syscalls/lchown/lchown03.c
new file mode 100644
index 0000000..68bd12e
--- /dev/null
+++ b/testcases/kernel/syscalls/lchown/lchown03.c
@@ -0,0 +1,162 @@
+/*
+ * Copyright (c) 2013 Fujitsu Ltd.
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
+ * with this program.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <string.h>
+#include <signal.h>
+#include <grp.h>
+#include <pwd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <sys/mount.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+			 S_IXGRP|S_IROTH|S_IXOTH)
+#define TEST_FILE	"mntpoint"
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
+	char *desc;
+	int exp_errno;
+	void (*setup) (int pos);
+} test_cases[] = {
+	{TEST_FILE, "EROFS", EROFS, NULL},
+};
+
+char *TCID = "lchown03";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EROFS, 0 };
+
+static void setup(void);
+static void cleanup(void);
+static void help(void);
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	char *msg;
+	uid_t user_id;
+	gid_t group_id;
+	int i;
+
+	msg = parse_opts(argc, argv, options, help);
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
+	user_id = geteuid();
+	group_id = getegid();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++) {
+
+			TEST(lchown(test_cases[i].pathname, user_id, group_id));
+
+			if (TEST_RETURN == -1) {
+				TEST_ERROR_LOG(TEST_ERRNO);
+				if (TEST_ERRNO == test_cases[i].exp_errno) {
+					tst_resm(TPASS,
+						 "lchown(2) fails,%s, errno:%d",
+						 test_cases[i].desc,
+						 TEST_ERRNO);
+				} else {
+					tst_resm(TFAIL,
+						 "lchown(2) fails, %s, errno:"
+						 "%d, expected errno:%d",
+						 test_cases[i].desc, TEST_ERRNO,
+						 test_cases[i].exp_errno);
+				}
+			} else {
+				tst_resm(TFAIL,
+					 "lchown(2) returned %ld, expected -1, "
+					 "errno:%d", TEST_RETURN,
+					 test_cases[i].exp_errno);
+			}
+		}
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	tst_require_root(NULL);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	tst_mkfs(NULL, device, fstype, NULL);
+	SAFE_MKDIR(cleanup, TEST_FILE, DIR_MODE);
+	if (mount(device, TEST_FILE, fstype, MS_RDONLY, NULL) < 0) {
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
+	if (mount_flag && umount(TEST_FILE) < 0) {
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
