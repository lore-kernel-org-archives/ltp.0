From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 4 Mar 2020 16:44:27 +0800
Subject: [LTP] [PATCH v1 2/2] syscalls/settimeofday02: convert to new library
In-Reply-To: <1583311467-2379-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1583311467-2379-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1583311467-2379-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

As well as settimeofday01, using tst_sycall for gettimeofday
and remove EFAULT error test. Also, add EINVAL error test.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .../syscalls/settimeofday/settimeofday02.c    | 207 +++++-------------
 1 file changed, 49 insertions(+), 158 deletions(-)

diff --git a/testcases/kernel/syscalls/settimeofday/settimeofday02.c b/testcases/kernel/syscalls/settimeofday/settimeofday02.c
index 5516e619e..290c692b8 100644
--- a/testcases/kernel/syscalls/settimeofday/settimeofday02.c
+++ b/testcases/kernel/syscalls/settimeofday/settimeofday02.c
@@ -1,189 +1,80 @@
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
- * 	settimeofday02.c
+ * Copyright (c) International Business Machines  Corp., 2001
  *
  * DESCRIPTION
  *	Testcase to check that settimeofday() sets errnos correctly.
  *
- * ALGORITHM
- *	Setup:
- *	  Setup signal handling.
- *	  Check that we are not root.
- *	  Setup expected errnos.
- *	  Pause for SIGUSER1 if option specified.
- *	  Save the current time values.
- *	Loop if the proper options are given.
- *	  Call settimeofday with an invalid "buf" address and verify that
- *		errno is set to EFAULT.
- *	  Call settimeofday as a non-root user.  Verify that the call fails
- *		and errno is set to EPERM.
- *	Cleanup:
- *	  Print errno log and/or timing stats if options given.
- *
- * USAGE:  <for command-line>
- *	settimeofday02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
- *
- * Restrictions
- *	Must not be run as root
  */
 
 #include <stdio.h>
 #include <sys/time.h>
 #include <errno.h>
-#include "test.h"
-#include <pwd.h>
+#include <linux/capability.h>
+#include "tst_capability.h"
+#include "tst_test.h"
+#include "lapi/syscalls.h"
 
 #define	VAL_SEC		100
 #define	VAL_MSEC	100
 
-char *TCID = "settimeofday02";
-int TST_TOTAL = 1;
-
-struct timeval tp;
-time_t save_tv_sec, save_tv_usec;
-
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
+struct timeval tv_saved;
+static int flag;
 
-void setup(void);
-void cleanup(void);
-void restore_time(void);
+static struct tcase {
+	struct timeval tv;
+	int exp_errno;
+	char *message;
+} tcases[] = {
+	{{-1, 0}, EINVAL, "tv.tv_sec is negative"},
+	{{0, -1}, EINVAL, "tv.tv_usec is outside the range [0..999,999]"},
+	{{100, 100}, EPERM, "calling process without CAP_SYS_TIME capability"},
+};
 
-#if !defined(UCLINUX)
-
-int main(int argc, char **argv)
+static void verify_settimeofday(unsigned int n)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		TEST(settimeofday((void *)-1, NULL));
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "settimeofday(2) failed to FAIL");
-			restore_time();
-		} else {
-			if (TEST_ERRNO != EFAULT) {
-				tst_resm(TFAIL, "Expected EFAULT got %d",
-					 TEST_ERRNO);
-			} else {
-				tst_resm(TPASS, "Received expected errno");
-			}
-		}
-
-		tp.tv_sec = VAL_SEC;
-		tp.tv_usec = VAL_MSEC;
-		TEST(settimeofday(&tp, NULL));
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "settimeofday(2) failed to FAIL");
-			restore_time();
-		} else {
-			if (TEST_ERRNO != EPERM) {
-				tst_resm(TFAIL, "Expected EPERM got %d",
-					 TEST_ERRNO);
-			} else {
-				tst_resm(TPASS, "Received expected errno");
-			}
-		}
+	struct tcase *tc = &tcases[n];
+
+	flag = 0;
+	tst_res(TINFO, "%s", tc->message);
+	TEST(settimeofday(&tc->tv, NULL));
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "settimeofday() succeeded unexpectedly");
+		flag = 1;
+		return;
 	}
-	cleanup();
-	tst_exit();
 
+	if (TST_ERR != tc->exp_errno)
+		tst_res(TFAIL | TTERRNO, "Expected %s got ", tst_strerrno(tc->exp_errno));
+	else
+		tst_res(TPASS | TTERRNO, "Received expected errno");
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
-	/* Switch to nobody user for correct error code collection */
-	ltpuser = getpwnam(nobody_uid);
-	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setuid");
-	}
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
-	TEST_PAUSE;
-
-	/* Save the current time values */
-	if ((gettimeofday(&tp, (struct timezone *)&tp)) == -1) {
-		tst_brkm(TBROK, cleanup, "gettimeofday failed. "
-			 "errno=%d", errno);
-	}
-	save_tv_sec = tp.tv_sec;
-	save_tv_usec = tp.tv_usec;
+	if (!flag)
+		return;
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
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_settimeofday,
+	.tcnt = ARRAY_SIZE(tcases),
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_DROP, CAP_SYS_TIME),
+		{}
+	},
+};
 
-}
-
-void restore_time(void)
-{
-	/* restore the original time values. */
-	tp.tv_sec = save_tv_sec;
-	tp.tv_usec = save_tv_usec;
-	if ((settimeofday(&tp, NULL)) == -1) {
-		tst_resm(TWARN, "FATAL COULD NOT RESET THE CLOCK");
-		tst_resm(TFAIL, "Error Setting Time, errno=%d", errno);
-	}
-}
-- 
2.18.0



