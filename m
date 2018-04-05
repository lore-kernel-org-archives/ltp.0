From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Apr 2018 16:50:15 +0200
Subject: [LTP] [RFC PATCH 6/6] syscalls/wait401: Rewrite to the new library
In-Reply-To: <20180405145015.7633-1-chrubis@suse.cz>
References: <20180405145015.7633-1-chrubis@suse.cz>
Message-ID: <20180405145015.7633-7-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ Get rid of the sleep(1) in the process

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/wait4/wait401.c | 122 +++++++++++-------------------
 1 file changed, 45 insertions(+), 77 deletions(-)

diff --git a/testcases/kernel/syscalls/wait4/wait401.c b/testcases/kernel/syscalls/wait4/wait401.c
index 26a5c7002..eb5f41f42 100644
--- a/testcases/kernel/syscalls/wait4/wait401.c
+++ b/testcases/kernel/syscalls/wait4/wait401.c
@@ -1,106 +1,74 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2012-2018 Cyril Hrubis <chrubis@suse.cz>
  *
- *   Copyright (c) International Business Machines  Corp., 2001
- *   Copyright (c) 2012 Cyril Hrubis <chrubis@suse.cz>
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
- *	wait401 - check that a call to wait4() correctly waits for a child
- *		  process to exit
+ * wait401 - check that a call to wait4() correctly waits for a child
+ *           process to exit
  */
 
-#include "test.h"
-
+#include <stdlib.h>
 #include <errno.h>
 #define _USE_BSD
 #include <sys/types.h>
 #include <sys/resource.h>
 #include <sys/wait.h>
+#include "tst_test.h"
 
-char *TCID = "wait401";
-int TST_TOTAL = 1;
-
-static void cleanup(void);
-static void setup(void);
-
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
 	pid_t pid;
 	int status = 1;
 	struct rusage rusage;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		pid = FORK_OR_VFORK();
-
-		switch (pid) {
-		case -1:
-			tst_brkm(TBROK, cleanup, "fork() failed");
-			break;
-		case 0:
-			sleep(1);
-			exit(0);
-			break;
-		default:
-			TEST(wait4(pid, &status, 0, &rusage));
-			break;
-		}
+	pid = SAFE_FORK();
+	if (!pid)
+		exit(0);
 
-		if (TEST_RETURN == -1) {
-			tst_brkm(TFAIL, cleanup, "%s call failed - errno = %d "
-				 ": %s", TCID, TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-		}
-
-		if (WIFEXITED(status) == 0) {
-			tst_brkm(TFAIL, cleanup,
-				 "%s call succeeded but "
-				 "WIFEXITED() did not return expected value "
-				 "- %d", TCID, WIFEXITED(status));
-		} else if (TEST_RETURN != pid) {
-			tst_resm(TFAIL, "%s did not return the "
-				 "expected value (%d), actual: %ld",
-				 TCID, pid, TEST_RETURN);
-		} else {
+	TEST(wait4(pid, &status, 0, &rusage));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TERRNO, "wait4() failed");
+		return;
+	}
 
-			tst_resm(TPASS,
-				 "Received child pid as expected.");
-		}
+	if (TEST_RETURN != pid) {
+		tst_res(TFAIL, "waitpid() returned wrong pid %li, expected %i",
+		        TEST_RETURN, pid);
+	} else {
+		tst_res(TPASS, "waitpid() returned correct pid %i", pid);
+	}
 
-		tst_resm(TPASS, "%s call succeeded", TCID);
+	if (!WIFEXITED(status)) {
+		tst_res(TFAIL, "WIFEXITED() not set in status (%s)",
+		        tst_strstatus(status));
+		return;
 	}
 
-	cleanup();
-	tst_exit();
-}
+	tst_res(TPASS, "WIFEXITED() is set in status");
 
-static void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	if (WEXITSTATUS(status))
+		tst_res(TFAIL, "WEXITSTATUS() != 0 but %i", WEXITSTATUS(status));
+	else
+		tst_res(TPASS, "WEXITSTATUS() == 0");
 
-	TEST_PAUSE;
 }
 
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.forks_child = 1,
+	.test_all = run,
+};
-- 
2.13.6

