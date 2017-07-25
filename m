From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 25 Jul 2017 15:40:44 +0200
Subject: [LTP] [COMMITTED] [PATCH 1/2] syscalls/chdir03: Rewrite.
Message-ID: <20170725134045.13656-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Rewrite test to the new library.

Also fixes first part of issue #181.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/chdir/chdir03.c | 190 ++++++++----------------------
 1 file changed, 46 insertions(+), 144 deletions(-)

diff --git a/testcases/kernel/syscalls/chdir/chdir03.c b/testcases/kernel/syscalls/chdir/chdir03.c
index fbf1a4f02..aa0720626 100644
--- a/testcases/kernel/syscalls/chdir/chdir03.c
+++ b/testcases/kernel/syscalls/chdir/chdir03.c
@@ -1,26 +1,23 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
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
 
 /*
- * NAME
- *	chdir03
- *
  * DESCRIPTION
  *	Testcase for testing that chdir(2) sets EACCES errno
  *
@@ -30,160 +27,65 @@
  *	3.	create another child process, sets its uid to ltpuser2
  *	4.	this child attempts to chdir(2) to the directory created in 2.
  *		and expects to get an EACCES.
- *
- * USAGE:  <for command-line>
- *  chdir03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	This test must be run as root.
  */
 
-#include <stdio.h>
-#include <sys/types.h>
-#include <unistd.h>
 #include <pwd.h>
 #include <errno.h>
-#include <sys/wait.h>
 #include <stdlib.h>
-#include <string.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "chdir03";
-int TST_TOTAL = 1;
-
-void setup(void);
-void cleanup(void);
+#include "tst_test.h"
 
-char good_dir[100];
+#define DIRNAME "chdir03_dir"
 
 static uid_t nobody_uid, bin_uid;
 
-int main(int ac, char **av)
+void verify_chdir(void)
 {
-	int lc;
+	pid_t pid;
 
-	pid_t pid, pid1;
-	int status;
+	pid = SAFE_FORK();
+	if (!pid) {
+		SAFE_SETUID(bin_uid);
 
-	tst_parse_opts(ac, av, NULL, NULL);
+		TEST(chdir(DIRNAME));
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			tst_brkm(TBROK, cleanup, "first fork failed");
+		if (TEST_RETURN != -1) {
+			tst_res(TFAIL, "chdir() succeeded unexpectedly");
+			return;
 		}
 
-		if (pid == 0) {
-			if (setreuid(nobody_uid, nobody_uid) != 0) {
-				perror("setreuid failed in child #1");
-				exit(1);
-			}
-			if (mkdir(good_dir, 00700) != 0) {
-				perror("mkdir failed in child #1");
-				exit(1);
-			}
-			exit(0);
+		if (TEST_ERRNO != EACCES) {
+			tst_res(TFAIL | TTERRNO,
+				"chdir() should fail with EACCES");
+			return;
 		}
-		wait(&status);
-
-		if ((pid1 = FORK_OR_VFORK()) < 0)
-			tst_brkm(TBROK, cleanup, "second fork failed");
-
-		if (pid1 == 0) {	/* second child */
-
-			int rval;
-
-			/*
-			 * set the child's ID to ltpuser2 using seteuid()
-			 * so that the ID can be changed back after the
-			 * TEST call is made.
-			 */
-			if (seteuid(bin_uid) != 0) {
-				perror("setreuid failed in child #2");
-				exit(1);
-			}
-
-			TEST(chdir(good_dir));
 
-			if (TEST_RETURN != -1) {
-				printf("call succeeded unexpectedly\n");
-				rval = 1;
-			} else if (TEST_ERRNO != EACCES) {
-				printf("didn't get EACCES as expected; got ");
-				rval = 1;
-			} else {
-				printf("got EACCES as expected\n");
-				rval = 0;
-			}
-			/* Only really required with vfork. */
-			if (seteuid(0) != 0) {
-				perror("seteuid(0) failed");
-				rval = 1;
-			}
-
-			exit(rval);
-
-		} else {
-			if (wait(&status) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "wait failed");
-			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
-				tst_brkm(TBROK, cleanup,
-					 "child exited abnormally");
-			tst_resm(TPASS, "child reported success");
-		}
-		if (rmdir(good_dir) == -1) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "rmdir(%s) failed", good_dir);
-		}
+		tst_res(TPASS | TTERRNO, "chdir() failed expectedly");
 	}
-
-	cleanup();
-	tst_exit();
 }
 
 void setup(void)
 {
 	struct passwd *pw;
-	char *cur_dir = NULL;
-
-	tst_require_root();
+	pid_t pid;
 
-	pw = SAFE_GETPWNAM(NULL, "nobody");
+	pw = SAFE_GETPWNAM("nobody");
 	nobody_uid = pw->pw_uid;
-	pw = SAFE_GETPWNAM(NULL, "bin");
+	pw = SAFE_GETPWNAM("bin");
 	bin_uid = pw->pw_uid;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	if ((cur_dir = getcwd(cur_dir, 0)) == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "getcwd failed");
-
-	sprintf(good_dir, "%s/%d", cur_dir, getpid());
+	pid = SAFE_FORK();
+	if (!pid) {
+		SAFE_SETEUID(nobody_uid);
+		SAFE_MKDIR(DIRNAME, 0700);
+		exit(0);
+	}
+	tst_reap_children();
 }
 
-void cleanup(void)
-{
-	tst_rmdir();
-
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = verify_chdir,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+};
-- 
2.13.0

