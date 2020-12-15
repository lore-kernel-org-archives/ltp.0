From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 15 Dec 2020 10:25:34 +0100
Subject: [LTP] [PATCH] fs/lftest: Convert to new library
Message-ID: <20201215092534.757347-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Additonal changes:
 - Use temp directory instead of working dir
 - 100 buffers is teh default  now and can be changed using -n
 - Removed some useless output (nseek, nwrite was always bufnum)

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 runtest/fs                          |   2 +-
 testcases/kernel/fs/lftest/lftest.c | 111 ++++++++++++----------------
 2 files changed, 49 insertions(+), 64 deletions(-)

diff --git a/runtest/fs b/runtest/fs
index 5892e9fda..17b1415eb 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -58,7 +58,7 @@ ftest06 ftest06
 ftest07 ftest07
 ftest08 ftest08
 
-lftest01	lftest 100
+lftest01	lftest
 writetest01	writetest
 
 #Also run the fs_di (Data Integrity tests)
diff --git a/testcases/kernel/fs/lftest/lftest.c b/testcases/kernel/fs/lftest/lftest.c
index 9439b4cf0..7ce7df84a 100644
--- a/testcases/kernel/fs/lftest/lftest.c
+++ b/testcases/kernel/fs/lftest/lftest.c
@@ -1,31 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) 2001, International Business Machines  Corp.
+ * Copyright (c) 2020, Joerg Vehlow <joerg.vehlow@aox-tech.de>
  *
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
- *  FILE        : lftest.c
- *  DESCRIPTION : The purpose of this test is to verify the file size limitations of a filesystem.
- *                It writes one buffer at a time and lseeks from the beginning of the file to the
- *                end of the last write position.  The intent is to test lseek64.
- *  HISTORY:
- *           06/19/01  :  Written by Jeff Martin(martinjn@us.ibm.com) to test large files on jfs.
- *           07/12/01  :  Added timing.
- *
+ * The purpose of this test is to verify the file size limitations
+ * of a filesystem. It writes one buffer at a time and lseeks from
+ * the beginning of the file to the end of the last write position.
+ * The intent is to test lseek64.
  */
 
 #include <stdio.h>
@@ -36,59 +17,63 @@
 #include <fcntl.h>
 #include <time.h>
 
-/* set write buffer size to whatever floats your boat.  I usually use 1M */
-#define BSIZE 1048576L
-char buf[BSIZE];
+#include "tst_test.h"
 
-int main(int argc, char *argv[])
-{
-	off_t i;
-	long bufnum;
-	off_t fd;
-	time_t time1, time2;
-	int writecnt = 0, seekcnt = 0, diff;
+static char *str_bufnum;
+static int bufnum = 100;
+static char buf[TST_MB];
 
-	time1 = time(NULL);
+static void setup(void)
+{
+	unsigned int i;
 
-	if (argc != 2 || atoi(argv[1]) < 1) {
-		printf("usage:<# of %ld buffers to write>\n", BSIZE);
-		exit(3);
+	if (str_bufnum) {
+		if (tst_parse_int(str_bufnum ,&bufnum, 0, INT_MAX)) {
+			tst_brk(TBROK, "Invalid buffer count '%s'", str_bufnum);
+		}
 	}
-	bufnum = strtol(argv[1], NULL, 0);
-	printf("Started building a %lu megabyte file @ %s\n", bufnum,
-	       asctime(localtime(&time1)));
 
 	buf[0] = 'A';
-	for (i = 1; i < BSIZE; i++)
+	for (i = 1; i < ARRAY_SIZE(buf) - 1; i++)
 		buf[i] = '0';
-	buf[BSIZE - 1] = 'Z';
+	buf[ARRAY_SIZE(buf) - 1] = 'Z';
+}
+
+static void run(void)
+{
+	time_t time1, time2;
+	int i, fd, diff;
+
+	time1 = time(NULL);
+	tst_res(TINFO, "Started building a %d megabyte file", bufnum);
 
 	if ((fd = creat("large_file", 0755)) == -1)
-		perror("lftest: ");
+		tst_brk(TBROK | TERRNO, "creat failed");
 
 	for (i = 0; i < bufnum; i++) {
-		if (write(fd, buf, BSIZE) == -1)
-			return -1;
-		else {
-			printf(".");
-			writecnt++;
-			fflush(stdout);
+		if (write(fd, buf, sizeof(buf)) == -1) {
+			tst_brk(TFAIL | TERRNO, "write failed");
 		}
 		fsync(fd);
-		if (lseek(fd, (i + 1) * BSIZE, 0) == -1)
-			return -1;
-		else
-			seekcnt++;
+		if (lseek(fd, (i + 1) * sizeof(buf), 0) == -1)
+			tst_brk(TFAIL | TERRNO, "lseek failed");
 	}
 	close(fd);
 	time2 = time(NULL);
-	printf("\nFinished building a %lu megabyte file @ %s\n", bufnum,
-	       asctime(localtime(&time2)));
+	tst_res(TINFO, "Finished building a %d megabyte file", bufnum);
 	diff = time2 - time1;
-	printf("Number of Writes: %d\n"
-	       "Number of Seeks: %d\n"
-	       "Total time for test to run: %d minute(s) and %d seconds\n",
-	       writecnt, seekcnt, diff / 60, diff % 60);
+	tst_res(TINFO, "Total time for test to run: %d minute(s) and %d seconds",
+	        diff / 60, diff % 60);
 
-	return 0;
+	tst_res(TPASS, "Test successfull");
 }
+
+static struct tst_test test = {
+	.options = (struct tst_option[]) {
+		{"n:", &str_bufnum, "-n COUNT Number of megabytes to write (default 100)"},
+		{}
+	},
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.test_all = run
+};
\ No newline@end of file
-- 
2.25.1

