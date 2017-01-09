From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 9 Jan 2017 16:15:55 +0800
Subject: [LTP] [PATCH 3/4] getcwd03.c: cleanup && convert to new API
In-Reply-To: <1483949756-8685-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1483949756-8685-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1483949756-8685-3-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

take use of some SAFE Marcos

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/getcwd/getcwd03.c | 291 +++++++++-------------------
 1 file changed, 87 insertions(+), 204 deletions(-)

diff --git a/testcases/kernel/syscalls/getcwd/getcwd03.c b/testcases/kernel/syscalls/getcwd/getcwd03.c
index af74608..b34b6f9 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd03.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd03.c
@@ -1,237 +1,120 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
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
+ * along with this program.
  */
 
 /*
- * NAME
- *	getcwd03
- *
  * DESCRIPTION
- *	Testcase to check the basic functionality of the getcwd(2) system call
- *	for symbolically linked directories.
+ * Testcase to check the basic functionality of the getcwd(2)
+ * system call on a symbolic link.
  *
  * ALGORITHM
- *	This testcase checks for the functionality of the getcwd(2) system call
- *	on a symbolic link. First create a directory (dir1), and create a
- *	symbolic link (dir2) to it at the same directory level. Then, chdir()
- *	to dir1, and get the working directory (cwd1), and its pathname (pwd1).
- *	Then, chdir() to dir2, and get the working directory (cwd2), its
- *	pathname (pwd2), and its readlink info (link2).
- *	Testcase succeeds if:
- *	i.	pwd1 == pwd2
- *	ii.	cwd1 == cwd2
- *	iii.	link2 == basename(cwd1)
- *
- * USAGE:  <for command-line>
- *  getcwd03 [-c n] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	NONE
+ * 1) create a directory, and create a symbolic link to it at the
+ *    same directory level.
+ * 2) get the working directory of a directory, and its pathname.
+ * 3) get the working directory of a symbolic link, and its pathname,
+ *    and its readlink info.
+ * 4) compare the working directories, pathnames and link information.
  */
+
 #define _GNU_SOURCE 1
+#include <errno.h>
 #include <stdio.h>
 #include <string.h>
-#include <errno.h>
-#include "test.h"
 #include <stdlib.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <stdlib.h>
-#define FAILED 1
-
-int flag;
-char *TCID = "getcwd03";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
-void cleanup(void);
-void setup(void);
-char *getpwd(void);
+static char dir1[BUFSIZ], dir2[BUFSIZ];
 
-int main(int ac, char **av)
+static void verify_getcwd(void)
 {
-	char dir1[BUFSIZ], dir2[BUFSIZ];
-	char cwd1[BUFSIZ], cwd2[BUFSIZ];
-	char *pwd1, *pwd2;
-	char link2[BUFSIZ];
-	int n;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	/*
-	 * The following loop checks looping state if -i option given
-	 */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		flag = 0;
-
-		/*
-		 * Create dir1, then chdir to dir1, and get the pwd,
-		 * and cwd informations
-		 */
-		sprintf(dir1, "getcwd1.%d", getpid());
-		if (mkdir(dir1, 00755) < 0) {
-			tst_brkm(TBROK, cleanup, "mkdir(2) failed");
-		}
-		if (chdir(dir1) != 0) {
-			tst_brkm(TBROK, cleanup, "chdir(2) failed");
-		}
-
-		pwd1 = getpwd();
-		if (getcwd(cwd1, sizeof cwd1) == NULL) {
-			tst_resm(TFAIL|TERRNO, "getcwd() failed unexpectedly");
-			flag = FAILED;
-		}
-		if ((flag != FAILED) && (strcmp(pwd1, cwd1) != 0)) {
-			tst_brkm(TFAIL, cleanup, "getcwd() returned unexpected "
-				 "working directory: expected: %s, got: %s\n",
-				 pwd1, cwd1);
-		}
-
-		tst_resm(TINFO, "getcwd(2) succeeded in returning correct path "
-			 "for dir1");
-
-		/*
-		 * Now create dir2, then chdir to dir2, and get the pwd,
-		 * cwd, and link informations
-		 */
-		chdir("..");
-		flag = 0;
-
-		sprintf(dir2, "getcwd2.%d", getpid());
-		if (symlink(dir1, dir2) < 0) {
-			tst_brkm(TBROK, cleanup, "symlink(2) failed: errno: %d",
-				 errno);
-		}
-
-		if (chdir(dir2) != 0) {
-			tst_brkm(TBROK, cleanup, "chdir(2) failed: errno: %d",
-				 errno);
-		}
-
-		pwd2 = getpwd();
-		if (getcwd(cwd2, sizeof cwd2) == NULL) {
-			tst_resm(TFAIL|TERRNO, "getcwd() failed unexpectedly");
-			flag = FAILED;
-		}
-
-		chdir("..");
-		if ((flag != FAILED) &&
-		    ((n = readlink(dir2, link2, sizeof(link2))) < 0)) {
-			tst_brkm(TBROK, cleanup, "readlink(2) failed: errno:%d",
-				 errno);
-		}
-
-		/*
-		 * Finally compare the pwd, cwd, link informations:
-		 * The test should pass iff all the following are true:
-		 * a.   pwd1 == pwd2
-		 * b.   cwd1 == cwd2
-		 * c.   link2 == basename(cwd1)
-		 */
-		if (flag != FAILED) {
-			if (strcmp(pwd1, pwd2) != 0) {
-				tst_resm(TFAIL, "pwd1: %s, pwd2: %s",
-					 pwd1, pwd2);
-				flag = FAILED;
-			}
-			if (strcmp(cwd1, cwd2) != 0) {
-				tst_resm(TFAIL, "cwd1: %s, cwd2: %s",
-					 cwd1, cwd2);
-				flag = FAILED;
-			}
-			if (memcmp(link2, (char *)basename(cwd1), n) != 0) {
-				tst_resm(TFAIL, "link2: %s, cwd1: %s",
-					 link2, cwd1);
-				flag = FAILED;
-			}
-			if (flag != FAILED) {
-				tst_resm(TINFO, "getcwd(2) succeeded in "
-					 "returning correct path for symbolic "
-					 "link dir2 -> dir1");
-			}
-		}
-
-		if (flag == FAILED) {
-			tst_resm(TFAIL, "Test FAILED");
-		} else {
-			tst_resm(TPASS, "Test PASSED");
-		}
-
-		/* clean up things in case we are looping */
-		if (unlink(dir2) == -1) {
-			tst_brkm(TBROK, cleanup, "couldnt remove dir2");
-		}
-		if (rmdir(dir1) == -1) {
-			tst_brkm(TBROK, cleanup, "couldnt remove dir1");
-		}
+	char buf1[BUFSIZ], buf2[BUFSIZ];
+	char link[BUFSIZ];
+	char *res1;
+	char *res2;
+
+	SAFE_CHDIR(dir1);
+
+	errno = 0;
+	res1 = getcwd(buf1, sizeof(buf1));
+	TEST_ERRNO = errno;
+	if (res1 == NULL) {
+		tst_res(TFAIL | TTERRNO, "getcwd() failed to "
+			"get working directory of a directory");
+		return;
 	}
-	cleanup();
 
-	tst_exit();
-}
+	SAFE_CHDIR("..");
+	SAFE_CHDIR(dir2);
 
-void setup(void)
-{
-	/* FORK is set here because of the popen() call below */
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	errno = 0;
+	res2 = getcwd(buf2, sizeof(buf2));
+	TEST_ERRNO = errno;
+	if (res2 == NULL) {
+		tst_res(TFAIL | TTERRNO, "getcwd() failed to get "
+			"working directory of a symbolic link");
+		return;
+	}
+
+	SAFE_CHDIR("..");
+	SAFE_READLINK(dir2, link, sizeof(link));
+
+	if (strcmp(res1, res2)) {
+		tst_res(TFAIL, "getcwd() got mismatched strings containing "
+			"the pathname of the current working directory");
+		return;
+	}
 
-	TEST_PAUSE;
+	if (strcmp(buf1, buf2)) {
+		tst_res(TFAIL, "getcwd() got mismatched working directories");
+		return;
+	}
 
-	/* create a test directory and cd into it */
-	tst_tmpdir();
+	if (strcmp(link, SAFE_BASENAME(buf1))) {
+		tst_res(TFAIL,
+			"link information didn't match the working directory");
+		return;
+	}
+
+	tst_res(TPASS, "getcwd() succeeded");
 }
 
-void cleanup(void)
+static void setup(void)
 {
-	/* remove the test directory */
-	tst_rmdir();
+	SAFE_CHDIR("/tmp");
+	sprintf(dir1, "getcwd1.%d", getpid());
+	sprintf(dir2, "getcwd2.%d", getpid());
+	SAFE_MKDIR(dir1, 0755);
+	SAFE_SYMLINK(dir1, dir2);
 }
 
-char *getpwd(void)
+static void cleanup(void)
 {
-	FILE *fin;
-	char *pwd = "/bin/pwd";
-	char *cp;
-	char *buf;
-
-	buf = malloc(BUFSIZ);
-	if ((fin = popen(pwd, "r")) == NULL) {
-		tst_resm(TINFO, "%s: can't run %s", TCID, pwd);
-		tst_brkm(TBROK, cleanup, "%s FAILED", TCID);
-	}
-	while (fgets(buf, BUFSIZ, fin) != NULL) {
-		if ((cp = strchr(buf, '\n')) == NULL) {
-			tst_brkm(TBROK, cleanup, "pwd output too long");
-		}
-		*cp = 0;
-	}
-	pclose(fin);
-	return buf;
+	if (unlink(dir2) == -1)
+		tst_res(TWARN | TERRNO, "could not remove %s", dir2);
+
+	if (rmdir(dir1) == -1)
+		tst_res(TWARN | TERRNO, "could not remove %s", dir1);
 }
+
+static struct tst_test test = {
+	.tid = "getcwd03",
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_getcwd
+};
-- 
1.8.3.1



