From: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Date: Mon, 12 Jun 2017 15:27:11 +0800
Subject: [LTP] [PATCH v2] syscalls/write01.c: Add test with different buffer
	sizes && Remove write02
In-Reply-To: <20170526141655.GE6492@rei.lan>
References: <20170526141655.GE6492@rei.lan>
Message-ID: <1497252431-8344-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/write/write01.c |  40 +++++---
 testcases/kernel/syscalls/write/write02.c | 146 ------------------------------
 2 files changed, 25 insertions(+), 161 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/write/write02.c

diff --git a/testcases/kernel/syscalls/write/write01.c b/testcases/kernel/syscalls/write/write01.c
index 1a60052..14fa7c9 100644
--- a/testcases/kernel/syscalls/write/write01.c
+++ b/testcases/kernel/syscalls/write/write01.c
@@ -20,17 +20,9 @@
  * You should have received a copy of the GNU General Public License along
  * with this program; if not, write the Free Software Foundation, Inc.,
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
  */
 
+#include <stdio.h>
 #include <errno.h>
 #include "tst_test.h"
 
@@ -38,17 +30,35 @@ static int fd;
 
 static void verify_write(void)
 {
-	TEST(write(fd, "w", 1));
+	int i, badcount = 0;
+	char buf[BUFSIZ];
+
+	memset(buf, 'w', BUFSIZ);
 
-	if (TEST_RETURN == -1)
-		tst_res(TFAIL | TTERRNO, "write(2) failed");
+	SAFE_LSEEK(fd, 0, SEEK_SET);
+
+	for (i = BUFSIZ; i > 0; i--) {
+		TEST(write(fd, &buf, i));
+		if (TEST_RETURN == -1) {
+			tst_res(TFAIL | TTERRNO, "write failed");
+			return;
+		}
+
+		if (TEST_RETURN != i) {
+			badcount++;
+			tst_res(TINFO, "bad write count");
+		}
+	}
+
+	if (badcount != 0)
+		tst_res(TFAIL, "write() failed to return proper count");
 	else
-		tst_res(TPASS, "write(2) returned %ld", TEST_RETURN);
+		tst_res(TPASS, "write() passed");
 }
 
 static void setup(void)
 {
-	fd = SAFE_OPEN("testfile", O_RDWR | O_CREAT, 0700);
+	fd = SAFE_OPEN("test_file", O_RDWR | O_CREAT, 0700);
 }
 
 static void cleanup(void)
@@ -58,8 +68,8 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.test_all = verify_write,
 	.setup = setup,
 	.cleanup = cleanup,
+	.test_all = verify_write,
 	.needs_tmpdir = 1,
 };
diff --git a/testcases/kernel/syscalls/write/write02.c b/testcases/kernel/syscalls/write/write02.c
deleted file mode 100644
index 4924422..0000000
--- a/testcases/kernel/syscalls/write/write02.c
+++ /dev/null
@@ -1,146 +0,0 @@
-/*
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
- */
-
-/*
- * NAME
- *	write02.c
- *
- * DESCRIPTION
- *	Basic functionality test: does the return from write match the count
- *	of the number of bytes written.
- *
- *
- * ALGORITHM
- *	Create a file and write some bytes out to it.
- *	Check the return count against the number returned.
- *
- * USAGE:  <for command-line>
- *      write02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *      where,  -c n : Run n copies concurrently.
- *              -e   : Turn on errno logging.
- *              -i n : Execute test n times.
- *              -I x : Execute test for x seconds.
- *              -P x : Pause for x seconds between iterations.
- *              -t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions
- *	None
- */
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <stdio.h>
-#include "test.h"
-
-char *TCID = "write02";
-int TST_TOTAL = 1;
-
-void cleanup(void);
-void setup(void);
-
-char pfiln[40] = "";
-
-int main(int argc, char **argv)
-{
-	int lc;
-
-	int cwrite;
-	int fild;
-	int iws;
-	int badcount = 0;
-	char pwbuf[BUFSIZ + 1];
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();		/* global setup for test */
-
-	/* The following loop checks looping state if -i option given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-//block1:
-		tst_resm(TINFO, "Block 1: test to see write() returns proper "
-			 "write count");
-
-		for (iws = 0; iws < BUFSIZ; iws++) {
-			pwbuf[iws] = 'A' + (iws % 26);
-		}
-		pwbuf[BUFSIZ] = '\n';
-
-		if ((fild = creat(pfiln, 0777)) == -1) {
-			tst_brkm(TBROK, cleanup, "Can't creat Xwrit");
-		}
-		for (iws = BUFSIZ; iws > 0; iws--) {
-			if ((cwrite = write(fild, pwbuf, iws)) != iws) {
-				badcount++;
-				tst_resm(TINFO, "bad write count");
-			}
-		}
-		if (badcount != 0) {
-			tst_resm(TFAIL, "write() FAILED to return proper cnt");
-		} else {
-			tst_resm(TPASS, "write() PASSED");
-		}
-		tst_resm(TINFO, "block 1 passed");
-		close(fild);
-	}
-	cleanup();
-	tst_exit();
-}
-
-/*
- * setup() - performs all ONE TIME setup for this test
- */
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	umask(0);
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -i option.
-	 * You want to make sure you do this before you create your temporary
-	 * directory.
-	 */
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	sprintf(pfiln, "write1.%d", getpid());
-}
-
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at completion or
- * premature exit.
- */
-void cleanup(void)
-{
-
-	unlink(pfiln);
-
-	tst_rmdir();
-}
-- 
1.8.3.1



