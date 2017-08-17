From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Aug 2017 13:52:28 +0200
Subject: [LTP] [PATCH 1/2] [COMMITTED] syscalls/setrlimit02: Cleanup &
	convert to newlib
Message-ID: <20170817115229.30598-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/setrlimit/setrlimit02.c | 168 +++++++---------------
 1 file changed, 48 insertions(+), 120 deletions(-)

diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit02.c b/testcases/kernel/syscalls/setrlimit/setrlimit02.c
index 5175e9ada..92cc4f4c6 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit02.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit02.c
@@ -1,150 +1,78 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ *	07/2001 Ported by Wayne Boyer
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
  *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
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
-
 /*
- * NAME
- *	setrlimit02.c
- *
- * DESCRIPTION
- *	Testcase to test the different errnos set by setrlimit(2) system call.
- *
- * USAGE:  <for command-line>
- *  setrlimit02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
- *	NONE
+ * Testcase to test the different errnos set by setrlimit(2) system call.
  */
-#include <sys/time.h>
-#include <sys/resource.h>
-#include <unistd.h>
-#include <errno.h>
 #include <pwd.h>
-#include "test.h"
-
-char *TCID = "setrlimit02";
-
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-struct rlimit rlim;
+#include <errno.h>
+#include "tst_test.h"
 
-void setup();
-void cleanup();
+static char nobody_uid[] = "nobody";
+static struct rlimit rlim;
 
-struct test_case_t {
+static struct tcase {
 	int resource;
 	struct rlimit *rlim;
-	int error;
-} TC[] = {
+	int exp_errno;
+} tcases[] = {
 #if !defined(UCLINUX)
-	/* rlim points outside the process address space - EFAULT */
-	{
-	RLIMIT_NOFILE, (void *)-1, EFAULT},
+	{RLIMIT_NOFILE, (void *)-1, EFAULT},
 #endif
-	    /* the resource is invalid - EINVAL */
-	{
-	-1, &rlim, EINVAL},
-	    /* a non-root user attemps to increase the rlim_max value - EPERM */
-	{
-	RLIMIT_NOFILE, &rlim, EPERM}
+	{-1, &rlim, EINVAL},
+	{RLIMIT_NOFILE, &rlim, EPERM}
 };
 
-int TST_TOTAL = ARRAY_SIZE(TC);
-
-int main(int ac, char **av)
+static void verify_setrlimit(unsigned int n)
 {
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	struct tcase *tc = &tcases[n];
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	TEST(setrlimit(tc->resource, tc->rlim));
 
-		tst_count = 0;
-
-		/* loop through the test cases */
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			TEST(setrlimit(TC[i].resource, TC[i].rlim));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - "
-					 "errno = %d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "unexpected error - %d : %s - "
-					 "expected %d", TEST_ERRNO,
-					 strerror(TEST_ERRNO), TC[i].error);
-			}
-		}
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "call succeeded unexpectedly");
+		return;
 	}
-	cleanup();
 
-	tst_exit();
+	if (TEST_ERRNO != tc->exp_errno) {
+		tst_res(TFAIL | TTERRNO,
+			"setrlimit() should fail with %s got",
+			tst_strerrno(tc->exp_errno));
+		return;
+	}
 
+	tst_res(TPASS | TTERRNO, "setrlimit() failed as expected");
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	struct passwd *ltpuser = SAFE_GETPWNAM(nobody_uid);
 
-	TEST_PAUSE;
+	SAFE_SETUID(ltpuser->pw_uid);
 
-	/* Switch to nobody user for correct error code collection */
-	ltpuser = getpwnam(nobody_uid);
-	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setuid");
-	}
-
-	/* set an illegal value for a non-root user - test #3 - EPERM */
-	getrlimit(RLIMIT_NOFILE, &rlim);
+	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlim);
 	rlim.rlim_max++;
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test = verify_setrlimit,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+};
-- 
2.13.0

