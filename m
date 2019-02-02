From: Steve Muckle <smuckle@google.com>
Date: Fri,  1 Feb 2019 17:59:24 -0800
Subject: [LTP] [PATCH DRAFT] syscalls/stime: convert to new lib,
	use direct syscall
Message-ID: <20190202015923.189057-1-smuckle@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use direct syscall to expand test compatibility to Android.

Change-Id: Icdeec19bd3675902266adc1ef7f9173b76016e15
Signed-off-by: Steve Muckle <smuckle@google.com>
---

I set about cleaning up the stime tests but later realized I don't
have a platform that has the stime syscall so I cannot test this
patch fully. If someone else has such a platform (looks like 32-bit
x86 has it) and wants to take the patch over, feel free :) .

 testcases/kernel/syscalls/stime/stime01.c | 217 +++++-----------------
 testcases/kernel/syscalls/stime/stime02.c | 176 ++++--------------
 2 files changed, 80 insertions(+), 313 deletions(-)

diff --git a/testcases/kernel/syscalls/stime/stime01.c b/testcases/kernel/syscalls/stime/stime01.c
index 378aa52a8..55c8053b0 100644
--- a/testcases/kernel/syscalls/stime/stime01.c
+++ b/testcases/kernel/syscalls/stime/stime01.c
@@ -1,24 +1,6 @@
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
- * Test Name: stime01
+ * Copyright (c) International Business Machines  Corp., 2001
  *
  * Test Description:
  *  Verify that the system call stime() successfully sets the system's idea
@@ -27,177 +9,64 @@
  * Expected Result:
  *  stime() should succeed to set the system data/time to the specified time.
  *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *   	Log the errno and Issue a FAIL message.
- *   Otherwise,
- *   	Verify the Functionality of system call
- *      if successful,
- *      	Issue Functionality-Pass message.
- *      Otherwise,
- *		Issue Functionality-Fail message.
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *
- * Usage:  <for command-line>
- *  stime01 [-c n] [-e] [-f] [-i n] [-I x] [-p x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-f   : Turn off functionality Testing.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
  * History
  *	07/2001 John George
  *		-Ported
- *
- * Restrictions:
- *  This test should be run by 'super-user' (root) only.
- *
  */
 
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <fcntl.h>
 #include <time.h>
-#include <string.h>
-#include <sys/stat.h>
-#include <signal.h>
 #include <sys/time.h>
 
-#include "test.h"
-
-#define INCR_TIME	30	/* increment in the system's current time */
+#include "lapi/syscalls.h"
+#include "tst_test.h"
 
 #define BASH_CLOCK
 
-char *TCID = "stime01";
-int TST_TOTAL = 1;
-struct timeval real_time_tv, pres_time_tv;
-time_t new_time;
-
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
+static struct timeval real_time_tv;
 
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/*
-		 * ``Break`` the clock.
-		 *
-		 * This is being done inline here so that the offset is
-		 * automatically reset based on the elapsed time, and not a
-		 * fixed time sampled once in setup.
-		 *
-		 * The big assumption here is the clock state isn't super
-		 * fubared if so, the executing party needs to go fix their
-		 * RTC's battery, or they have more pressing issues to attend
-		 * to as far as clock skew is concerned :P.
-		 */
-		if (gettimeofday(&real_time_tv, NULL) < 0) {
-			tst_brkm(TBROK | TERRNO, NULL,
-				 "failed to get current time via gettimeofday(2)");
-		}
-
-		/* Get the system's new time */
-		new_time = real_time_tv.tv_sec + INCR_TIME;
-
-		tst_count = 0;
-
-		/*
-		 * Invoke stime(2) to set the system's time to the specified
-		 * new_time.
-		 */
-		if (stime(&new_time) < 0) {
-			tst_resm(TFAIL | TERRNO, "stime(%ld) failed", new_time);
-		} else {
-
-			/*
-			 * Get the system's current time after call
-			 * to stime().
-			 */
-			if (gettimeofday(&pres_time_tv, NULL) < 0) {
-				tst_brkm(TFAIL | TERRNO, cleanup,
-					 "time() failed to get "
-					 "system's time after stime");
-			}
-
-			/* Now do the actual verification */
-			switch (pres_time_tv.tv_sec - new_time) {
-			case 0:
-			case 1:
-				tst_resm(TINFO, "pt.tv_sec: %ld",
-					 pres_time_tv.tv_sec);
-				tst_resm(TPASS, "system time was set "
-					 "to %ld", new_time);
-				break;
-			default:
-				tst_resm(TFAIL, "system time was not "
-					 "set to %ld (time is "
-					 "actually: %ld)",
-					 new_time, pres_time_tv.tv_sec);
-			}
-
-			if (settimeofday(&real_time_tv, NULL) < 0) {
-				tst_resm(TBROK | TERRNO,
-					 "failed to restore time to original "
-					 "value; system clock may need to be "
-					 "fixed manually");
-			}
-
+	time_t new_time;
+	struct timeval pres_time_tv;
+
+	if (gettimeofday(&real_time_tv, NULL) < 0)
+		tst_brk(TBROK | TERRNO,
+			"failed to get current time via gettimeofday(2)");
+
+	new_time = real_time_tv.tv_sec + 30;
+
+	/* Invoke stime to set the system's time to the specified new_time. */
+	if (tst_syscall(__NR_stime, &new_time) < 0) {
+		tst_res(TFAIL | TERRNO, "stime(%ld) failed", new_time);
+	} else {
+		if (gettimeofday(&pres_time_tv, NULL) < 0)
+			tst_brk(TFAIL | TERRNO, "time() failed to get "
+				"system's time after stime");
+
+		switch (pres_time_tv.tv_sec - new_time) {
+		case 0:
+		case 1:
+			tst_res(TINFO, "pt.tv_sec: %ld", pres_time_tv.tv_sec);
+			tst_res(TPASS, "system time was set to %ld", new_time);
+			break;
+		default:
+			tst_res(TFAIL, "system time not set to %ld (time "
+				"actually: %ld)", new_time,
+				pres_time_tv.tv_sec);
 		}
-
 	}
-
-	cleanup();
-	tst_exit();
-
 }
 
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *  Get the current time and system's new time to be set in the test.
- */
-void setup(void)
+static void cleanup(void)
 {
-	tst_require_root();
-
-	TEST_PAUSE;
-
-}
-
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- */
-void cleanup(void)
-{
-
 	/* Restore the original system time. */
-	if (settimeofday(&real_time_tv, NULL) != 0) {
-		tst_resm(TBROK | TERRNO, "failed to restore time to original "
-			 "value; system clock may need to be "
-			 "fixed manually");
-	}
-
+	if (settimeofday(&real_time_tv, NULL) != 0)
+		tst_res(TBROK | TERRNO, "failed to restore time to original "
+			"value; system clock may need to be fixed manually");
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.cleanup = cleanup,
+	.needs_root = 1,
+};
diff --git a/testcases/kernel/syscalls/stime/stime02.c b/testcases/kernel/syscalls/stime/stime02.c
index 180e36119..cf86069ba 100644
--- a/testcases/kernel/syscalls/stime/stime02.c
+++ b/testcases/kernel/syscalls/stime/stime02.c
@@ -1,24 +1,6 @@
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
- * Test Name: stime02
+ * Copyright (c) International Business Machines  Corp., 2001
  *
  * Test Description:
  *   Verify that the system call stime() fails to set the system's idea
@@ -27,144 +9,60 @@
  * Expected Result:
  *  stime() should fail with return value -1 and set errno to EPERM.
  *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *   	if errno set == expected errno
- *   		Issue sys call fails with expected return value and errno.
- *   	Otherwise,
- *		Issue sys call fails with unexpected errno.
- *   Otherwise,
- *	Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *
- * Usage:  <for command-line>
- *  stime02 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
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
- * Restrictions:
  */
 
-#include <stdio.h>
-#include <unistd.h>
 #include <sys/types.h>
 #include <errno.h>
-#include <fcntl.h>
 #include <time.h>
-#include <string.h>
-#include <sys/stat.h>
-#include <signal.h>
 #include <pwd.h>
 
-#include "test.h"
+#include "lapi/syscalls.h"
+#include "tst_test.h"
 
-#define INCR_TIME	10	/* increment in the system's current time */
+static time_t new_time;
 
-char *TCID = "stime02";
-int TST_TOTAL = 1;
-
-time_t curr_time;		/* system's current time in seconds */
-time_t new_time;		/* system's new time */
-time_t tloc;			/* argument var. for time() */
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Invoke stime(2) to set the system's time
-		 * to the specified new_time as non-root user.
-		 */
-		TEST(stime(&new_time));
-
-		if (TEST_RETURN == -1) {
-			if (TEST_ERRNO == EPERM) {
-				tst_resm(TPASS, "stime(2) fails, Caller not "
-					 "root, errno:%d", TEST_ERRNO);
-			} else {
-				tst_resm(TFAIL, "stime(2) fails, Caller not "
-					 "root, errno:%d, expected errno:%d",
-					 TEST_ERRNO, EPERM);
-			}
-		} else {
-			tst_resm(TFAIL, "stime(2) returned %ld, expected -1, "
-				 "errno:%d", TEST_RETURN, EPERM);
-		}
-		tst_count++;	/* incr TEST_LOOP counter */
-	}
-
-	cleanup();
-	tst_exit();
-
+	/*
+	 * Invoke stime to set the system's time to the specified new_time as
+	 * non-root user.
+	 */
+	TEST(tst_syscall(__NR_stime, &new_time));
+
+	if (TST_RET == -1)
+		if (TST_ERR == EPERM)
+			tst_res(TPASS | TTERRNO, "stime(2) fails, Caller not "
+				"root");
+		else
+			tst_res(TFAIL| TTERRNO, "stime(2) fails, Caller not "
+				"root, expected errno:%d", EPERM);
+	else
+		tst_res(TFAIL, "stime(2) returned %ld, expected -1, "
+			"errno:%d", TST_RET, EPERM);
 }
 
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *  Get the current time and system's new time.
- */
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	time_t curr_time;
+	struct passwd *ltpuser;
 
 	/* Switch to nobody user for correct error code collection */
-	ltpuser = getpwnam(nobody_uid);
-	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setuid");
-	}
+	ltpuser = getpwnam("nobody");
+	if (setuid(ltpuser->pw_uid) == -1)
+		tst_brk(TBROK | TERRNO, "setuid failed to "
+			"set the effective uid to %d", ltpuser->pw_uid);
 
-	TEST_PAUSE;
+	if ((curr_time = time(NULL)) < 0)
+		tst_brk(TBROK | TERRNO, "time() failed to get current time");
 
-	/* Get the current time */
-	if ((curr_time = time(&tloc)) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "time() failed to get current time, errno=%d", errno);
-	}
-
-	/* Get the system's new time */
-	new_time = curr_time + INCR_TIME;
+	new_time = curr_time + 10;
 }
 
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+};
-- 
2.20.1.611.gfbb209baf1-goog

