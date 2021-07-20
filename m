From: Dai Shili <daisl.fnst@fujitsu.com>
Date: Tue, 20 Jul 2021 04:58:17 -0400
Subject: [LTP] [PATCH] syscalls/readv03: Convert to new API
Message-ID: <1626771497-20281-1-git-send-email-daisl.fnst@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/readv/readv03.c | 150 ++++++------------------------
 1 file changed, 27 insertions(+), 123 deletions(-)

diff --git a/testcases/kernel/syscalls/readv/readv03.c b/testcases/kernel/syscalls/readv/readv03.c
index 09a2ce4..c31d74a 100644
--- a/testcases/kernel/syscalls/readv/readv03.c
+++ b/testcases/kernel/syscalls/readv/readv03.c
@@ -1,148 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (C) Bull S.A. 2001
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
+ * Copyright (C) Bull S.A. 2001
+ * Copyright (c) International Business Machines  Corp., 2001
+ * 05/2002 Ported by Jacky Malcles
  */
 
-/*
- * NAME
- * 	readv03.c
- *
- * DESCRIPTION
- *	Testcase to check the error condition of the readv(2) system call
- *	when fd refers to a directory.
- *
- * CALLS
- * 	readv()
- *
- * ALGORITHM
- *      loop if that option was specified
- *      call readv() when fd refers to a directory.
- *      check the errno value
- *        issue a PASS message if we get EISDIR - errno 21
- *      otherwise, the tests fails
- *        issue a FAIL message
- *      call cleanup
- *
- * USAGE$
- *	readv03
- *
- * HISTORY
- *	05/2002 Ported by Jacky Malcles
- *
- * RESTRICTIONS
- * 	None
+/*\
+ * [Description]
+ *      Testcase to check EISDIR error when fd refers to a directory.
  */
-#include <sys/types.h>
+
 #include <sys/uio.h>
 #include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <sys/stat.h>
+#include "tst_test.h"
 
-#include "test.h"
-#include "safe_macros.h"
-
-#define	K_1	1024
+#define K_1     1024
 #define MODES   S_IRWXU
 
 char buf1[K_1];
 
 struct iovec rd_iovec[1] = {
-	{buf1, K_1}
+        {buf1, K_1}
 };
 
 const char *TEST_DIR = "alpha";
-int r_val;
-int fd;
-
-char *TCID = "readv03";
-int TST_TOTAL = 1;
+static int fd;
 
-void setup();
-void cleanup();
-
-int main(int ac, char **av)
+static void verify_readv(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	/* The following loop checks looping state if -i option given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		if (readv(fd, rd_iovec, 1) < 0) {
-			if (errno != EISDIR) {
-				tst_resm(TFAIL, "expected errno = EISDIR, "
-					 "got %d", errno);
-			} else {
-				tst_resm(TPASS, "got EISDIR");
-			}
-		} else {
-			tst_resm(TFAIL, "Error: readv returned a positive "
-				 "value");
-		}
-
-	}
-	cleanup();
-	tst_exit();
-
+        TST_EXP_FAIL2(readv(fd, rd_iovec, 1), EISDIR,
+                     "readv() got EISDIR");
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
 void setup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* make a temporary directory and cd to it */
-	tst_tmpdir();
-
-	/*
-	 * create a new directory and open it
-	 */
-
-	if ((r_val = mkdir(TEST_DIR, MODES)) == -1) {
-		tst_brkm(TBROK, cleanup, "%s - mkdir() in main() "
-			 "failed", TCID);
-	}
-
-	if ((fd = open(TEST_DIR, O_RDONLY)) == -1) {
-		tst_brkm(TBROK, cleanup, "open of directory failed");
-	}
-
+        SAFE_MKDIR(TEST_DIR, MODES);
+        fd = SAFE_OPEN(TEST_DIR, O_RDONLY);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	SAFE_CLOSE(cleanup, fd);
-	tst_rmdir();
-
+        if (fd > 0)
+                SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+        .needs_tmpdir = 1,
+        .setup = setup,
+        .cleanup = cleanup,
+        .test_all = verify_readv,
+};
-- 
1.8.3.1

