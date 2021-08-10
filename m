From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Tue, 10 Aug 2021 09:52:50 +0800
Subject: [LTP] [PATCH 3/4] syscalls/chmod03: Convert to new API
Message-ID: <20210810015250.21315-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/testcases/kernel/syscalls/chroot/chroot03.c b/testcases/kernel/syscalls/chroot/chroot03.c
index b904e4ac9..0e509f415 100644
--- a/testcases/kernel/syscalls/chroot/chroot03.c
+++ b/testcases/kernel/syscalls/chroot/chroot03.c
@@ -1,168 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *   Copyright (c) International Business Machines  Corp., 2001
  *
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
+ *	 07/2001 Ported by Wayne Boyer
  */

-/*
- *	Testcase to test whether chroot(2) sets errno correctly.
- *
- *	1.	Test for ENAMETOOLONG:
- *		Create a bad directory name with length more than
- *		VFS_MAXNAMELEN (Linux kernel variable), and pass it as the
- *		path to chroot(2).
- *
- *	2.	Test for ENOENT:
- *		Attempt to chroot(2) on a non-existent directory
- *
- *	3.	Test for ENOTDIR:
- *		Attempt to chdir(2) on a file.
- *
- *	4.	Test for EFAULT:
- *		The pathname parameter to chroot() points to an invalid address,
- *		chroot(2) fails with EPERM.
+/*\
+ * [Description]
  *
- *	5.	Test for ELOOP:
- *		Too many symbolic links were encountered When resolving the
- *		pathname parameter.
- *
- *	07/2001 Ported by Wayne Boyer
+ * Testcase to test whether chroot(2) sets errno correctly.
+ *
+ * - to test whether chroot() is setting ENAMETOOLONG if the
+ *   pathname is more than VFS_MAXNAMELEN.
+ * - to test whether chroot() is setting ENOTDIR if the argument
+ *   is not a directory.
+ * - to test whether chroot() is setting ENOENT if the directory
+ *   does not exist.
+ * - attempt to chroot to a path pointing to an invalid address
+ *   and expect EFAULT as errno.
+ * - to test whether chroot() is setting ELOOP if the two
+ *   symbolic directory who point to each other.
  */

 #include <stdio.h>
-#include <errno.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-#include "test.h"
-#include <fcntl.h>
-#include "safe_macros.h"
-
-char *TCID = "chroot03";
+#include "tst_test.h"

-static int fd;
 static char fname[255];
 static char nonexistent_dir[100] = "testdir";
 static char bad_dir[] = "abcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
 static char symbolic_dir[] = "sym_dir1";

-struct test_case_t {
+static struct tcase {
 	char *dir;
 	int error;
-} TC[] = {
-	/*
-	 * to test whether chroot() is setting ENAMETOOLONG if the
-	 * pathname is more than VFS_MAXNAMELEN
-	 */
-	{
-	bad_dir, ENAMETOOLONG},
-	    /*
-	     * to test whether chroot() is setting ENOTDIR if the argument
-	     * is not a directory.
-	     */
-	{
-	fname, ENOTDIR},
-	    /*
-	     * to test whether chroot() is setting ENOENT if the directory
-	     * does not exist.
-	     */
-	{
-	nonexistent_dir, ENOENT},
-#if !defined(UCLINUX)
-	    /*
-	     * attempt to chroot to a path pointing to an invalid address
-	     * and expect EFAULT as errno
-	     */
-	{
-	(char *)-1, EFAULT},
-#endif
-	{symbolic_dir, ELOOP}
+	char *desc;
+} tcases[] = {
+	{bad_dir, ENAMETOOLONG, "chroot(pathname more than VFS_MAXNAMELEN)"},
+	{fname, ENOTDIR, "chroot(not a directory)"},
+	{nonexistent_dir, ENOENT, "chroot(path does not exists)"},
+	{(char *)-1, EFAULT, "chroot(a path pointing to an invalid address)"},
+	{symbolic_dir, ELOOP, "chroot(two symbolic directory who point to each other)"}
 };

-int TST_TOTAL = ARRAY_SIZE(TC);
-
-static char *bad_addr;
-
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void verify_chroot(unsigned int n)
 {
-	int lc;
-	int i;
+	struct tcase *tc = &tcases[n];

-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(chroot(TC[i].dir));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS | TTERRNO, "failed as expected");
-			} else {
-				tst_resm(TFAIL | TTERRNO,
-					 "didn't fail as expected (expected errno "
-					 "= %d : %s)",
-					 TC[i].error, strerror(TC[i].error));
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_FAIL(chroot(tc->dir), tc->error, "%s", tc->desc);
 }

 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-	tst_tmpdir();
+	unsigned int i;

-	/*
-	 * create a file and use it to test whether chroot() is setting
-	 * ENOTDIR if the argument is not a directory.
-	 */
 	(void)sprintf(fname, "tfile_%d", getpid());
-	fd = SAFE_CREAT(cleanup, fname, 0777);
+	SAFE_TOUCH(fname, 0666, NULL);

-#if !defined(UCLINUX)
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED)
-		tst_brkm(TBROK, cleanup, "mmap failed");
-
-	TC[3].dir = bad_addr;
-#endif
+	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
+		if (tcases[i].error == EFAULT)
+			tcases[3].dir = tst_get_bad_addr(NULL);
+	}
+
 	/*
 	 * create two symbolic directory who point to each other to
 	 * test ELOOP.
 	 */
-	SAFE_SYMLINK(cleanup, "sym_dir1/", "sym_dir2");
-	SAFE_SYMLINK(cleanup, "sym_dir2/", "sym_dir1");
+	SAFE_SYMLINK("sym_dir1/", "sym_dir2");
+	SAFE_SYMLINK("sym_dir2/", "sym_dir1");
 }

-static void cleanup(void)
-{
-	close(fd);
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_chroot,
+	.needs_tmpdir = 1,
+};
--
2.20.1




