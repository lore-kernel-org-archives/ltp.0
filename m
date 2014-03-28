Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WTR5d-0001SE-R5
	for ltp-list@lists.sourceforge.net; Fri, 28 Mar 2014 07:20:33 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WTR5a-0003Sz-QK
	for ltp-list@lists.sourceforge.net; Fri, 28 Mar 2014 07:20:33 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s2S7KFVD021445
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Mar 2014 15:20:15 +0800
Message-ID: <1395991214.5017.2.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 28 Mar 2014 15:20:14 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH] read/read02.c: cleanup
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

* Delete some useless commtents and variable.
* Use SAFE_* macros.
* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/read/read02.c | 217 +++++++++++---------------------
 1 file changed, 74 insertions(+), 143 deletions(-)

diff --git a/testcases/kernel/syscalls/read/read02.c b/testcases/kernel/syscalls/read/read02.c
index 8681662..8aabe93 100644
--- a/testcases/kernel/syscalls/read/read02.c
+++ b/testcases/kernel/syscalls/read/read02.c
@@ -1,63 +1,36 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ *	07/2001 Ported by Wayne Boyer
  *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
-
 /*
- * NAME
- * 	read02.c
- *
  * DESCRIPTION
- * 	test 1:
- *	Does read return -1 if file descriptor is not valid, check for EBADF
+ *	test 1:
+ *	Read with an invalid file descriptor, and expect an EBADF.
  *
  *	test 2:
- *	Check if read sets EISDIR, if the fd refers to a directory
- *
- * 	test 3:
- * 	Check if read sets EFAULT, if buf is -1.
- *$
- * ALGORITHM
- * 	test 1:
- * 	Read with an invalid file descriptor, and expect an EBADF
+ *	The parameter passed to read is a directory, check if the errno is
+ *	set to EISDIR.
  *
- * 	test 2:
- * 	The parameter passed to read is a directory, check if the errno is
- * 	set to EISDIR.
- *
- * 	test 3:
- * 	Pass buf = -1 as a parmeter to read, expect an EFAULT.
- *$
- * USAGE:  <for command-line>
- *  read02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- * 	None
+ *	test 3:
+ *	Pass buf = -1 as a parmeter to read, expect an EFAULT.
  */
-#define _GNU_SOURCE		/* for O_DIRECTORY */
+
+#define _GNU_SOURCE
+
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
@@ -65,43 +38,31 @@
 #include <sys/mman.h>
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
-void cleanup(void);
-void setup(void);
+#define TEST_FILE	"test_file"
 
 char *TCID = "read02";
 
-char file[BUFSIZ];
-char fname[100] = "/tmp/tstfile";
-
-int exp_enos[] = { EBADF, EISDIR, EFAULT, 0 };
-
-int badfd = -1;
-int fd2, fd3;
-char buf[BUFSIZ];
+static int badfd = -1;
+static int fd2, fd3;
+static char buf[BUFSIZ];
+static int exp_enos[] = { EBADF, EISDIR, EFAULT, 0 };
 
-struct test_case_t {
+static struct test_case_t {
 	int *fd;
 	void *buf;
-	int error;
+	int exp_error;
 } TC[] = {
-	/* the file descriptor is invalid - EBADF */
-	{
-	&badfd, buf, EBADF},
-	    /* the file descriptor is a directory - EISDIR */
-	{
-	&fd2, buf, EISDIR,},
-#ifndef UCLINUX
-	    /* Skip since uClinux does not implement memory protection */
-	    /* the buffer is invalid - EFAULT */
-	{
-	&fd3, (void *)-1, EFAULT}
-#endif
+	{&badfd, buf, EBADF},
+	{&fd2, buf, EISDIR},
+	{&fd3, (void *)-1, EFAULT},
 };
 
-int TST_TOTAL = sizeof(TC) / sizeof(*TC);
-
-char *bad_addr = 0;
+int TST_TOTAL = ARRAY_SIZE(TC);
+static void setup(void);
+static void cleanup(void);
+static void read_verify(const struct test_case_t *);
 
 int main(int ac, char **av)
 {
@@ -109,98 +70,68 @@ int main(int ac, char **av)
 	int lc;
 	char *msg;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
 
 	setup();
 
-	/* set up the expected errnos */
 	TEST_EXP_ENOS(exp_enos);
 
-	/*
-	 * The following loop checks looping state if -i option given
-	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
-
-		/* loop through the test cases */
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			TEST(read(*TC[i].fd, TC[i].buf, 1));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			TEST_ERROR_LOG(TEST_ERRNO);
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - "
-					 "errno = %d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "unexpected error - %d : %s - "
-					 "expected %d", TEST_ERRNO,
-					 strerror(TEST_ERRNO), TC[i].error);
-			}
-		}
+		for (i = 0; i < TST_TOTAL; i++)
+			read_verify(&TC[i]);
 	}
 	cleanup();
 	tst_exit();
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test
- */
-void setup(void)
+static void setup(void)
 {
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* create a temporary filename */
-	sprintf(fname, "%s.%d", fname, getpid());
-
 	TEST_PAUSE;
 
-	if ((fd2 = open("/tmp", O_DIRECTORY)) == -1) {
-		tst_brkm(TBROK, cleanup, "open of fd2 failed");
-	}
+	tst_tmpdir();
 
-	if ((fd3 = open(fname, O_RDWR | O_CREAT, 0666)) == -1) {
-		tst_brkm(TBROK, cleanup, "open of fd3 (temp file) failed");
-	}
+	fd2 = SAFE_OPEN(cleanup, "/tmp", O_DIRECTORY);
 
-	if (write(fd3, "A", 1) != 1) {
-		tst_brkm(TBROK, cleanup, "can't write to fd3");
-	}
-	close(fd3);
-	if ((fd3 = open(fname, O_RDWR | O_CREAT, 0666)) == -1) {
-		tst_brkm(TBROK, cleanup, "open of fd3 (temp file) failed");
+	SAFE_FILE_PRINTF(cleanup, TEST_FILE, "A");
+
+	fd3 = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT, 0666);
+}
+
+static void read_verify(const struct test_case_t *test)
+{
+	TEST(read(*test->fd, test->buf, 1));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "call succeeded unexpectedly");
+		return;
 	}
-#if !defined(UCLINUX)
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED) {
-		tst_brkm(TBROK, cleanup, "mmap failed");
+
+	TEST_ERROR_LOG(TEST_ERRNO);
+
+	if (TEST_ERRNO == test->exp_error) {
+		tst_resm(TPASS | TTERRNO, "expected failure - errno = %d : %s",
+			 TEST_ERRNO, strerror(TEST_ERRNO));
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "unexpected error - %d : %s - expected %d",
+			 TEST_ERRNO, strerror(TEST_ERRNO), test->exp_error);
 	}
-	TC[2].buf = bad_addr;
-#endif
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- *	       or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/*
-	 * print timing status if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
-	unlink(fname);
 
+	if (fd3 > 0)
+		close(fd3);
+
+	if (fd2 > 0)
+		close(fd2);
+
+	tst_rmdir();
 }
-- 
1.8.4.2




------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
