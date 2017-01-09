From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 9 Jan 2017 16:15:53 +0800
Subject: [LTP] [PATCH 1/4] getcwd01.c: cleanup && convert to new API
Message-ID: <1483949756-8685-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

add one test for ERANGE

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/getcwd/getcwd01.c | 181 +++++++++-------------------
 1 file changed, 59 insertions(+), 122 deletions(-)

diff --git a/testcases/kernel/syscalls/getcwd/getcwd01.c b/testcases/kernel/syscalls/getcwd/getcwd01.c
index 0d0ecdb..701823b 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd01.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd01.c
@@ -1,152 +1,89 @@
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
- *	getcwd01
- *
  * DESCRIPTION
- *	Testcase to test that getcwd(2) sets errno correctly.
- *
- * ALGORITHM
- *	Test 1: Call getcwd(2) with a buf pointing outside the address space of
- *		 process, and a valid size, and expect EFAULT to be
- *		 set in errno.
- *	Test 2: Call getcwd(2) with buf = NULL, size = -1, and expect ENOMEM
- *		 to be set in errno.
- *	Test 3: Call getcwd(2) with a valid buf, and size = 0, and expect
- *		 EINVAL to be set in errno.
- *	Test 4: Call getcwd(2) on the root directory, and set size to 1, expect
- *		 ERANGE to be set in errno.
+ * Testcase to test that getcwd(2) sets errno correctly.
+ * 1) getcwd(2) fails if buf points to a bad address.
+ * 2) getcwd(2) fails if the size is invalid.
+ * 3) getcwd(2) fails if the size is set to 0.
+ * 4) getcwd(2) fails if the size is set to 1.
+ * 5) getcwd(2) fails if buf points to NULL and the size is set to 1.
  *
- * USAGE:  <for command-line>
- *  getcwd01 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
+ * Expected Result:
+ * 1) getcwd(2) should return NULL and set errno to EFAULT.
+ * 2) getcwd(2) should return NULL and set errno to ENOMEM.
+ * 3) getcwd(2) should return NULL and set errno to EINVAL.
+ * 4) getcwd(2) should return NULL and set errno to ERANGE.
+ * 5) getcwd(2) should return NULL and set errno to ERANGE.
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	NONE
  */
-#include <stdio.h>
-#include <string.h>
-#include <errno.h>
-#include "test.h"
 
-char *TCID = "getcwd01";
-char buf[100];
+#include <errno.h>
+#include <unistd.h>
+#include "tst_test.h"
 
-void cleanup(void);
-void setup(void);
-void setup_test4(void);
+static char buffer[5];
 
-struct test_case_t {
-	char *desc;
-	void (*setupfunc) ();
+static struct t_case {
 	char *buf;
 	int size;
-	int exp_errno;
-	char *exp_retval;
-} testcases[] = {
+	int exp_err;
+} tcases[] = {
 #ifndef UCLINUX
 	/* Skip since uClinux does not implement memory protection */
-	{
-	"Test for EFAULT", NULL, (void *)-1, BUFSIZ, EFAULT, NULL},
+	{(void *)-1, sizeof(buffer), EFAULT},
 #endif
-	{
-	"Test for ENOMEM", NULL, NULL, -1, ENOMEM, NULL}, {
-	"Test for EINVAL", NULL, buf, 0, EINVAL, NULL}, {
-	"Test for ERANGE", (void *)setup_test4, buf, 1, ERANGE, NULL}
+	{NULL, -1, ENOMEM},
+	{buffer, 0, EINVAL},
+	{buffer, 1, ERANGE},
+	{NULL, 1, ERANGE}
 };
 
-int TST_TOTAL = ARRAY_SIZE(testcases);
-
-int main(int ac, char **av)
+static void verify_getcwd(unsigned int n)
 {
-	int i;
-	int lc;
-	char *test_erg;
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
-		for (i = 0; i < TST_TOTAL; ++i) {
-			tst_resm(TINFO, "%s", testcases[i].desc);
-
-			if (testcases[i].setupfunc != NULL) {
-				testcases[i].setupfunc();
-			}
-
-			errno = 0;
-			test_erg = getcwd(testcases[i].buf, testcases[i].size);
-			TEST_ERRNO = errno;
-
-			if (test_erg != testcases[i].exp_retval) {
-				tst_resm(TFAIL, "getcwd(2) failed to return"
-					 "expected value, expected: %p, "
-					 "got: %p", testcases[i].exp_retval,
-					 test_erg);
-				continue;
-			}
-			if (TEST_ERRNO != testcases[i].exp_errno) {
-				tst_resm(TFAIL, "getcwd returned unexpected "
-					 "errno, expected: %d, got: %d",
-					 testcases[i].exp_errno, TEST_ERRNO);
-				continue;
-			}
-			tst_resm(TPASS, "Test case %d PASSED", i + 1);
-		}
+	struct t_case *tc = &tcases[n];
+	char *res;
+
+	errno = 0;
+	res = getcwd(tc->buf, tc->size);
+	TEST_ERRNO = errno;
+	if (res != NULL) {
+		tst_res(TFAIL, "getcwd() succeeded unexpectedly");
+		return;
 	}
-	cleanup();
 
-	tst_exit();
-}
+	if (TEST_ERRNO != tc->exp_err) {
+		tst_res(TFAIL | TTERRNO, "getcwd() failed unexpectedly, expected %s",
+			tst_strerrno(tc->exp_err));
+		return;
+	}
 
-void setup_test4(void)
-{
-	chdir("/");
+	tst_res(TPASS | TTERRNO, "getcwd() failed as expected");
 }
 
-void setup(void)
+static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
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
+	.tid = "getcwd01",
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_getcwd
+};
-- 
1.8.3.1



