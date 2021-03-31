From: Xie Ziyao <xieziyao@huawei.com>
Date: Wed, 31 Mar 2021 15:09:12 +0800
Subject: [LTP] [PATCH 1/3] syscalls/close: Convert close01 to the new API
In-Reply-To: <20210331070914.4401-1-xieziyao@huawei.com>
References: <20210331070914.4401-1-xieziyao@huawei.com>
Message-ID: <20210331070914.4401-2-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

convert close01 to the new API

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/close/close01.c | 122 +++++++---------------
 1 file changed, 36 insertions(+), 86 deletions(-)

diff --git a/testcases/kernel/syscalls/close/close01.c b/testcases/kernel/syscalls/close/close01.c
index c734ff7d2..fc753f414 100644
--- a/testcases/kernel/syscalls/close/close01.c
+++ b/testcases/kernel/syscalls/close/close01.c
@@ -1,124 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 Ported by Wayne Boyer
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * 07/2001 Ported by Wayne Boyer
  */

-/*
- * DESCRIPTION
- *	Test that closing a regular file and a pipe works correctly
+/*\
+ * [Description]
+ *
+ * Test that closing a regular file and a pipe works correctly
  */

 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <sys/stat.h>
-#include "test.h"
-#include "safe_macros.h"
-
-void cleanup(void);
-void setup(void);

-char *TCID = "close01";
-int TST_TOTAL = 2;
+#include "tst_test.h"
+#include "tst_safe_macros.h"

 char fname[40] = "";
-
 int fild, newfd, pipefildes[2];

 struct test_case_t {
 	int *fd;
 	char *type;
-} TC[] = {
+} tc[] = {
 	/* file descriptor for a regular file */
-	{
-	&newfd, "file"},
-	    /* file descriptor for a pipe */
-	{
-	&pipefildes[0], "pipe"}
+	{&newfd, "file"},
+	/* file descriptor for a pipe */
+	{&pipefildes[0], "pipe"}
 };

-int main(int ac, char **av)
+static void run(unsigned int i)
 {
+	fild = SAFE_CREAT(fname, 0777);
+	newfd = SAFE_DUP(fild);
+	SAFE_PIPE(pipefildes);

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
+	TEST(close(*tc[i].fd));

-		SAFE_PIPE(cleanup, pipefildes);
+	if (TST_RET == -1)
+		tst_res(TFAIL, "call failed unexpectedly");

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
+	if (close(*tc[i].fd) == -1)
+		tst_res(TPASS, "%s appears closed", tc[i].type);
+	else
+		tst_res(TFAIL, "%s close succeeded on second attempt",
+			tc[i].type);
 }

-void setup(void)
+static void setup(void)
 {
 	int mypid;

-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
 	umask(0);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
 	mypid = getpid();
+
 	sprintf(fname, "fname.%d", mypid);
 }

-void cleanup(void)
+static void cleanup(void)
 {
-	close(fild);
+	SAFE_CLOSE(fild);
+}

-	tst_rmdir();
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tc),
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run,
+};

-}
--
2.17.1

