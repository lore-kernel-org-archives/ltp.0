From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Fri, 9 Jun 2017 18:56:00 +0800
Subject: [LTP] [PATCH 1/2] syscalls/open01: Cleanup && convert to new library
Message-ID: <1497005761-1215-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/open/open01.c | 153 +++++++++-----------------------
 1 file changed, 44 insertions(+), 109 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open01.c b/testcases/kernel/syscalls/open/open01.c
index adb59d4..45af9ca 100644
--- a/testcases/kernel/syscalls/open/open01.c
+++ b/testcases/kernel/syscalls/open/open01.c
@@ -1,6 +1,7 @@
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
+ *    07/2001 Ported by Wayne Boyer
+ *    06/2017 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -18,139 +19,73 @@
  */
 
 /*
- * NAME
- *	open01.c
- *
  * DESCRIPTION
  *	Open a file with oflag = O_CREAT set, does it set the sticky bit off?
- *
  *	Open "/tmp" with O_DIRECTORY, does it set the S_IFDIR bit on?
  *
  * ALGORITHM
  *	1. open a new file with O_CREAT, fstat.st_mode should not have the
  *	   01000 bit on. In Linux, the save text bit is *NOT* cleared.
- *
  *	2. open "/tmp" with O_DIRECTORY.  fstat.st_mode should have the
  *	   040000 bit on.
- *
- * USAGE:  <for command-line>
- *  open01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	None
  */
+
 #define _GNU_SOURCE		/* for O_DIRECTORY */
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <errno.h>
-#include "test.h"
+#include "tst_test.h"
 
-char *TCID = "open01";
-int TST_TOTAL = 1;
+#define TEST_FILE	"testfile"
+#define TEST_DIR	"/tmp"
 
-static char pfilname[40] = "";
+static int fd;
 
-static void cleanup(void);
-static void setup(void);
+static struct tcase {
+	char *filename;
+	int flag;
+	mode_t mode;
+	unsigned short tst_bit;
+	char *desc;
+} tcases[] = {
+	{TEST_FILE, O_RDWR | O_CREAT, 01444, S_ISVTX, "Sticky bit"},
+	{TEST_DIR, O_DIRECTORY, NULL, S_IFDIR, "Directory bit"}
+};
 
-int main(int ac, char **av)
+static void verify_open(unsigned int n)
 {
-	int lc;
-
-	struct stat statbuf;
-	int fildes;
-	unsigned short filmode;
-
-	/*
-	 * parse standard command line options
-	 */
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	/*
-	 * check looping state if -i option given on the command line
-	 */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;	/* reset tst_count while looping. */
-
-		/* test #1 */
-		TEST(open(pfilname, O_RDWR | O_CREAT, 01444));
-
-		fildes = TEST_RETURN;
-		if (fildes == -1) {
-			tst_resm(TFAIL, "Cannot open %s", pfilname);
-			continue;
-		}
-
-		fstat(fildes, &statbuf);
-		filmode = statbuf.st_mode;
-		if (!(filmode & S_ISVTX)) {
-			tst_resm(TFAIL, "Save test bit cleared, but "
-				 "should not have been");
-		} else {
-			tst_resm(TPASS, "Save text bit not cleared "
-				 "as expected");
-		}
-
-		/* test #2 */
-		TEST(open("/tmp", O_DIRECTORY));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "open of /tmp failed, errno: %d",
-				 TEST_ERRNO);
-			continue;
-		}
-
-		fstat(TEST_RETURN, &statbuf);
-		filmode = statbuf.st_mode;
-		if (!(filmode & S_IFDIR)) {
-			tst_resm(TFAIL, "directory bit cleared, but "
-				 "should not have been");
-		} else {
-			tst_resm(TPASS, "directory bit is set "
-				 "as expected");
-		}
-
-		/* clean up things is case we are looping */
-		if (close(fildes) == -1)
-			tst_brkm(TBROK, cleanup, "close #1 failed");
-
-		if (unlink(pfilname) == -1)
-			tst_brkm(TBROK, cleanup, "can't remove file");
-
-		if (close(TEST_RETURN) == -1)
-			tst_brkm(TBROK, cleanup, "close #2 failed");
+	struct tcase *tc = &tcases[n];
+	struct stat buf;
+
+	TEST(open(tc->filename, tc->flag, tc->mode));
+	fd = TEST_RETURN;
+	if (fd == -1) {
+		tst_res(TFAIL, "Cannot open a file");
+		return;
 	}
 
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	umask(0);
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	SAFE_FSTAT(fd, &buf);
+	if (!(buf.st_mode & tc->tst_bit))
+		tst_res(TFAIL, "%s is cleared unexpectedly", tc->desc);
+	else
+		tst_res(TPASS, "%s is set as expected", tc->desc);
 
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	sprintf(pfilname, "open3.%d", getpid());
+	SAFE_CLOSE(fd);
+	if (S_ISREG(buf.st_mode))
+		SAFE_UNLINK(tc->filename);
 }
 
 static void cleanup(void)
 {
-	tst_rmdir();
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.tid = "open01",
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1,
+	.cleanup = cleanup,
+	.test = verify_open,
+};
-- 
1.8.4.2



