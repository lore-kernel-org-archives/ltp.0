From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Sun, 13 Jun 2021 23:00:43 +0530
Subject: [LTP] [PATCH v3] setitimer02: Convert setitimer02 to new API
In-Reply-To: <YMNrt8TxrxhNjFPN@yuki>
References: <YMNrt8TxrxhNjFPN@yuki>
Message-ID: <20210613173043.8797-1-vinay.m.engg@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Vinay Kumar <vinay.m.engg@gmail.com>
---
 .../kernel/syscalls/setitimer/setitimer02.c   | 167 +++---------------
 1 file changed, 24 insertions(+), 143 deletions(-)

diff --git a/testcases/kernel/syscalls/setitimer/setitimer02.c b/testcases/kernel/syscalls/setitimer/setitimer02.c
index 4d13cd1e0..59da87e8d 100644
--- a/testcases/kernel/syscalls/setitimer/setitimer02.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer02.c
@@ -1,161 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ * 03/2001 - Written by Wayne Boyer
  *
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
  */
 
-/*
- * NAME
- *	setitimer02.c
- *
- * DESCRIPTION
- *	setitimer02 - check that a setitimer() call fails as expected
- *		      with incorrect values.
+/*\
+ * [Description]
  *
- * ALGORITHM
- *	loop if that option was specified
- *	allocate needed space and set up needed values
- *	issue the system call
- *	check the errno value
- *	  issue a PASS message if we get EFAULT
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	  break any remaining tests
- *	  call cleanup
- *
- * USAGE:  <for command-line>
- *  setitimer02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	none
+ * setitimer02 - check that a setitimer() call fails as expected
+ *	 with incorrect values.
  */
 
-#include "test.h"
-
 #include <errno.h>
 #include <sys/time.h>
+#include <stdlib.h>
+#include "tst_test.h"
 
-void cleanup(void);
-void setup(void);
-
-char *TCID = "setitimer02";
-int TST_TOTAL = 1;
+struct itimerval *value;
 
-#if !defined(UCLINUX)
-
-int main(int ac, char **av)
+static void verify_setitimer(void)
 {
-	int lc;
-	struct itimerval *value;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/* allocate some space for a timer structure */
-		if ((value = malloc((size_t)sizeof(struct itimerval))) ==
-		    NULL) {
-			tst_brkm(TBROK, cleanup, "value malloc failed");
-		}
-
-		/* set up some reasonable values */
-
-		value->it_value.tv_sec = 30;
-		value->it_value.tv_usec = 0;
-		value->it_interval.tv_sec = 0;
-		value->it_interval.tv_usec = 0;
-		/*
-		 * issue the system call with the TEST() macro
-		 * ITIMER_REAL = 0, ITIMER_VIRTUAL = 1 and ITIMER_PROF = 2
-		 */
-
-		/* call with a bad address */
-		TEST(setitimer(ITIMER_REAL, value, (struct itimerval *)-1));
-
-		if (TEST_RETURN == 0) {
-			tst_resm(TFAIL, "call failed to produce EFAULT error "
-				 "- errno = %d - %s", TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-			continue;
-		}
-
-		switch (TEST_ERRNO) {
-		case EFAULT:
-			tst_resm(TPASS, "expected failure - errno = %d - %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		default:
-			tst_resm(TFAIL, "call failed to produce EFAULT error "
-				 "- errno = %d - %s", TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-		}
-
-		/*
-		 * clean up things in case we are looping
-		 */
-		free(value);
-		value = NULL;
-	}
-
-	cleanup();
-	tst_exit();
-
-}
-
-#else
-
-int main(void)
-{
-	tst_resm(TINFO, "test is not available on uClinux");
-	tst_exit();
+  /* call with a bad address */
+	TST_EXP_FAIL(setitimer(ITIMER_REAL, value, (struct itimerval *)-1),
+		EFAULT, "expected failure - errno = %d - %s", TST_ERR, strerror(TST_ERR));
 }
 
-#endif /* if !defined(UCLINUX) */
-
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
+	value = tst_alloc((size_t)sizeof(struct itimerval));
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	value->it_value.tv_sec = 30;
+	value->it_value.tv_usec = 0;
+	value->it_interval.tv_sec = 0;
+	value->it_interval.tv_usec = 0;
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.test_all = verify_setitimer,
+	.setup = setup,
+};
-- 
2.17.1

