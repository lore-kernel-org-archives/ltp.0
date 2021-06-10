From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Date: Thu, 10 Jun 2021 17:10:42 +0800
Subject: [LTP] [PATCH 1/2] syscalls/read03: Convert to new API
Message-ID: <20210610091043.900863-1-ruansy.fnst@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/read/read03.c | 155 +++++-------------------
 1 file changed, 33 insertions(+), 122 deletions(-)

diff --git a/testcases/kernel/syscalls/read/read03.c b/testcases/kernel/syscalls/read/read03.c
index 28554f5ba..2bee29c13 100644
--- a/testcases/kernel/syscalls/read/read03.c
+++ b/testcases/kernel/syscalls/read/read03.c
@@ -1,146 +1,57 @@
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
- *	read03.c
- *
- * DESCRIPTION
- *	Testcase to check that read() sets errno to EAGAIN
- *
- * ALGORITHM
- *	Create a named pipe (fifo), open it in O_NONBLOCK mode, and
- *	attempt to read from it, without writing to it. read() should fail
- *	with EAGAIN.
- *
- * USAGE:  <for command-line>
- *  read03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
+/*\
+ * [DESCRIPTION]
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	NONE
+ * Testcase to check if read() successfully sets errno to EAGAIN when read from
+ * a pipe(fifo, opened in O_NONBLOCK mode) without writing to it.
  */
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <signal.h>
-#include <errno.h>
-#include "test.h"
 
-char *TCID = "read03";
-int TST_TOTAL = 1;
-
-char fifo[100] = "fifo";
-int rfd, wfd;
-struct stat buf;
+#include <stdio.h>
+#include <fcntl.h>
+#include "tst_test.h"
 
-void alarm_handler();
-void setup();
-void cleanup();
+static char fifo[100];
+static int rfd, wfd;
 
-int main(int ac, char **av)
+static void verify_read(void)
 {
-	int lc;
-
 	int c;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	/*
-	 * The following loop checks looping state if -i option given
-	 */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		TEST(read(rfd, &c, 1));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "read() failed to fail when nothing "
-				 "is written to a pipe");
-			continue;
-		}
-
-		if (TEST_ERRNO != EAGAIN) {
-			tst_resm(TFAIL, "read set bad errno, expected "
-				 "EAGAIN, got %d", TEST_ERRNO);
-		} else {
-			tst_resm(TPASS, "read() succeded in setting errno to "
-				 "EAGAIN");
-		}
-	}
-	cleanup();
-	tst_exit();
-
+	TST_EXP_FAIL(read(rfd, &c, 1), EAGAIN,
+		     "read() when nothing is written to a pipe");
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test
- */
-void setup(void)
+static void setup(void)
 {
+	struct stat buf;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* create a temporary filename */
-	sprintf(fifo, "%s.%d", fifo, getpid());
+	sprintf(fifo, "fifo.%d", getpid());
 
-	/* Create a temporary directory and cd to it */
-	tst_tmpdir();
+	SAFE_MKNOD(fifo, S_IFIFO | 0777, 0);
+	SAFE_STAT(fifo, &buf);
 
-	if (mknod(fifo, S_IFIFO | 0777, 0) < 0) {
-		tst_brkm(TBROK, cleanup, "mknod() failed, errno: %d", errno);
-	}
-	if (stat(fifo, &buf) != 0) {
-		tst_brkm(TBROK, cleanup, "stat() failed, errno: %d", errno);
-	}
 	if ((buf.st_mode & S_IFIFO) == 0) {
-		tst_brkm(TBROK, cleanup, "Mode does not indicate fifo file");
+		tst_brk(TBROK, "Mode does not indicate fifo file");
 	}
 
-	rfd = open(fifo, O_RDONLY | O_NONBLOCK);
-	wfd = open(fifo, O_WRONLY | O_NONBLOCK);
+	rfd = SAFE_OPEN(fifo, O_RDONLY | O_NONBLOCK);
+	wfd = SAFE_OPEN(fifo, O_WRONLY | O_NONBLOCK);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-
-	close(rfd);
-	close(wfd);
-	unlink(fifo);
-
-	/* delete the test directory created in setup() */
-	tst_rmdir();
-
+	SAFE_CLOSE(rfd);
+	SAFE_CLOSE(wfd);
+	SAFE_UNLINK(fifo);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_read,
+};
-- 
2.31.1



