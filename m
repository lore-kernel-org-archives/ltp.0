Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WGgQ3-0007CH-Pj
	for ltp-list@lists.sourceforge.net; Fri, 21 Feb 2014 03:04:55 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WGgQ0-0002zT-NR
	for ltp-list@lists.sourceforge.net; Fri, 21 Feb 2014 03:04:55 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1L34hiU002928
	for <ltp-list@lists.sourceforge.net>; Fri, 21 Feb 2014 11:04:43 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Fri, 21 Feb 2014 11:03:09 +0800
Message-Id: <1392951789-12569-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH] msync/msync03.c: add EBUSY test for msync(2)
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

Merge msync03.c, msync04.c, msync05.c into one msync03
test, which contains EINVAL and ENOMEM error value tests.

And add new EBUSY error value test.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/ltplite                           |   2 -
 runtest/stress.part3                      |   2 -
 runtest/syscalls                          |   2 -
 testcases/kernel/syscalls/.gitignore      |   2 -
 testcases/kernel/syscalls/msync/msync03.c | 225 ++++++++++++++++++------------
 testcases/kernel/syscalls/msync/msync04.c | 158 ---------------------
 testcases/kernel/syscalls/msync/msync05.c | 136 ------------------
 7 files changed, 136 insertions(+), 391 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/msync/msync04.c
 delete mode 100644 testcases/kernel/syscalls/msync/msync05.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 4bd1c53..40e194d 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -504,8 +504,6 @@ msgsnd06 msgsnd06
 msync01 msync01
 msync02 msync02
 msync03 msync03
-msync04 msync04
-msync05 msync05
 
 munlock01 munlock01
 munlock02 munlock02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index d631c19..aa89495 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -427,8 +427,6 @@ msgsnd06 msgsnd06
 msync01 msync01
 msync02 msync02
 msync03 msync03
-msync04 msync04
-msync05 msync05
 
 munlock01 munlock01
 munlock02 munlock02
diff --git a/runtest/syscalls b/runtest/syscalls
index 540c130..8a31c56 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -658,8 +658,6 @@ msgsnd06 msgsnd06
 msync01 msync01
 msync02 msync02
 msync03 msync03
-msync04 msync04
-msync05 msync05
 
 munlock01 munlock01
 munlock02 munlock02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 2fc0c99..de489f7 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -560,8 +560,6 @@
 /msync/msync01
 /msync/msync02
 /msync/msync03
-/msync/msync04
-/msync/msync05
 /munlock/munlock01
 /munlock/munlock02
 /munlockall/munlockall01
diff --git a/testcases/kernel/syscalls/msync/msync03.c b/testcases/kernel/syscalls/msync/msync03.c
index e152f2c..cc1f186 100644
--- a/testcases/kernel/syscalls/msync/msync03.c
+++ b/testcases/kernel/syscalls/msync/msync03.c
@@ -1,138 +1,185 @@
 /*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
- * Test Name: msync03
- *
- * Test Description:
- *  Verify that, msync() fails, when the region to synchronize, is outside
- *  the address space of the process.
- *
- * Expected Result:
- *  msync() should fail with a return value of -1, and errno should be
- *  set to EINVAL.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *      if errno set == expected errno
- *              Issue sys call fails with expected return value and errno.
- *      Otherwise,
- *              Issue sys call fails with unexpected errno.
- *   Otherwise,
- *      Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *
- * Usage:  <for command-line>
- *  msync03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *	       -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS:
- *  None.
+ * Description:
+ * Verify that,
+ *  1. msync() fails with -1 return value and sets errno to EBUSY
+ *     if MS_INVALIDATE was specified in flags, and a memory lock
+ *     exists for the specified address range.
+ *  2. msync() fails with -1 return value and sets errno to EINVAL
+ *     if addr is not a multiple of PAGESIZE; or any bit other than
+ *     MS_ASYNC | MS_INVALIDATE | MS_SYNC is set in flags; or both
+ *     MS_SYNC and MS_ASYNC are set in flags.
+ *  3. msync() fails with -1 return value and sets errno to ENOMEM
+ *     if the indicated memory (or part of it) was not mapped.
  */
+
+#include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <sys/stat.h>
 #include <sys/mman.h>
+#include <sys/mount.h>
+#include <pwd.h>
 #include <sys/resource.h>
 
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
+
+#define INV_SYNC	-1
+#define TEMPFILE	"msync_file"
+#define BUF_SIZE	256
+
+static void setup(void);
+static void cleanup(void);
+
+static int fd;
+static char *addr1;
+static char *addr2;
+static char *addr3;
+
+#if !defined(UCLINUX)
+static char *addr4;
+#endif
+
+static size_t page_sz;
+
+static struct test_case_t {
+	char **addr;
+	int flags;
+	int exp_errno;
+} test_cases[] = {
+	{ &addr1, MS_INVALIDATE, EBUSY },
+	{ &addr1, MS_ASYNC | MS_SYNC, EINVAL },
+	{ &addr1, INV_SYNC, EINVAL },
+	{ &addr2, MS_SYNC, EINVAL },
+	{ &addr3, MS_SYNC, EINVAL },
+#if !defined(UCLINUX)
+	{ &addr4, MS_SYNC, ENOMEM },
+#endif
+};
+
+static void msync_verify(struct test_case_t *tc);
 
 char *TCID = "msync03";
-int TST_TOTAL = 1;
-
-void *addr;			/* addr of memory mapped region */
-size_t page_sz;			/* system page size */
-
-int exp_enos[] = { EINVAL, 0 };
-
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EBUSY, EINVAL, ENOMEM, 0 };
 
 int main(int ac, char **av)
 {
-	int lc;
+	int i, lc;
 	char *msg;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
 	setup();
 
-	TEST_EXP_ENOS(exp_enos);
-
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
 		tst_count = 0;
 
-		TEST(msync(addr, page_sz, MS_ASYNC));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "msync() returns unexpected "
-				 "value %ld, expected:-1", TEST_RETURN);
-			continue;
-		}
-
-		if (errno == EINVAL)
-			tst_resm(TPASS, "msync failed with EINVAL as expected");
-		else
-			tst_resm(TFAIL | TERRNO, "msync failed unexpectedly");
+		for (i = 0; i < TST_TOTAL; i++)
+			msync_verify(&test_cases[i]);
 	}
 
 	cleanup();
 	tst_exit();
 }
 
-void setup()
+static void setup(void)
 {
-	struct rlimit brkval;
+	size_t nwrite = 0;
+	char write_buf[BUF_SIZE];
+	struct rlimit rl;
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
+	TEST_EXP_ENOS(exp_enos);
+
+	tst_tmpdir();
+
 	TEST_PAUSE;
 
-	if ((page_sz = getpagesize()) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "getpagesize failed");
+	page_sz = (size_t)sysconf(_SC_PAGESIZE);
+
+	fd = SAFE_OPEN(cleanup, TEMPFILE, O_RDWR | O_CREAT, 0666);
+
+	memset(write_buf, 'a', BUF_SIZE);
+	while (nwrite < page_sz) {
+		SAFE_WRITE(cleanup, 1, fd, write_buf, BUF_SIZE);
+		nwrite += BUF_SIZE;
+	}
+
+	addr1 = SAFE_MMAP(cleanup, 0, page_sz, PROT_READ | PROT_WRITE,
+			  MAP_SHARED | MAP_LOCKED, fd, 0);
+
+	/* addr2 is not a multiple of PAGESIZE */
+	addr2 = addr1 + 1;
+
+	/* addr3 is outside the address space of the process */
+	if (getrlimit(RLIMIT_DATA, &rl) < 0)
+		tst_brkm(TBROK | TERRNO, NULL, "getrlimit failed");
+	addr3 = (char *)rl.rlim_max;
 
-	getrlimit(RLIMIT_DATA, &brkval);
+#if !defined(UCLINUX)
+	/* memory pointed to by addr4 was not mapped */
+	addr4 =  get_high_address();
+#endif
+}
+
+static void msync_verify(struct test_case_t *tc)
+{
+	TEST(msync(*(tc->addr), page_sz, tc->flags));
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "msync succeeded unexpectedly");
+		return;
+	}
+
+	TEST_ERROR_LOG(TEST_ERRNO);
 
-	addr = (void *)brkval.rlim_max;
+	if (TEST_ERRNO == tc->exp_errno) {
+		tst_resm(TPASS | TTERRNO, "msync failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "msync failed unexpectedly; expected: "
+			 "%d - %s", tc->exp_errno,
+			 strerror(tc->exp_errno));
+	}
 }
 
-void cleanup()
+static void cleanup(void)
 {
 	TEST_CLEANUP;
 
+	if (munmap(addr1, page_sz) < 0)
+		tst_resm(TWARN | TERRNO, "munmap() failed");
+
+	if (fd > 0 && close(fd) < 0)
+		tst_resm(TWARN | TERRNO, "close() failed");
+
+	if (unlink(TEMPFILE) < 0)
+		tst_resm(TWARN | TERRNO, "unlink(%s) failed", TEMPFILE);
+
+	tst_rmdir();
 }
diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
deleted file mode 100644
index a739e62..0000000
--- a/testcases/kernel/syscalls/msync/msync04.c
+++ /dev/null
@@ -1,158 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- * Test Name: msync04
- *
- * Test Description:
- *  Verify that, msync() fails, when the region to synchronize, is mapped
- *  but the flags argument is invalid.
- *
- * Expected Result:
- *  msync() should fail with a return value of -1, and set errno EINVAL.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Create temporary directory.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *      if errno set == expected errno
- *              Issue sys call fails with expected return value and errno.
- *      Otherwise,
- *              Issue sys call fails with unexpected errno.
- *   Otherwise,
- *      Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory(s)/file(s) created.
- *
- * Usage:  <for command-line>
- *  msync04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS:
- *  None.
- */
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/mman.h>
-
-#include "test.h"
-#include "usctest.h"
-
-#define TEMPFILE	"msync_file"
-#define BUF_SIZE	256
-#define INV_SYNC	-1
-
-char *TCID = "msync04";
-int TST_TOTAL = 1;
-
-char *addr;			/* addr of memory mapped region */
-size_t page_sz;			/* system page size */
-int fildes;			/* file descriptor for tempfile */
-
-int exp_enos[] = { EINVAL, 0 };
-
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-
-int main(int ac, char **av)
-{
-	TEST_EXP_ENOS(exp_enos);
-
-	tst_count = 0;
-
-	setup();
-
-	TEST(msync(addr, page_sz, INV_SYNC));
-
-	if (TEST_RETURN != -1)
-		tst_resm(TFAIL, "msync succeeded unexpectedly");
-	else if (TEST_ERRNO == EINVAL)
-		tst_resm(TPASS, "msync failed with EINVAL as expected");
-	else
-		tst_resm(TFAIL | TTERRNO, "msync failed unexpectedly");
-
-	cleanup();
-
-	tst_exit();
-}
-
-void setup()
-{
-	int c_total = 0, nwrite = 0;	/* no. of bytes to be written */
-	char tst_buf[BUF_SIZE];	/* buffer to hold data to be written */
-
-	TEST_PAUSE;
-
-	if ((page_sz = getpagesize()) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "getpagesize failed");
-
-	tst_tmpdir();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	/* Creat a temporary file used for mapping */
-	if ((fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
-
-	/* Write one page size of char data into temporary file */
-	while (c_total < page_sz) {
-		if ((nwrite = write(fildes, tst_buf, sizeof(tst_buf))) <= 0)
-			tst_brkm(TBROK, cleanup, "write failed");
-		else
-			c_total += nwrite;
-	}
-
-	addr = mmap(0, page_sz, PROT_READ | PROT_WRITE, MAP_FILE | MAP_PRIVATE,
-		    fildes, 0);
-
-	/* Check for the return value of mmap() */
-	if (addr == MAP_FAILED)
-		tst_brkm(TBROK | TERRNO, cleanup, "mmap failed");
-}
-
-void cleanup()
-{
-	TEST_CLEANUP;
-
-	if (munmap(addr, page_sz) == -1)
-		tst_brkm(TBROK, NULL, "munmap failed");
-
-	/* Close the temporary file */
-	if (close(fildes) == -1)
-		tst_brkm(TBROK, NULL, "close failed");
-
-	tst_rmdir();
-}
diff --git a/testcases/kernel/syscalls/msync/msync05.c b/testcases/kernel/syscalls/msync/msync05.c
deleted file mode 100644
index eaf28ab..0000000
--- a/testcases/kernel/syscalls/msync/msync05.c
+++ /dev/null
@@ -1,136 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- * Test Name: msync05
- *
- * Test Description:
- *  Verify that, msync() fails, when the region to synchronize, was not
- *  mapped.
- *
- * Expected Result:
- *  msync() should fail with a return value of -1, and set errno ENOMEM.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *      if errno set == expected errno
- *              Issue sys call fails with expected return value and errno.
- *      Otherwise,
- *              Issue sys call fails with unexpected errno.
- *   Otherwise,
- *      Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *
- * Usage:  <for command-line>
- *  msync05 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *	03/2002 Paul Larson: expected error should be ENOMEM not EFAULT
- *
- * RESTRICTIONS:
- *  None.
- */
-#include <errno.h>
-#include <unistd.h>
-#include <sys/mman.h>
-
-#include "test.h"
-#include "usctest.h"
-
-char *TCID = "msync05";
-int TST_TOTAL = 1;
-
-void *addr;			/* addr of memory mapped region */
-size_t page_sz;			/* system page size */
-
-int exp_enos[] = { ENOMEM, 0 };
-
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-
-#if !defined(UCLINUX)
-int main(int ac, char **av)
-{
-	int lc;
-	char *msg;
-
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-
-	setup();
-
-	TEST_EXP_ENOS(exp_enos);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		TEST(msync(addr, page_sz, MS_SYNC));
-
-		if (TEST_RETURN != -1)
-			tst_resm(TFAIL, "msync succeeded unexpectedly");
-		else if (TEST_ERRNO == ENOMEM)
-			tst_resm(TPASS, "msync failed as expected with ENOMEM");
-		else
-			tst_resm(TFAIL | TTERRNO, "msync failed unexpectedly");
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-void setup()
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	if ((page_sz = getpagesize()) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "getpagesize failed");
-
-	addr = get_high_address();
-}
-
-void cleanup()
-{
-	TEST_CLEANUP;
-}
-
-#else
-int main()
-{
-	tst_brkm(TCONF, NULL, "test is not available on uClinux");
-}
-#endif /* if !defined(UCLINUX) */
-- 
1.8.2.1


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
