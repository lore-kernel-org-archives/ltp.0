From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Date: Wed, 3 Mar 2021 10:22:21 +0800
Subject: [LTP] [PATCH] syscalls/chdir04: Convert to the new API
Message-ID: <20210303022221.1044234-1-ruansy.fnst@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/chdir/chdir04.c | 185 ++++++----------------
 1 file changed, 47 insertions(+), 138 deletions(-)

diff --git a/testcases/kernel/syscalls/chdir/chdir04.c b/testcases/kernel/syscalls/chdir/chdir04.c
index f0420e4c9..8bf68977f 100644
--- a/testcases/kernel/syscalls/chdir/chdir04.c
+++ b/testcases/kernel/syscalls/chdir/chdir04.c
@@ -1,162 +1,71 @@
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
  */
 
-/*
- * NAME
- * 	chdir04.c
- *
- * DESCRIPTION
- *	Testcase to test whether chdir(2) sets errno correctly.
- *
- * ALGORITHM
- *	1.	Test for ENAMETOOLONG:
- *		Create a bad directory name with length more than
- *
- *		VFS_MAXNAMELEN (Linux kernel variable), and attempt to
- *		chdir(2) to it.
- *
- *	2.	Test for ENOENT:
- *		Attempt to chdir(2) on a non-existent directory
- *
- *	3.	Test for EFAULT:
- *		Pass an address which lies outside the address space of the
- *		process, and expect an EFAULT.
- *
- * USAGE:  <for command-line>
- * chdir04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+/*\
+ * [DESCRIPTION]
  *
- * RESTRICTIONS
- *	NONE
- */
+ * Testcase to test whether chdir(2) sets errno correctly.
+\*/
 
-#include <stdio.h>
 #include <errno.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-#include "test.h"
-
-char *TCID = "chdir04";
+#include "tst_test.h"
 
 char bad_dir[] =
     "abcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
-
 char noexist_dir[] = "/tmp/noexistdir";
-
-struct test_case_t {
-	char *dname;
-	int error;
-} TC[] = {
-	/*
-	 * to test whether chdir() is setting ENAMETOOLONG if the
-	 * directory is more than VFS_MAXNAMELEN
-	 */
-	{
-	bad_dir, ENAMETOOLONG},
-	    /*
-	     * to test whether chdir() is setting ENOENT if the
-	     * directory is not existing.
-	     */
-	{
-	noexist_dir, ENOENT},
-	    /*
-	     * to test whether chdir() is setting EFAULT if the
-	     * directory is an invalid address.
-	     */
-	{
-	(void *)-1, EFAULT}
-};
-
-int TST_TOTAL = ARRAY_SIZE(TC);
-
-int flag;
-#define	FAILED	1
-
-void setup(void);
-void cleanup(void);
-
 char *bad_addr = 0;
 
-int main(int ac, char **av)
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			TEST(chdir(TC[i].dname));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == TC[i].error)
-				tst_resm(TPASS | TTERRNO, "failed as expected");
-			else {
-				tst_resm(TFAIL | TTERRNO,
-					 "didn't fail as expected (expected %d)",
-					 TC[i].error);
-			}
-		}
-	}
-	cleanup();
-
-	tst_exit();
-
-}
+static struct test_case_t {
+	char *dir_name;
+	int expected_error;
+} testcase_list[] = {
+	{bad_dir, ENAMETOOLONG},
+	{noexist_dir, ENOENT},
+	{(void *)-1, EFAULT}
+};
 
-void setup(void)
+static void setup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
 #ifdef UCLINUX
 	bad_addr = mmap(0, 1, PROT_NONE,
 			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
 	if (bad_addr == MAP_FAILED)
-		tst_brkm(TBROK | TERRNO, cleanup, "mmap() failed");
-	TC[2].dname = bad_addr;
+		tst_brk(TBROK | TERRNO, "mmap() failed");
+	testcase_list[2].dir_name = bad_addr;
+#endif
+}
+
+static void cleanup(void)
+{
+#ifdef UCLINUX
+	munmap(bad_addr, 1);
 #endif
 }
 
-void cleanup(void)
+static void verify_chdir(unsigned int i)
 {
-	tst_rmdir();
+	TEST(chdir(testcase_list[i].dir_name));
+
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "call succeeded unexpectedly");
+		return;
+	}
 
+	if (TST_ERR == testcase_list[i].expected_error)
+		tst_res(TPASS | TTERRNO, "failed as expected");
+	else {
+		tst_res(TFAIL | TTERRNO,
+			"didn't fail as expected (expected %d)",
+			testcase_list[i].expected_error);
+	}
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test = verify_chdir,
+	.tcnt = ARRAY_SIZE(testcase_list),
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.30.1



