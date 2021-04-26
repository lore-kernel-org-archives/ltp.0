From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 26 Apr 2021 20:52:22 +0800
Subject: [LTP] [PATCH 1/3 v2] syscalls/close: Convert close01 to the new API
In-Reply-To: <20210426125224.150268-1-xieziyao@huawei.com>
References: <20210426125224.150268-1-xieziyao@huawei.com>
Message-ID: <20210426125224.150268-2-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Cleanup and convert close01 to the new API;
2. Add SAFE_CLOSE() to the file descriptor.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
v1->v2:
1. Cleanup with TST_EXP_PASS();
2. Add SAFE_CLOSE() to the file descriptor for a pipe.

 testcases/kernel/syscalls/close/close01.c | 134 +++++++---------------
 1 file changed, 40 insertions(+), 94 deletions(-)

diff --git a/testcases/kernel/syscalls/close/close01.c b/testcases/kernel/syscalls/close/close01.c
index c734ff7d2..759c43af0 100644
--- a/testcases/kernel/syscalls/close/close01.c
+++ b/testcases/kernel/syscalls/close/close01.c
@@ -1,124 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 Ported by Wayne Boyer
+ * 07/2001 Ported by Wayne Boyer
+ */
+
+/*\
+ * [Description]
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
+ * Basic test for the close() syscall.
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
+ * [Description]
  *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- * DESCRIPTION
- *	Test that closing a regular file and a pipe works correctly
+ * Test that closing a regular file and a pipe works correctly.
  */

 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <sys/stat.h>
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"

-void cleanup(void);
-void setup(void);
+#define FILENAME "close01_testfile"

-char *TCID = "close01";
-int TST_TOTAL = 2;
+int fild, newfd, pipefildes[2];

-char fname[40] = "";
+static void setup_file(void)
+{
+	newfd = SAFE_DUP(fild);
+}

-int fild, newfd, pipefildes[2];
+static void setup_pipe(void)
+{
+	SAFE_PIPE(pipefildes);
+	SAFE_CLOSE(pipefildes[1]);
+}

 struct test_case_t {
 	int *fd;
 	char *type;
-} TC[] = {
-	/* file descriptor for a regular file */
-	{
-	&newfd, "file"},
-	    /* file descriptor for a pipe */
-	{
-	&pipefildes[0], "pipe"}
+	void (*setupfunc) ();
+} tc[] = {
+	{&newfd, "file", setup_file},
+	{&pipefildes[0], "pipe", setup_pipe}
 };

-int main(int ac, char **av)
+static void run(unsigned int i)
 {
-
-	int i;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		if ((fild = creat(fname, 0777)) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "can't open file %s",
-				 fname);
-
-		if ((newfd = dup(fild)) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "can't dup the file des");
-
-		SAFE_PIPE(cleanup, pipefildes);
-
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			TEST(close(*TC[i].fd));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL, "call failed unexpectedly");
-				continue;
-			}
-
-			if (close(*TC[i].fd) == -1) {
-				tst_resm(TPASS, "%s appears closed",
-					 TC[i].type);
-			} else {
-				tst_resm(TFAIL, "%s close succeeded on"
-					 "second attempt", TC[i].type);
-			}
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
+	tc[i].setupfunc();
+	TST_EXP_PASS(close(*tc[i].fd), "close a %s", tc[i].type);
 }

-void setup(void)
+static void setup(void)
 {
-	int mypid;
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
 	umask(0);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	mypid = getpid();
-	sprintf(fname, "fname.%d", mypid);
+	fild = SAFE_CREAT(FILENAME, 0777);
 }

-void cleanup(void)
+static void cleanup(void)
 {
-	close(fild);
-
-	tst_rmdir();
-
+	SAFE_CLOSE(fild);
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tc),
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run,
+};
--
2.17.1

