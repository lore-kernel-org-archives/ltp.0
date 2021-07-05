From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 5 Jul 2021 15:59:03 +0800
Subject: [LTP] [PATCH 2/2 v2] fork08: Rewrite the test to a proper
 synchronization
In-Reply-To: <20210705075903.98692-1-xieziyao@huawei.com>
References: <20210705075903.98692-1-xieziyao@huawei.com>
Message-ID: <20210705075903.98692-3-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Rewrite fork08 to a proper synchronization with the new API.

Fixes: #774
Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
v1->v2:
1. Write a new test as follows,
* Parent writes 1 bytes (for example 'a') to a file in setup()
* Parent opens a file descriptor for reading pointing to that file
* Parent forks a child to close fd
* Parent forks another child to read a byte from the file checks that the byte is 'a' then exits
* Parent waits the all the children
* Parent checks that the end of file is reached
2. Use file descriptors instead of the FILE.

 testcases/kernel/syscalls/fork/fork08.c | 200 ++++++------------------
 1 file changed, 49 insertions(+), 151 deletions(-)

diff --git a/testcases/kernel/syscalls/fork/fork08.c b/testcases/kernel/syscalls/fork/fork08.c
index 1123f7473..9e30ffe3d 100644
--- a/testcases/kernel/syscalls/fork/fork08.c
+++ b/testcases/kernel/syscalls/fork/fork08.c
@@ -1,172 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
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
- *
- * NAME
- *	fork08.c
- *
- * DESCRIPTION
- *	Check if the parent's file descriptors are affected by
- *	actions in the child; they should not be.
- *
- * ALGORITHM
- *	Parent opens a file.
- *	Forks a child which closes a file.
- *	Parent forks a second child which attempts to read the (closed)
- *	file.
- *
- * USAGE
- *	fork08
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+ * Copyright (c) International Business Machines  Corp., 2001
+ * 07/2001 Ported by Wayne Boyer
+ * Copyright (c) 2021 Xie Ziyao <xieziyao@huawei.com>
+ */
+
+/*\
+ * [Description]
  *
- * RESTRICTIONS
- *	None
+ * Check that the parent's file descriptors will not be affected by actions
+ * in the child.
  */

-#include <sys/types.h>
-#include <sys/wait.h>
-#include <sys/stat.h>
-#include <stdio.h>
-#include "test.h"
+#include <stdlib.h>

-char *TCID = "fork08";
-int TST_TOTAL = 1;
+#include "tst_test.h"

-static void setup(void);
-static void cleanup(void);
+#define TESTFILE "testfile_fork08"

-static char pbuf[10];
-static char fnamebuf[40];
+static int fd;
+static char buf;

-int main(int ac, char **av)
+static void run(void)
 {
-	int status, count, forks, pid1;
-	int ch_r_stat;
-	FILE *rea, *writ;
-
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	int ret;

-		writ = fopen(fnamebuf, "w");
-		if (writ == NULL)
-			tst_resm(TFAIL, "failed to fopen file for write");
-		rea = fopen(fnamebuf, "r");
-		if (rea == NULL)
-			tst_resm(TFAIL, "failed to fopen file for read");
-
-		fprintf(writ, "abcdefghijklmnopqrstuv");
-		fflush(writ);
-		sleep(1);
-
-		if ((getc(rea)) != 'a')
-			tst_resm(TFAIL, "getc from read side was confused");
-
-		forks = 0;
-
-forkone:
-		++forks;
-
-		pid1 = fork();
-		if (pid1 != 0) {
-			tst_resm(TINFO, "parent forksval: %d", forks);
-
-			if ((pid1 != (-1)) && (forks < 2))
-				goto forkone;
-			else if (pid1 < 0)
-				tst_resm(TINFO, "Fork failed");
-		} else {	/* child */
-			/*
-			 * If first child close the file descriptor for the
-			 * read stream
-			 */
-			if (forks == 1) {
-				if ((fclose(rea)) == -1) {
-					tst_resm(TFAIL, "error in first child"
-						 " closing fildes");
-				}
-				_exit(0);
-			}
-
-			/*
-			 * If second child attempt to read from the file
-			 */
-			else if (forks == 2) {
-				ch_r_stat = getc(rea);
-				tst_resm(TINFO, "second child got char: %c",
-					 ch_r_stat);
-				if (ch_r_stat == 'b') {
-					tst_resm(TPASS, "Test passed in child "
-						 "number %d", forks);
-					exit(0);
-				} else if (ch_r_stat == EOF) {
-					tst_resm(TFAIL, "Second child got "
-						 "EOF");
-					exit(-1);
-				} else {
-					tst_resm(TFAIL, "test failed in child "
-						 "no %d", forks);
-					exit(-1);
-				}
-			} else {	/* end of second child */
-				tst_resm(TINFO, "forksnumber: %d", forks);
-				exit(3);
-			}
-		}
-
-		for (count = 0; count <= forks; count++) {
-			wait(&status);
-			tst_resm(TINFO, "exit status of wait "
-				 " expected 0 got %d", status);
-			status >>= 8;
-			if (status == 0)
-				tst_resm(TPASS, "parent test PASSED");
-			else
-				tst_resm(TFAIL, "parent test FAILED");
-		}
-
-		tst_resm(TINFO, "Number of processes forked is %d", forks);
-		fclose(rea);
-		fclose(writ);
+	fd = SAFE_OPEN(TESTFILE, O_RDONLY);
+	if (!SAFE_FORK()) {
+		SAFE_CLOSE(fd);
+		exit(0);
+	}
+	tst_reap_children();
+
+	if (!SAFE_FORK()) {
+		SAFE_READ(1, fd, &buf, 1);
+		if (buf != 'a')
+			tst_res(TFAIL, "%6d: read '%c' instead of 'a'",
+				getpid(), buf);
+		exit(0);
 	}
+	tst_reap_children();

-	cleanup();
-	tst_exit();
+	ret = read(fd, &buf, 1);
+	if (ret == 0)
+		tst_res(TPASS, "read the end of file correctly");
+	else
+		tst_res(TFAIL, "read() returns %d, expected 0", ret);
+
+	SAFE_CLOSE(fd);
 }

 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	umask(0);
-	TEST_PAUSE;
-	tst_tmpdir();
-
-	strcpy(fnamebuf, "fork07.");
-	sprintf(pbuf, "%d", getpid());
-	strcat(fnamebuf, pbuf);
+	tst_fill_file(TESTFILE, 'a', 1, 1);
 }

 static void cleanup(void)
 {
-	tst_rmdir();
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+	.cleanup = cleanup,
+	.setup = setup,
+	.test_all = run,
+};
--
2.17.1

