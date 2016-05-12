From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 12 May 2016 15:18:13 +0800
Subject: [LTP] [PATCH 1/2] syscalls/pipe01: Cleanup && convert to new API.
Message-ID: <1463037494-7284-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/pipe/pipe01.c | 170 +++++++++++---------------------
 1 file changed, 56 insertions(+), 114 deletions(-)

diff --git a/testcases/kernel/syscalls/pipe/pipe01.c b/testcases/kernel/syscalls/pipe/pipe01.c
index 18cda6f..36902be 100644
--- a/testcases/kernel/syscalls/pipe/pipe01.c
+++ b/testcases/kernel/syscalls/pipe/pipe01.c
@@ -1,145 +1,87 @@
 /*
+ * Copyright (c) International Business Machines Corp., 2001
  *
- *   Copyright (c) International Business Machines  Corp., 2001
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
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
- * NAME
- *	pipe01.c
- *
- * DESCRIPTION
- *	Testcase to check the basic functionality of the pipe(2) syscall:
- *	Check that both ends of the pipe (both file descriptors) are
- *	available to a process opening the pipe.
- *
- * ALGORITHM
- *	Write a string of characters down a pipe; read the string from the
- *	other file descriptor. Test passes if both can be done, as reported
- *	by the number of characters written and read.
- *
- * USAGE:  <for command-line>
- *  pipe01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * RESTRICITONS
- *	NONE
+ * Basic test for pipe().
  */
-#include <unistd.h>
+
 #include <errno.h>
 #include <string.h>
-#include "test.h"
-
-char *TCID = "pipe01";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
-void setup(void);
-void cleanup(void);
+#define SIZE	27
 
-ssize_t do_read(int fd, void *buf, size_t count)
-{
-	ssize_t n;
-
-	do {
-		n = read(fd, buf, count);
-	} while (n < 0 && errno == EINTR);
-
-	return n;
-}
+static int fildes[2];
+static char wrbuf[SIZE], rebuf[SIZE];
 
-int main(int ac, char **av)
+static void verify_pipe(void)
 {
-	int lc;
-
-	int fildes[2];		/* fds for pipe read and write */
-	char wrbuf[BUFSIZ], rebuf[BUFSIZ];
-	int red, written;	/* no. of chars read/written to pipe */
-	int greater, length;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	int red, written;
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	strcpy(rebuf, "00000000000000000000000000");
 
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
+	TEST(pipe(fildes));
 
-		TEST(pipe(fildes));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "pipe() failed unexpectedly - errno %d",
-				 TEST_ERRNO);
-			continue;
-		}
-
-		strcpy(wrbuf, "abcdefghijklmnopqrstuvwxyz");
-		length = strlen(wrbuf);
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL, "pipe() failed unexpectedly - errno %d",
+			 TEST_ERRNO);
+		return;
+	}
 
-		if ((written = write(fildes[1], wrbuf, length)) == -1) {
-			tst_brkm(TBROK, cleanup, "write() failed");
-		}
+	written = SAFE_WRITE(1, fildes[1], wrbuf, strlen(wrbuf));
 
-		if (written < 0 || written > 26) {
-			tst_resm(TFAIL, "Condition #1 test failed");
-			continue;
-		}
+	if (written < 0 || written > 26) {
+		tst_res(TFAIL, "Condition #1 test failed");
+		return;
+	}
 
-		if ((red = do_read(fildes[0], rebuf, written)) == -1) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "read() failed");
-		}
+	red = SAFE_READ(1, fildes[0], rebuf, written);
 
-		if (red < 0 || red > written) {
-			tst_resm(TFAIL, "Condition #2 test failed");
-			continue;
-		}
+	if (red < 0 || red > written) {
+		tst_res(TFAIL, "Condition #2 test failed");
+		return;
+	}
 
-		/* are the strings written and read equal */
-		if ((greater = strncmp(rebuf, wrbuf, red)) != 0) {
-			tst_resm(TFAIL, "Condition #3 test failed");
-			continue;
-		}
-		tst_resm(TPASS, "pipe() functionality is correct");
+	if ((strncmp(rebuf, wrbuf, red)) != 0) {
+		tst_res(TFAIL, "Condition #3 test failed");
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	tst_res(TPASS, "pipe() functionality is correct");
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	strcpy(wrbuf, "abcdefghijklmnopqrstuvwxyz");
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
+	if (fildes[0] > 0 && close(fildes[0]))
+		tst_res(TWARN | TERRNO, "Failed to close file");
+
+	if (fildes[1] > 0 && close(fildes[1]))
+		tst_res(TWARN | TERRNO, "Failed to close file");
 }
+
+static struct tst_test test = {
+	.tid = "pipe01",
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_pipe,
+	.needs_tmpdir = 1,
+};
-- 
1.8.3.1



