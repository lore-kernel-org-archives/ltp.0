From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Sat, 15 Aug 2020 13:13:12 +0800
Subject: [LTP] [PATCH 2/2] syscalls/sigsuspend01.c: Convert to the new API
In-Reply-To: <20200815051312.25002-1-yangx.jy@cn.fujitsu.com>
References: <20200815051312.25002-1-yangx.jy@cn.fujitsu.com>
Message-ID: <20200815051312.25002-2-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also add an extra check point:
The process can unblock and receive SIGALRM by sigsuspend()
even if sigprocmask() has blocked SIGALRM.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/sigsuspend/sigsuspend01.c | 237 ++++--------------
 1 file changed, 53 insertions(+), 184 deletions(-)

diff --git a/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c b/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c
index a846f6330..e96fb837c 100644
--- a/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c
+++ b/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c
@@ -1,212 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
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
- */
-
-/*
- * Test Name: sigsuspend01
- *
- * Test Description:
- *  Verify that sigsuspend() succeeds to change process's current signal
- *  mask with the specified signal mask and suspends the process execution
- *  until the delivery of a signal.
- *
- * Expected Result:
- *  sigsuspend() should return after the execution of signal catching
- *  function and the previous signal mask should be restored.
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
- *   	Log the errno and Issue a FAIL message.
- *   Otherwise,
- *   	Verify the Functionality of system call
- *      if successful,
- *      	Issue Functionality-Pass message.
- *      Otherwise,
- *		Issue Functionality-Fail message.
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory created.
- *
- * Usage:  <for command-line>
- *  sigsuspend01 [-c n] [-e] [-f] [-i n] [-I x] [-p x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-f   : Turn off functionality Testing.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions:
- *  None.
+ * Description:
+ * Verify the basic function of sigsuspend():
+ * 1) sigsuspend() can replace process's current signal mask
+ *    by the specified signal mask and suspend the process
+ *    execution until the delivery of a signal.
+ * 2) sigsuspend() should return after the execution of signal
+ *    handler and restore the previous signal mask.
  */
 
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/types.h>
 #include <errno.h>
-#include <fcntl.h>
+#include <unistd.h>
 #include <string.h>
 #include <signal.h>
-#include <ucontext.h>
-
-#include "test.h"
 
-char *TCID = "sigsuspend01";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
-struct sigaction sa_new;	/* struct to hold signal info */
-sigset_t signalset;		/* signal set to hold signal lists */
-sigset_t sigset1;
-sigset_t sigset2;
+static sigset_t signalset, sigset1, sigset2;
+static volatile sig_atomic_t alarm_num;
 
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-void sig_handler(int sig);	/* signal catching function */
-
-int main(int ac, char **av)
+static void sig_handler(int sig)
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
-		/* Set the alarm timer */
-		alarm(5);
-
-		/*
-		 * Call sigsuspend() to replace current signal mask
-		 * of the process and suspend process execution till
-		 * receipt of a signal 'SIGALRM'.
-		 */
-		TEST(sigsuspend(&signalset));
-
-		/* Reset the alarm timer */
-		alarm(0);
-
-		if ((TEST_RETURN == -1) && (TEST_ERRNO == EINTR)) {
-			if (sigprocmask(SIG_UNBLOCK, 0, &sigset2) == -1) {
-				tst_resm(TFAIL, "sigprocmask() Failed "
-					 "to get previous signal mask "
-					 "of process");
-			} else if (memcmp(&sigset1, &sigset2,
-				   sizeof(unsigned long))) {
-				tst_resm(TFAIL, "sigsuspend failed to "
-					 "preserve signal mask");
-			} else {
-				tst_resm(TPASS, "Functionality of "
-					 "sigsuspend() successful");
-			}
-		} else {
-			tst_resm(TFAIL | TTERRNO,
-				 "sigsuspend() returned value %ld",
-				 TEST_RETURN);
-		}
-
-		tst_count++;	/* incr TEST_LOOP counter */
-	}
-
-	cleanup();
-	tst_exit();
+	alarm_num = sig;
 }
 
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- * Initialise signal set with the list that includes/excludes
- * all system-defined signals.
- * Set the signal handler to catch SIGALRM signal.
- * Get the current signal mask of test process using sigprocmask().
- */
-void setup(void)
+static void verify_sigsuspend(void)
 {
+	alarm_num = 0;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	SAFE_SIGFILLSET(&sigset2);
 
-	TEST_PAUSE;
+	alarm(1);
 
-	/*
-	 * Initialise the signal sets with the list that
-	 * excludes/includes  all system-defined signals.
-	 */
-	if (sigemptyset(&signalset) == -1) {
-		tst_brkm(TFAIL, cleanup,
-			 "sigemptyset() failed, errno=%d : %s",
-			 errno, strerror(errno));
-	}
-	if (sigfillset(&sigset2) == -1) {
-		tst_brkm(TFAIL, cleanup,
-			 "sigfillset() failed, errno=%d : %s",
-			 errno, strerror(errno));
+	/* Unblock SIGALRM */
+	TEST(sigsuspend(&signalset));
+
+	alarm(0);
+
+	if (TST_RET != -1 || TST_ERR != EINTR) {
+		tst_res(TFAIL | TTERRNO,
+			"sigsuspend() returned value %ld", TST_RET);
+		return;
 	}
 
-	/* Set the signal handler function to catch the signal */
-	sa_new.sa_handler = sig_handler;
-	if (sigaction(SIGALRM, &sa_new, 0) == -1) {
-		tst_brkm(TFAIL, cleanup,
-			 "sigaction() failed, errno=%d : %s",
-			 errno, strerror(errno));
+	if (alarm_num != SIGALRM) {
+		tst_res(TFAIL, "sigsuspend() didn't unblock SIGALRM");
+		return;
 	}
 
-	/* Read the test process's current signal mask. */
-	if (sigprocmask(SIG_UNBLOCK, 0, &sigset1) == -1) {
-		tst_brkm(TFAIL, cleanup,
-			 "sigprocmask() Failed, errno=%d : %s",
-			 errno, strerror(errno));
+	SAFE_SIGPROCMASK(0, NULL, &sigset2);
+	if (memcmp(&sigset1, &sigset2, sizeof(unsigned long))) {
+		tst_res(TFAIL, "sigsuspend() failed to "
+			"restore the previous signal mask");
+		return;
 	}
-}
 
-/*
- * void
- * sig_handler(int sig) - Signal catching function.
- *   This function gets executed when the signal SIGALRM is delivered
- *   to the test process after the expiry of alarm time and the signal was
- *   trapped by sigaction() to execute this function.
- *
- *   This function simply returns without doing anything.
- */
-void sig_handler(int sig)
-{
+	tst_res(TPASS, "sigsuspend() succeeded");
 }
 
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- */
-void cleanup(void)
+static void setup(void)
 {
+	struct sigaction sa_new;
 
+	SAFE_SIGEMPTYSET(&signalset);
+	SAFE_SIGEMPTYSET(&sigset1);
+	SAFE_SIGADDSET(&sigset1, SIGALRM);
+
+	sa_new.sa_handler = sig_handler;
+	SAFE_SIGACTION(SIGALRM, &sa_new, 0);
+
+	/* Block SIGALRM */
+	SAFE_SIGPROCMASK(SIG_SETMASK, &sigset1, NULL);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = verify_sigsuspend,
+};
-- 
2.21.0



