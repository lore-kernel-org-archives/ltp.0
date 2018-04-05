From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Apr 2018 16:50:14 +0200
Subject: [LTP] [RFC PATCH 5/6] syscalls/waitpid01: Rewrite to the new
	library.
In-Reply-To: <20180405145015.7633-1-chrubis@suse.cz>
References: <20180405145015.7633-1-chrubis@suse.cz>
Message-ID: <20180405145015.7633-6-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ use raise(SIGALRM) instead of wasting time with alarm(2)

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/waitpid/waitpid01.c | 172 ++++++++------------------
 1 file changed, 52 insertions(+), 120 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid01.c b/testcases/kernel/syscalls/waitpid/waitpid01.c
index e05e783ef..efbc26e5a 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid01.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid01.c
@@ -1,142 +1,74 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ *    07/2001 John George
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
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
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
- * NAME
- *	waitpid01.c
- *
- * DESCRIPTION
- *	Check that when a child kills itself by generating an alarm
- *	exception, the waiting parent is correctly notified.
- *
- * ALGORITHM
- *	Fork a child that sets an alarm. When the alarm goes off, causing
- *	the death of the child, the parent checks that SIG_ALRM was returned
- *
- * USAGE:  <for command-line>
- *      waitpid01 [-c n] [-i n] [-I x] [-P x] [-t]
- *      where,  -c n : Run n copies concurrently.
- *              -i n : Execute test n times.
- *              -I x : Execute test for x seconds.
- *              -P x : Pause for x seconds between iterations.
- *              -t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
+ * Check that when a child kills itself by SIGALRM the waiting parent is
+ * correctly notified.
  *
- * Restrictions
- *	None
+ * Fork a child that raises(SIGALRM), the parent checks that SIGALRM was
+ * returned.
  */
-
-#include <sys/signal.h>
-#include <sys/types.h>
+#include <stdlib.h>
 #include <sys/wait.h>
-#include <errno.h>
-#include "test.h"
-
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "waitpid01";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
-int main(int argc, char **argv)
+static void run(void)
 {
-	int lc;
-
-	int pid, npid, sig, nsig;
-	int exno, nexno, status;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
+	pid_t pid, rpid;
+	int status;
 
-	setup();
-
-	/* check for looping state if -i option is given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		exno = 1;
-		sig = 14;
+	pid = SAFE_FORK();
+	if (!pid) {
+		raise(SIGALRM);
+		exit(0);
+	}
 
-		pid = FORK_OR_VFORK();
-		if (pid < 0) {
-			tst_brkm(TFAIL, cleanup, "Fork Failed");
-		} else if (pid == 0) {
-			alarm(2);
-			pause();
-			exit(exno);
-		} else {
-			errno = 0;
-			while (((npid = waitpid(pid, &status, 0)) != -1) ||
-			       (errno == EINTR)) {
-				if (errno == EINTR)
-					continue;
+	rpid = waitpid(pid, &status, 0);
+	if (rpid < 0)
+		tst_brk(TBROK | TERRNO, "waitpid() failed");
 
-				if (npid != pid) {
-					tst_resm(TFAIL, "waitpid error: "
-						 "unexpected pid returned");
-				} else {
-					tst_resm(TPASS,
-						 "recieved expected pid");
-				}
+	if (rpid != pid) {
+		tst_res(TFAIL, "waitpid() returned wrong pid %i, expected %i",
+		        rpid, pid);
+	} else {
+		tst_res(TPASS, "waitpid() returned correct pid %i", pid);
+	}
 
-				nsig = WTERMSIG(status);
+	if (!WIFSIGNALED(status)) {
+		tst_res(TFAIL, "WIFSIGNALED() not set in status (%s)",
+		        tst_strstatus(status));
+		return;
+	}
 
-				/*
-				 * nsig is the signal number returned by
-				 * waitpid
-				 */
-				if (nsig != sig) {
-					tst_resm(TFAIL, "waitpid error: "
-						 "unexpected signal "
-						 "returned");
-				} else {
-					tst_resm(TPASS, "recieved expected "
-						 "signal");
-				}
+	tst_res(TPASS, "WIFSIGNALED() set in status");
 
-				/*
-				 * nexno is the exit number returned by
-				 * waitpid
-				 */
-				nexno = WEXITSTATUS(status);
-				if (nexno != 0) {
-					tst_resm(TFAIL, "signal error: "
-						 "unexpected exit number "
-						 "returned");
-				}
-			}
-		}
+	if (WTERMSIG(status) != SIGALRM) {
+		tst_res(TFAIL, "WTERMSIG() != SIGALRM but %s",
+		        tst_strsig(WTERMSIG(status)));
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	tst_res(TPASS, "WTERMSIG() == SIGALRM");
 }
 
-static void setup(void)
-{
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-}
+static struct tst_test test = {
+	.forks_child = 1,
+	.test_all = run,
+};
-- 
2.13.6

