From: QI Fuli <fukuri.sai@gmail.com>
Date: Thu,  2 Sep 2021 20:58:46 +0900
Subject: [LTP] [PATCH 2/5] syscalls/dup2/dup202: Convert dup202 to the new
 API
In-Reply-To: <20210902115849.72382-1-qi.fuli@fujitsu.com>
References: <20210902115849.72382-1-qi.fuli@fujitsu.com>
Message-ID: <20210902115849.72382-3-qi.fuli@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup2/dup202.c | 175 +++++++-----------------
 1 file changed, 48 insertions(+), 127 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup202.c b/testcases/kernel/syscalls/dup2/dup202.c
index c87769fa9..16f8b2add 100644
--- a/testcases/kernel/syscalls/dup2/dup202.c
+++ b/testcases/kernel/syscalls/dup2/dup202.c
@@ -1,65 +1,22 @@
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
+// SPDX-License-Identifier: GPL-2.0-or-later
 
 /*
- * NAME
- *	dup202.c
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- * DESCRIPTION
+ * DESCRIPTION:
  *	Is the access mode the same for both file descriptors?
  *		0: read only ?	"0444"
  *		1: write only ? "0222"
  *		2: read/write ? "0666"
  *
- * ALGORITHM
- *	Creat a file with each access mode; dup each file descriptor;
- *	stat each file descriptor and compare modes of each pair
- *
- * USAGE:  <for command-line>
- *  dup202 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
+ * HISTORY:
  *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	None
  */
 
-#include <sys/types.h>
-#include <sys/stat.h>
 #include <errno.h>
-#include <fcntl.h>
 #include <stdio.h>
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "dup202";
-int TST_TOTAL = 3;
-
-void setup(void);
-void cleanup(void);
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 
 char testfile[40];
 int fail;
@@ -68,100 +25,64 @@ int newfd;
 /* set these to a known index into our local file descriptor table */
 int duprdo = 10, dupwro = 20, duprdwr = 30;
 
-struct test_case_t {
+static struct tcase {
 	int *nfd;
 	mode_t mode;
-} TC[] = {
+} tcases[]= {
 	/* The first test creat(es) a file with mode 0444 */
-	{
-	&duprdo, (S_IRUSR | S_IRGRP | S_IROTH)},
+	{&duprdo, (S_IRUSR | S_IRGRP | S_IROTH)},
 	    /* The second test creat(es) a file with mode 0222 */
-	{
-	&dupwro, (S_IWUSR | S_IWGRP | S_IWOTH)},
+	{&dupwro, (S_IWUSR | S_IWGRP | S_IWOTH)},
 	    /* The third test creat(es) a file with mode 0666 */
-	{
-	&duprdwr,
-		    (S_IRUSR | S_IRGRP | S_IROTH | S_IWUSR | S_IWGRP | S_IWOTH)}
+	{&duprdwr, (S_IRUSR | S_IRGRP | S_IROTH | S_IWUSR | S_IWGRP | S_IWOTH)},
 };
 
-int main(int ac, char **av)
+void setup(void)
 {
-	int lc;
-	int i, ofd;
-	struct stat oldbuf, newbuf;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/* loop through the test cases */
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			if ((ofd = creat(testfile, TC[i].mode)) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "creat failed");
-
-			TEST(dup2(ofd, *TC[i].nfd));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL | TTERRNO,
-					 "call failed unexpectedly");
-				continue;
-			}
+	(void)umask(0);
+	sprintf(testfile, "dup202.%d", getpid());
+}
 
-			/* stat the original file */
-			SAFE_FSTAT(cleanup, ofd, &oldbuf);
+static void run(unsigned int i)
+{
+	int ofd;
+	struct stat oldbuf, newbuf;
+	struct tcase *tc = tcases + i;
 
-			/* stat the duped file */
-			SAFE_FSTAT(cleanup, *TC[i].nfd, &newbuf);
+	ofd = creat(testfile, tc->mode);
+	if (ofd == -1)
+		tst_brk(TBROK | TERRNO, "creat failed");
 
-			if (oldbuf.st_mode != newbuf.st_mode)
-				tst_resm(TFAIL, "original and dup "
-					 "modes do not match");
-			else
-				tst_resm(TPASS, "fstat shows new and "
-					 "old modes are the same");
+	TEST(dup2(ofd, *tc->nfd));
 
-			/* remove the file so that we can use it again */
-			if (close(*TC[i].nfd) == -1)
-				perror("close failed");
-			if (close(ofd) == -1)
-				perror("close failed");
-			if (unlink(testfile) == -1)
-				perror("unlink failed");
-		}
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "call failed unexpectedly");
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
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	/* stat the original file */
+	SAFE_FSTAT(ofd, &oldbuf);
 
-	TEST_PAUSE;
+	/* stat the duped file */
+	SAFE_FSTAT(*tc->nfd, &newbuf);
 
-	tst_tmpdir();
+	if (oldbuf.st_mode != newbuf.st_mode)
+		tst_res(TFAIL, "original and dup modes do not match");
+	else
+		tst_res(TPASS, "fstat shows new and old modes are the same");
 
-	(void)umask(0);
-
-	sprintf(testfile, "dup202.%d", getpid());
+	/* remove the file so that we can use it again */
+	if (close(*tc->nfd) == -1)
+		perror("close failed");
+	if (close(ofd) == -1)
+		perror("close failed");
+	if (unlink(testfile) == -1)
+		perror("unlink failed");
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+};
-- 
2.31.1

