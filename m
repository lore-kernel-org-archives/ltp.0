From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Sun, 13 Jun 2021 22:13:35 +0530
Subject: [LTP] [PATCH v3] getitimer02: Convert getitimer02 to new API
In-Reply-To: <YMNoFyN89L6/VhP3@yuki>
References: <YMNoFyN89L6/VhP3@yuki>
Message-ID: <20210613164335.6035-1-vinay.m.engg@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Vinay Kumar <vinay.m.engg@gmail.com>
---
 .../kernel/syscalls/getitimer/getitimer02.c   | 104 +++---------------
 1 file changed, 16 insertions(+), 88 deletions(-)

diff --git a/testcases/kernel/syscalls/getitimer/getitimer02.c b/testcases/kernel/syscalls/getitimer/getitimer02.c
index b9c03143a..2eb3f3a94 100644
--- a/testcases/kernel/syscalls/getitimer/getitimer02.c
+++ b/testcases/kernel/syscalls/getitimer/getitimer02.c
@@ -1,99 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
- *
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
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * 03/2001 - Written by Wayne Boyer
  */
 
-/*
-  HISTORY
-  03/2001 - Written by Wayne Boyer
-
-  TEST ITEMS:
-  Check that a getitimer() call fails as expected
-  with an incorrect second argument.
-*/
-
-
-#include "test.h"
+/*\
+ *[Description]
+ *
+ * Check that a getitimer() call fails as expected
+ * with an incorrect second argument.
+ */
 
 #include <errno.h>
 #include <sys/time.h>
+#include "tst_test.h"
 
-char *TCID = "getitimer02";
-int TST_TOTAL = 1;
-
-#if !defined(UCLINUX)
-
-static void cleanup(void);
-static void setup(void);
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		/* call with a bad address */
-		TEST(getitimer(ITIMER_REAL, (struct itimerval *)-1));
-
-		if (TEST_RETURN == 0) {
-			tst_resm(TFAIL, "call failed to produce "
-				 "expected error - errno = %d - %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			continue;
-		}
-
-		switch (TEST_ERRNO) {
-		case EFAULT:
-			tst_resm(TPASS, "expected failure - errno = %d - %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		default:
-			tst_resm(TFAIL, "call failed to produce "
-				 "expected error - errno = %d - %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		}
-	}
-
-	cleanup();
-
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-}
-
-#else
-
-int main(void)
+static void verify_getitimer(void)
 {
-	tst_resm(TINFO, "test is not available on uClinux");
-	tst_exit();
+	/* call with a bad address */
+	TST_EXP_FAIL(getitimer(ITIMER_REAL, (struct itimerval *)-1),
+		EFAULT, "expected failure - errno = %d - %s", TST_ERR, strerror(TST_ERR));
 }
 
-#endif /* if !defined(UCLINUX) */
+static struct tst_test test = {
+	.test_all = verify_getitimer,
+};
-- 
2.17.1

