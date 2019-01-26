From: Steve Muckle <smuckle@google.com>
Date: Fri, 25 Jan 2019 17:56:06 -0800
Subject: [LTP] [PATCH] syscalls/vhangup: convert to new lib,
	use direct syscall
Message-ID: <20190126015606.236588-1-smuckle@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use direct syscall to expand test compatibility to Android.

Signed-off-by: Steve Muckle <smuckle@google.com>
---
 testcases/kernel/syscalls/vhangup/vhangup01.c |  89 +++++--------
 testcases/kernel/syscalls/vhangup/vhangup02.c | 123 ++++--------------
 2 files changed, 53 insertions(+), 159 deletions(-)

diff --git a/testcases/kernel/syscalls/vhangup/vhangup01.c b/testcases/kernel/syscalls/vhangup/vhangup01.c
index c35dec226..b0f28b901 100644
--- a/testcases/kernel/syscalls/vhangup/vhangup01.c
+++ b/testcases/kernel/syscalls/vhangup/vhangup01.c
@@ -1,23 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  *	07/2001 John George
  * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-/*
  * Check the return value, and errno of vhangup(2) when a non-root user calls
  * vhangup().
  */
@@ -26,64 +12,47 @@
 #include <pwd.h>
 #include <sys/wait.h>
 
-#include "test.h"
-#include "safe_macros.h"
-
-static void setup(void);
-
-char *TCID = "vhangup01";
-int TST_TOTAL = 1;
+#include "tst_test.h"
+#include "lapi/syscalls.h"
 
 static uid_t nobody_uid;
 
-int main(int argc, char **argv)
+static void run(void)
 {
-	int lc;
-
 	pid_t pid;
 	int retval;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			tst_brkm(TFAIL, NULL, "fork failed");
-		} else if (pid > 0) {
-			tst_record_childstatus(NULL, pid);
-		} else {
-			retval = setreuid(nobody_uid, nobody_uid);
-			if (retval < 0) {
-				perror("setreuid");
-				tst_brkm(TFAIL, NULL, "setreuid failed");
-			}
-			TEST(vhangup());
-			if (TEST_RETURN != -1) {
-				tst_brkm(TFAIL, NULL, "vhangup() failed to "
-					 "fail");
-			} else if (TEST_ERRNO == EPERM) {
-				tst_resm(TPASS, "Got EPERM as expected.");
-			} else {
-				tst_resm(TFAIL, "expected EPERM got %d",
-					 TEST_ERRNO);
-			}
-		}
+	if ((pid = SAFE_FORK()) < 0) {
+		tst_brk(TBROK | TTERRNO, "fork failed");
+	} else if (pid > 0) {
+		/* parent */
+		waitpid(pid, NULL, 0);
+	} else {
+		/* child */
+		retval = setreuid(nobody_uid, nobody_uid);
+		if (retval < 0)
+			tst_brk(TBROK | TTERRNO, "setreuid failed");
+		TEST(tst_syscall(__NR_vhangup));
+		if (TST_RET != -1)
+			tst_brk(TFAIL, "vhangup() failed to fail");
+		else if (TST_ERR == EPERM)
+			tst_res(TPASS, "Got EPERM as expected.");
+		else
+			tst_res(TFAIL, "expected EPERM got %d", TST_ERR);
 	}
-
-	tst_exit();
 }
 
 static void setup(void)
 {
 	struct passwd *pw;
 
-	tst_require_root();
-
-	pw = SAFE_GETPWNAM(NULL, "nobody");
+	pw = SAFE_GETPWNAM("nobody");
 	nobody_uid = pw->pw_uid;
-
-	TEST_PAUSE;
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/vhangup/vhangup02.c b/testcases/kernel/syscalls/vhangup/vhangup02.c
index b6bca5df9..504413ad8 100644
--- a/testcases/kernel/syscalls/vhangup/vhangup02.c
+++ b/testcases/kernel/syscalls/vhangup/vhangup02.c
@@ -1,43 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
  *
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
- *	vhangup02.c
- *
- * DESCRIPTION
- * 	To test the basic functionality of vhangup(2)
- *
- *
- * USAGE:  <for command-line>
- *      vhangup02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *      where,  -c n : Run n copies concurrently.
- *              -i n : Execute test n times.
- *              -I x : Execute test for x seconds.
- *              -P x : Pause for x seconds between iterations.
- *              -t   : Turn on syscall timing.
  * History
  *	07/2001 John George
  *		-Ported
- *
- * Restrictions
- *	None
  */
 
 #include <unistd.h>
@@ -45,75 +12,33 @@
 #include <errno.h>
 #include <pwd.h>
 #include <sys/wait.h>
-#include "test.h"
-
-void setup(void);
-void cleanup(void);
-
-char *TCID = "vhangup02";
-int TST_TOTAL = 1;
+#include "tst_test.h"
+#include "lapi/syscalls.h"
 
-int fail;
-
-int main(int argc, char **argv)
+static void run(void)
 {
-	int lc;
-
 	pid_t pid, pid1;
-	int status;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		fail = 0;
-
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			tst_brkm(TFAIL, cleanup, "fork failed");
-		} else if (pid > 0) {	/* parent */
-			waitpid(pid, &status, 0);
-			_exit(0);
-		} else {	/* child */
-			pid1 = setsid();
-			if (pid1 < 0) {
-				tst_brkm(TFAIL, cleanup, "setsid failed");
-			}
-			TEST(vhangup());
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL, "vhangup() failed, errno:%d",
-					 errno);
-			} else {
-				tst_resm(TPASS, "vhangup() succeeded");
-			}
-		}
+	if ((pid = SAFE_FORK()) < 0) {
+		tst_brk(TFAIL | TTERRNO, "fork failed");
+	} else if (pid > 0) {
+		/* parent */
+		waitpid(pid, NULL, 0);
+	} else {
+		/* child */
+		pid1 = setsid();
+		if (pid1 < 0)
+			tst_brk(TBROK | TTERRNO, "setsid failed");
+		TEST(tst_syscall(__NR_vhangup));
+		if (TST_RET == -1)
+			tst_res(TFAIL | TTERRNO, "vhangup() failed");
+		else
+			tst_res(TPASS, "vhangup() succeeded");
 	}
-	cleanup();
-	tst_exit();
-
-}
-
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
-{
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
-	TEST_PAUSE;
 }
 
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.needs_root = 1,
+};
-- 
2.20.1.495.gaa96b0ce6b-goog

