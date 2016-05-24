From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 24 May 2016 10:55:56 +0800
Subject: [LTP] [PATCH 3/3] syscalls/pipe03: Cleanup && convert to new API
In-Reply-To: <1464058556-7675-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1464058556-7675-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1464058556-7675-3-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/pipe/pipe03.c | 148 ++++++++++----------------------
 1 file changed, 45 insertions(+), 103 deletions(-)

diff --git a/testcases/kernel/syscalls/pipe/pipe03.c b/testcases/kernel/syscalls/pipe/pipe03.c
index 8aa281d..290511f 100644
--- a/testcases/kernel/syscalls/pipe/pipe03.c
+++ b/testcases/kernel/syscalls/pipe/pipe03.c
@@ -1,127 +1,69 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2002
  *
- *   Copyright (c) International Business Machines  Corp., 2002
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
  */
 
 /*
  * NAME
- *	pipe03.c
+ * pipe03.c
  *
  * DESCRIPTION
- * 	Make sure that writing to the read end of a pipe and reading from
- * 	the write end of a pipe both fail.
- *
- * ALGORITHM
- * 	1. Open a pipe
- * 	2. Attempt to write to the [0] descriptor (expect -1)
- * 	3. Attempt to read from the [1] descriptor (expect -1)
+ * Make sure that writing to the read end of a pipe and reading from
+ * the write end of a pipe both fail.
  *
- * USAGE:  <for command-line>
- *  pipe03 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	11/2002 Ported by Paul Larson
  */
+
 #include <unistd.h>
 #include <errno.h>
-#include "test.h"
+#include "tst_test.h"
 
-char *TCID = "pipe03";
-int TST_TOTAL = 1;
+static int fd[2];
 
-void setup(void);
-void cleanup(void);
-
-ssize_t do_read(int fd, void *buf, size_t count)
+static void verify_pipe(void)
 {
-	ssize_t n;
-
-	do {
-		n = read(fd, buf, count);
-	} while (n < 0 && errno == EINTR);
-
-	return n;
-}
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	int fildes[2];		/* fds for pipe read and write */
-	char rbuf[BUFSIZ];
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
+	char buf[2];
 
-		TEST(pipe(fildes));
-
-		if (TEST_RETURN == -1)
-			tst_brkm(TBROK | TTERRNO, cleanup,
-				 "pipe() failed unexpectedly");
-
-		TEST(write(fildes[0], "A", 1));
-		if (TEST_RETURN == -1 && TEST_ERRNO == EBADF)
-			tst_resm(TPASS, "expected failure writing to "
-				 "read end of pipe");
-		else
-			tst_resm(TFAIL | TTERRNO,
-				 "success when writing to read "
-				 "end of pipe ret=%ld", TEST_RETURN);
-
-		TEST(do_read(fildes[1], rbuf, 1));
-		if (TEST_RETURN == -1 && TEST_ERRNO == EBADF)
-			tst_resm(TPASS, "expected failure reading from "
-				 "write end of pipe");
-		else
-			tst_resm(TFAIL | TTERRNO, "success when reading from "
-				 "write end of pipe ret=%ld", TEST_RETURN);
+	TEST(pipe(fd));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO, "pipe() failed unexpectedly");
+		return;
 	}
-	cleanup();
 
-	tst_exit();
-}
-
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
-{
+	TEST(write(fd[0], "A", 1));
+	if (TEST_RETURN == -1 && errno == EBADF) {
+		tst_res(TPASS | TTERRNO, "expected failure writing "
+			"to read end of pipe");
+	} else {
+		tst_res(TFAIL | TTERRNO, "unexpected failure writing "
+			"to read end of pipe");
+	}
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	TEST(read(fd[1], buf, 1));
+	if (TEST_RETURN == -1 && errno == EBADF) {
+		tst_res(TPASS | TTERRNO, "expected failure reading "
+			"from write end of pipe");
+	} else {
+		tst_res(TFAIL | TTERRNO, "unexpected failure reading "
+			"from write end of pipe");
+	}
 
-	TEST_PAUSE;
+	SAFE_CLOSE(fd[0]);
+	SAFE_CLOSE(fd[1]);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.tid = "pipe03",
+	.test_all = verify_pipe,
+};
-- 
1.8.3.1



