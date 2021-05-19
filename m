From: Xie Ziyao <xieziyao@huawei.com>
Date: Wed, 19 May 2021 16:46:54 +0800
Subject: [LTP] [PATCH 1/2] syscalls/sendfile: Convert sendfile08 to the new
 API
In-Reply-To: <20210519084655.52780-1-xieziyao@huawei.com>
References: <20210519084655.52780-1-xieziyao@huawei.com>
Message-ID: <20210519084655.52780-2-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Convert sendfile08 to the new API.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 .../kernel/syscalls/sendfile/sendfile08.c     | 138 ++++++------------
 1 file changed, 46 insertions(+), 92 deletions(-)

diff --git a/testcases/kernel/syscalls/sendfile/sendfile08.c b/testcases/kernel/syscalls/sendfile/sendfile08.c
index a29632712..868a610e4 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile08.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile08.c
@@ -1,123 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2012 Red Hat, Inc.
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
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */

-/*
+/*\
+ * [Description]
+ *
  * Bug in the splice code has caused the file position on the write side
  * of the sendfile system call to be incorrectly set to the read side file
  * position. This can result in the data being written to an incorrect offset.
  *
- * This is a regression test for kernel commit
- * 2cb4b05e7647891b46b91c07c9a60304803d1688
+ * This is a regression test for kernel commit 2cb4b05e7647.
  */

-#include <sys/sendfile.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <fcntl.h>
 #include <stdio.h>
+#include <fcntl.h>
 #include <string.h>
 #include <unistd.h>
-#include "test.h"
-#include "safe_macros.h"
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/sendfile.h>
+
+#include "tst_test.h"

-#define TEST_MSG_IN "world"
-#define TEST_MSG_OUT "hello"
-#define TEST_MSG_ALL (TEST_MSG_OUT TEST_MSG_IN)
+#define IN_FILE		"in_file"
+#define OUT_FILE	"out_file"

-TCID_DEFINE(sendfile08);
-int TST_TOTAL = 1;
+#define TEST_MSG_IN	"world"
+#define TEST_MSG_OUT	"hello"
+#define TEST_MSG_ALL	(TEST_MSG_OUT TEST_MSG_IN)

 static int in_fd;
 static int out_fd;
-static char *in_file = "sendfile08.in";
-static char *out_file = "sendfile08.out";

-static void cleanup(void);
-static void setup(void);
-
-int main(int argc, char *argv[])
+static void run(void)
 {
-	int lc;
-	int ret;
-	char buf[BUFSIZ];
+	TEST(sendfile(out_fd, in_fd, NULL, strlen(TEST_MSG_IN)));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sendfile() failed");

-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		TEST(sendfile(out_fd, in_fd, NULL, strlen(TEST_MSG_IN)));
-
-		if (TEST_RETURN == -1)
-			tst_brkm(TBROK | TTERRNO, cleanup, "sendfile() failed");
-
-		ret = SAFE_LSEEK(cleanup, out_fd, 0, SEEK_SET);
-		ret = read(out_fd, buf, BUFSIZ);
-		if (ret == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "read %s failed",
-				 out_file);
-
-		if (!strncmp(buf, TEST_MSG_ALL, strlen(TEST_MSG_ALL)))
-			tst_resm(TPASS, "sendfile(2) copies data correctly");
-		else
-			tst_resm(TFAIL, "sendfile(2) copies data incorrectly."
-				 " Expect \"%s%s\", got \"%s\"", TEST_MSG_OUT,
-				 TEST_MSG_IN, buf);
-	}
-
-	cleanup();
-	tst_exit();
+	char buf[BUFSIZ];
+	SAFE_LSEEK(out_fd, 0, SEEK_SET);
+	SAFE_READ(0, out_fd, buf, BUFSIZ);
+
+	if (!strncmp(buf, TEST_MSG_ALL, strlen(TEST_MSG_ALL)))
+		tst_res(TPASS, "sendfile(2) copies data correctly");
+	else
+		tst_res(TFAIL, "sendfile(2) copies data incorrectly. "
+			       "Expect \"%s%s\", got \"%s\"",
+			TEST_MSG_OUT, TEST_MSG_IN, buf);
 }

 static void setup(void)
 {
-	int ret;
-
-	/* Disable test if the version of the kernel is less than 2.6.33 */
-	if ((tst_kvercmp(2, 6, 33)) < 0) {
-		tst_resm(TCONF, "The out_fd must be socket before kernel");
-		tst_brkm(TCONF, NULL, "2.6.33, see kernel commit cc56f7d");
-	}
+	in_fd = SAFE_CREAT(IN_FILE, 0700);
+	SAFE_WRITE(1, in_fd, TEST_MSG_IN, strlen(TEST_MSG_IN));
+	SAFE_CLOSE(in_fd);
+	in_fd = SAFE_OPEN(IN_FILE, O_RDONLY);

-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	in_fd = SAFE_CREAT(cleanup, in_file, 0700);
-
-	ret = write(in_fd, TEST_MSG_IN, strlen(TEST_MSG_IN));
-	if (ret == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Write %s failed", in_file);
-	close(in_fd);
-
-	in_fd = SAFE_OPEN(cleanup, in_file, O_RDONLY);
-	out_fd = SAFE_OPEN(cleanup, out_file, O_TRUNC | O_CREAT | O_RDWR, 0777);
-
-	ret = write(out_fd, TEST_MSG_OUT, strlen(TEST_MSG_OUT));
-	if (ret == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Write %s failed", out_file);
+	out_fd = SAFE_OPEN(OUT_FILE, O_TRUNC | O_CREAT | O_RDWR, 0777);
+	SAFE_WRITE(1, out_fd, TEST_MSG_OUT, strlen(TEST_MSG_OUT));
 }

 static void cleanup(void)
 {
-	close(out_fd);
-	close(in_fd);
-
-	tst_rmdir();
+	SAFE_CLOSE(in_fd);
+	SAFE_CLOSE(out_fd);
 }
+
+static struct tst_test test = {
+	.min_kver = "2.6.33",
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+};
--
2.17.1

