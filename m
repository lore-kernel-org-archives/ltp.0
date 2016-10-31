From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Mon, 31 Oct 2016 10:54:37 +0800
Subject: [LTP] [PATCH 2/3] syscalls/umask02: Cleanup && Convert to new API
In-Reply-To: <1477882478-30693-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1477882478-30693-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1477882478-30693-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/umask/umask02.c | 143 +++++++++---------------------
 1 file changed, 41 insertions(+), 102 deletions(-)

diff --git a/testcases/kernel/syscalls/umask/umask02.c b/testcases/kernel/syscalls/umask/umask02.c
index 0ba797c..9ec94a0 100644
--- a/testcases/kernel/syscalls/umask/umask02.c
+++ b/testcases/kernel/syscalls/umask/umask02.c
@@ -1,118 +1,57 @@
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
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
+ * Copyright (c) International Business Machines  Corp., 2001
+ *  07/2001 Ported by John George
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
- * NAME
- *	umask02.c
- *
- * DESCRIPTION
- *	Check that umask changes the mask, and that the previous
- *	value of the mask is returned correctly for each value.
- *
- * ALGORITHM
- *	For each mask value (9 bits) set mask, and check that the return
- *	corresponds to the previous value set.
- *
- * USAGE:  <for command-line>
- *	umask02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions
- *	None
+ * umask(2) changes the mask from 0000 to 0777, the previous value
+ * of the mask should be returned correctly for each value.
  */
 
+#include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include "test.h"
-
-char *TCID = "umask02";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
-void setup(void);
-void cleanup(void);
-
-int main(int argc, char **argv)
+static void verify_umask(void)
 {
-	int lc;
-
-	int uret = 0, i, mskval = 0000;
-	int failcnt = 0;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	/* Check for looping state if -i option is given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
+	int mskval = 0000;
+	int failflag = 0;
+
+	for (umask(mskval++); mskval < 01000; mskval++) {
+		TEST(umask(mskval));
+		if (TEST_RETURN < 0) {
+			tst_res(TFAIL | TTERRNO,
+				"umask(%o) failed unexpectedly", mskval);
+			return;
+		}
 
-		for (umask(++mskval), i = 1; mskval < 01000;
-		     uret = umask(++mskval), i++) {
-			if ((uret != mskval - 1) && (mskval != 0000)) {
-				failcnt = 1;
-				tst_resm(TFAIL, "umask(%d) returned bad mask "
-					 "value %d.", mskval, uret);
-			}
+		if (TEST_RETURN != mskval - 1) {
+			failflag = 1;
+			tst_res(TFAIL, "umask(%o) returned %ld, expected %d",
+				mskval, TEST_RETURN, mskval - 1);
 		}
-		if (!failcnt)
-			tst_resm(TPASS, "All umask values return correct "
-				 "values");
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
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
-	TEST_PAUSE;
+	if (!failflag)
+		tst_res(TPASS, "All umask values returned correctly");
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
+	.tid = "umask02",
+	.test_all = verify_umask,
+};
-- 
1.8.4.2



