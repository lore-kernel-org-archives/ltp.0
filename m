From: QI Fuli <fukuri.sai@gmail.com>
Date: Thu, 16 Sep 2021 00:51:49 +0900
Subject: [LTP] [PATCH v2 1/4] syscalls/dup2/dup201: Convert to new API
In-Reply-To: <20210915155152.8515-1-qi.fuli@fujitsu.com>
References: <20210915155152.8515-1-qi.fuli@fujitsu.com>
Message-ID: <20210915155152.8515-2-qi.fuli@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup2/dup201.c | 174 +++++-------------------
 1 file changed, 33 insertions(+), 141 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup201.c b/testcases/kernel/syscalls/dup2/dup201.c
index 4fa34466a..8e47a2244 100644
--- a/testcases/kernel/syscalls/dup2/dup201.c
+++ b/testcases/kernel/syscalls/dup2/dup201.c
@@ -1,163 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
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
+ * Copyright (c) International Business Machines  Corp., 2001
  */
 
-/*
- * NAME
- *	dup201.c
- *
- * DESCRIPTION
- *	Negative tests for dup2() with bad fd (EBADF)
- *
- * ALGORITHM
- * 	Setup:
- *	a.	Setup signal handling.
- *	b.	Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	a.	Loop if the proper options are given.
- *	b.	Loop through the test cases
- * 	c.	Execute dup2() system call
- *	d.	Check return code, if system call failed (return=-1), test
- *		for EBADF.
- *
- * 	Cleanup:
- * 	a.	Print errno log and/or timing stats if options given
+/*\
+ * [Description]
  *
- * USAGE:  <for command-line>
- *  dup201 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
+ * Negative tests for dup2() with bad fd (EBADF)
+ * First fd argument is less than 0
+ * First fd argument is getdtablesize()
+ * Second fd argument is less than 0
+ * Second fd argument is getdtablesize()
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *	01/2002 Removed EMFILE test - Paul Larson
- *
- * RESTRICTIONS
- * 	NONE
  */
 
-#include <sys/types.h>
-#include <fcntl.h>
 #include <errno.h>
-#include <sys/time.h>
-#include <sys/resource.h>
 #include <unistd.h>
-#include <signal.h>
-#include "test.h"
-
-void setup(void);
-void cleanup(void);
-
-char *TCID = "dup201";
-int TST_TOTAL = 4;
+#include "tst_test.h"
 
-int maxfd;
-int goodfd = 5;
-int badfd = -1;
-int mystdout = 0;
+static int maxfd;
+static int goodfd = 5;
+static int badfd = -1;
+static int mystdout = 0;
 
-struct test_case_t {
+static struct tcase {
 	int *ofd;
 	int *nfd;
-	int error;
-	void (*setupfunc) ();
-} TC[] = {
-	/* First fd argument is less than 0 - EBADF */
-	{&badfd, &goodfd, EBADF, NULL},
-	    /* First fd argument is getdtablesize() - EBADF */
-	{&maxfd, &goodfd, EBADF, NULL},
-	    /* Second fd argument is less than 0 - EBADF */
-	{&mystdout, &badfd, EBADF, NULL},
-	    /* Second fd argument is getdtablesize() - EBADF */
-	{&mystdout, &maxfd, EBADF, NULL},
+} tcases[] = {
+	{&badfd, &goodfd},
+	{&maxfd, &goodfd},
+	{&mystdout, &badfd},
+	{&mystdout, &maxfd},
 };
 
-int main(int ac, char **av)
-{
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
-
-		/* loop through the test cases */
-
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			/* call the test case setup routine if necessary */
-			if (TC[i].setupfunc != NULL)
-				(*TC[i].setupfunc) ();
-
-			TEST(dup2(*TC[i].ofd, *TC[i].nfd));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS,
-					 "failed as expected - errno = %d : %s",
-					 TEST_ERRNO, strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL | TTERRNO,
-					 "failed unexpectedly; "
-					 "expected %d: %s", TC[i].error,
-					 strerror(TC[i].error));
-			}
-		}
-	}
-	cleanup();
-
-	tst_exit();
-}
-
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
-	tst_tmpdir();
-
 	/* get some test specific values */
 	maxfd = getdtablesize();
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
+static void run(unsigned int i)
 {
-	tst_rmdir();
+	struct tcase *tc = tcases + i;
+
+	TST_EXP_FAIL2(dup2(*tc->ofd, *tc->nfd), EBADF,
+			"failed as expected - %s", strerror(EBADF));
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+};
-- 
2.31.1

