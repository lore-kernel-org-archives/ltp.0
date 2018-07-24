From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Tue, 24 Jul 2018 19:30:55 +0800
Subject: [LTP] [PATCH 3/3] syscalls/alarm07: Rewrite to new library
In-Reply-To: <1532431855-18452-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1532431855-18452-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1532431855-18452-3-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Initialize alarms_received variable in loops
2) Add the output of TPASS

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/alarm/alarm07.c | 175 ++++++------------------------
 1 file changed, 31 insertions(+), 144 deletions(-)

diff --git a/testcases/kernel/syscalls/alarm/alarm07.c b/testcases/kernel/syscalls/alarm/alarm07.c
index 5f4d6e4..b874324 100644
--- a/testcases/kernel/syscalls/alarm/alarm07.c
+++ b/testcases/kernel/syscalls/alarm/alarm07.c
@@ -1,171 +1,58 @@
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
- * Test Name: alarm07
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Author: Wayne Boyer
  *
  * Test Description:
- *  Check the functionality of the alarm() when the time input
- *  parameter is non-zero and the process does a fork.
- *
- * Expected Result:
- *  The alarm request should be cleared in the child process.
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
- *  alarm07 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
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
+ *  By the SIGALRM signal, check whether the previously specified alarm request
+ *  was cleared in the child process or not.
  */
 
-#include <stdio.h>
 #include <unistd.h>
-#include <sys/types.h>
+#include <stdlib.h>
 #include <errno.h>
-#include <string.h>
 #include <signal.h>
-#include <sys/wait.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
-char *TCID = "alarm07";
-int TST_TOTAL = 1;
-int alarms_received = 0;
+static volatile int alarms_received = 0;
 
-void setup();
-void cleanup();
-void sigproc(int sig);
-
-int main(int ac, char **av)
+static void verify_alarm(void)
 {
-	int lc;
-	int sleep_time = 5;
-	int status;
-	int time_sec = 3;
-	pid_t cpid;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	pid_t pid;
+	alarms_received = 0;
 
-		tst_count = 0;
+	TEST(alarm(3));
 
-		/*
-		 * Call First alarm() with non-zero time parameter
-		 * 'time_sec' to send SIGALRM to the process.
-		 */
-		TEST(alarm(time_sec));
+	pid = SAFE_FORK();
 
-		/* Now, fork a child process */
-		cpid = FORK_OR_VFORK();
-		if (cpid < 0) {
-			tst_resm(TFAIL | TERRNO, "fork() failed");
-		}
-
-		sleep(sleep_time);
+	sleep(5);
 
-		if (cpid == 0) {
-			if (alarms_received == 0)
-				exit(0);
-			else {
-				printf("alarm request not cleared in "
-				       "child; alarms received:%d\n",
-				       alarms_received);
-				exit(1);
-			}
+	if (pid == 0) {
+		if (alarms_received == 0) {
+			tst_res(TPASS, "alarm() request cleared in child");
 		} else {
-			/* Wait for child to complete execution */
-			SAFE_WAIT(cleanup, &status);
-			if (!WIFEXITED(status) ||
-			    WEXITSTATUS(status) != 0)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "child exited abnormally");
+			tst_res(TFAIL, "alarm() request not cleared in "
+				"child; alarms received:%d", alarms_received);
 		}
+		 exit(0);
+	} else {
+		tst_reap_children();
 	}
-
-	cleanup();
-	tst_exit();
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- *  Setup signal handler to catch SIGALRM signal.
- */
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* Set the signal catching function */
-	if (signal(SIGALRM, sigproc) == SIG_ERR) {
-		tst_brkm(TFAIL | TERRNO, cleanup, "signal(SIGALRM, ..) failed");
-	}
-}
-
-/*
- * sigproc(int) - This function defines the action that has to be taken
- *	          when the SIGALRM signal is caught.
- *   It also sets the variable which is used to check whether the
- *   alarm system call was successful.
- */
-void sigproc(int sig)
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
 {
 	alarms_received++;
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- */
-void cleanup(void)
+static void setup(void)
 {
+	SAFE_SIGNAL(SIGALRM, sighandler);
 }
+
+static struct tst_test test = {
+	.test_all = verify_alarm,
+	.setup = setup,
+	.forks_child = 1,
+};
-- 
1.8.3.1



