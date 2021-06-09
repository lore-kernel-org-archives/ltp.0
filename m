From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Wed,  9 Jun 2021 23:05:52 +0530
Subject: [LTP] [PATCH v2 01/10] getitimer02 : Convert getitimer02 to new API
In-Reply-To: <YL/Wf51Y6V5lRnkM@pevik>
References: <YL/Wf51Y6V5lRnkM@pevik>
Message-ID: <20210609173601.29352-1-vinay.m.engg@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Vinay Kumar <vinay.m.engg@gmail.com>
---
 .../kernel/syscalls/getitimer/getitimer02.c   | 103 ++++--------------
 1 file changed, 24 insertions(+), 79 deletions(-)

diff --git a/testcases/kernel/syscalls/getitimer/getitimer02.c b/testcases/kernel/syscalls/getitimer/getitimer02.c
index b9c03143a..c2ca8880b 100644
--- a/testcases/kernel/syscalls/getitimer/getitimer02.c
+++ b/testcases/kernel/syscalls/getitimer/getitimer02.c
@@ -1,99 +1,44 @@
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
+static void verify_getitimer(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
 		/* call with a bad address */
 		TEST(getitimer(ITIMER_REAL, (struct itimerval *)-1));
 
-		if (TEST_RETURN == 0) {
-			tst_resm(TFAIL, "call failed to produce "
-				 "expected error - errno = %d - %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			continue;
+		if (TST_RET == 0) {
+			tst_res(TFAIL, "call failed to produce "
+				"expected error - errno = %d - %s",
+				TST_ERR, strerror(TST_ERR));
 		}
 
-		switch (TEST_ERRNO) {
+		switch (TST_ERR) {
 		case EFAULT:
-			tst_resm(TPASS, "expected failure - errno = %d - %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_res(TPASS, "expected failure - errno = %d - %s",
+				 TST_ERR, strerror(TST_ERR));
 			break;
 		default:
-			tst_resm(TFAIL, "call failed to produce "
-				 "expected error - errno = %d - %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_res(TFAIL, "call failed to produce "
+					"expected error - errno = %d - %s",
+					TST_ERR, strerror(TST_ERR));
 		}
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
-{
-	tst_resm(TINFO, "test is not available on uClinux");
-	tst_exit();
 }
 
-#endif /* if !defined(UCLINUX) */
+static struct tst_test test = {
+			.test_all = verify_getitimer,
+			.needs_root = 1,
+};
-- 
2.17.1

