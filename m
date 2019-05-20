From: Christian Amann <camann@suse.com>
Date: Mon, 20 May 2019 07:50:38 +0200
Subject: [LTP] [PATCH v1 2/2] syscalls/fstat{03,05}: rewrote testcases
In-Reply-To: <20190520055038.11499-1-camann@suse.com>
References: <20190520055038.11499-1-camann@suse.com>
Message-ID: <20190520055038.11499-2-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Merged fstat03 and fstat05:
	Both testcases had lots of duplicated code which
	could be removed by creating a single testcase
	for both scenarios.
Rewrote testcase:
	Cleaned up and ported to new library.

Signed-off-by: Christian Amann <camann@suse.com>
---
 runtest/syscalls                           |   2 -
 testcases/kernel/syscalls/fstat/.gitignore |   2 -
 testcases/kernel/syscalls/fstat/fstat03.c  | 198 +++++++----------------
 testcases/kernel/syscalls/fstat/fstat05.c  | 244 -----------------------------
 4 files changed, 59 insertions(+), 387 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/fstat/fstat05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 5c2f4cec6..3cfb99c63 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -338,8 +338,6 @@ fstat02 fstat02
 fstat02_64 fstat02_64
 fstat03 fstat03
 fstat03_64 fstat03_64
-fstat05 fstat05
-fstat05_64 fstat05_64
 
 #fstatat64/newfstatat test cases
 fstatat01 fstatat01
diff --git a/testcases/kernel/syscalls/fstat/.gitignore b/testcases/kernel/syscalls/fstat/.gitignore
index 1c66bdf10..9b1089438 100644
--- a/testcases/kernel/syscalls/fstat/.gitignore
+++ b/testcases/kernel/syscalls/fstat/.gitignore
@@ -2,5 +2,3 @@
 /fstat02_64
 /fstat03
 /fstat03_64
-/fstat05
-/fstat05_64
diff --git a/testcases/kernel/syscalls/fstat/fstat03.c b/testcases/kernel/syscalls/fstat/fstat03.c
index 0fa62b847..c1ee79bc9 100644
--- a/testcases/kernel/syscalls/fstat/fstat03.c
+++ b/testcases/kernel/syscalls/fstat/fstat03.c
@@ -1,160 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Test Name: fstat03
- *
- * Test Description:
- *   Verify that, fstat(2) returns -1 and sets errno to EBADF if the file
- *   pointed to by file descriptor is not valid.
- *
- * Expected Result:
- *  fstat() should fail with return value -1 and set expected errno.
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
- *	if errno set == expected errno
- *		Issue sys call fails with expected return value and errno.
- *	Otherwise,
- *		Issue sys call fails with unexpected errno.
- *   Otherwise,
- *	Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory(s)/file(s) created.
- *
- * Usage:  <for command-line>
- *  fstat03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
- *  This test should be executed by 'non-super-user' only.
+ * Copyright (c) International Business Machines  Corp., 2001
+ *  07/2001 Ported by Wayne Boyer
+ *  05/2019 Ported to new library: Christian Amann <camann@suse.com>
+ */
+/*
+ * Tests different error scenarios:
  *
+ * 1) Calls fstat() with closed file descriptor
+ *    -> EBADF
+ * 2) Calls fstat() with an invalid address for stat structure
+ *    -> EFAULT
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
 #include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/types.h>
-#include <sys/stat.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "fstat.h"
 
-#include "test.h"
-#include "safe_macros.h"
-
-#define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
 #define TEST_FILE	"testfile"
 
-char *TCID = "fstat03";
-int TST_TOTAL = 1;
-
-int fildes;			/* testfile descriptor */
+static int fd_ok;
+static int fd_ebadf;
+static struct stat stat_buf;
 
-void setup();			/* Main setup function for the tests */
-void cleanup();			/* cleanup function for the test */
+static struct tcase{
+	int *fd;
+	struct stat *stat_buf;
+	int exp_err;
+} tcases[] = {
+	{&fd_ebadf, &stat_buf, EBADF},
+	{&fd_ok, NULL, EFAULT},
+};
 
-int main(int ac, char **av)
+static void run(unsigned int n)
 {
-	struct stat stat_buf;	/* stat structure buffer */
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	/*
-	 * Invoke setup function to create a testfile under temporary
-	 * directory.
-	 */
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-		/*
-		 * Call fstat(2) to get the status information
-		 * of a closed testfile pointed to by 'fd'.
-		 * verify that fstat fails with -1 return value and
-		 * sets appropriate errno.
-		 */
-		TEST(fstat(fildes, &stat_buf));
-
-		/* Check return code from fstat(2) */
-		if (TEST_RETURN == -1) {
-			if (TEST_ERRNO == EBADF) {
-				tst_resm(TPASS,
-					 "fstat() fails with expected error EBADF");
-			} else {
-				tst_resm(TFAIL | TTERRNO,
-					 "fstat() did not fail with EBADF");
-			}
+	struct tcase *tc = &tcases[n];
+
+	TEST(tst_fstat(*tc->fd, tc->stat_buf));
+	if (TST_RET == -1) {
+		if (tc->exp_err == TST_ERR) {
+			tst_res(TPASS,
+				 "fstat() fails with expected error %s",
+				 tst_strerrno(tc->exp_err));
 		} else {
-			tst_resm(TFAIL, "fstat() returned %ld, expected -1",
-				 TEST_RETURN);
+			tst_res(TFAIL | TTERRNO,
+				 "fstat() did not fail with %s, but with",
+				 tst_strerrno(tc->exp_err));
 		}
-	}
-
-	/*
-	 * Invoke cleanup() to delete the test directory/file(s) created
-	 * in the setup().
-	 */
-	cleanup();
-
-	tst_exit();
+	} else
+		tst_res(TFAIL, "fstat() returned %ld, expected -1",
+			 TST_RET);
 }
 
-/*
- * void
- * setup(void) - performs all ONE TIME setup for this test.
- *	Exit the test program on receipt of unexpected signals.
- *	Create a temporary directory and change directory to it.
- *      Create a testfile under temporary directory.
- *      Close the testfile.
- */
-void setup(void)
+static void setup(void)
 {
-	/* Capture unexpected signals */
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	syscall_info();
 
-	/* Make a temp dir and cd to it */
-	tst_tmpdir();
-
-	/* Create a testfile under temporary directory */
-	fildes = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT, 0666);
-
-	SAFE_CLOSE(cleanup, fildes);
+	fd_ebadf = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
+	SAFE_CLOSE(fd_ebadf);
+	fd_ok = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
 }
 
-/*
- * void
- * cleanup() - Performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *	Print test timing stats and errno log if test executed with options.
- *	Close the testfile if still opened.
- *	Remove temporary directory and sub-directories/files under it
- *	created during setup().
- *	Exit the test program with normal exit code.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-
-	tst_rmdir();
-
+	if (fd_ebadf > 0)
+		SAFE_CLOSE(fd_ebadf);
+	if (fd_ok > 0)
+		SAFE_CLOSE(fd_ok);
 }
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test_variants = TEST_VARIANTS,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/fstat/fstat05.c b/testcases/kernel/syscalls/fstat/fstat05.c
deleted file mode 100644
index 200de4130..000000000
--- a/testcases/kernel/syscalls/fstat/fstat05.c
+++ /dev/null
@@ -1,244 +0,0 @@
-/*
- *
- *   Copyright (C) Bull S.A. 2001
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
- * Test Name: fstat05
- *
- * Test Description:
- *   Verify that,
- *   if buffer points outside user's accessible address space fstat(2)
- *	either returns -1 and sets errno to EFAULT
- *	or SIGSEGV is returned instead of EFAULT
- *
- * Expected Result:
- *   fstat() should fail with return value -1 and set expected errno.
- *    or
- *   fstat() should fail with SIGSEGV returned.
- *   Both results are considered as acceptable.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling SIGSEGV included.
- *   Switch to nobody user.
- *   Pause for SIGUSR1 if option specified.
- *   Create temporary directory.
- *   Create a testfile under temporary directory.
- *
- *  Test:
- *   Buffer points outside user's accessible address space.
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *	if errno set == expected errno
- *		Issue sys call fails with expected return value and errno.
- *	Otherwise,
- *		Issue sys call fails with unexpected errno.
- *   Otherwise,
- *	Issue sys call returns unexpected value.
- *
- *  Sighandler:
- *	if signal == SIGSEGV
- *		Issue sys call fails with expected signal
- *      Otherwise,
- *              Issue sys call fails with unexpected signal.
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Close the test file
- *   Delete the temporary directory(s)/file(s) created.
- *
- * Usage:  <for command-line>
- *  fstat05 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * History
- *	05/2002 Jacky Malcles
- *		-Ported
- *
- * Restrictions:
- *      This test must be run as root.
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <pwd.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-#define TEST_FILE       "testfile"
-
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-char *TCID = "fstat05";
-int TST_TOTAL = 1;
-
-int fildes;			/* testfile descriptor */
-
-void setup();			/* Main setup function for the tests */
-void cleanup();			/* cleanup function for the test */
-void sighandler(int sig);	/* signals handler function for the test */
-
-int siglist[] = { SIGHUP, SIGINT, SIGQUIT, SIGILL, SIGTRAP, SIGABRT, SIGIOT,
-	SIGBUS, SIGFPE, SIGUSR1, SIGSEGV, SIGUSR2, SIGPIPE, SIGALRM,
-	SIGTERM,
-#ifdef SIGSTKFLT
-	SIGSTKFLT,
-#endif
-	SIGCHLD, SIGCONT, SIGTSTP, SIGTTIN,
-	SIGTTOU, SIGURG, SIGXCPU, SIGXFSZ, SIGVTALRM, SIGPROF,
-	SIGWINCH, SIGIO, SIGPWR, SIGSYS,
-#ifdef SIGUNUSED
-	SIGUNUSED
-#endif
-};
-
-int SIG_SEEN = sizeof(siglist) / sizeof(int);
-
-#if !defined(UCLINUX)
-
-int main(int ac, char **av)
-{
-	struct stat *ptr_str = tst_get_bad_addr(NULL);
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	/*
-	 * Invoke setup function
-	 */
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Call fstat(2).
-		 * verify that it fails with -1 return value and
-		 * sets appropriate errno.
-		 */
-		TEST(fstat(fildes, ptr_str));
-
-		/* Check return code from fstat(2) */
-		if (TEST_RETURN == -1) {
-			if (TEST_ERRNO == EFAULT)
-				tst_resm(TPASS,
-					 "fstat failed with EFAULT as expected");
-			else
-				tst_resm(TFAIL | TTERRNO,
-					 "fstat failed unexpectedly");
-		} else
-			tst_resm(TFAIL, "fstat() returned %ld but we wanted -1",
-				 TEST_RETURN);
-
-	}
-
-	/*
-	 * Invoke cleanup() to delete the test directory/file(s) created
-	 * in the setup().
-	 */
-	cleanup();
-	tst_exit();
-}
-
-#else
-
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "test is not available on uClinux");
-}
-
-#endif /* if !defined(UCLINUX) */
-
-/*
- * void
- * setup(void) - performs all ONE TIME setup for this test.
- *	Exit the test program on receipt of unexpected signals.
- *	Create a temporary directory and change directory to it.
- */
-void setup(void)
-{
-	int i;
-
-	tst_require_root();
-
-	/*
-	 * Capture unexpected signals SIGSEGV included
-	 * SIGSEGV being considered as acceptable as returned value
-	 */
-	for (i = 0; i < SIG_SEEN; i++)
-		signal(siglist[i], &sighandler);
-
-	ltpuser = getpwnam(nobody_uid);
-	SAFE_SETUID(NULL, ltpuser->pw_uid);
-
-	tst_tmpdir();
-
-	/* Create a testfile under temporary directory */
-	fildes = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT, 0666);
-
-	TEST_PAUSE;
-}
-
-/*
- * void
- * cleanup() - Performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *	Print test timing stats and errno log if test executed with options.
- *	Remove temporary directory and sub-directories/files under it
- *	created during setup().
- *	Exit the test program with normal exit code.
- */
-void cleanup(void)
-{
-
-	SAFE_CLOSE(cleanup, fildes);
-
-	tst_rmdir();
-
-}
-
-/*
- * sighandler() - handle the signals
- */
-
-void sighandler(int sig)
-{
-	if (sig == SIGSEGV)
-		tst_resm(TPASS, "fstat failed as expected with SIGSEGV");
-	else
-		tst_brkm(TBROK, NULL, "Unexpected signal %d received.", sig);
-	cleanup();
-	tst_exit();
-}
-- 
2.16.4

