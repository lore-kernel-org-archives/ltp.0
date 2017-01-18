From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 18 Jan 2017 14:03:26 +0800
Subject: [LTP] [PATCH v2 1/3] syscalls/getcwd02.c: cleanup && convert to new
	API
In-Reply-To: <20170117134335.GA28074@rei.lan>
References: <20170117134335.GA28074@rei.lan>
Message-ID: <1484719408-28782-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

remove some duplicated tests

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/getcwd/getcwd02.c | 318 ++++++----------------------
 1 file changed, 59 insertions(+), 259 deletions(-)

diff --git a/testcases/kernel/syscalls/getcwd/getcwd02.c b/testcases/kernel/syscalls/getcwd/getcwd02.c
index 030474c..7785bb6 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd02.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd02.c
@@ -1,286 +1,86 @@
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
- *	getcwd02
- *
  * DESCRIPTION
- *	Testcase to check the basic functionality of the getcwd(2) system call.
- *
- * ALGORITHM
- *	Get the path name of the current working directory from the current
- *	shell through a pipe, and compare it with what is returned by
- *	getcwd(2) system call.
- *
- *  Blocks 1-4 are with char[], #4 is special case where address is -1
- *
- *	Block 1: Call getcwd(2) with valid cwd[]:
- *              Should work fine
- *	Block 2: Call getcwd(2) with valid cwd[], size = 0:
- *              Should return NULL, errno = EINVAL
- *	Block 3: Call getcwd(2) with valid cwd[], size <= strlen(path):
- *              i.e. size = 1, Should return NULL, errno = ERANGE
- *      Block 4: Call getcwd(2) with cwd address = -1, size > strlen(path):
- *              Should return NULL, errno = EFAULT
- *
- *  Blocks 5-7 are with char*
- *
- *	Block 5: Call getcwd(2) with *buffer = NULL, size = 0:
- * 		Should allocate buffer, and work fine
- *	Block 6: Call getcwd(2) with *buffer = NULL, size <= strlen(path):
- * 		i.e. size = 1, Should return NULL, errno = ERANGE
- *      Block 7: Call getcwd(2) with *buffer = NULL, size > strlen(path):
- *              Should work fine and allocate buffer
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *      02/2002 Added more testcases, cleaned up by wjh
- *
- * RESTRICTIONS
- *	NONE
+ * Testcase to check the basic functionality of the getcwd(2) system call.
+ * 1) getcwd(2) works fine if buf and size are valid.
+ * 2) getcwd(2) works fine if buf points to NULL and size is set to 0.
+ * 3) getcwd(2) works fine if buf points to NULL and size is greater than strlen(path).
  */
-#include <stdio.h>
-#include <string.h>
-#include <errno.h>
-#include "test.h"
-#define FAILED 1
-
-char *pwd = "/bin/pwd";
-int flag;
-char *TCID = "getcwd02";
-int TST_TOTAL = 7;
-
-void cleanup(void);
-void setup(void);
-void do_block1(void);
-void do_block2(void);
-void do_block3(void);
-void do_block4(void);
-void do_block5(void);
-void do_block6(void);
-void do_block7(void);
-
-char pwd_buf[BUFSIZ];		//holds results of pwd pipe
-char cwd[BUFSIZ];		//used as our valid buffer
-char *buffer = NULL;		//catches the return value from getcwd when passing NULL
-char *cwd_ptr = NULL;		//catches the return value from getcwd() when passing cwd[]
-
-int main(int ac, char **av)
-{
-	FILE *fin;
-	char *cp;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-	setup();
-
-	/*
-	 * The following loop checks looping state if -i option given
-	 */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		if ((fin = popen(pwd, "r")) == NULL) {
-			tst_resm(TINFO, "%s: can't run %s", TCID, pwd);
-			tst_brkm(TBROK, cleanup, "%s FAILED", TCID);
-		}
-		while (fgets(pwd_buf, sizeof(pwd_buf), fin) != NULL) {
-			if ((cp = strchr(pwd_buf, '\n')) == NULL) {
-				tst_brkm(TBROK, cleanup, "pwd output too long");
-			}
-			*cp = 0;
-		}
-		pclose(fin);
 
-		do_block1();
-		do_block2();
-		do_block3();
-		do_block4();
-		do_block5();
-		do_block6();
-		do_block7();
-	}
-	cleanup();
-	tst_exit();
-}
-
-void do_block1(void)		//valid cwd[]: -> Should work fine
-{
-	int flag = 0;
-	tst_resm(TINFO, "Enter Block 1");
-
-	if ((cwd_ptr = getcwd(cwd, sizeof(cwd))) == NULL) {
-		tst_resm(TFAIL|TERRNO, "getcwd() failed unexpectedly");
-		flag = FAILED;
-	}
-	if ((flag != FAILED) && (strcmp(pwd_buf, cwd) != 0)) {
-		tst_resm(TFAIL, "getcwd() returned unexpected working "
-			 "directory: expected: %s, got: %s\n", pwd_buf, cwd);
-		flag = FAILED;
-	}
-	tst_resm(TINFO, "Exit Block 1");
-	if (flag == FAILED) {
-		tst_resm(TFAIL, "Block 1 FAILED");
-	} else {
-		tst_resm(TPASS, "Block 1 PASSED");
-	}
-}
-
-void do_block2(void)		//valid cwd[], size = 0: -> Should return NULL, errno = EINVAL
-{
-	int flag = 0;
-	tst_resm(TINFO, "Enter Block 2");
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include "tst_test.h"
 
-	if (((cwd_ptr = getcwd(cwd, 0)) == NULL)
-	    && (errno != EINVAL)) {
-		tst_resm(TFAIL|TERRNO, "getcwd() failed unexpectedly (wanted EINVAL)");
-		flag = FAILED;
-	}
-	tst_resm(TINFO, "Exit Block 2");
-	if (flag == FAILED) {
-		tst_resm(TFAIL, "Block 2 FAILED");
-	} else {
-		tst_resm(TPASS, "Block 2 PASSED");
-	}
-}
+static char exp_buf[5] = "/tmp";
+static char buffer[5];
 
-void do_block3(void)		//valid cwd[], size = 1 -> Should return NULL, errno = ERANGE
-{
-	int flag = 0;
-	tst_resm(TINFO, "Enter Block 3");
+static struct t_case {
+	char *buf;
+	size_t size;
+} tcases[] = {
+	{buffer, sizeof(buffer)},
+	{NULL, 0},
+	{NULL, sizeof(buffer)}
+};
 
-	if (((cwd_ptr = getcwd(cwd, 1)) != NULL)
-	    || (errno != ERANGE)) {
-		tst_resm(TFAIL|TERRNO, "getcwd() failed unexpectedly (wanted ERANGE)");
-		flag = FAILED;
-	}
-	tst_resm(TINFO, "Exit Block 3");
-	if (flag == FAILED) {
-		tst_resm(TFAIL, "Block 3 FAILED");
-	} else {
-		tst_resm(TPASS, "Block 3 PASSED");
-	}
-}
-
-void do_block4(void)		//invalid cwd[] = -1, size = BUFSIZ: -> return NULL, errno = FAULT
+static void verify_getcwd(unsigned int n)
 {
-/* Skip since uClinux does not implement memory protection */
-#ifndef UCLINUX
-	int flag = 0;
-	tst_resm(TINFO, "Enter Block 4");
+	struct t_case *tc = &tcases[n];
+	char *res = NULL;
 
-	if (((cwd_ptr = getcwd((char *)-1, sizeof(cwd))) != NULL)
-	    || (errno != EFAULT)) {
-		tst_resm(TFAIL|TERRNO, "getcwd() failed unexpectedly (wanted EFAULT)");
-		flag = FAILED;
+	errno = 0;
+	res  = getcwd(tc->buf, tc->size);
+	TEST_ERRNO = errno;
+	if (!res) {
+		tst_res(TFAIL | TTERRNO, "getcwd() failed");
+		goto end;
 	}
-	tst_resm(TINFO, "Exit Block 4");
-	if (flag == FAILED) {
-		tst_resm(TFAIL, "Block 4 FAILED");
-	} else {
-		tst_resm(TPASS, "Block 4 PASSED");
-	}
-#else
-	tst_resm(TINFO, "Skipping Block 4 on uClinux");
-#endif
-}
 
-void do_block5(void)		//buffer = NULL, and size = 0, should succeed
-{
-	int flag = 0;
-	tst_resm(TINFO, "Enter Block 5");
-
-	if ((buffer = getcwd(NULL, 0)) == NULL) {
-		tst_resm(TFAIL|TERRNO, "getcwd() failed unexpectedly");
-		flag = FAILED;
-	}
-	if ((flag != FAILED) && (strcmp(pwd_buf, buffer) != 0)) {
-		tst_resm(TFAIL, "getcwd() returned unexpected working "
-			 "directory: expected: %s, got: %s\n", pwd_buf, buffer);
-		flag = FAILED;
+	if (tc->buf != NULL && strcmp(exp_buf, tc->buf)) {
+		tst_res(TFAIL, "getcwd() returned unexpected directory: %s, "
+			"expected: %s", tc->buf, exp_buf);
+		goto end;
 	}
-	tst_resm(TINFO, "Exit Block 5");
-	if (flag == FAILED) {
-		tst_resm(TFAIL, "Block 5 FAILED");
-	} else {
-		tst_resm(TPASS, "Block 5 PASSED");
-	}
-	free(buffer);
-	buffer = NULL;
-}
-
-void do_block6(void)		//buffer = NULL, size = 1: -> return NULL, errno = ERANGE
-{
-	int flag = 0;
-	tst_resm(TINFO, "Enter Block 6");
 
-	if (((buffer = getcwd(NULL, 1)) != NULL)
-	    || (errno != ERANGE)) {
-		tst_resm(TFAIL|TERRNO, "getcwd() failed unexpectedly (wanted ERANGE)");
-		flag = FAILED;
+	if (strcmp(exp_buf, res)) {
+		tst_res(TFAIL, "getcwd() returned unexpected directory: %s, "
+			"expected: %s", res, exp_buf);
+		goto end;
 	}
-	tst_resm(TINFO, "Exit Block 6");
-	if (flag == FAILED) {
-		tst_resm(TFAIL, "Block 6 FAILED");
-	} else {
-		tst_resm(TPASS, "Block 6 PASSED");
-	}
-}
 
-void do_block7(void)		//buffer = NULL, size = BUFSIZ: -> work fine, allocate buffer
-{
-	int flag = 0;
-	tst_resm(TINFO, "Enter Block 7");
+	tst_res(TPASS, "getcwd() returned expected directory: %s", res);
 
-	if ((buffer = getcwd(NULL, sizeof(cwd))) == NULL) {
-		tst_resm(TFAIL|TERRNO, "getcwd() failed unexpectedly");
-		flag = FAILED;
-	}
-	if ((flag != FAILED) && (strcmp(pwd_buf, buffer) != 0)) {
-		tst_resm(TFAIL, "getcwd() returned unexpected working "
-			 "directory: expected: %s, got: %s\n", pwd_buf, buffer);
-		flag = FAILED;
-	}
-	tst_resm(TINFO, "Exit Block 7");
-	if (flag == FAILED) {
-		tst_resm(TFAIL, "Block 7 FAILED");
-	} else {
-		tst_resm(TPASS, "Block 7 PASSED");
-	}
-	free(buffer);
-	buffer = NULL;
+end:
+	if (!tc->buf)
+		free(res);
 }
 
-void setup(void)
+static void setup(void)
 {
-	/* FORK is set here because of the popen() call above */
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* create a test directory and cd into it */
-	tst_tmpdir();
+	SAFE_CHDIR("/tmp");
 }
 
-void cleanup(void)
-{
-	/* remove the test directory */
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.tid = "getcwd02",
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_getcwd
+};
-- 
1.8.3.1



