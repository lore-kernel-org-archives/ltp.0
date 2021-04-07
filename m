From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Wed, 7 Apr 2021 16:14:15 +0800
Subject: [LTP] [PATCH] syscalls/getdtablesize: Update to the new api
Message-ID: <20210407081415.8353-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1)use some safe macros
2)open a temporary file instead of /etc/hosts since it might be not exist
3)cleanup all of the opened fd

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 .../syscalls/getdtablesize/getdtablesize01.c  | 161 ++++++++----------
 1 file changed, 73 insertions(+), 88 deletions(-)

diff --git a/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c b/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
index d25cac261..f16c54a68 100644
--- a/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
+++ b/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
@@ -1,119 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2005
  * Copyright (c) Wipro Technologies Ltd, 2005.  All Rights Reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
+ * AUTHOR: Prashant P Yendigeri <prashant.yendigeri@wipro.com>
+ *	   Robbie Williamson <robbiew@us.ibm.com>
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER   : getdtablesize01
- *
- *    EXECUTED BY       : root / superuser
- *
- *    TEST TITLE        : Basic tests for getdtablesize01(2)
- *
- *    TEST CASE TOTAL   : 1
- *
- *    AUTHOR            : Prashant P Yendigeri
- *                        <prashant.yendigeri@wipro.com>
- *                        Robbie Williamson
- *                        <robbiew@us.ibm.com>
- *
- *    DESCRIPTION
- *      This is a Phase I test for the getdtablesize01(2) system call.
- *      It is intended to provide a limited exposure of the system call.
+
+/*\
+ * [Description]
+ * Test getdtablesize() returns the maximum number of files a process can
+ * have open, one more than the largest possible value for a file descriptor.
  *
- **********************************************************/
+ * [Algorithm]
+ * 1. Check the return value of getdtablesize() is equal to _SC_OPEN_MAX or
+ * the current limit on the number of open files per process.
+ * 2. Open the maximum allowed number of file descriptors and then check if
+ * it is equal to the return value of getdtablesize() - 1.
+ */

-#include <stdio.h>
-#include <errno.h>
-#include <sys/types.h>
+#include <stdlib.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <sys/time.h>
 #include <sys/resource.h>
 #include <unistd.h>
-#include "test.h"
+#include "tst_test.h"

-void setup();
-void cleanup();
+#define TESTFILE "getdtablesize01_testfile"
+#define FILE_OPEN_MAX SAFE_SYSCONF(_SC_OPEN_MAX)

-char *TCID = "getdtablesize01";
-int TST_TOTAL = 1;
+static int *fd, count;

-int main(void)
+static void run(void)
 {
-	int table_size, fd = 0, count = 0;
+	int temp_fd;
 	int max_val_opfiles;
 	struct rlimit rlp;

-	setup();
-	table_size = getdtablesize();
-	getrlimit(RLIMIT_NOFILE, &rlp);
-	max_val_opfiles = (rlim_t) rlp.rlim_cur;
-
-	tst_resm(TINFO,
-		 "Maximum number of files a process can have opened is %d",
-		 table_size);
-	tst_resm(TINFO,
-		 "Checking with the value returned by getrlimit...RLIMIT_NOFILE");
-
-	if (table_size == max_val_opfiles)
-		tst_resm(TPASS, "got correct dtablesize, value is %d",
-			 max_val_opfiles);
-	else {
-		tst_resm(TFAIL, "got incorrect table size, value is %d",
-			 max_val_opfiles);
-		cleanup();
-	}
+	TEST(getdtablesize());
+	tst_res(TINFO,
+		"Maximum number of files a process can have opened is %d",
+		TST_RET);

-	tst_resm(TINFO,
-		 "Checking Max num of files that can be opened by a process.Should be: RLIMIT_NOFILE - 1");
-	for (;;) {
-		fd = open("/etc/hosts", O_RDONLY);
+	tst_res(TINFO, "Checking with the value returned by getrlimit");

-		if (fd == -1)
-			break;
-		count = fd;
+	if (getrlimit(RLIMIT_NOFILE, &rlp))
+		max_val_opfiles = FILE_OPEN_MAX;
+	else
+		max_val_opfiles = (rlim_t)rlp.rlim_cur;

-#ifdef DEBUG
-		printf("Opened file num %d\n", fd);
-#endif
-	}
+	if (TST_RET == max_val_opfiles)
+		tst_res(TPASS, "got correct dtablesize, value is %d "
+			"max_val_opfiles value is %d",
+			TST_RET, max_val_opfiles);
+	else
+		tst_res(TFAIL, "got incorrect dtablesize, value is %d"
+			 "max_val_opfiles value is %d",
+			 TST_RET, max_val_opfiles);

-//Now the max files opened should be RLIMIT_NOFILE - 1 , why ? read getdtablesize man page
+	tst_res(TINFO,
+		"Checking Max num of files that can be opened by a process."
+		"Should be: RLIMIT_NOFILE - 1");

-	if (count > 0)
-		close(count);
-	if (count == (max_val_opfiles - 1))
-		tst_resm(TPASS, "%d = %d", count, (max_val_opfiles - 1));
-	else if (fd < 0 && errno == ENFILE)
-		tst_brkm(TCONF, cleanup, "Reached maximum number of open files for the system");
-	else
-		tst_resm(TFAIL, "%d != %d", count, (max_val_opfiles - 1));
+	while (1) {
+		temp_fd = open(TESTFILE, O_CREAT | O_RDONLY, 0755);
+		if (temp_fd == -1)
+			break;
+		fd[count++] = temp_fd;
+	}

-	cleanup();
-	tst_exit();
+	if (fd[count - 1] == (max_val_opfiles - 1))
+		tst_res(TPASS,
+			"max open file fd is correct, %d = %d",
+			fd[count - 1], (max_val_opfiles - 1));
+	else if (temp_fd < 0 && errno == ENFILE)
+		tst_brk(TCONF,
+			"Reached maximum number of open files for the system");
+	else
+		tst_res(TFAIL | TERRNO, "%d != %d", fd[count - 1], (max_val_opfiles - 1));
 }

-void setup(void)
+static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	fd = SAFE_MALLOC(FILE_OPEN_MAX * sizeof(int));
 }

-void cleanup(void)
+static void cleanup(void)
 {
+	int i;
+	for (i = 0; i < count; i++)
+		SAFE_CLOSE(fd[i]);
+
+	free(fd);
+	fd = NULL;
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};
+
--
2.17.1

