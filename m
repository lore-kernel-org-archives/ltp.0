From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Apr 2018 16:50:12 +0200
Subject: [LTP] [RFC PATCH 3/6] syscalls/alarm05: Rewrite to the new library.
In-Reply-To: <20180405145015.7633-1-chrubis@suse.cz>
References: <20180405145015.7633-1-chrubis@suse.cz>
Message-ID: <20180405145015.7633-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ Speed up the test a bit, we save 6 seconds yay!

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/alarm/alarm05.c | 216 +++++++-----------------------
 1 file changed, 45 insertions(+), 171 deletions(-)

diff --git a/testcases/kernel/syscalls/alarm/alarm05.c b/testcases/kernel/syscalls/alarm/alarm05.c
index 1e93d2554..acb43c9a8 100644
--- a/testcases/kernel/syscalls/alarm/alarm05.c
+++ b/testcases/kernel/syscalls/alarm/alarm05.c
@@ -1,203 +1,77 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001,2005
+ *	07/2001 Ported by Wayne Boyer
+ *	06/2005 Test for alarm cleanup by Amos Waterland
  *
- *   Copyright (c) International Business Machines  Corp., 2001,2005
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
  *
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
 
 /*
- * Test Name: alarm05
- *
  * Test Description:
- *  Check the functionality of the Alarm system call when the time input
- *  parameter is non zero.
- *
- * Expected Result:
  *  The return value of the alarm system call should be equal to the
  *  amount previously remaining in the alarm clock.
  *  A SIGALRM signal should be received after the specified amount of
  *  time has elapsed.
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
- *  alarm05 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	06/2005 Test for alarm cleanup by Amos Waterland
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS:
- *  None.
  */
 
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-
-#include "test.h"
+#include "tst_test.h"
 
-char *TCID = "alarm05";
-int TST_TOTAL = 1;
-int alarms_received = 0;	/* flag to indicate SIGALRM received or not */
+static volatile int alarms_fired = 0;
 
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-void sigproc(int sig);		/* signal catching function */
-
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
-	int time_sec1 = 10;	/* time for which 1st alarm is set */
-	int time_sec2 = 5;	/* time for which 2st alarm is set */
-	int ret_val1, ret_val2;	/* return values for alarm() calls */
-	int ret_val3;
-	int sleep_time1 = 3;	/* waiting time for the signal */
-	int sleep_time2 = 6;	/* waiting time for the signal */
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	unsigned int ret;
 
-		tst_count = 0;
+	alarms_fired = 0;
 
-		/*
-		 * Reset alarms_received for every iteration, since it has
-		 * old values from previous iterations (if any) and not
-		 * a value of zero
-		 */
-		alarms_received = 0;
+	ret = alarm(10);
+	if (ret)
+		tst_res(TFAIL, "alarm() returned non-zero");
+	else
+		tst_res(TPASS, "alarm() returned zero");
 
-		/*
-		 * Call First alarm() with non-zero time parameter
-		 * 'time_sec1' to send SIGALRM to the calling process.
-		 */
-		TEST(alarm(time_sec1));
-		ret_val1 = TEST_RETURN;
+	sleep(1);
 
-		/* Wait for signal SIGALARM */
-		sleep(sleep_time1);
+	ret = alarm(1);
+	if (ret == 9)
+		tst_res(TPASS, "alarm() returned remainder correctly");
+	else
+		tst_res(TFAIL, "alarm() returned wrong remained %u", ret);
 
-		/*
-		 * Call Second alarm() with non-zero time parameter
-		 * 'time_sec2' to send SIGALRM to the calling process.
-		 */
-		TEST(alarm(time_sec2));
-		ret_val2 = TEST_RETURN;
+	sleep(2);
 
-		/* Wait for signal SIGALRM */
-		sleep(sleep_time2);
-
-		/*
-		 * Check whether the second alarm() call returned
-		 * the amount of time previously remaining in the
-		 * alarm clock of the calling process, and
-		 * sigproc() executed when SIGALRM received by the
-		 * process, the variable alarms_received is set.
-		 */
-		if ((alarms_received == 1) &&
-		    (ret_val2 == (time_sec1 - sleep_time1))) {
-
-			/*
-			 *  Make sure the system cleaned up the alarm
-			 *  after it delivered it.
-			 */
-			TEST(alarm(0));
-			ret_val3 = TEST_RETURN;
-
-			if (ret_val3 != 0)
-				tst_resm(TFAIL, "System did not "
-					 "clean up delivered " "alarm");
-			else {
-				tst_resm(TPASS, "Functionality of "
-					 "alarm(%u) successful",
-					 time_sec2);
-			}
-		} else {
-			tst_resm(TFAIL, "alarm(%u) fails, returned %d, "
-				 "alarms_received:%d",
-				 time_sec2, ret_val2, alarms_received);
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	if (alarms_fired == 1)
+		tst_res(TPASS, "alarm handler fired once");
+	else
+		tst_res(TFAIL, "alarm handler filred %u times", alarms_fired);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- *  Setup the signal handler to catch SIGALRM.
- */
-void setup(void)
+static void sighandler(int sig)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* Set the signal catching function */
-	if (signal(SIGALRM, sigproc) == SIG_ERR) {
-		tst_brkm(TFAIL, cleanup,
-			 "signal() fails to catch SIGALARM, errno=%d", errno);
-	}
+	if (sig == SIGALRM)
+		alarms_fired++;
 }
 
-/*
- * sigproc(int) - This function defines the action that has to be taken
- *	          when the SIGALRM signal is caught.
- *   It also sets the variable which is used to check whether the
- *   alarm system call was successful.
- */
-void sigproc(int sig)
+static void setup(void)
 {
-	alarms_received++;
+	SAFE_SIGNAL(SIGALRM, sighandler);
 }
 
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- */
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+};
-- 
2.13.6

