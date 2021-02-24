From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Date: Wed, 24 Feb 2021 11:12:27 +0800
Subject: [LTP] [PATCH 2/2] syscalls/getpid02: Convert to new API
In-Reply-To: <20210224031227.151844-1-ruansy.fnst@cn.fujitsu.com>
References: <20210224031227.151844-1-ruansy.fnst@cn.fujitsu.com>
Message-ID: <20210224031227.151844-2-ruansy.fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/getpid/getpid02.c | 152 +++++---------------
 1 file changed, 34 insertions(+), 118 deletions(-)

diff --git a/testcases/kernel/syscalls/getpid/getpid02.c b/testcases/kernel/syscalls/getpid/getpid02.c
index 6c44ea96a..6b5dd0a63 100644
--- a/testcases/kernel/syscalls/getpid/getpid02.c
+++ b/testcases/kernel/syscalls/getpid/getpid02.c
@@ -1,136 +1,52 @@
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
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
-/*
- * Test Name: getpid02
- *
- * Test Description:
- *  Verify that getpid() system call gets the process ID of the of the
- *  calling process.
- *
- * Expected Result:
- *  getpid() should return pid of the process on success.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Pause for SIGUSR1 if option specified.
+/*\
+ * [DESCRIPTION]
  *
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
- *  getpid02 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
- */
+ * Verify that getpid() system call gets the process ID of the of the calling
+ * process.
+\*/
 
-#include <unistd.h>
-#include <sys/types.h>
+#include <stdlib.h>
 #include <errno.h>
-#include <unistd.h>
-#include <string.h>
-#include <signal.h>
+#include <sys/types.h>
 #include <sys/wait.h>
 
-#include "test.h"
-#include "safe_macros.h"
-
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-
-char *TCID = "getpid02";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
-int main(int ac, char **av)
+static void verify_getpid(void)
 {
-	int lc;
 	pid_t proc_id;		/* process id of the test process */
 	pid_t pid;		/* process id of the child process */
 	pid_t pproc_id;		/* parent process id */
 	int status;		/* exit status of child process */
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		TEST(getpid());
-
-		proc_id = TEST_RETURN;
-
-		if ((pid = FORK_OR_VFORK()) == -1)
-			tst_resm(TFAIL | TERRNO, "fork failed");
-		else if (pid == 0) {
-			pproc_id = getppid();
-
-			if (pproc_id != proc_id)
-				exit(1);
-			exit(0);
-		} else {
-			SAFE_WAIT(cleanup, &status);
-			if (!WIFEXITED(status) ||
-			    WEXITSTATUS(status) != 0)
-				tst_resm(TFAIL, "getpid() returned "
-					 "invalid pid %d", proc_id);
-			else
-				tst_resm(TPASS,
-					 "getpid functionality is correct");
-		}
+	TEST(getpid());
+
+	proc_id = TST_RET;
+
+	if ((pid = SAFE_FORK()) == -1)
+		tst_res(TFAIL | TERRNO, "fork failed");
+	else if (pid == 0) {
+		pproc_id = getppid();
+
+		if (pproc_id != proc_id)
+			exit(1);
+		exit(0);
+	} else {
+		SAFE_WAIT(&status);
+		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+			tst_res(TFAIL, "getpid() returned invalid pid %d",
+				proc_id);
+		else
+			tst_res(TPASS, "getpid() functionality is correct");
 	}
-
-	cleanup();
-	tst_exit();
 }
 
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.forks_child = 1,
+	.test_all = verify_getpid,
+};
-- 
2.30.1



