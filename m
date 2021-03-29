From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 29 Mar 2021 20:47:07 +0800
Subject: [LTP] [PATCH 3/3] syscalls/chown: rewrite chown/chown05.c with the
 new api
In-Reply-To: <20210329124707.117102-1-xieziyao@huawei.com>
References: <20210329124707.117102-1-xieziyao@huawei.com>
Message-ID: <20210329124707.117102-4-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

rewrite chown/chown05.c with the new api

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/chown/chown05.c | 201 +++++++---------------
 1 file changed, 62 insertions(+), 139 deletions(-)

diff --git a/testcases/kernel/syscalls/chown/chown05.c b/testcases/kernel/syscalls/chown/chown05.c
index 47510ee9a..29e540558 100644
--- a/testcases/kernel/syscalls/chown/chown05.c
+++ b/testcases/kernel/syscalls/chown/chown05.c
@@ -1,70 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
+ * 07/2001 Ported by Wayne Boyer
  */

-/*
- * Test Name: chown05
- *
- * Test Description:
- *  Verify that, chown(2) succeeds to change the owner and group of a file
- *  specified by path to any numeric owner(uid)/group(gid) values when invoked
- *  by super-user.
- *
- * Expected Result:
- *  chown(2) should return 0 and the ownership set on the file should match
- *  the numeric values contained in owner and group respectively.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Create temporary directory.
- *   Pause for SIGUSR1 if option specified.
+/*\
+ * [Description]
  *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *   	Log the errno and Issue a FAIL message.
- *   Otherwise,
- *   	Verify the Functionality of system call
- *      if successful,
- *      	Issue Functionality-Pass message.
- *      Otherwise,
- *		Issue Functionality-Fail message.
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory created.
+ * Verify that, chown(2) succeeds to change the owner and group of a file
+ * specified by path to any numeric owner(uid)/group(gid) values when invoked
+ * by super-user.
  *
- * Usage:  <for command-line>
- *  chown05 [-c n] [-e] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
+ * [Algorithm]
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS:
- *  This test should be run by 'super-user' (root) only.
+ * - Execute system call
+ * - Check return code, if system call failed (return=-1)
+ * -   Log the errno and Issue a FAIL message
+ * - Otherwise
+ * - Verify the Functionality of system call
+ * -   if successful
+ * -     Issue Functionality-Pass message
+ * -   Otherwise
+ * -     Issue Functionality-Fail message
  */

 #include <stdio.h>
@@ -75,99 +32,65 @@
 #include <string.h>
 #include <signal.h>

-#include "test.h"
-#include "safe_macros.h"
-#include "compat_16.h"
+#include "tst_test.h"
+#include "compat_tst_16.h"
+#include "tst_safe_macros.h"

 #define FILE_MODE	(S_IFREG|S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
 #define TESTFILE	"testfile"

-TCID_DEFINE(chown05);
-
 struct test_case_t {
 	uid_t user_id;
 	gid_t group_id;
-} test_cases[] = {
-	{
-	700, 701}, {
-	702, -1}, {
-	703, 701}, {
-	-1, 704}, {
-703, 705},};
-
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-void setup();			/* setup function for the test */
-void cleanup();			/* cleanup function for the test */
-
-int main(int ac, char **av)
+} tc[] = {
+	{700, 701},
+	{702, -1},
+	{703, 701},
+	{-1, 704},
+	{703, 705},
+};
+
+static void run(unsigned int i)
 {
 	struct stat stat_buf;	/* stat(2) struct contents */
-	int lc;
-	int i;
+
 	uid_t user_id;		/* user id of the user set for testfile */
 	gid_t group_id;		/* group id of the user set for testfile */

-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			user_id = test_cases[i].user_id;
-			group_id = test_cases[i].group_id;
-
-			TEST(CHOWN(cleanup, TESTFILE, user_id, group_id));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL | TTERRNO, "chown failed");
-				continue;
-			}
-			if (stat(TESTFILE, &stat_buf) == -1)
-				tst_brkm(TFAIL, cleanup, "stat failed");
-			if ((int)user_id == -1)
-				user_id = test_cases[i - 1].user_id;
-			if ((int)group_id == -1)
-				group_id = test_cases[i - 1].group_id;
-
-			if (stat_buf.st_uid != user_id ||
-			    stat_buf.st_gid != group_id)
-				tst_resm(TFAIL, "%s: incorrect "
-					 "ownership set, Expected %d "
-					 "%d", TESTFILE, user_id,
-					 group_id);
-			else
-				tst_resm(TPASS, "chown succeeded");
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	user_id = tc[i].user_id;
+	group_id = tc[i].group_id;
+	TEST(CHOWN(TESTFILE, user_id, group_id));
+
+	if (TST_RET == -1)
+		tst_res(TFAIL | TTERRNO, "chown failed");
+
+	if ((int)user_id == -1)
+		user_id = tc[i - 1].user_id;
+	if ((int)group_id == -1)
+		group_id = tc[i - 1].group_id;
+
+	SAFE_STAT(TESTFILE, &stat_buf);
+	if (stat_buf.st_uid != user_id ||
+	    stat_buf.st_gid != group_id)
+		tst_res(TFAIL, "%s: incorrect ownership set, "
+			       "Expected %d %d",
+			TESTFILE, user_id, group_id);
+	else
+		tst_res(TPASS, "chown succeeded");
 }

-void setup(void)
+static void setup(void)
 {
 	int fd;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	if ((fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "opening %s failed",
-			 TESTFILE);
-	SAFE_CLOSE(cleanup, fd);
-
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
+	SAFE_CLOSE(fd);
 }

-void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tc),
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.test = run,
+};
+
--
2.17.1

