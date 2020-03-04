From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 4 Mar 2020 16:44:26 +0800
Subject: [LTP] [PATCH v1 1/2] syscalls/settimeofday01: convert to new library
Message-ID: <1583311467-2379-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also, since glibc 2.31[1], when tz and tv are both null, it will get
SIGSEGV sig. So, remove this EFAULT error test to adopt glibc2.31.

Moreover, musl 1.2.0 is now available and changes time_t for 32-bit
archs to a 64-bit type. It is updated to slove y2038 problem and get
time function no longer used for 32bit arch but not affecting set time
function and 64 bit arch, more info see[2]. So for gettimeofday(), we
use tst_syscall instead of calling libc to avoid this problem.

[1]https://sourceware.org/ml/libc-announce/2020/msg00001.html
[2]https://musl.libc.org/time64.html
Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .../syscalls/settimeofday/settimeofday01.c    | 200 ++++--------------
 1 file changed, 46 insertions(+), 154 deletions(-)

diff --git a/testcases/kernel/syscalls/settimeofday/settimeofday01.c b/testcases/kernel/syscalls/settimeofday/settimeofday01.c
index 7388c3231..fdb03ba7f 100644
--- a/testcases/kernel/syscalls/settimeofday/settimeofday01.c
+++ b/testcases/kernel/syscalls/settimeofday/settimeofday01.c
@@ -1,52 +1,10 @@
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
- */
-
-/*
- * NAME
- * 	settimeofday01.c
+ * Copyright (c) International Business Machines  Corp., 2001
  *
  * DESCRIPTION
  *	Testcase to check the basic functionality of settimeofday().
  *
- * ALGORITHM
- *	Setup:
- *	  Setup signal handling.
- *	  Check that we are the proper user.
- *	  Setup expected errnos.
- *	  Pause for SIGUSER1 if option specified.
- *	  Save the current time values.
- *	Loop if the proper options are given.
- *	  Call settimeofday and verify the time was changed.
- *	  Call settimeofday with invalid Args and verify that the call fails.
- *	Cleanup:
- *	  Restore the original time values.
- *	  Print errno log and/or timing stats if options given.
- *
- * USAGE:  <for command-line>
- *	settimeofday01 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
  * History
  *	07/2001 John George
  *		-Ported
@@ -58,135 +16,69 @@
 #include <sys/time.h>
 #include <errno.h>
 #include <unistd.h>
-#include "test.h"
+#include "tst_test.h"
+#include "lapi/syscalls.h"
 
-#define	FAILED		1
 #define	VAL_SEC		100
 #define	VAL_MSEC	100
-#define ACCEPTABLE_DELTA	500	/* in milli-seconds */
+#define ACCEPTABLE_DELTA 500
 #define USEC_PER_SEC    1000000L
 
-char *TCID = "settimeofday01";
-int TST_TOTAL = 1;
-time_t save_tv_sec, save_tv_usec;
-struct timeval tp, tp1, tp2;
-
-void setup(void);
-void cleanup(void);
+struct timeval tv_saved;
 
-#if !defined(UCLINUX)
-
-int main(int argc, char **argv)
+static void verify_settimeofday(void)
 {
-	int lc;
 	suseconds_t delta;
+	struct timeval tv1, tv2;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int condition_number = 1;
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		gettimeofday(&tp, NULL);
-		tp.tv_sec += VAL_SEC;
-		tp.tv_usec += VAL_MSEC;
-		if (tp.tv_usec >= USEC_PER_SEC)
-			tp.tv_usec = VAL_MSEC;
-
-		TEST(settimeofday(&tp, NULL));
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "Error Setting Time, errno=%d",
-				 TEST_ERRNO);
-		}
-
-		if ((gettimeofday(&tp2, (struct timezone *)&tp1)) == -1) {
-			tst_resm(TBROK, "Error Getting Time, errno=%d", errno);
-		}
+	if (tst_syscall(__NR_gettimeofday, &tv1, NULL) == -1)
+		tst_brk(TBROK | TERRNO, "gettimeofday(&tv1, NULL) failed");
 
-		if (tp2.tv_sec > tp.tv_sec) {
-			delta =
-			    (suseconds_t) (tp2.tv_sec - tp.tv_sec) * 1000 +
-			    (tp2.tv_usec - tp.tv_usec) / 1000;
-		} else {
-			delta =
-			    (suseconds_t) (tp.tv_sec - tp2.tv_sec) * 1000 +
-			    (tp.tv_usec - tp2.tv_usec) / 1000;
-		}
+	tv1.tv_sec += VAL_SEC;
+	tv1.tv_usec += VAL_MSEC;
+	if (tv1.tv_usec >= USEC_PER_SEC)
+		tv1.tv_usec = VAL_MSEC;
 
-		if (delta > -ACCEPTABLE_DELTA && delta < ACCEPTABLE_DELTA) {
-			tst_resm(TPASS, "Test condition %d successful",
-				 condition_number++);
-		} else {
-			tst_resm(TFAIL, "Test condition %d failed",
-				 condition_number++);
-		}
-
-		/* Invalid Args : Error Condition where tp = NULL */
-		TEST(settimeofday((struct timeval *)-1, NULL));
-		if (TEST_RETURN == -1) {
-			tst_resm(TPASS, "Test condition %d successful",
-				 condition_number++);
-		} else {
-			tst_resm(TFAIL, "Test condition %d failed",
-				 condition_number);
-		}
+	TEST(settimeofday(&tv1, NULL));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "settimeofday(&tv1, NULL) failed");
+		return;
+	}
 
+	if (tst_syscall(__NR_gettimeofday, &tv2, NULL) == -1)
+		tst_brk(TBROK | TERRNO, "gettimeofday(&tv2, NULL) failed");
+
+	if (tv2.tv_sec > tv1.tv_sec) {
+		delta =
+			(suseconds_t) (tv2.tv_sec - tv1.tv_sec) * 1000 +
+			(tv2.tv_usec - tv1.tv_usec) / 1000;
+	} else {
+		delta =
+			(suseconds_t) (tv1.tv_sec - tv2.tv_sec) * 1000 +
+			(tv1.tv_usec - tv2.tv_usec) / 1000;
 	}
-	cleanup();
-	tst_exit();
 
+	if (delta > -ACCEPTABLE_DELTA && delta < ACCEPTABLE_DELTA)
+		tst_res(TPASS, "settimeofday() pass");
+	else
+		tst_res(TFAIL, "settimeofday() fail");
 }
 
-#else
-
-int main(void)
+static void setup(void)
 {
-	tst_resm(TINFO, "test is not available on uClinux");
-	tst_exit();
+	if (tst_syscall(__NR_gettimeofday, &tv_saved, NULL) == -1)
+		tst_brk(TBROK | TERRNO, "gettimeofday(&tv_saved, NULL) failed");
 }
 
-#endif /* if !defined(UCLINUX) */
-
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
+static void cleanup(void)
 {
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
-	TEST_PAUSE;
-
-	/* Save the current time values */
-	if ((gettimeofday(&tp, (struct timezone *)&tp1)) == -1) {
-		tst_brkm(TBROK, cleanup, "gettimeofday failed. "
-			 "errno=%d", errno);
-	}
-	save_tv_sec = tp.tv_sec;
-	save_tv_usec = tp.tv_usec;
+	if ((settimeofday(&tv_saved, NULL)) == -1)
+		tst_brk(TBROK | TERRNO, "settimeofday(&tv_saved, NULL) failed");
 }
 
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
-{
-	/* restore the original time values. */
-	tp.tv_sec = save_tv_sec;
-	tp.tv_usec = save_tv_usec;
-	if ((settimeofday(&tp, NULL)) == -1) {
-		tst_resm(TWARN, "FATAL COULD NOT RESET THE CLOCK");
-		tst_resm(TFAIL, "Error Setting Time, errno=%d", errno);
-	}
-
-}
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_settimeofday,
+	.needs_root = 1,
+};
-- 
2.18.0



