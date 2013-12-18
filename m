Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1VtC4g-0000kr-BI
	for ltp-list@lists.sourceforge.net; Wed, 18 Dec 2013 08:01:46 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VtC4e-0000s2-7o
	for ltp-list@lists.sourceforge.net; Wed, 18 Dec 2013 08:01:46 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rBI81WKo009078
	for <ltp-list@lists.sourceforge.net>; Wed, 18 Dec 2013 16:01:32 +0800
Message-ID: <52B1565D.50406@cn.fujitsu.com>
Date: Wed, 18 Dec 2013 16:01:33 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] getdents/getdents05.c: add ENOENT test for getdents(2)
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


create a new case to test ENOENT error value for getdents(2)

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/ltplite                                 |   1 +
 runtest/stress.part3                            |   1 +
 runtest/syscalls                                |   2 +
 testcases/kernel/syscalls/getdents/getdents05.c | 133 ++++++++++++++++++++++++
 4 files changed, 137 insertions(+)
 create mode 100644 testcases/kernel/syscalls/getdents/getdents05.c

diff --git a/runtest/ltplite b/runtest/ltplite
index c90bc48..953f5a6 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -277,6 +277,7 @@ getdents01 getdents01
 getdents02 getdents02
 getdents03 getdents03
 getdents04 getdents04
+getdents05 getdents05
 
 getdomainname01 getdomainname01
 
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index eac28d0..a4b1a66 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -216,6 +216,7 @@ getdents01 getdents01
 getdents02 getdents02
 getdents03 getdents03
 getdents04 getdents04
+getdents05 getdents05
 
 getdomainname01 getdomainname01
 
diff --git a/runtest/syscalls b/runtest/syscalls
index c5bbe8f..aa2d30c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -327,11 +327,13 @@ getdents01 getdents01
 getdents02 getdents02
 getdents03 getdents03
 getdents04 getdents04
+getdents05 getdents05
 
 getdents01_64 getdents01 -l
 getdents02_64 getdents02 -l
 getdents03_64 getdents03 -l
 getdents04_64 getdents04 -l
+getdents05_64 getdents05 -l
 
 getdomainname01 getdomainname01
 
diff --git a/testcases/kernel/syscalls/getdents/getdents05.c b/testcases/kernel/syscalls/getdents/getdents05.c
new file mode 100644
index 0000000..b4df82a
--- /dev/null
+++ b/testcases/kernel/syscalls/getdents/getdents05.c
@@ -0,0 +1,133 @@
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
+ * Test Description:
+ *   test ENOENT error value for getdents(2)
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "getdents.h"
+
+static void cleanup(void);
+static void setup(void);
+
+#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+			 S_IXGRP|S_IROTH|S_IXOTH)
+#define TEST_DIR	"test_dir"
+
+char *TCID = "getdents05";
+int TST_TOTAL = 1;
+
+static int exp_enos[] = { ENOENT, 0 };
+
+static int longsyscall;
+
+static option_t options[] = {
+		/* -l long option. Tests getdents64 */
+		{"l", &longsyscall, NULL},
+		{NULL, NULL, NULL}
+};
+
+static void help(void)
+{
+	printf("  -l      Test the getdents64 system call\n");
+}
+
+int main(int ac, char **av)
+{
+	int lc;
+	char *msg;
+	int rval, fd;
+	struct linux_dirent64 dir64;
+	struct linux_dirent dir;
+
+	msg = parse_opts(ac, av, options, &help);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		SAFE_MKDIR(cleanup, TEST_DIR, DIR_MODE);
+
+		fd = SAFE_OPEN(cleanup, TEST_DIR, O_DIRECTORY);
+		if (rmdir(TEST_DIR) == -1) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "rmdir(%s) failed", TEST_DIR);
+		}
+
+		if (longsyscall)
+			rval = getdents64(fd, &dir64, sizeof(dir64));
+		else
+			rval = getdents(fd, &dir, sizeof(dir));
+
+		if (rval < 0) {
+			TEST_ERROR_LOG(errno);
+
+			switch (errno) {
+			case ENOENT:
+				tst_resm(TPASS, "getdents failed as "
+					 "expected with ENOENT");
+			break;
+			case ENOSYS:
+				tst_resm(TCONF, "syscall not implemented");
+			break;
+			default:
+				tst_resm(TFAIL | TERRNO,
+					 "getdents failed unexpectedly");
+			break;
+			}
+		} else {
+			tst_resm(TFAIL, "getdents call succeeded unexpectedly");
+		}
+
+		SAFE_CLOSE(cleanup, fd);
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
+	tst_tmpdir();
+
+	TEST_EXP_ENOS(exp_enos);
+
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	tst_rmdir();
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
