From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  9 Mar 2017 16:13:06 +0100
Subject: [LTP] [COMMITTED] [PATCH 4/6] syscalls/times03: Cleanups & rewrite.
In-Reply-To: <20170309151308.17512-1-chrubis@suse.cz>
References: <20170309151308.17512-1-chrubis@suse.cz>
Message-ID: <20170309151308.17512-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Rewrite the test to new library

* Speed up the test from 22s to 7s, doing the work for second or two
  which seems to be more than enough

* Run the test in a child to reset the counters and add a few more assertions

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/times/times03.c | 335 +++++++++++++-----------------
 1 file changed, 150 insertions(+), 185 deletions(-)

diff --git a/testcases/kernel/syscalls/times/times03.c b/testcases/kernel/syscalls/times/times03.c
index f6f8323..0db8215 100644
--- a/testcases/kernel/syscalls/times/times03.c
+++ b/testcases/kernel/syscalls/times/times03.c
@@ -1,26 +1,22 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (C) 2017 Cyril Hrubis <chrubis@suse.cz>
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
-
 /*
- * NAME
- *	times03.c
- *
  * DESCRIPTION
  *	Testcase to check the basic functionality of the times() system call.
  *
@@ -30,19 +26,8 @@
  *	a for-loop. Then use the times() system call, to determine the
  *	cpu time/sleep time, and other statistics.
  *
- * USAGE:  <for command-line>
- *	times03 [-c n] [-f] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-f   : Turn off functionality Testing.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
  * History
  *	07/2001 John George
- *		-Ported
- *
- * Restrictions
- *	NONE
  */
 
 #include <sys/types.h>
@@ -50,200 +35,180 @@
 #include <errno.h>
 #include <sys/wait.h>
 #include <time.h>
-#include "test.h"
 #include <signal.h>
-#include <stdint.h>
+#include <stdlib.h>
 
-char *TCID = "times03";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
-volatile int timeout;		/* Did we timeout in alarm() ? */
+static volatile int timeout;
 
-void work(void);
-void sighandler(int signal, siginfo_t * info, void *uc);
-
-void setup(void);
-void cleanup(void);
-
-int main(int argc, char **argv)
+static void sighandler(int signal)
 {
-	struct tms buf1, buf2;
-	time_t start_time, end_time;
-	int pid2, status;
-	struct sigaction sa;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
+	if (signal == SIGALRM)
+		timeout = 1;
+}
 
-	/*
-	 * We spend time in userspace using the following mechanism :
-	 * Setup an alarm() for 3 secs and do some simple loop operations
-	 * until we get the signal. This makes the test independent of
-	 * processor speed.
-	 */
-	sa.sa_sigaction = sighandler;
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags = SA_SIGINFO;
+static volatile int k;
 
-	if (sigaction(SIGALRM, &sa, NULL) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "Sigaction failed !\n");
+static void work(void)
+{
+	int i, j;
 
+	while (!timeout)
+		for (i = 0; i < 10000; i++)
+			for (j = 0; j < 100; j++)
+				k = i * j;
 	timeout = 0;
-	alarm(3);
+}
 
+static void generate_utime(void)
+{
+	alarm(1);
 	work();
+}
+
+static void generate_stime(void)
+{
+	time_t start_time, end_time;
+	struct tms buf;
 
 	/*
 	 * At least some CPU time must be used in system space. This is
 	 * achieved by executing the times(2) call for
-	 * atleast 5 secs. This logic makes it independant
+	 * atleast 2 secs. This logic makes it independant
 	 * of the processor speed.
 	 */
 	start_time = time(NULL);
 	for (;;) {
-		if (times(&buf1) == -1)
-			tst_resm(TFAIL | TERRNO, "times failed");
+		if (times(&buf) == -1)
+			tst_res(TFAIL | TERRNO, "times failed");
 		end_time = time(NULL);
-		if ((end_time - start_time) > 5) {
-			break;
-		}
+		if ((end_time - start_time) > 2)
+			return;
 	}
-	if (times(&buf1) == -1) {
-		tst_resm(TFAIL | TERRNO, "times failed");
+}
+
+static void verify_times(void)
+{
+	int pid;
+	struct tms buf1, buf2, buf3;
+
+	if (times(&buf1) == -1)
+		tst_brk(TBROK | TERRNO, "times()");
+
+	if (buf1.tms_utime != 0)
+		tst_res(TFAIL, "buf1.tms_utime = %li", buf1.tms_utime);
+	else
+		tst_res(TPASS, "buf1.tms_utime = 0");
+
+	if (buf1.tms_stime != 0)
+		tst_res(TFAIL, "buf1.tms_stime = %li", buf1.tms_stime);
+	else
+		tst_res(TPASS, "buf1.tms_stime = 0");
+
+	generate_utime();
+	generate_stime();
+
+	if (times(&buf2) == -1)
+		tst_brk(TBROK | TERRNO, "times()");
+
+	if (buf2.tms_utime == 0)
+		tst_res(TFAIL, "buf2.tms_utime = 0");
+	else
+		tst_res(TPASS, "buf2.tms_utime = %li", buf2.tms_utime);
+
+	if (buf1.tms_utime >= buf2.tms_utime) {
+		tst_res(TFAIL, "buf1.tms_utime (%li) >= buf2.tms_utime (%li)",
+			buf1.tms_utime, buf2.tms_utime);
 	} else {
-		if (buf1.tms_utime == 0)
-			tst_resm(TFAIL, "times report " "0 user time");
-		if (buf1.tms_stime == 0)
-			tst_resm(TFAIL, "times report "
-				 "0 system time");
-		if (buf1.tms_cutime != 0)
-			tst_resm(TFAIL, "times report "
-				 "%ld child user time",
-				 buf1.tms_cutime);
-		if (buf1.tms_cstime != 0)
-			tst_resm(TFAIL,
-				 "times report "
-				 "%ld child system time",
-				 buf1.tms_cstime);
-
-		pid2 = FORK_OR_VFORK();
-		if (pid2 < 0) {
-			tst_brkm(TFAIL, cleanup, "Fork failed");
-		} else if (pid2 == 0) {
-
-			/* Spend some cycles in userspace */
-
-			timeout = 0;
-			alarm(3);
-
-			work();
-
-			/*
-			 * Atleast some CPU system ime must be used
-			 * even in the child process (thereby
-			 * making it independent of the
-			 * processor speed). In fact the child
-			 * uses twice as much CPU time.
-			 */
-			start_time = time(NULL);
-			for (;;) {
-				if (times(&buf2) == -1) {
-					tst_resm(TFAIL,
-						 "Call to times "
-						 "failed, "
-						 "errno = %d", errno);
-					exit(1);
-				}
-				end_time = time(NULL);
-				if ((end_time - start_time)
-				    > 10) {
-					break;
-				}
-			}
-			exit(0);
-		}
-
-		waitpid(pid2, &status, 0);
-		if (WEXITSTATUS(status) != 0) {
-			tst_resm(TFAIL, "Call to times(2) "
-				 "failed in child");
-		}
-		if (times(&buf2) == -1) {
-			tst_resm(TFAIL | TTERRNO, "times failed");
-		}
-		if (buf1.tms_utime > buf2.tms_utime)
-			tst_resm(TFAIL, "Error: parents's "
-				 "user time(%ld) before child "
-				 "> parent's user time (%ld) "
-				 "after child",
-				 buf1.tms_utime, buf2.tms_utime);
-		if (buf2.tms_cutime == 0)
-			tst_resm(TFAIL, "times "
-				 "report %ld child user "
-				 "time should be > than "
-				 "zero", buf2.tms_cutime);
-		if (buf2.tms_cstime == 0)
-			tst_resm(TFAIL, "times "
-				 "report %ld child system time "
-				 "should be > than zero",
-				 buf2.tms_cstime);
+		tst_res(TPASS, "buf1.tms_utime (%li) < buf2.tms_utime (%li)",
+			buf1.tms_utime, buf2.tms_utime);
 	}
 
-	cleanup();
-	tst_exit();
-}
+	if (buf2.tms_stime == 0)
+		tst_res(TFAIL, "buf2.tms_stime = 0");
+	else
+		tst_res(TPASS, "buf2.tms_stime = %li", buf2.tms_stime);
 
-/*
- * sighandler
- *	Set the timeout to indicate we timed out in the alarm().
- */
+	if (buf1.tms_stime >= buf2.tms_stime) {
+		tst_res(TFAIL, "buf1.tms_stime (%li) >= buf2.tms_stime (%li)",
+			buf1.tms_stime, buf2.tms_stime);
+	} else {
+		tst_res(TPASS, "buf1.tms_stime (%li) < buf2.tms_stime (%li)",
+			buf1.tms_stime, buf2.tms_stime);
+	}
 
-void sighandler(int signal, siginfo_t * info, void *uc)
-{
-	if (signal == SIGALRM)
-		timeout = 1;
+	if (buf2.tms_cutime != 0)
+		tst_res(TFAIL, "buf2.tms_cutime = %li", buf2.tms_cutime);
 	else
-		tst_brkm(TBROK, cleanup, "Unexpected signal %d\n", signal);
-}
+		tst_res(TPASS, "buf2.tms_cutime = 0");
 
-/*
- * work
- *	Do some work in user space, until we get a timeout.
- */
+	if (buf2.tms_cstime != 0)
+		tst_res(TFAIL, "buf2.tms_cstime = %li", buf2.tms_cstime);
+	else
+		tst_res(TPASS, "buf2.tms_cstime = 0");
 
-void work(void)
-{
-	int i, j, k;
+	pid = SAFE_FORK();
 
-	while (!timeout)
-		for (i = 0; i < 10000; i++)
-			for (j = 0; j < 100; j++)
-				k = i * j;
-	timeout = 0;
-}
+	if (!pid) {
+		generate_utime();
+		generate_stime();
+		exit(0);
+	}
 
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
-{
+	SAFE_WAITPID(pid, NULL, 0);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	if (times(&buf3) == -1)
+		tst_brk(TBROK | TERRNO, "times()");
 
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
-	TEST_PAUSE;
+	if (buf2.tms_utime > buf3.tms_utime) {
+		tst_res(TFAIL, "buf2.tms_utime (%li) > buf3.tms_utime (%li)",
+			buf2.tms_utime, buf3.tms_utime);
+	} else {
+		tst_res(TPASS, "buf2.tms_utime (%li) <= buf3.tms_utime (%li)",
+			buf2.tms_utime, buf3.tms_utime);
+	}
+
+	if (buf2.tms_stime > buf3.tms_stime) {
+		tst_res(TFAIL, "buf2.tms_stime (%li) > buf3.tms_stime (%li)",
+			buf2.tms_stime, buf3.tms_stime);
+	} else {
+		tst_res(TPASS, "buf2.tms_stime (%li) <= buf3.tms_stime (%li)",
+			buf2.tms_stime, buf3.tms_stime);
+	}
+
+	if (buf3.tms_cutime == 0)
+		tst_res(TFAIL, "buf3.tms_cutime = 0");
+	else
+		tst_res(TPASS, "buf3.tms_cutime = %ld", buf3.tms_cutime);
+
+	if (buf3.tms_cstime == 0)
+		tst_res(TFAIL, "buf3.tms_cstime = 0");
+	else
+		tst_res(TPASS, "buf3.tms_cstime = %ld", buf3.tms_cstime);
+
+	exit(0);
 }
 
 /*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
+ * Run the test in a child to reset times in case of -i option.
  */
-void cleanup(void)
+static void do_test(void)
 {
+	int pid = SAFE_FORK();
 
+	if (!pid)
+		verify_times();
 }
+
+static void setup(void)
+{
+	SAFE_SIGNAL(SIGALRM, sighandler);
+}
+
+static struct tst_test test = {
+	.tid = "times03",
+	.setup = setup,
+	.forks_child = 1,
+	.test_all = do_test,
+};
-- 
2.10.2

