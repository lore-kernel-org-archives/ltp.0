From: QI Fuli <fukuri.sai@gmail.com>
Date: Thu,  2 Sep 2021 20:58:48 +0900
Subject: [LTP] [PATCH 4/5] syscalls/dup2/dup204: Convert dup204 to the new
 API
In-Reply-To: <20210902115849.72382-1-qi.fuli@fujitsu.com>
References: <20210902115849.72382-1-qi.fuli@fujitsu.com>
Message-ID: <20210902115849.72382-5-qi.fuli@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup2/dup204.c | 135 ++++++------------------
 1 file changed, 35 insertions(+), 100 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup204.c b/testcases/kernel/syscalls/dup2/dup204.c
index a357bc17e..3fd6b0832 100644
--- a/testcases/kernel/syscalls/dup2/dup204.c
+++ b/testcases/kernel/syscalls/dup2/dup204.c
@@ -1,118 +1,25 @@
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
- *	dup204.c
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- * DESCRIPTION
+ * DESCRIPTION:
  *	Testcase to check the basic functionality of dup2(2).
- *
- * ALGORITHM
- *	attempt to call dup2() on read/write ends of a pipe
- *
- * USAGE:  <for command-line>
- *  dup204 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * RESTRICTION
- *	NONE
  */
 
 #ifndef _GNU_SOURCE
 #define _GNU_SOURCE
 #endif
-#include <sys/types.h>
-#include <fcntl.h>
-#include <sys/stat.h>
-#include <errno.h>
-#include <signal.h>
-#include <string.h>
-#include "test.h"
-#include "safe_macros.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "dup204";
-int TST_TOTAL = 2;
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 
 int fd[2];
 int nfd[2];
 
-int main(int ac, char **av)
-{
-	int lc;
-	int i;
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
-			TEST(dup2(fd[i], nfd[i]));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL, "call failed unexpectedly");
-				continue;
-			}
-
-			SAFE_FSTAT(cleanup, fd[i], &oldbuf);
-			SAFE_FSTAT(cleanup, nfd[i], &newbuf);
-
-			if (oldbuf.st_ino != newbuf.st_ino)
-				tst_resm(TFAIL, "original and duped "
-					 "inodes do not match");
-			else
-				tst_resm(TPASS, "original and duped "
-					 "inodes are the same");
-
-			SAFE_CLOSE(cleanup, TEST_RETURN);
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
 void setup(void)
 {
 	fd[0] = -1;
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	SAFE_PIPE(cleanup, fd);
+	SAFE_PIPE(fd);
 }
 
 void cleanup(void)
@@ -123,6 +30,34 @@ void cleanup(void)
 		close(fd[i]);
 		close(nfd[i]);
 	}
+}
+
+static void run(unsigned int i)
+{
+	struct stat oldbuf, newbuf;
+
+	TEST(dup2(fd[i], nfd[i]));
 
-	tst_rmdir();
+	if (TST_RET == -1) {
+		tst_res(TFAIL, "call failed unexpectedly");
+		return;
+	}
+
+	SAFE_FSTAT(fd[i], &oldbuf);
+	SAFE_FSTAT(nfd[i], &newbuf);
+
+	if (oldbuf.st_ino != newbuf.st_ino)
+		tst_res(TFAIL, "original and duped inodes do not match");
+	else
+		tst_res(TPASS, "original and duped inodes are the same");
+
+	SAFE_CLOSE(TST_RET);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.tcnt = 2,
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.31.1

