From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 25 Jul 2017 15:40:45 +0200
Subject: [LTP] [COMMITTED] [PATCH 2/2] syscalls/fchdir03: Rewrite.
In-Reply-To: <20170725134045.13656-1-chrubis@suse.cz>
References: <20170725134045.13656-1-chrubis@suse.cz>
Message-ID: <20170725134045.13656-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Rewrite test to the new library

Also fixes second part of issue #181.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fchdir/fchdir03.c | 173 ++++++----------------------
 1 file changed, 35 insertions(+), 138 deletions(-)

diff --git a/testcases/kernel/syscalls/fchdir/fchdir03.c b/testcases/kernel/syscalls/fchdir/fchdir03.c
index a7c32c418..59685f814 100644
--- a/testcases/kernel/syscalls/fchdir/fchdir03.c
+++ b/testcases/kernel/syscalls/fchdir/fchdir03.c
@@ -1,27 +1,24 @@
 /*
- *
  * Copyright (C) Bull S.A. 2001
  * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
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
- * NAME
- *	fchdir03
- *
  * DESCRIPTION
  *	Testcase for testing that fchdir(2) sets EACCES errno
  *
@@ -31,147 +28,47 @@
  *	3.	this child opens the directory and gets a file descriptor
  *	4.	this child attempts to fchdir(2) to the directory created in 2.
  *		and expects to get an EACCES.
- *	5.	finally this child checks the return code,
- *		resets the process ID to root and calls cleanup.
- *
- * USAGE:  <for command-line>
- *  fchdir03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	04/2002 Ported by Jacky Malcles
- *
- * RESTRICTIONS
- *	This test must be run as root.
  */
 
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
 #include <errno.h>
-#include <fcntl.h>
 #include <pwd.h>
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "fchdir03";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
-void setup(void);
-void cleanup(void);
+#define DIRNAME "fchdir03_dir"
 
-char good_dir[100];
-int fd;
+static int fd;
 
-static uid_t nobody_uid;
-
-int main(int ac, char **av)
+void verify_fchdir(void)
 {
-	int lc;
-
-	pid_t pid;
-	int status;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		if ((pid = FORK_OR_VFORK()) == -1)
-			tst_brkm(TBROK, cleanup, "fork failed");
-
-		if (pid == 0) {
-			/*
-			 * set the child's ID to ltpuser1 using seteuid()
-			 * so that the ID can be changed back after the
-			 * TEST call is made.
-			 */
-			if (seteuid(nobody_uid) != 0) {
-				perror("setreuid failed in child #1");
-				exit(1);
-			}
-			if (mkdir(good_dir, 00400) != 0) {
-				perror("mkdir failed in child #1");
-				exit(1);
-			}
-			if ((fd = open(good_dir, O_RDONLY)) == -1) {
-				perror("opening directory failed");
-			}
+	TEST(fchdir(fd));
 
-			TEST(fchdir(fd));
-
-			if (TEST_RETURN != -1) {
-				printf("Call succeeded unexpectedly\n");
-				exit(1);
-			} else if (TEST_ERRNO != EACCES) {
-				printf("Expected %d - got %d\n",
-				       EACCES, TEST_ERRNO);
-				exit(1);
-			} else
-				printf("Got EACCES as expected\n");
-
-			/* reset the UID to root */
-			if (setuid(0) == -1)
-				perror("setuid(0) failed");
-
-		} else {
-			if (wait(&status) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "wait failed");
-			else if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
-				tst_brkm(TBROK, cleanup,
-					 "child exited abnormally (wait status = "
-					 "%d", status);
-			else {
-				/* let the child carry on */
-				exit(0);
-			}
-		}
-
-		if (rmdir(good_dir) == -1)
-			tst_brkm(TBROK, cleanup, "rmdir failed");
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "fchdir() succeeded unexpectedly");
+		return;
+	}
 
+	if (TEST_ERRNO != EACCES) {
+		tst_res(TFAIL | TTERRNO, "fchdir() should fail with EACCES");
+		return;
 	}
-	cleanup();
 
-	tst_exit();
+	tst_res(TPASS | TTERRNO, "fchdir() failed expectedly");
 }
 
 void setup(void)
 {
 	struct passwd *pw;
 
-	char *cur_dir = NULL;
-
-	tst_require_root();
-
-	pw = SAFE_GETPWNAM(NULL, "nobody");
-	nobody_uid = pw->pw_uid;
+	pw = SAFE_GETPWNAM("nobody");
+	SAFE_SETEUID(pw->pw_uid);
+	SAFE_MKDIR(DIRNAME, 0400);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	if ((cur_dir = getcwd(cur_dir, 0)) == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "getcwd failed");
-
-	sprintf(good_dir, "%s.%d", cur_dir, getpid());
+	fd = SAFE_OPEN(DIRNAME, O_RDONLY);
 }
 
-void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = verify_fchdir,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
-- 
2.13.0

