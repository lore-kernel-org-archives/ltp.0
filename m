From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 31 Oct 2019 11:21:15 +0100
Subject: [LTP] [PATCH v3 1/2] Update syscalls/fsync03 to new API
In-Reply-To: <20191031102116.10592-1-mdoucha@suse.cz>
References: <20191009152459.GB15291@rei.lan>
 <20191031102116.10592-1-mdoucha@suse.cz>
Message-ID: <20191031102116.10592-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.com>
---
 testcases/kernel/syscalls/fsync/fsync03.c | 150 ++++++----------------
 1 file changed, 36 insertions(+), 114 deletions(-)

diff --git a/testcases/kernel/syscalls/fsync/fsync03.c b/testcases/kernel/syscalls/fsync/fsync03.c
index 60d15f429..04d9a6c22 100644
--- a/testcases/kernel/syscalls/fsync/fsync03.c
+++ b/testcases/kernel/syscalls/fsync/fsync03.c
@@ -1,141 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
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
+ *   Copyright (c) Wayne Boyer, International Business Machines  Corp., 2001
+ *   Copyright (c) 2019 SUSE LLC <mdoucha@suse.cz>
  */
 
 /*
- * NAME
- *	fsync03.c
- *
- * DESCRIPTION
- *	Testcase to check that fsync(2) sets errno correctly.
- *
- * ALGORITHM
- *	1. Call fsync() with an invalid fd, and test for EBADF.
- *	2. Call fsync() on a pipe(fd), and expect EINVAL.
- *
- * USAGE:  <for command-line>
- *  fsync03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
- *	NONE
+ * Test Description:
+ *  Testcase to check that fsync(2) sets errno correctly.
+ *  1. Call fsync() with an invalid fd, and test for EBADF.
+ *  2. Call fsync() on a pipe(fd), and expect EINVAL.
  */
 
 #include <unistd.h>
 #include <errno.h>
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
-void setup(void);
-void cleanup(void);
+static int pfd[2];
+static int bfd = -1;
 
-int fd[2];			/* fd's for the pipe() call in setup()  */
-int pfd;			/* holds the value for fd[1]            */
-int bfd = -1;			/* an invalid fd                        */
-
-struct test_case_t {
+const struct test_case {
 	int *fd;
 	int error;
 } TC[] = {
 	/* EBADF - fd is invalid (-1) */
-	{
-	&bfd, EBADF},
-	    /* EINVAL - fsync() on pipe should not succeed. */
-	{
-	&pfd, EINVAL}
+	{&bfd, EBADF},
+	/* EINVAL - fsync() on pipe should not succeed. */
+	{pfd, EINVAL}
 };
 
-char *TCID = "fsync03";
-int TST_TOTAL = 2;
-
-int main(int ac, char **av)
+static void test_fsync(unsigned int n)
 {
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
+	const struct test_case *tc = TC + n;
 
-		/* loop through the test cases */
-		for (i = 0; i < TST_TOTAL; i++) {
+	TEST(fsync(*tc->fd));
 
-			TEST(fsync(*(TC[i].fd)));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
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
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "fsync() returned unexpected value %ld",
+			TST_RET);
+	} else if (TST_ERR != tc->error) {
+		tst_res(TFAIL | TTERRNO, "fsync(): unexpected error");
+	} else {
+		tst_res(TPASS, "fsync() failed as expected");
 	}
-	cleanup();
-
-	tst_exit();
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* make a temporary directory and cd to it */
-	tst_tmpdir();
-
-	SAFE_PIPE(cleanup, fd);
-
-	pfd = fd[1];
+	SAFE_PIPE(pfd);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-
-	/* delete the test directory created in setup() */
-	tst_rmdir();
-
+	close(pfd[0]);
+	close(pfd[1]);
 }
+
+static struct tst_test test = {
+	.test = test_fsync,
+	.tcnt = ARRAY_SIZE(TC),
+	.setup = setup,
+	.cleanup = cleanup
+};
-- 
2.23.0

