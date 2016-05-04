From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed,  4 May 2016 16:12:14 +0300
Subject: [LTP] [PATCH] direct_io/diotest1.c: fix gcc warning and use test
	temp directory
Message-ID: <1462367534-12224-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Unlike other diotests, diotest1 doesn't use temporary directory for
its test files but rather the directory it is run in.

also fix:
* fix old-style definition warning for prg_usage();
* use SAFE_* macros;
* add cleanup().

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/io/direct_io/diotest1.c |  139 +++++++++++-------------------
 1 files changed, 51 insertions(+), 88 deletions(-)

diff --git a/testcases/kernel/io/direct_io/diotest1.c b/testcases/kernel/io/direct_io/diotest1.c
index ca32898..4dd989c 100644
--- a/testcases/kernel/io/direct_io/diotest1.c
+++ b/testcases/kernel/io/direct_io/diotest1.c
@@ -1,25 +1,19 @@
 /*
+ * Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
+ * Copyright (c) International Business Machines  Corp., 2002
  *
- *   Copyright (c) International Business Machines  Corp., 2002
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
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
- *      diotest1.c
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
  *
  * DESCRIPTION
  *	Copy the contents of the input file to output file using direct read
@@ -33,10 +27,7 @@
  *
  * History
  *	04/22/2002	Narasimha Sharoff nsharoff@us.ibm.com
- *
- * RESTRICTIONS
- *	None
-*/
+ */
 
 #include <stdio.h>
 #include <stdlib.h>
@@ -49,6 +40,7 @@
 #include "diotest_routines.h"
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "diotest01";	/* Test program identifier.    */
 int TST_TOTAL = 1;		/* Total number of test conditions */
@@ -60,35 +52,34 @@ int TST_TOTAL = 1;		/* Total number of test conditions */
 #define	LEN	30
 #define	TRUE 1
 
+static char infile[LEN];	/* Input file. Default "infile" */
+static char outfile[LEN];	/* Output file. Default "outfile" */
+static int fd1, fd2;
+
 /*
  * prg_usage: display the program usage.
 */
-void prg_usage()
+void prg_usage(void)
 {
 	fprintf(stderr,
 		"Usage: diotest1 [-b bufsize] [-n numblks] [-i infile] [-o outfile]\n");
 	tst_brkm(TBROK, NULL, "usage");
 }
 
-/*
- * fail_clean: cleanup and exit.
-*/
-void fail_clean(int fd1, int fd2, char *infile, char *outfile)
+void cleanup(void)
 {
-	close(fd1);
-	close(fd2);
-	unlink(infile);
-	unlink(outfile);
-	tst_brkm(TFAIL, NULL, "Test failed");
+	if (fd1 > 0)
+		close(fd1);
+	if (fd2 > 0)
+		close(fd2);
+
+	tst_rmdir();
 }
 
 int main(int argc, char *argv[])
 {
 	int bufsize = BUFSIZE;	/* Buffer size. Default 8k */
 	int numblks = NBLKS;	/* Number of blocks. Default 20 */
-	char infile[LEN];	/* Input file. Default "infile" */
-	char outfile[LEN];	/* Output file. Default "outfile" */
-	int fd, fd1, fd2;
 	int i, n, offset;
 	char *buf;
 
@@ -125,80 +116,52 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	tst_tmpdir();
+
 	/* Test for filesystem support of O_DIRECT */
-	if ((fd = open(infile, O_DIRECT | O_RDWR | O_CREAT, 0666)) < 0) {
-		tst_brkm(TCONF,
-			 NULL,
-			 "O_DIRECT is not supported by this filesystem.");
-	} else {
-		close(fd);
-	}
+	int fd = open(infile, O_DIRECT | O_RDWR | O_CREAT, 0666);
 
-	/* Open files */
-	if ((fd1 = open(infile, O_DIRECT | O_RDWR | O_CREAT, 0666)) < 0) {
-		tst_brkm(TFAIL, NULL, "open infile failed: %s",
-			 strerror(errno));
-	}
+	if (fd < 0)
+		tst_brkm(TCONF, cleanup, "O_DIRECT not supported by FS");
+	SAFE_CLOSE(cleanup, fd);
 
-	if ((fd2 = open(outfile, O_DIRECT | O_RDWR | O_CREAT, 0666)) < 0) {
-		close(fd1);
-		unlink(infile);
-		tst_brkm(TFAIL, NULL, "open outfile failed: %s",
-			 strerror(errno));
-	}
+	/* Open files */
+	fd1 = SAFE_OPEN(cleanup, infile, O_DIRECT | O_RDWR | O_CREAT, 0666);
+	fd2 = SAFE_OPEN(cleanup, outfile, O_DIRECT | O_RDWR | O_CREAT, 0666);
 
 	/* Allocate for buf, Create input file */
-	if ((buf = valloc(bufsize)) == 0) {
-		tst_resm(TFAIL, "valloc() failed: %s", strerror(errno));
-		fail_clean(fd1, fd2, infile, outfile);
-	}
+	buf = valloc(bufsize);
+
+	if (!buf)
+		tst_brkm(TFAIL | TERRNO, cleanup, "valloc() failed");
+
 	for (i = 0; i < numblks; i++) {
 		fillbuf(buf, bufsize, (char)(i % 256));
-		if (write(fd1, buf, bufsize) < 0) {
-			tst_resm(TFAIL, "write infile failed: %s",
-				 strerror(errno));
-			fail_clean(fd1, fd2, infile, outfile);
-		}
+		SAFE_WRITE(cleanup, 1, fd1, buf, bufsize);
 	}
 
 	/* Copy infile to outfile using direct read and direct write */
 	offset = 0;
-	if (lseek(fd1, offset, SEEK_SET) < 0) {
-		tst_resm(TFAIL, "lseek(infd) failed: %s", strerror(errno));
-		fail_clean(fd1, fd2, infile, outfile);
-	}
+	SAFE_LSEEK(cleanup, fd1, offset, SEEK_SET);
+
 	while ((n = read(fd1, buf, bufsize)) > 0) {
-		if (lseek(fd2, offset, SEEK_SET) < 0) {
-			tst_resm(TFAIL, "lseek(outfd) failed: %s",
-				 strerror(errno));
-			fail_clean(fd1, fd2, infile, outfile);
-		}
-		if (write(fd2, buf, n) < n) {
-			tst_resm(TFAIL, "write(outfd) failed: %s",
-				 strerror(errno));
-			fail_clean(fd1, fd2, infile, outfile);
-		}
+		SAFE_LSEEK(cleanup, fd2, offset, SEEK_SET);
+
+		SAFE_WRITE(cleanup, 1, fd2, buf, n);
+
 		offset += n;
-		if (lseek(fd1, offset, SEEK_SET) < 0) {
-			tst_resm(TFAIL, "lseek(infd) failed: %s",
-				 strerror(errno));
-			fail_clean(fd1, fd2, infile, outfile);
-		}
+		SAFE_LSEEK(cleanup, fd1, offset, SEEK_SET);
 	}
 
 	/* Verify */
 	if (filecmp(infile, outfile) != 0) {
-		tst_resm(TFAIL, "file compare failed for %s and %s",
+		tst_brkm(TFAIL, cleanup, "file compare failed for %s and %s",
 			 infile, outfile);
-		fail_clean(fd1, fd2, infile, outfile);
 	}
 
-	/* Cleanup */
-	close(fd1);
-	close(fd2);
-	unlink(infile);
-	unlink(outfile);
 	tst_resm(TPASS, "Test passed");
+
+	cleanup();
 	tst_exit();
 }
 
-- 
1.7.1

