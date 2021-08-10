From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Tue, 10 Aug 2021 09:52:35 +0800
Subject: [LTP] [PATCH v3, 2/4] syscalls/chroot02: Convert to new API
Message-ID: <20210810015235.20965-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/testcases/kernel/syscalls/chroot/chroot02.c b/testcases/kernel/syscalls/chroot/chroot02.c
index e483ca4b5..cf365ce01 100644
--- a/testcases/kernel/syscalls/chroot/chroot02.c
+++ b/testcases/kernel/syscalls/chroot/chroot02.c
@@ -1,148 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
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
+ *   07/2001 Ported by Wayne Boyer
+ *	 04/2003 Modified by Manoj Iyer - manjo@mail.utexas.edu
  */

-/*
- * NAME
- *	chroot02.c
- *
- * DESCRIPTION
- *	Test functionality of chroot(2)
- *
- * ALGORITHM
- *	Change root directory and then stat a file.
- *
- * USAGE:  <for command-line>
- *  chroot02 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *	04/2003 Modified by Manoj Iyer - manjo@mail.utexas.edu
- *	Change testcase to chroot into a temporary directory
- *	and stat() a known file.
+/*\
+ * [Description]
  *
- * RESTRICTIONS
- *	NONE
+ * - Create a file in the temporary directory;
+ * - Change the root to this temporary directory;
+ * - Check whether this file can be accessed in the new root directory;
  */

-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-#include <errno.h>
-#include "test.h"
-#include <fcntl.h>
-
-char *TCID = "chroot02";
-int TST_TOTAL = 1;
-int fileHandle = 0;
+#include <stdlib.h>
+#include "tst_test.h"

 #define TMP_FILENAME	"chroot02_testfile"
-struct stat buf;
-
-void setup(void);
-void cleanup(void);
+static struct stat buf;
+static char *path;

-int main(int ac, char **av)
+static void verify_chroot(void)
 {
-	int lc;
-	int pid, status, retval;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	/* Check for looping state if -i option is given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		if ((pid = FORK_OR_VFORK()) == -1) {
-			tst_brkm(TBROK, cleanup, "Could not fork");
-		}
-
-		if (pid == 0) {
-			retval = 0;
-
-			if (chroot(tst_get_tmpdir()) == -1) {
-				perror("chroot failed");
-				retval = 1;
-			} else {
-				if (stat("/" TMP_FILENAME, &buf) == -1) {
-					retval = 1;
-					perror("stat failed");
-				}
-			}
-
-			exit(retval);
-		}
-
-		/* parent */
-		wait(&status);
-		/* make sure the child returned a good exit status */
-		if (WIFSIGNALED(status) ||
-		    (WIFEXITED(status) && WEXITSTATUS(status) != 0))
-			tst_resm(TFAIL, "chroot functionality incorrect");
-		else
-			tst_resm(TPASS, "chroot functionality correct");
+	if (!SAFE_FORK()) {
+		TST_EXP_PASS(chroot(path), "chroot(%s)", path);
+		if (!TST_PASS)
+			return;
+
+		TST_EXP_PASS(stat("/" TMP_FILENAME, &buf), "stat(/%s)", TMP_FILENAME);
 	}
-
-	cleanup();
-	tst_exit();
-
 }

-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
-
-	tst_tmpdir();
-	if ((fileHandle = creat(TMP_FILENAME, 0777)) == -1)
-		tst_brkm(TBROK, cleanup, "failed to create temporary file "
-			 TMP_FILENAME);
-	if (stat(TMP_FILENAME, &buf) != 0)
-		tst_brkm(TBROK, cleanup, TMP_FILENAME " does not exist");
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	path = tst_get_tmpdir();
+	SAFE_TOUCH(TMP_FILENAME, 0666, NULL);
+	SAFE_STAT(TMP_FILENAME, &buf);
 }

-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
-	close(fileHandle);
+	free(path);
+}

-	tst_rmdir();
+static struct tst_test test = {
+	.cleanup = cleanup,
+	.setup = setup,
+	.test_all = verify_chroot,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+};

-}
--
2.20.1



