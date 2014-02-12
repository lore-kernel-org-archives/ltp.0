Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WDRnp-0005iK-M6
	for ltp-list@lists.sourceforge.net; Wed, 12 Feb 2014 04:52:05 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WDRnj-0005iE-QY
	for ltp-list@lists.sourceforge.net; Wed, 12 Feb 2014 04:52:05 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1C4pdIq024709
	for <ltp-list@lists.sourceforge.net>; Wed, 12 Feb 2014 12:51:39 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 12 Feb 2014 12:50:24 +0800
Message-Id: <1392180624-18697-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH v2] getdents/getdents02.c: add ENOENT test for
	getdents(2)
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

Merge getdents02.c, getdents03.c, getdents04.c into one getdents02
test, which contains EBADF, EINVAL and ENOTDIR error value tests.

And add new ENOENT error value test.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/ltplite                                 |   2 -
 runtest/stress.part3                            |   2 -
 runtest/syscalls                                |   4 -
 testcases/kernel/syscalls/getdents/getdents02.c | 160 ++++++++++++++++++------
 testcases/kernel/syscalls/getdents/getdents03.c | 126 -------------------
 testcases/kernel/syscalls/getdents/getdents04.c | 127 -------------------
 6 files changed, 125 insertions(+), 296 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/getdents/getdents03.c
 delete mode 100644 testcases/kernel/syscalls/getdents/getdents04.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 2f8f977..2e44f09 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -276,8 +276,6 @@ getcwd03 getcwd03
 
 getdents01 getdents01
 getdents02 getdents02
-getdents03 getdents03
-getdents04 getdents04
 
 getdomainname01 getdomainname01
 
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 5703d13..187adf9 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -215,8 +215,6 @@ getcwd03 getcwd03
 
 getdents01 getdents01
 getdents02 getdents02
-getdents03 getdents03
-getdents04 getdents04
 
 getdomainname01 getdomainname01
 
diff --git a/runtest/syscalls b/runtest/syscalls
index 083c240..f794143 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -326,13 +326,9 @@ getcwd03 getcwd03
 
 getdents01 getdents01
 getdents02 getdents02
-getdents03 getdents03
-getdents04 getdents04
 
 getdents01_64 getdents01 -l
 getdents02_64 getdents02 -l
-getdents03_64 getdents03 -l
-getdents04_64 getdents04 -l
 
 getdomainname01 getdomainname01
 
diff --git a/testcases/kernel/syscalls/getdents/getdents02.c b/testcases/kernel/syscalls/getdents/getdents02.c
index 66cf89f..275fedf 100644
--- a/testcases/kernel/syscalls/getdents/getdents02.c
+++ b/testcases/kernel/syscalls/getdents/getdents02.c
@@ -19,6 +19,21 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
+/*
+ * Test Description:
+ *  Verify that,
+ *   1. getdents() fails with -1 return value and sets errno to EBADF
+ *      if file descriptor fd is invalid.
+ *   2. getdents() fails with -1 return value and sets errno to EINVAL
+ *      if result buffer is too small.
+ *   3. getdents() fails with -1 return value and sets errno to ENOTDIR
+ *      if file descriptor does not refer to a directory.
+ *   4. getdents() fails with -1 return value and sets errno to ENOENT
+ *      if there is no such directory.
+ *
+ */
+
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <sys/types.h>
@@ -28,14 +43,29 @@
 #include "test.h"
 #include "usctest.h"
 #include "getdents.h"
+#include "safe_macros.h"
+
+#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+			 S_IXGRP|S_IROTH|S_IXOTH)
+#define TEST_DIR	"test_dir"
 
 static void cleanup(void);
 static void setup(void);
+static void print_test_result(int err, int exp_errno);
 
 char *TCID = "getdents02";
-int TST_TOTAL = 1;
 
-static int exp_enos[] = { EBADF, 0 };
+static int exp_enos[] = { EBADF, EINVAL, ENOTDIR, ENOENT, 0 };
+
+static void test_ebadf(void);
+static void test_einval(void);
+static void test_enotdir(void);
+static void test_enoent(void);
+
+static void (*testfunc[])(void) = { test_ebadf, test_einval,
+				    test_enotdir, test_enoent };
+
+int TST_TOTAL = ARRAY_SIZE(testfunc);
 
 static int longsyscall;
 
@@ -52,11 +82,8 @@ static void help(void)
 
 int main(int ac, char **av)
 {
-	int lc;
+	int lc, i;
 	char *msg;
-	int rval;
-	struct linux_dirent64 dirp64;
-	struct linux_dirent dirp;
 
 	if ((msg = parse_opts(ac, av, options, &help)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
@@ -64,37 +91,10 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int fd = -5;
-
 		tst_count = 0;
 
-		if (longsyscall)
-			rval = getdents64(fd, &dirp64, sizeof(dirp64));
-		else
-			rval = getdents(fd, &dirp, sizeof(dirp));
-
-		/*
-		 * Hopefully we get an error due to the bad file descriptor.
-		 */
-		if (rval < 0) {
-			TEST_ERROR_LOG(errno);
-
-			switch (errno) {
-			case EBADF:
-				tst_resm(TPASS,
-					 "failed as expected with EBADF");
-			break;
-			case ENOSYS:
-				tst_resm(TCONF, "syscall not implemented");
-			break;
-			default:
-				tst_resm(TFAIL | TERRNO,
-					 "getdents failed unexpectedly");
-			break;
-			}
-		} else {
-			tst_resm(TFAIL, "call succeeded unexpectedly");
-		}
+		for (i = 0; i < TST_TOTAL; i++)
+			(*testfunc[i])();
 	}
 
 	cleanup();
@@ -112,6 +112,96 @@ static void setup(void)
 	TEST_PAUSE;
 }
 
+static void print_test_result(int err, int exp_errno)
+{
+	TEST_ERROR_LOG(err);
+	if (err == 0) {
+		tst_resm(TFAIL, "call succeeded unexpectedly");
+	} else if  (err == exp_errno) {
+		tst_resm(TPASS, "getdents failed as expected: %s",
+			 strerror(err));
+	} else if (err == ENOSYS) {
+		tst_resm(TCONF, "syscall not implemented");
+	} else {
+		tst_resm(TFAIL, "getdents failed unexpectedly: %s",
+			 strerror(err));
+	}
+}
+
+static void test_ebadf(void)
+{
+	int fd = -5;
+	struct linux_dirent64 dirp64;
+	struct linux_dirent dirp;
+
+	if (longsyscall)
+		getdents64(fd, &dirp64, sizeof(dirp64));
+	else
+		getdents(fd, &dirp, sizeof(dirp));
+
+	print_test_result(errno, EBADF);
+}
+
+static void test_einval(void)
+{
+	int fd;
+	char buf[1];
+
+	fd = SAFE_OPEN(cleanup, ".", O_RDONLY);
+
+	/* Pass one byte long buffer. The result should be EINVAL */
+	if (longsyscall)
+		getdents64(fd, (void *)buf, sizeof(buf));
+	else
+		getdents(fd, (void *)buf, sizeof(buf));
+
+	print_test_result(errno, EINVAL);
+
+	SAFE_CLOSE(cleanup, fd);
+}
+
+static void test_enotdir(void)
+{
+	int fd;
+	struct linux_dirent64 dir64;
+	struct linux_dirent dir;
+
+	fd = SAFE_OPEN(cleanup, "test", O_CREAT | O_RDWR);
+
+	if (longsyscall)
+		getdents64(fd, &dir64, sizeof(dir64));
+	else
+		getdents(fd, &dir, sizeof(dir));
+
+	print_test_result(errno, ENOTDIR);
+
+	SAFE_CLOSE(cleanup, fd);
+}
+
+static void test_enoent(void)
+{
+	int fd;
+	struct linux_dirent64 dir64;
+	struct linux_dirent dir;
+
+	SAFE_MKDIR(cleanup, TEST_DIR, DIR_MODE);
+
+	fd = SAFE_OPEN(cleanup, TEST_DIR, O_DIRECTORY);
+	if (rmdir(TEST_DIR) == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "rmdir(%s) failed", TEST_DIR);
+	}
+
+	if (longsyscall)
+		getdents64(fd, &dir64, sizeof(dir64));
+	else
+		getdents(fd, &dir, sizeof(dir));
+
+	print_test_result(errno, ENOENT);
+
+	SAFE_CLOSE(cleanup, fd);
+}
+
 static void cleanup(void)
 {
 	TEST_CLEANUP;
diff --git a/testcases/kernel/syscalls/getdents/getdents03.c b/testcases/kernel/syscalls/getdents/getdents03.c
deleted file mode 100644
index 5a7b295..0000000
--- a/testcases/kernel/syscalls/getdents/getdents03.c
+++ /dev/null
@@ -1,126 +0,0 @@
-/*
- * Copyright (c) International Business Machines  Corp., 2001
- *	         written by Wayne Boyer
- * Copyright (c) 2013 Markos Chandras
- * Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-#include <stdio.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-
-#include "test.h"
-#include "usctest.h"
-#include "getdents.h"
-
-static void cleanup(void);
-static void setup(void);
-
-char *TCID = "getdents03";
-int TST_TOTAL = 1;
-
-static int exp_enos[] = { EINVAL, 0 };
-
-static int longsyscall;
-
-static option_t options[] = {
-		/* -l long option. Tests getdents64 */
-		{"l", &longsyscall, NULL},
-		{NULL, NULL, NULL}
-};
-
-static void help(void)
-{
-	printf("  -l      Test the getdents64 system call\n");
-}
-
-int main(int ac, char **av)
-{
-	int lc;
-	char *msg;
-	int rval, fd;
-	char buf[1];
-
-	if ((msg = parse_opts(ac, av, options, &help)) != NULL)
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		if ((fd = open(".", O_RDONLY)) == -1)
-			tst_brkm(TBROK, cleanup, "open of directory failed");
-
-		/* Pass one byte long buffer. The result should be EINVAL */
-		if (longsyscall)
-			rval = getdents64(fd, (void *)buf, sizeof(buf));
-		else
-			rval = getdents(fd, (void *)buf, sizeof(buf));
-
-		/*
-		 * Hopefully we get an error due to the small buffer.
-		 */
-		if (rval < 0) {
-			TEST_ERROR_LOG(errno);
-
-			switch (errno) {
-			case EINVAL:
-				tst_resm(TPASS,
-					 "getdents failed with EINVAL as expected");
-			break;
-			case ENOSYS:
-				tst_resm(TCONF, "syscall not implemented");
-			break;
-			default:
-				tst_resm(TFAIL | TERRNO,
-					 "getdents call failed unexpectedly");
-				break;
-			}
-		} else {
-			tst_resm(TFAIL, "getdents passed unexpectedly");
-		}
-
-		if (close(fd) == -1)
-			tst_brkm(TBROK, cleanup, "fd close failed");
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	TEST_EXP_ENOS(exp_enos);
-
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-	TEST_CLEANUP;
-
-	tst_rmdir();
-}
diff --git a/testcases/kernel/syscalls/getdents/getdents04.c b/testcases/kernel/syscalls/getdents/getdents04.c
deleted file mode 100644
index 5d94cda..0000000
--- a/testcases/kernel/syscalls/getdents/getdents04.c
+++ /dev/null
@@ -1,127 +0,0 @@
-/*
- * Copyright (c) International Business Machines  Corp., 2001
- *	         written by Wayne Boyer
- * Copyright (c) 2013 Markos Chandras
- * Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-#include <stdio.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-
-#include "test.h"
-#include "usctest.h"
-#include "getdents.h"
-
-static void cleanup(void);
-static void setup(void);
-
-char *TCID = "getdents04";
-int TST_TOTAL = 1;
-
-static int exp_enos[] = { ENOTDIR, 0 };
-
-static int longsyscall;
-
-static option_t options[] = {
-		/* -l long option. Tests getdents64 */
-		{"l", &longsyscall, NULL},
-		{NULL, NULL, NULL}
-};
-
-static void help(void)
-{
-	printf("  -l      Test the getdents64 system call\n");
-}
-
-int main(int ac, char **av)
-{
-	int lc;
-	char *msg;
-	int rval, fd;
-	struct linux_dirent64 dir64;
-	struct linux_dirent dir;
-
-	if ((msg = parse_opts(ac, av, options, &help)) != NULL)
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		if ((fd = open("test", O_CREAT | O_RDWR, 0777)) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "open of file failed");
-
-		if (longsyscall)
-			rval = getdents64(fd, &dir64, sizeof(dir64));
-		else
-			rval = getdents(fd, &dir, sizeof(dir));
-
-		/*
-		 * Calling with a non directory file descriptor should give
-		 * an ENOTDIR error.
-		 */
-		if (rval < 0) {
-			TEST_ERROR_LOG(errno);
-
-			switch (errno) {
-			case ENOTDIR:
-				tst_resm(TPASS,
-					 "getdents failed as expected with ENOTDIR");
-			break;
-			case ENOSYS:
-				tst_resm(TCONF, "syscall not implemented");
-			break;
-			break;
-			default:
-				tst_resm(TFAIL | TERRNO,
-					 "getdents failed unexpectedly");
-			break;
-			}
-		} else {
-			tst_resm(TFAIL, "getdents call succeeded unexpectedly");
-		}
-
-		if (close(fd) == -1)
-			tst_brkm(TBROK, cleanup, "fd close failed");
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_tmpdir();
-
-	TEST_EXP_ENOS(exp_enos);
-
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-	TEST_CLEANUP;
-
-	tst_rmdir();
-}
-- 
1.8.2.1


------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
