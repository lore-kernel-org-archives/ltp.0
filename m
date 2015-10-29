From: Cedric Hnyda <chnyda@suse.com>
Date: Thu, 29 Oct 2015 17:55:56 +0100
Subject: [LTP]  [PATCH 1/3] diotest: cleanup & fix
Message-ID: <1446137758-27267-1-git-send-email-chnyda@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch is mostly about fixing coding style mistakes
in diotest*.c to make the code more readable.
Headers were also updated.
Useless function arguments were removed
Useless "removed" tests like:
	tst_resm(TPASS, "removed")
  were removed.
Added O_DIRECT in fcntl.h and check
that O_DIRECT is supported by the file system

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 include/lapi/fcntl.h                             |   4 +
 testcases/kernel/io/direct_io/diotest1.c         |  84 +++++-----
 testcases/kernel/io/direct_io/diotest2.c         | 121 ++++++++-------
 testcases/kernel/io/direct_io/diotest3.c         | 118 +++++++-------
 testcases/kernel/io/direct_io/diotest4.c         | 189 ++++++++++++-----------
 testcases/kernel/io/direct_io/diotest5.c         | 141 ++++++++---------
 testcases/kernel/io/direct_io/diotest6.c         |  66 ++++----
 testcases/kernel/io/direct_io/diotest_routines.c |  68 ++++----
 testcases/kernel/io/direct_io/diotest_routines.h |  40 +++--
 9 files changed, 435 insertions(+), 396 deletions(-)

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index 0661651..e5d223a 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -59,6 +59,10 @@
 # define O_NOATIME 01000000
 #endif
 
+#ifndef O_DIRECT
+# define O_DIRECT 00040000
+#endif
+
 #ifndef O_PATH
 # define O_PATH 010000000
 #endif
diff --git a/testcases/kernel/io/direct_io/diotest1.c b/testcases/kernel/io/direct_io/diotest1.c
index ca32898..110c629 100644
--- a/testcases/kernel/io/direct_io/diotest1.c
+++ b/testcases/kernel/io/direct_io/diotest1.c
@@ -1,20 +1,20 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2002
+ *  04/30/2002 Narasimha Sharoff nsharoff@us.ibm.com
  *
- *   Copyright (c) International Business Machines  Corp., 2002
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
@@ -30,12 +30,6 @@
  *
  * USAGE
  *	diotest1 [-b bufsize] [-n numblks] [-i infile] [-o outfile]
- *
- * History
- *	04/22/2002	Narasimha Sharoff nsharoff@us.ibm.com
- *
- * RESTRICTIONS
- *	None
 */
 
 #include <stdio.h>
@@ -50,20 +44,21 @@
 
 #include "test.h"
 
-char *TCID = "diotest01";	/* Test program identifier.    */
-int TST_TOTAL = 1;		/* Total number of test conditions */
-
-#ifdef O_DIRECT
+char *TCID = "diotest01";
+int TST_TOTAL = 1;
 
 #define	BUFSIZE	8192
 #define	NBLKS	20
 #define	LEN	30
 #define	TRUE 1
 
+static void fail_clean(int fd1, int fd2, char *infile, char *outfile);
+static void prg_usage(void);
+
 /*
  * prg_usage: display the program usage.
 */
-void prg_usage()
+static void prg_usage(void)
 {
 	fprintf(stderr,
 		"Usage: diotest1 [-b bufsize] [-n numblks] [-i infile] [-o outfile]\n");
@@ -73,7 +68,7 @@ void prg_usage()
 /*
  * fail_clean: cleanup and exit.
 */
-void fail_clean(int fd1, int fd2, char *infile, char *outfile)
+static void fail_clean(int fd1, int fd2, char *infile, char *outfile)
 {
 	close(fd1);
 	close(fd2);
@@ -98,7 +93,8 @@ int main(int argc, char *argv[])
 	while ((i = getopt(argc, argv, "b:n:i:o:")) != -1) {
 		switch (i) {
 		case 'b':
-			if ((bufsize = atoi(optarg)) <= 0) {
+			bufsize = atoi(optarg);
+			if (bufsize <= 0) {
 				fprintf(stderr, "bufsize must be > 0\n");
 				prg_usage();
 			}
@@ -109,7 +105,8 @@ int main(int argc, char *argv[])
 			}
 			break;
 		case 'n':
-			if ((numblks = atoi(optarg)) <= 0) {
+			numblks = atoi(optarg);
+			if (numblks <= 0) {
 				fprintf(stderr, "numblks must be > 0\n");
 				prg_usage();
 			}
@@ -126,21 +123,25 @@ int main(int argc, char *argv[])
 	}
 
 	/* Test for filesystem support of O_DIRECT */
-	if ((fd = open(infile, O_DIRECT | O_RDWR | O_CREAT, 0666)) < 0) {
-		tst_brkm(TCONF,
-			 NULL,
-			 "O_DIRECT is not supported by this filesystem.");
-	} else {
-		close(fd);
-	}
+	fd = open(infile, O_DIRECT | O_RDWR | O_CREAT, 0666);
+	if (fd < 0 && errno == EINVAL)
+		tst_brkm(TCONF, NULL,
+			 "O_DIRECT is not supported by this filesystem. %s",
+			 strerror(errno));
+	else if (fd < 0)
+		tst_brkm(TBROK, NULL, "Couldn't open test file %s: %s",
+			 infile, strerror(errno));
+	close(fd);
 
 	/* Open files */
-	if ((fd1 = open(infile, O_DIRECT | O_RDWR | O_CREAT, 0666)) < 0) {
+	fd1 = open(infile, O_DIRECT | O_RDWR | O_CREAT, 0666);
+	if (fd1 < 0) {
 		tst_brkm(TFAIL, NULL, "open infile failed: %s",
 			 strerror(errno));
 	}
 
-	if ((fd2 = open(outfile, O_DIRECT | O_RDWR | O_CREAT, 0666)) < 0) {
+	fd2 = open(outfile, O_DIRECT | O_RDWR | O_CREAT, 0666);
+	if (fd2 < 0) {
 		close(fd1);
 		unlink(infile);
 		tst_brkm(TFAIL, NULL, "open outfile failed: %s",
@@ -148,7 +149,8 @@ int main(int argc, char *argv[])
 	}
 
 	/* Allocate for buf, Create input file */
-	if ((buf = valloc(bufsize)) == 0) {
+	buf = valloc(bufsize);
+	if (!buf) {
 		tst_resm(TFAIL, "valloc() failed: %s", strerror(errno));
 		fail_clean(fd1, fd2, infile, outfile);
 	}
@@ -201,11 +203,3 @@ int main(int argc, char *argv[])
 	tst_resm(TPASS, "Test passed");
 	tst_exit();
 }
-
-#else /* O_DIRECT */
-
-int main()
-{
-	tst_brkm(TCONF, NULL, "O_DIRECT is not defined.");
-}
-#endif /* O_DIRECT */
diff --git a/testcases/kernel/io/direct_io/diotest2.c b/testcases/kernel/io/direct_io/diotest2.c
index 15ae932..afa8e95 100644
--- a/testcases/kernel/io/direct_io/diotest2.c
+++ b/testcases/kernel/io/direct_io/diotest2.c
@@ -1,20 +1,20 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2002
+ *  04/30/2002 Narasimha Sharoff nsharoff@us.ibm.com
  *
- *   Copyright (c) International Business Machines  Corp., 2002
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
@@ -35,12 +35,6 @@
  *
  * USAGE
  *      diotest2 [-b bufsize] [-o offset] [-i iterations] [-f filename]
- *
- * History
- *	04/22/2002	Narasimha Sharoff nsharoff@us.ibm.com
- *
- * RESTRICTIONS
- *	None
 */
 
 #include <stdio.h>
@@ -57,10 +51,8 @@
 
 #include "test.h"
 
-char *TCID = "diotest02";	/* Test program identifier.    */
-int TST_TOTAL = 3;		/* Total number of test conditions */
-
-#ifdef O_DIRECT
+char *TCID = "diotest02";
+int TST_TOTAL = 3;
 
 #define	BUFSIZE	4096
 #define TRUE	1
@@ -69,23 +61,33 @@ int TST_TOTAL = 3;		/* Total number of test conditions */
 #define WRITE_DIRECT 2
 #define RDWR_DIRECT 3
 
+static int runtest(int fd_r, int fd_w, int iter, off64_t offset);
+static void cleanup(void);
+static void prg_usage(void);
+static void setup(void);
+
+static int fd1 = -1;
+static char filename[LEN];
+
 /*
  * runtest: write the data to the file. Read the data from the file and compare.
  *	For each iteration, write data starting at offse+iter*bufsize
  *	location in the file and read from there.
 */
-int runtest(int fd_r, int fd_w, int iter, off64_t offset, int action)
+static int runtest(int fd_r, int fd_w, int iter, off64_t offset)
 {
 	char *buf1;
 	char *buf2;
 	int i, bufsize = BUFSIZE;
 
 	/* Allocate for buffers */
-	if ((buf1 = valloc(bufsize)) == 0) {
+	buf1 = valloc(bufsize);
+	if (buf1 == 0) {
 		tst_resm(TFAIL, "valloc() buf1 failed: %s", strerror(errno));
 		return (-1);
 	}
-	if ((buf2 = valloc(bufsize)) == 0) {
+	buf2 = valloc(bufsize);
+	if (buf2 == 0) {
 		tst_resm(TFAIL, "valloc() buf2 failed: %s", strerror(errno));
 		return (-1);
 	}
@@ -122,24 +124,19 @@ int runtest(int fd_r, int fd_w, int iter, off64_t offset, int action)
 /*
  * prg_usage: display the program usage.
 */
-void prg_usage()
+static void prg_usage(void)
 {
 	fprintf(stderr,
 		"Usage: diotest2 [-b bufsize] [-o offset] [-i iterations] [-f filename]\n");
 	exit(1);
 }
 
-int fd1 = -1;
-char filename[LEN];
-static void setup(void);
-static void cleanup(void);
-
 int main(int argc, char *argv[])
 {
 	int iter = 100;		/* Iterations. Default 100 */
 	int bufsize = BUFSIZE;	/* Buffer size. Default 4k */
 	off64_t offset = 0;	/* Offset. Default 0 */
-	int i, action, fd_r, fd_w;
+	int i, fd_r, fd_w;
 	int fail_count = 0, total = 0, failed = 0;
 
 	/* Options */
@@ -147,7 +144,8 @@ int main(int argc, char *argv[])
 	while ((i = getopt(argc, argv, "b:o:i:f:")) != -1) {
 		switch (i) {
 		case 'b':
-			if ((bufsize = atoi(optarg)) <= 0) {
+			bufsize = atoi(optarg);
+			if (bufsize <= 0) {
 				fprintf(stderr, "bufsize must be > 0\n");
 				prg_usage();
 			}
@@ -158,13 +156,15 @@ int main(int argc, char *argv[])
 			}
 			break;
 		case 'o':
-			if ((offset = atoi(optarg)) <= 0) {
+			offset = atoi(optarg);
+			if (offset <= 0) {
 				fprintf(stderr, "offset must be > 0\n");
 				prg_usage();
 			}
 			break;
 		case 'i':
-			if ((iter = atoi(optarg)) <= 0) {
+			iter = atoi(optarg);
+			if (iter <= 0) {
 				fprintf(stderr, "iterations must be > 0\n");
 				prg_usage();
 			}
@@ -180,14 +180,15 @@ int main(int argc, char *argv[])
 	setup();
 
 	/* Testblock-1: Read with Direct IO, Write without */
-	action = READ_DIRECT;
-	if ((fd_w = open(filename, O_WRONLY | O_CREAT, 0666)) < 0)
+	fd_w = open(filename, O_WRONLY | O_CREAT, 0666);
+	if (fd_w < 0)
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "open(%s, O_WRONLY..) failed", filename);
-	if ((fd_r = open(filename, O_DIRECT | O_RDONLY, 0666)) < 0)
+	fd_r = open(filename, O_DIRECT | O_RDONLY, 0666);
+	if (fd_r < 0)
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "open(%s, O_DIRECT|O_RDONLY..) failed", filename);
-	if (runtest(fd_r, fd_w, iter, offset, action) < 0) {
+	if (runtest(fd_r, fd_w, iter, offset) < 0) {
 		failed = TRUE;
 		fail_count++;
 		tst_resm(TFAIL, "Read with Direct IO, Write without");
@@ -199,14 +200,15 @@ int main(int argc, char *argv[])
 	total++;
 
 	/* Testblock-2: Write with Direct IO, Read without */
-	action = WRITE_DIRECT;
-	if ((fd_w = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666)) == -1)
+	fd_w = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
+	if (fd_w == -1)
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "open(%s, O_DIRECT|O_WRONLY..) failed", filename);
-	if ((fd_r = open(filename, O_RDONLY | O_CREAT, 0666)) == -1)
+	fd_r = open(filename, O_RDONLY | O_CREAT, 0666);
+	if (fd_r == -1)
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "open(%s, O_RDONLY..) failed", filename);
-	if (runtest(fd_r, fd_w, iter, offset, action) < 0) {
+	if (runtest(fd_r, fd_w, iter, offset) < 0) {
 		failed = TRUE;
 		fail_count++;
 		tst_resm(TFAIL, "Write with Direct IO, Read without");
@@ -218,16 +220,17 @@ int main(int argc, char *argv[])
 	total++;
 
 	/* Testblock-3: Read, Write with Direct IO. */
-	action = RDWR_DIRECT;
-	if ((fd_w = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666)) == -1)
+	fd_w = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
+	if (fd_w == -1)
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "open(%s, O_DIRECT|O_WRONLY|O_CREAT, ..) failed",
 			 filename);
-	if ((fd_r = open(filename, O_DIRECT | O_RDONLY | O_CREAT, 0666)) == -1)
+	fd_r = open(filename, O_DIRECT | O_RDONLY | O_CREAT, 0666);
+	if (fd_r == -1)
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "open(%s, O_DIRECT|O_RDONLY|O_CREAT, ..) failed",
 			 filename);
-	if (runtest(fd_r, fd_w, iter, offset, action) < 0) {
+	if (runtest(fd_r, fd_w, iter, offset) < 0) {
 		failed = TRUE;
 		fail_count++;
 		tst_resm(TFAIL, "Read, Write with Direct IO");
@@ -251,17 +254,24 @@ int main(int argc, char *argv[])
 
 static void setup(void)
 {
+
 	tst_tmpdir();
 
-	if ((fd1 = open(filename, O_CREAT | O_EXCL, 0600)) == -1)
+	fd1 = open(filename, O_CREAT | O_EXCL, 0600);
+	if (fd1 == -1)
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "open(%s, O_CREAT|O_EXCL, ..) failed", filename);
 	close(fd1);
 
 	/* Test for filesystem support of O_DIRECT */
-	if ((fd1 = open(filename, O_DIRECT, 0600)) == -1)
-		tst_brkm(TCONF | TERRNO, cleanup,
-			 "open(%s, O_DIRECT, ..) failed", filename);
+	fd1 = open(filename, O_DIRECT, 0600);
+	if (fd1 < 0 && errno == EINVAL)
+		tst_brkm(TCONF, cleanup,
+			 "O_DIRECT is not supported by this filesystem. %s",
+			 strerror(errno));
+	else if (fd1 < 0)
+		tst_brkm(TBROK, cleanup, "Couldn't open test file %s: %s",
+			 filename, strerror(errno));
 	close(fd1);
 
 }
@@ -274,10 +284,3 @@ static void cleanup(void)
 	tst_rmdir();
 
 }
-
-#else /* O_DIRECT */
-int main()
-{
-	tst_brkm(TCONF, NULL, "O_DIRECT is not defined.");
-}
-#endif /* O_DIRECT */
diff --git a/testcases/kernel/io/direct_io/diotest3.c b/testcases/kernel/io/direct_io/diotest3.c
index 5ec4e18..2734afd 100644
--- a/testcases/kernel/io/direct_io/diotest3.c
+++ b/testcases/kernel/io/direct_io/diotest3.c
@@ -1,20 +1,20 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2002
+ *  04/30/2002 Narasimha Sharoff nsharoff@us.ibm.com
  *
- *   Copyright (c) International Business Machines  Corp., 2002
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
@@ -37,11 +37,6 @@
  *	diotest3 [-b bufsize] [-o offset] [-n numchild]
  *			[-i iterations [-f filename]
  *
- * History
- *	04/22/2002	Narasimha Sharoff nsharoff@us.ibm.com
- *
- * RESTRICTIONS
- *	None
 */
 
 #include <stdio.h>
@@ -57,10 +52,8 @@
 
 #include "test.h"
 
-char *TCID = "diotest03";	/* Test program identifier.    */
-int TST_TOTAL = 3;		/* Total number of test conditions */
-
-#ifdef O_DIRECT
+char *TCID = "diotest03";
+int TST_TOTAL = 3;
 
 #define	BUFSIZE	4096
 #define TRUE 1
@@ -69,15 +62,21 @@ int TST_TOTAL = 3;		/* Total number of test conditions */
 #define	WRITE_DIRECT 2
 #define	RDWR_DIRECT 3
 
-static int iter = 100;		/* Iterations. Default 100 */
-static int bufsize = BUFSIZE;	/* Buffersize. Default 4k */
-static int offset = 0;		/* Offset. Default 0 */
+static void prg_usage(void);
+static int runtest(int fd_r, int fd_w, int childnum, int action);
+static int child_function(int childnum, int action);
+static void cleanup(void);
+static void setup(void);
+
+static int iter = 100;
+static int bufsize = BUFSIZE;
+static int offset;
 static char filename[LEN];
 
 /*
  * prg_usage: display the program usage
 */
-void prg_usage()
+static void prg_usage(void)
 {
 	fprintf(stderr,
 		"Usage: diotest3 [-b bufsize] [-o offset] [-n numchild] [-i iterations] [-f filename]\n");
@@ -91,7 +90,7 @@ void prg_usage()
  *
  * XXX (garrcoop): shouldn't use libltp APIs because it runs forked.
  */
-int runtest(int fd_r, int fd_w, int childnum, int action)
+static int runtest(int fd_r, int fd_w, int childnum, int action)
 {
 	char *buf1;
 	char *buf2;
@@ -101,11 +100,13 @@ int runtest(int fd_r, int fd_w, int childnum, int action)
 
 	/* Allocate for buffers */
 	seekoff = offset + bufsize * childnum;
-	if ((buf1 = valloc(bufsize)) == 0) {
+	buf1 = valloc(bufsize);
+	if (!buf1) {
 		tst_resm(TFAIL | TERRNO, "valloc for buf1 failed");
 		return (-1);
 	}
-	if ((buf2 = valloc(bufsize)) == 0) {
+	buf2 = valloc(bufsize);
+	if (!buf2) {
 		tst_resm(TFAIL | TERRNO, "valloc for buf2 failed");
 		return (-1);
 	}
@@ -149,19 +150,21 @@ int runtest(int fd_r, int fd_w, int childnum, int action)
 /*
  * child_function: open the file for read and write. Call the runtest routine.
 */
-int child_function(int childnum, int action)
+static int child_function(int childnum, int action)
 {
 	int fd_w, fd_r;
 
 	switch (action) {
 	case READ_DIRECT:
-		if ((fd_w = open(filename, O_WRONLY | O_CREAT, 0666)) < 0) {
+		fd_w = open(filename, O_WRONLY | O_CREAT, 0666);
+		if (fd_w < 0) {
 			tst_resm(TFAIL | TERRNO,
 				 "open(%s, O_WRONLY|O_CREAT, ..) failed",
 				 filename);
 			return (-1);
 		}
-		if ((fd_r = open(filename, O_DIRECT | O_RDONLY, 0666)) < 0) {
+		fd_r = open(filename, O_DIRECT | O_RDONLY, 0666);
+		if (fd_r < 0) {
 			tst_resm(TFAIL | TERRNO,
 				 "open(%s, O_DIRECT|O_RDONLY, ..) failed",
 				 filename);
@@ -177,13 +180,14 @@ int child_function(int childnum, int action)
 		}
 		break;
 	case WRITE_DIRECT:
-		if ((fd_w =
-		     open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666)) < 0) {
+		fd_w = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
+		if (fd_w < 0) {
 			tst_resm(TFAIL, "fd_w open failed for %s: %s", filename,
 				 strerror(errno));
 			return (-1);
 		}
-		if ((fd_r = open(filename, O_RDONLY, 0666)) < 0) {
+		fd_r = open(filename, O_RDONLY, 0666);
+		if (fd_r < 0) {
 			tst_resm(TFAIL, "fd_r open failed for %s: %s",
 				 filename, strerror(errno));
 			close(fd_w);
@@ -198,13 +202,14 @@ int child_function(int childnum, int action)
 		}
 		break;
 	case RDWR_DIRECT:
-		if ((fd_w =
-		     open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666)) < 0) {
+		fd_w = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
+		if (fd_w < 0) {
 			tst_resm(TFAIL, "fd_w open failed for %s: %s", filename,
 				 strerror(errno));
 			return (-1);
 		}
-		if ((fd_r = open(filename, O_DIRECT | O_RDONLY, 0666)) < 0) {
+		fd_r = open(filename, O_DIRECT | O_RDONLY, 0666);
+		if (fd_r < 0) {
 			tst_resm(TFAIL, "fd_r open failed for %s: %s",
 				 filename, strerror(errno));
 			close(fd_w);
@@ -227,8 +232,6 @@ int child_function(int childnum, int action)
 	exit(0);
 }
 
-static void setup(void);
-static void cleanup(void);
 static int fd1 = -1;
 
 int main(int argc, char *argv[])
@@ -242,7 +245,8 @@ int main(int argc, char *argv[])
 	while ((i = getopt(argc, argv, "b:o:i:n:f:")) != -1) {
 		switch (i) {
 		case 'b':
-			if ((bufsize = atoi(optarg)) <= 0) {
+			bufsize = atoi(optarg);
+			if (bufsize <= 0) {
 				fprintf(stderr, "bufsize must be > 0\n");
 				prg_usage();
 			}
@@ -253,19 +257,22 @@ int main(int argc, char *argv[])
 			}
 			break;
 		case 'o':
-			if ((offset = atoi(optarg)) <= 0) {
+			offset = atoi(optarg);
+			if (offset <= 0) {
 				fprintf(stderr, "offset must be > 0\n");
 				prg_usage();
 			}
 			break;
 		case 'i':
-			if ((iter = atoi(optarg)) <= 0) {
+			iter = atoi(optarg);
+			if (iter <= 0) {
 				fprintf(stderr, "iterations must be > 0\n");
 				prg_usage();
 			}
 			break;
 		case 'n':
-			if ((numchild = atoi(optarg)) <= 0) {
+			numchild = atoi(optarg);
+			if (numchild <= 0) {
 				fprintf(stderr, "no of children must be > 0\n");
 				prg_usage();
 			}
@@ -346,17 +353,24 @@ int main(int argc, char *argv[])
 
 static void setup(void)
 {
+
 	tst_tmpdir();
 
-	if ((fd1 = open(filename, O_CREAT | O_EXCL, 0600)) < 0)
+	fd1 = open(filename, O_CREAT | O_EXCL, 0600);
+	if (fd1 < 0)
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "open(%s, O_CREAT|O_EXCL, ..) failed", filename);
 	close(fd1);
 
 	/* Test for filesystem support of O_DIRECT */
-	if ((fd1 = open(filename, O_DIRECT, 0600)) < 0)
-		tst_brkm(TCONF, cleanup, "open(%s, O_DIRECT, ..) failed",
-			 filename);
+	fd1 = open(filename, O_DIRECT, 0600);
+	if (fd1 < 0 && errno == EINVAL)
+		tst_brkm(TCONF, cleanup,
+			 "O_DIRECT is not supported by this filesystem. %s",
+			 strerror(errno));
+	else if (fd1 < 0)
+		tst_brkm(TBROK, cleanup, "Couldn't open test file %s: %s",
+			 filename, strerror(errno));
 	close(fd1);
 }
 
@@ -366,12 +380,4 @@ static void cleanup(void)
 		unlink(filename);
 
 	tst_rmdir();
-
-}
-#else /* O_DIRECT */
-
-int main()
-{
-	tst_brkm(TCONF, NULL, "O_DIRECT is not defined.");
 }
-#endif /* O_DIRECT */
diff --git a/testcases/kernel/io/direct_io/diotest4.c b/testcases/kernel/io/direct_io/diotest4.c
index e19e48f..3ccf49e 100644
--- a/testcases/kernel/io/direct_io/diotest4.c
+++ b/testcases/kernel/io/direct_io/diotest4.c
@@ -1,20 +1,20 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2002
+ *  04/30/2002 Narasimha Sharoff nsharoff@us.ibm.com
  *
- *   Copyright (c) International Business Machines  Corp., 2002
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
@@ -47,12 +47,6 @@
  *
  * USAGE
  *      diotest4 [-b filesize_in_blocks]
- *
- * History
- *	04/22/2002	Narasimha Sharoff nsharoff@us.ibm.com
- *
- * RESTRICTIONS
- *	None
 */
 
 #include <stdio.h>
@@ -72,13 +66,11 @@
 #include "test.h"
 #include "tst_fs_type.h"
 
-char *TCID = "diotest4";	/* Test program identifier.    */
-int TST_TOTAL = 17;		/* Total number of test conditions */
-int NO_NFS = 1;			/* Test on NFS or not */
+char *TCID = "diotest4";
+int TST_TOTAL = 17;
+int NO_NFS = 1;
 
-#ifdef O_DIRECT
-
-#define BUFSIZE 	4096
+#define BUFSIZE	4096
 #define TRUE	1
 #define LEN	30
 
@@ -88,13 +80,23 @@ int NO_NFS = 1;			/* Test on NFS or not */
 #define ADDRESS_OF_MAIN main
 #endif
 
+static int fd1 = -1;
+static char filename[LEN];
+
+static void prg_usage(void);
+static int runtest_f(int fd, char *buf, int offset, int count, int errnum,
+				char *msg);
+
+static int runtest_s(int fd, char *buf, int offset, int count, char *msg);
+static void setup(void);
+static void cleanup(void);
+
 /*
  * runtest_f: Do read, writes. Verify the error value obtained by
  *	running read or write with the expected error value (errnum).
 */
-int
-runtest_f(int fd, char *buf, int offset, int count, int errnum, int testnum,
-	  char *msg)
+static int runtest_f(int fd, char *buf, int offset, int count, int errnum,
+				char *msg)
 {
 	int ret;
 	int l_fail = 0;
@@ -129,13 +131,13 @@ runtest_f(int fd, char *buf, int offset, int count, int errnum, int testnum,
 			l_fail = TRUE;
 		}
 	}
-	return (l_fail);
+	return l_fail;
 }
 
 /*
  * runtest_s: Do read, writes. Verify the they run successfully.
 */
-int runtest_s(int fd, char *buf, int offset, int count, int testnum, char *msg)
+static int runtest_s(int fd, char *buf, int offset, int count, char *msg)
 {
 	int ret;
 	int l_fail = 0;
@@ -145,7 +147,8 @@ int runtest_s(int fd, char *buf, int offset, int count, int testnum, char *msg)
 			 strerror(errno));
 		l_fail = TRUE;
 	} else {
-		if ((ret = read(fd, buf, count)) < 0) {
+		ret = read(fd, buf, count);
+		if (ret < 0) {
 			tst_resm(TFAIL, "read failed for %s. returns %d: %s",
 				 msg, ret, strerror(errno));
 			l_fail = TRUE;
@@ -156,19 +159,20 @@ int runtest_s(int fd, char *buf, int offset, int count, int testnum, char *msg)
 			 strerror(errno));
 		l_fail = TRUE;
 	} else {
-		if ((ret = write(fd, buf, count)) < 0) {
+		ret = write(fd, buf, count);
+		if (ret < 0) {
 			tst_resm(TFAIL, "write failed for %s. returns %d: %s",
 				 msg, ret, strerror(errno));
 			l_fail = TRUE;
 		}
 	}
-	return (l_fail);
+	return l_fail;
 }
 
 /*
  * prg_usage - Display the program usage
 */
-void prg_usage()
+static void prg_usage(void)
 {
 	fprintf(stderr, "Usage: diotest4 [-b filesize_in_blocks]\n");
 	exit(1);
@@ -184,11 +188,6 @@ static void testcheck_end(int ret, int *failed, int *fail_count, char *msg)
 		tst_resm(TPASS, "%s", msg);
 }
 
-static void setup(void);
-static void cleanup(void);
-static int fd1 = -1;
-static char filename[LEN];
-
 int main(int argc, char *argv[])
 {
 	int fblocks = 1;	/* Iterations. Default 1 */
@@ -207,7 +206,8 @@ int main(int argc, char *argv[])
 	while ((i = getopt(argc, argv, "b:")) != -1) {
 		switch (i) {
 		case 'b':
-			if ((fblocks = atoi(optarg)) <= 0) {
+			fblocks = atoi(optarg);
+			if (fblocks <= 0) {
 				fprintf(stderr, "fblocks must be > 0\n");
 				prg_usage();
 			}
@@ -220,11 +220,13 @@ int main(int argc, char *argv[])
 	setup();
 
 	/* Open file and fill, allocate for buffer */
-	if ((fd = open(filename, O_DIRECT | O_RDWR | O_CREAT, 0666)) < 0) {
+	fd = open(filename, O_DIRECT | O_RDWR | O_CREAT, 0666);
+	if (fd < 0) {
 		tst_brkm(TBROK, cleanup, "open failed for %s: %s",
 			 filename, strerror(errno));
 	}
-	if ((buf0 = valloc(BUFSIZE)) == NULL) {
+	buf0 = valloc(BUFSIZE);
+	if (buf0 == NULL) {
 		tst_brkm(TBROK, cleanup, "valloc() buf0 failed: %s",
 			 strerror(errno));
 	}
@@ -236,11 +238,13 @@ int main(int argc, char *argv[])
 		}
 	}
 	close(fd);
-	if ((buf2 = valloc(BUFSIZE)) == NULL) {
+	buf2 = valloc(BUFSIZE);
+	if (buf2 == NULL) {
 		tst_brkm(TBROK, cleanup, "valloc() buf2 failed: %s",
 			 strerror(errno));
 	}
-	if ((fd = open(filename, O_DIRECT | O_RDWR)) < 0) {
+	fd = open(filename, O_DIRECT | O_RDWR);
+	if (fd < 0) {
 		tst_brkm(TBROK, cleanup, "open failed for %s: %s",
 			 filename, strerror(errno));
 	}
@@ -259,18 +263,14 @@ int main(int argc, char *argv[])
 		tst_resm(TPASS, "Negative Offset");
 	total++;
 
-	/* Test-2: Removed */
-	tst_resm(TPASS, "removed");
-
 	/* Test-3: Odd count of read and write */
 	offset = 0;
 	count = 1;
-	lseek(fd, 0, SEEK_SET);
-	if (write(fd, buf2, 4096) == -1) {
+	lseek(fd, offset, SEEK_SET);
+	if (write(fd, buf2, 4096) == -1)
 		tst_resm(TFAIL, "can't write to file %d", ret);
-	}
 	if (NO_NFS) {
-		ret = runtest_f(fd, buf2, offset, count, EINVAL, 3, "odd count");
+		ret = runtest_f(fd, buf2, offset, count, EINVAL, "odd count");
 		testcheck_end(ret, &failed, &fail_count,
 					"Odd count of read and write");
 	} else
@@ -303,19 +303,20 @@ int main(int argc, char *argv[])
 	offset = 4096;
 	count = bufsize;
 	newfd = -1;
-	ret = runtest_f(newfd, buf2, offset, count, EBADF, 5, "negative fd");
+	ret = runtest_f(newfd, buf2, offset, count, EBADF, "negative fd");
 	testcheck_end(ret, &failed, &fail_count, "Invalid file descriptor");
 	total++;
 
 	/* Test-6: Out of range file descriptor */
 	count = bufsize;
 	offset = 4096;
-	if ((newfd = getdtablesize()) < 0) {
+	newfd = getdtablesize();
+	if (newfd < 0) {
 		tst_resm(TFAIL, "getdtablesize() failed: %s", strerror(errno));
 		failed = TRUE;
 		tst_resm(TFAIL, "Out of range file descriptor");
 	} else {
-		ret = runtest_f(newfd, buf2, offset, count, EBADF, 6,
+		ret = runtest_f(newfd, buf2, offset, count, EBADF,
 			      "out of range fd");
 		testcheck_end(ret, &failed, &fail_count,
 					"Out of range file descriptor");
@@ -330,20 +331,18 @@ int main(int argc, char *argv[])
 		tst_brkm(TBROK, cleanup, "can't close fd %d: %s", fd,
 			 strerror(errno));
 	}
-	ret = runtest_f(fd, buf2, offset, count, EBADF, 7, "closed fd");
+	ret = runtest_f(fd, buf2, offset, count, EBADF, "closed fd");
 	testcheck_end(ret, &failed, &fail_count, "Closed file descriptor");
 	total++;
 
-	/* Test-9: removed */
-	tst_resm(TPASS, "removed");
-
 	/* Test-9: Character device (/dev/null) read, write */
 	offset = 0;
 	count = bufsize;
-	if ((newfd = open("/dev/null", O_DIRECT | O_RDWR)) < 0) {
+	newfd = open("/dev/null", O_DIRECT | O_RDWR);
+	if (newfd < 0) {
 		tst_resm(TCONF, "Direct I/O on /dev/null is not supported");
 	} else {
-		ret = runtest_s(newfd, buf2, offset, count, 9, "/dev/null");
+		ret = runtest_s(newfd, buf2, offset, count, "/dev/null");
 		testcheck_end(ret, &failed, &fail_count,
 					"character device read, write");
 	}
@@ -352,32 +351,35 @@ int main(int argc, char *argv[])
 
 	/* Test-10: read, write to a mmaped file */
 	shm_base = (char *)(((long)sbrk(0) + (shmsz - 1)) & ~(shmsz - 1));
-	if (shm_base == NULL) {
+	if (shm_base == NULL)
 		tst_brkm(TBROK, cleanup, "sbrk failed: %s", strerror(errno));
-	}
+
 	offset = 4096;
 	count = bufsize;
-	if ((fd = open(filename, O_DIRECT | O_RDWR)) < 0) {
+	fd = open(filename, O_DIRECT | O_RDWR);
+	if (fd < 0) {
 		tst_brkm(TBROK, cleanup, "can't open %s: %s",
 			 filename, strerror(errno));
 	}
 	shm_base = mmap(shm_base, 0x100000, PROT_READ | PROT_WRITE,
 			MAP_SHARED | MAP_FIXED, fd, 0);
-	if (shm_base == (caddr_t) - 1) {
+	/* check -1 */
+	if (shm_base == ((caddr_t) -1)) {
 		tst_brkm(TBROK, cleanup, "can't mmap file: %s",
 			 strerror(errno));
 	}
-	ret = runtest_s(fd, buf2, offset, count, 10, "mmapped file");
+	ret = runtest_s(fd, buf2, offset, count, "mmapped file");
 	testcheck_end(ret, &failed, &fail_count,
 				"read, write to a mmaped file");
 	total++;
 
 	/* Test-11: read, write to an unmaped file with munmap */
-	if ((ret = munmap(shm_base, 0x100000)) < 0) {
+	ret = munmap(shm_base, 0x100000);
+	if (ret < 0) {
 		tst_brkm(TBROK, cleanup, "can't unmap file: %s",
 			 strerror(errno));
 	}
-	ret = runtest_s(fd, buf2, offset, count, 11, "unmapped file");
+	ret = runtest_s(fd, buf2, offset, count, "unmapped file");
 	testcheck_end(ret, &failed, &fail_count,
 				"read, write to an unmapped file");
 	close(fd);
@@ -386,7 +388,8 @@ int main(int argc, char *argv[])
 	/* Test-12: read from file not open for reading */
 	offset = 4096;
 	count = bufsize;
-	if ((fd = open(filename, O_DIRECT | O_WRONLY)) < 0) {
+	fd = open(filename, O_DIRECT | O_WRONLY);
+	if (fd < 0) {
 		tst_brkm(TBROK, cleanup, "can't open %s: %s",
 			 filename, strerror(errno));
 	}
@@ -412,7 +415,8 @@ int main(int argc, char *argv[])
 	/* Test-13: write to file not open for writing */
 	offset = 4096;
 	count = bufsize;
-	if ((fd = open(filename, O_DIRECT | O_RDONLY)) < 0) {
+	fd = open(filename, O_DIRECT | O_RDONLY);
+	if (fd < 0) {
 		tst_brkm(TBROK, cleanup, "can't open %s: %s",
 			 filename, strerror(errno));
 	}
@@ -438,13 +442,14 @@ int main(int argc, char *argv[])
 	/* Test-14: read, write with non-aligned buffer */
 	offset = 4096;
 	count = bufsize;
-	if ((fd = open(filename, O_DIRECT | O_RDWR)) < 0) {
+	fd = open(filename, O_DIRECT | O_RDWR);
+	if (fd < 0) {
 		tst_brkm(TBROK, cleanup, "can't open %s: %s",
 			 filename, strerror(errno));
 	}
 	if (NO_NFS) {
-		ret = runtest_f(fd, buf2 + 1, offset, count, EINVAL, 14,
-					" nonaligned buf");
+		ret = runtest_f(fd, buf2 + 1, offset, count, EINVAL,
+			" nonaligned buf");
 		testcheck_end(ret, &failed, &fail_count,
 				"read, write with non-aligned buffer");
 	} else
@@ -456,7 +461,8 @@ int main(int argc, char *argv[])
 	offset = 4096;
 	count = bufsize;
 	l_fail = 0;
-	if ((fd = open(filename, O_DIRECT | O_RDWR)) < 0) {
+	fd = open(filename, O_DIRECT | O_RDWR);
+	if (fd < 0) {
 		tst_brkm(TBROK, cleanup, "can't open %s: %s",
 			 filename, strerror(errno));
 	}
@@ -497,15 +503,15 @@ int main(int argc, char *argv[])
 	/* Test-16: read, write in non-existant space */
 	offset = 4096;
 	count = bufsize;
-	if ((buf1 =
-	     (char *)(((long)sbrk(0) + (shmsz - 1)) & ~(shmsz - 1))) == NULL) {
+	buf1 = (char *)(((long)sbrk(0) + (shmsz - 1)) & ~(shmsz - 1));
+	if (buf1 == NULL)
 		tst_brkm(TBROK | TERRNO, cleanup, "sbrk failed");
-	}
-	if ((fd = open(filename, O_DIRECT | O_RDWR)) < 0) {
+	fd = open(filename, O_DIRECT | O_RDWR);
+	if (fd < 0)
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "open(%s, O_DIRECT|O_RDWR) failed", filename);
-	}
-	ret = runtest_f(fd, buf1, offset, count, EFAULT, 16,
+
+	ret = runtest_f(fd, buf1, offset, count, EFAULT,
 		      " nonexistant space");
 	testcheck_end(ret, &failed, &fail_count,
 				"read, write in non-existant space");
@@ -515,11 +521,12 @@ int main(int argc, char *argv[])
 	/* Test-17: read, write for file with O_SYNC */
 	offset = 4096;
 	count = bufsize;
-	if ((fd = open(filename, O_DIRECT | O_RDWR | O_SYNC)) < 0) {
+	fd = open(filename, O_DIRECT | O_RDWR | O_SYNC);
+	if (fd < 0) {
 		tst_brkm(TBROK, cleanup,
 			 "open(%s, O_DIRECT|O_RDWR|O_SYNC failed)", filename);
 	}
-	ret = runtest_s(fd, buf2, offset, count, 17, "opened with O_SYNC");
+	ret = runtest_s(fd, buf2, offset, count, "opened with O_SYNC");
 	testcheck_end(ret, &failed, &fail_count,
 				"read, write for file with O_SYNC");
 	total++;
@@ -547,21 +554,25 @@ static void setup(void)
 	(void)sigaction(SIGXFSZ, &act, NULL);
 	sprintf(filename, "testdata-4.%ld", syscall(__NR_gettid));
 
-	if ((fd1 = open(filename, O_CREAT | O_EXCL, 0600)) < 0) {
+	fd1 = open(filename, O_CREAT | O_EXCL, 0600);
+	if (fd1 < 0) {
 		tst_brkm(TBROK, cleanup, "Couldn't create test file %s: %s",
 			 filename, strerror(errno));
 	}
 	close(fd1);
 
 	/* Test for filesystem support of O_DIRECT */
-	if ((fd1 = open(filename, O_DIRECT, 0600)) < 0) {
+	fd1 = open(filename, O_DIRECT, 0600);
+	if (fd1 < 0 && errno == EINVAL)
 		tst_brkm(TCONF, cleanup,
 			 "O_DIRECT is not supported by this filesystem. %s",
 			 strerror(errno));
-	}
+	else if (fd1 < 0)
+		tst_brkm(TBROK, cleanup, "Couldn't open test file %s: %s",
+			 filename, strerror(errno));
+
 	close(fd1);
 
-	/* On NFS or not */
 	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC)
 		NO_NFS = 0;
 }
@@ -574,11 +585,3 @@ static void cleanup(void)
 	tst_rmdir();
 
 }
-
-#else /* O_DIRECT */
-
-int main()
-{
-	tst_brkm(TCONF, NULL, "O_DIRECT is not defined.");
-}
-#endif /* O_DIRECT */
diff --git a/testcases/kernel/io/direct_io/diotest5.c b/testcases/kernel/io/direct_io/diotest5.c
index fadcce2..0c10742 100644
--- a/testcases/kernel/io/direct_io/diotest5.c
+++ b/testcases/kernel/io/direct_io/diotest5.c
@@ -1,20 +1,20 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2002
+ *  04/30/2002 Narasimha Sharoff nsharoff@us.ibm.com
  *
- *   Copyright (c) International Business Machines  Corp., 2002
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
@@ -32,18 +32,13 @@
  *	value marks the starting position in file from where to start the
  *	write and read. (Using larger offset, larger files can be tested).
  *	The nvector gives vector array size.  Test data file can be
- * 	specified through commandline and is useful for running test with
- * 	raw devices as a file.
+ *	specified through commandline and is useful for running test with
+ *	raw devices as a file.
  *
  * USAGE
  *      diotest5 [-b bufsize] [-o offset] [-i iterations]
  *			[-v nvector] [-f filename]
  *
- * History
- *	04/29/2002	Narasimha Sharoff nsharoff@us.ibm.com
- *
- * RESTRICTIONS
- *	None
 */
 
 #include <stdio.h>
@@ -60,10 +55,8 @@
 
 #include "test.h"
 
-char *TCID = "diotest05";	/* Test program identifier.    */
-int TST_TOTAL = 3;		/* Total number of test conditions */
-
-#ifdef O_DIRECT
+char *TCID = "diotest05";
+int TST_TOTAL = 3;
 
 #define	BUFSIZE	4096
 #define TRUE 1
@@ -75,31 +68,39 @@ int TST_TOTAL = 3;		/* Total number of test conditions */
 static int bufsize = BUFSIZE;	/* Buffer size. Default 4k */
 static int iter = 20;		/* Iterations. Default 20 */
 static int nvector = 20;	/* Vector array. Default 20 */
-static off64_t offset = 0;	/* Start offset. Default 0 */
+static off64_t offset;	/* Start offset. Default 0 */
 static char filename[LEN];	/* Test data file */
 static int fd1 = -1;
+
+static void setup(void);
+static void cleanup(void);
+static int runtest(int fd_r, int fd_w, int iter, off64_t offset);
+static void prg_usage(void);
+
 /*
  * runtest: Write the data in vector array to the file. Read the data
  *	from the file into another vectory array and verify. Repeat the test.
 */
-int runtest(int fd_r, int fd_w, int iter, off64_t offset, int action)
+static int runtest(int fd_r, int fd_w, int iter, off64_t offset)
 {
 	int i, bufsize = BUFSIZE;
 	struct iovec *iov1, *iov2, *iovp;
 
 	/* Allocate for buffers and data pointers */
-	if ((iov1 =
-	     (struct iovec *)valloc(sizeof(struct iovec) * nvector)) == NULL) {
+	iov1 = (struct iovec *) valloc(sizeof(struct iovec) * nvector);
+	if (iov1 == NULL) {
 		tst_resm(TFAIL, "valloc() buf1 failed: %s", strerror(errno));
 		return (-1);
 	}
-	if ((iov2 =
-	     (struct iovec *)valloc(sizeof(struct iovec) * nvector)) == NULL) {
+
+	iov2 = (struct iovec *) valloc(sizeof(struct iovec) * nvector);
+	if (iov2 == NULL) {
 		tst_resm(TFAIL, "valloc buf2 failed: %s", strerror(errno));
 		return (-1);
 	}
 	for (i = 0, iovp = iov1; i < nvector; iovp++, i++) {
-		if ((iovp->iov_base = valloc(bufsize)) == NULL) {
+		iovp->iov_base = valloc(bufsize);
+		if (iovp->iov_base == NULL) {
 			tst_resm(TFAIL, "valloc for iovp->iov_base: %s",
 				 strerror(errno));
 			return (-1);
@@ -107,7 +108,8 @@ int runtest(int fd_r, int fd_w, int iter, off64_t offset, int action)
 		iovp->iov_len = bufsize;
 	}
 	for (i = 0, iovp = iov2; i < nvector; iovp++, i++) {
-		if ((iovp->iov_base = valloc(bufsize)) == NULL) {
+		iovp->iov_base = valloc(bufsize);
+		if (iovp->iov_base == NULL) {
 			tst_resm(TFAIL, "valloc, iov2 for iovp->iov_base: %s",
 				 strerror(errno));
 			return (-1);
@@ -144,12 +146,10 @@ int runtest(int fd_r, int fd_w, int iter, off64_t offset, int action)
 	}
 
 	/* Cleanup */
-	for (i = 0, iovp = iov1; i < nvector; iovp++, i++) {
+	for (i = 0, iovp = iov1; i < nvector; iovp++, i++)
 		free(iovp->iov_base);
-	}
-	for (i = 0, iovp = iov2; i < nvector; iovp++, i++) {
+	for (i = 0, iovp = iov2; i < nvector; iovp++, i++)
 		free(iovp->iov_base);
-	}
 	free(iov1);
 	free(iov2);
 	return 0;
@@ -158,19 +158,16 @@ int runtest(int fd_r, int fd_w, int iter, off64_t offset, int action)
 /*
  * prg_usage: Display the program usage
 */
-void prg_usage()
+static void prg_usage(void)
 {
 	fprintf(stderr,
 		"Usage: diotest5 [-b bufsize] [-o offset] [ -i iteration] [ -v nvector] [-f filename]\n");
 	exit(1);
 }
 
-static void setup(void);
-static void cleanup(void);
-
 int main(int argc, char *argv[])
 {
-	int i, action, fd_r, fd_w;
+	int i, fd_r, fd_w;
 	int fail_count = 0, total = 0, failed = 0;
 
 	/* Options */
@@ -178,7 +175,8 @@ int main(int argc, char *argv[])
 	while ((i = getopt(argc, argv, "b:o:i:v:f:")) != -1) {
 		switch (i) {
 		case 'b':
-			if ((bufsize = atoi(optarg)) <= 0) {
+			bufsize = atoi(optarg);
+			if (bufsize <= 0) {
 				fprintf(stderr, "bufsize must be > 0");
 				prg_usage();
 			}
@@ -188,19 +186,22 @@ int main(int argc, char *argv[])
 			}
 			break;
 		case 'o':
-			if ((offset = atoll(optarg)) <= 0) {
+			offset = atoll(optarg);
+			if (offset <= 0) {
 				fprintf(stderr, "offset must be > 0");
 				prg_usage();
 			}
 			break;
 		case 'i':
-			if ((iter = atoi(optarg)) <= 0) {
+			iter = atoi(optarg);
+			if (iter <= 0) {
 				fprintf(stderr, "iterations must be > 0");
 				prg_usage();
 			}
 			break;
 		case 'v':
-			if ((nvector = atoi(optarg)) <= 0) {
+			nvector = atoi(optarg);
+			if (nvector <= 0) {
 				fprintf(stderr, "vector array must be > 0");
 				prg_usage();
 			}
@@ -216,16 +217,17 @@ int main(int argc, char *argv[])
 	setup();
 
 	/* Testblock-1: Read with Direct IO, Write without */
-	action = READ_DIRECT;
-	if ((fd_w = open(filename, O_WRONLY | O_CREAT, 0666)) < 0) {
+	fd_w = open(filename, O_WRONLY | O_CREAT, 0666);
+	if (fd_w < 0) {
 		tst_brkm(TBROK, cleanup, "fd_w open failed for %s: %s",
 			 filename, strerror(errno));
 	}
-	if ((fd_r = open64(filename, O_DIRECT | O_RDONLY | O_CREAT, 0666)) < 0) {
+	fd_r = open64(filename, O_DIRECT | O_RDONLY | O_CREAT, 0666);
+	if (fd_r < 0) {
 		tst_brkm(TBROK, cleanup, "fd_r open failed for %s: %s",
 			 filename, strerror(errno));
 	}
-	if (runtest(fd_r, fd_w, iter, offset, action) < 0) {
+	if (runtest(fd_r, fd_w, iter, offset) < 0) {
 		failed = TRUE;
 		fail_count++;
 		tst_resm(TFAIL, "Read with Direct IO, Write without");
@@ -238,16 +240,18 @@ int main(int argc, char *argv[])
 	total++;
 
 	/* Testblock-2: Write with Direct IO, Read without */
-	action = WRITE_DIRECT;
-	if ((fd_w = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666)) < 0) {
+
+	fd_w = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
+	if (fd_w < 0) {
 		tst_brkm(TBROK, cleanup, "fd_w open failed for %s: %s",
 			 filename, strerror(errno));
 	}
-	if ((fd_r = open64(filename, O_RDONLY | O_CREAT, 0666)) < 0) {
+	fd_r = open64(filename, O_RDONLY | O_CREAT, 0666);
+	if (fd_r < 0) {
 		tst_brkm(TBROK, cleanup, "fd_r open failed for %s: %s",
 			 filename, strerror(errno));
 	}
-	if (runtest(fd_r, fd_w, iter, offset, action) < 0) {
+	if (runtest(fd_r, fd_w, iter, offset) < 0) {
 		failed = TRUE;
 		fail_count++;
 		tst_resm(TFAIL, "Write with Direct IO, Read without");
@@ -259,16 +263,18 @@ int main(int argc, char *argv[])
 	total++;
 
 	/* Testblock-3: Read, Write with Direct IO */
-	action = RDWR_DIRECT;
-	if ((fd_w = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666)) < 0) {
+	fd_w = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
+	if (fd_w < 0) {
 		tst_brkm(TBROK, cleanup, "fd_w open failed for %s: %s",
 			 filename, strerror(errno));
 	}
-	if ((fd_r = open64(filename, O_DIRECT | O_RDONLY | O_CREAT, 0666)) < 0) {
+
+	fd_r = open64(filename, O_DIRECT | O_RDONLY | O_CREAT, 0666);
+	if (fd_r < 0) {
 		tst_brkm(TBROK, cleanup, "fd_r open failed for %s: %s",
 			 filename, strerror(errno));
 	}
-	if (runtest(fd_r, fd_w, iter, offset, action) < 0) {
+	if (runtest(fd_r, fd_w, iter, offset) < 0) {
 		failed = TRUE;
 		fail_count++;
 		tst_resm(TFAIL, "Read, Write with Direct IO");
@@ -293,20 +299,25 @@ int main(int argc, char *argv[])
 
 static void setup(void)
 {
+
 	tst_tmpdir();
 
-	if ((fd1 = open(filename, O_CREAT | O_EXCL, 0600)) < 0) {
+	fd1 = open(filename, O_CREAT | O_EXCL, 0600);
+	if (fd1 < 0) {
 		tst_brkm(TBROK, cleanup, "Couldn't create test file %s: %s",
 			 filename, strerror(errno));
 	}
 	close(fd1);
 
 	/* Test for filesystem support of O_DIRECT */
-	if ((fd1 = open(filename, O_DIRECT, 0600)) < 0) {
+	fd1 = open(filename, O_DIRECT, 0600);
+	if (fd1 < 0 && errno == EINVAL)
 		tst_brkm(TCONF, cleanup,
 			 "O_DIRECT is not supported by this filesystem. %s",
 			 strerror(errno));
-	}
+	else if (fd1 < 0)
+		tst_brkm(TBROK, cleanup, "Couldn't open test file %s: %s",
+			 filename, strerror(errno));
 	close(fd1);
 }
 
@@ -316,14 +327,4 @@ static void cleanup(void)
 		unlink(filename);
 
 	tst_rmdir();
-
-}
-#else /* O_DIRECT */
-
-int main()
-{
-
-	tst_resm(TCONF, "O_DIRECT is not defined.");
-	return 0;
 }
-#endif /* O_DIRECT */
diff --git a/testcases/kernel/io/direct_io/diotest6.c b/testcases/kernel/io/direct_io/diotest6.c
index 119aafb..221b254 100644
--- a/testcases/kernel/io/direct_io/diotest6.c
+++ b/testcases/kernel/io/direct_io/diotest6.c
@@ -51,8 +51,6 @@
 char *TCID = "diotest06";
 int TST_TOTAL = 3;
 
-#ifdef O_DIRECT
-
 #define	BUFSIZE	4096
 #define TRUE 1
 #define LEN 30
@@ -62,7 +60,7 @@ int TST_TOTAL = 3;
 
 static int iter = 100;
 static int bufsize = BUFSIZE;
-static off64_t offset = 0;
+static off64_t offset;
 static int nvector = 20;
 static char filename[LEN];
 static int fd1 = -1;
@@ -86,6 +84,7 @@ int runtest(int fd_r, int fd_w, int childnum, int action)
 {
 	off64_t seekoff;
 	int i, bufsize = BUFSIZE;
+	int ret;
 	char *buf1, *buf2;
 
 	buf1 = valloc(BUFSIZE);
@@ -127,8 +126,9 @@ int runtest(int fd_r, int fd_w, int childnum, int action)
 				 strerror(errno));
 			return (-1);
 		}
-		int ret;
-		if ((ret = read(fd_r, buf2, bufsize)) < bufsize) {
+		ret = read(fd_r, buf2, bufsize);
+
+		if (ret < bufsize) {
 			tst_resm(TFAIL, "read failed: %s", strerror(errno));
 			return (-1);
 		}
@@ -144,18 +144,20 @@ int runtest(int fd_r, int fd_w, int childnum, int action)
 /*
  * child_function: open the file for read and write. Call the runtest routine.
 */
-int child_function(int childnum, int action)
+static int child_function(int childnum, int action)
 {
 	int fd_w, fd_r;
 
 	switch (action) {
 	case READ_DIRECT:
-		if ((fd_w = open(filename, O_WRONLY | O_CREAT, 0666)) < 0) {
+		fd_w = open(filename, O_WRONLY | O_CREAT, 0666);
+		if (fd_w < 0) {
 			tst_resm(TFAIL, "fd_w open failed for %s: %s",
 				 filename, strerror(errno));
 			return (-1);
 		}
-		if ((fd_r = open(filename, O_DIRECT | O_RDONLY, 0666)) < 0) {
+		fd_r = open(filename, O_DIRECT | O_RDONLY, 0666);
+		if (fd_r < 0) {
 			tst_resm(TFAIL, "fd_r open failed for %s: %s",
 				 filename, strerror(errno));
 			close(fd_w);
@@ -171,13 +173,14 @@ int child_function(int childnum, int action)
 		}
 		break;
 	case WRITE_DIRECT:
-		if ((fd_w =
-		     open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666)) < 0) {
+		fd_w = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
+		if (fd_w < 0) {
 			tst_resm(TFAIL, "fd_w open failed for %s: %s", filename,
 				 strerror(errno));
 			return (-1);
 		}
-		if ((fd_r = open(filename, O_RDONLY, 0666)) < 0) {
+		fd_r = open(filename, O_RDONLY, 0666);
+		if (fd_r < 0) {
 			tst_resm(TFAIL, "fd_r open failed for %s: %s",
 				 filename, strerror(errno));
 			close(fd_w);
@@ -193,13 +196,14 @@ int child_function(int childnum, int action)
 		}
 		break;
 	case RDWR_DIRECT:
-		if ((fd_w =
-		     open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666)) < 0) {
+		fd_w = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
+		if (fd_w < 0) {
 			tst_resm(TFAIL, "fd_w open failed for %s: %s", filename,
 				 strerror(errno));
 			return (-1);
 		}
-		if ((fd_r = open(filename, O_DIRECT | O_RDONLY, 0666)) < 0) {
+		fd_r = open(filename, O_DIRECT | O_RDONLY, 0666);
+		if (fd_r < 0) {
 			tst_resm(TFAIL, "fd_r open failed for %s: %s",
 				 filename, strerror(errno));
 			close(fd_w);
@@ -233,7 +237,8 @@ int main(int argc, char *argv[])
 	while ((i = getopt(argc, argv, "b:o:i:n:v:f:")) != -1) {
 		switch (i) {
 		case 'b':
-			if ((bufsize = atoi(optarg)) <= 0) {
+			bufsize = atoi(optarg);
+			if ((bufsize) <= 0) {
 				fprintf(stderr, "bufsize must be > 0\n");
 				prg_usage();
 			}
@@ -244,25 +249,29 @@ int main(int argc, char *argv[])
 			}
 			break;
 		case 'o':
-			if ((offset = atoi(optarg)) <= 0) {
+			offset = atoi(optarg);
+			if (offset <= 0) {
 				fprintf(stderr, "offset must be > 0\n");
 				prg_usage();
 			}
 			break;
 		case 'i':
-			if ((iter = atoi(optarg)) <= 0) {
+			iter = atoi(optarg);
+			if (iter <= 0) {
 				fprintf(stderr, "iterations must be > 0\n");
 				prg_usage();
 			}
 			break;
 		case 'n':
-			if ((numchild = atoi(optarg)) <= 0) {
+			numchild = atoi(optarg);
+			if (numchild <= 0) {
 				fprintf(stderr, "no of children must be > 0\n");
 				prg_usage();
 			}
 			break;
 		case 'v':
-			if ((nvector = atoi(optarg)) <= 0) {
+			nvector = atoi(optarg);
+			if (nvector <= 0) {
 				fprintf(stderr, "vectory array must be > 0\n");
 				prg_usage();
 			}
@@ -343,18 +352,22 @@ static void setup(void)
 {
 	tst_tmpdir();
 
-	if ((fd1 = open(filename, O_CREAT | O_EXCL, 0600)) < 0) {
+	fd1 = open(filename, O_CREAT | O_EXCL, 0600);
+	if (fd1 < 0) {
 		tst_brkm(TBROK, cleanup, "Couldn't create test file %s: %s",
 			 filename, strerror(errno));
 	}
 	close(fd1);
 
 	/* Test for filesystem support of O_DIRECT */
-	if ((fd1 = open(filename, O_DIRECT, 0600)) < 0) {
+	fd1 = open(filename, O_DIRECT, 0600);
+	if (fd1 < 0 && errno == EINVAL)
 		tst_brkm(TCONF, cleanup,
 			 "O_DIRECT is not supported by this filesystem. %s",
 			 strerror(errno));
-	}
+	else if (fd1 < 0)
+		tst_brkm(TBROK, cleanup, "Couldn't open test file %s: %s",
+			 filename, strerror(errno));
 	close(fd1);
 }
 
@@ -365,12 +378,3 @@ static void cleanup(void)
 
 	tst_rmdir();
 }
-
-#else /* O_DIRECT */
-
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "O_DIRECT is not defined.");
-}
-
-#endif /* O_DIRECT */
diff --git a/testcases/kernel/io/direct_io/diotest_routines.c b/testcases/kernel/io/direct_io/diotest_routines.c
index fe03630..3d98165 100644
--- a/testcases/kernel/io/direct_io/diotest_routines.c
+++ b/testcases/kernel/io/direct_io/diotest_routines.c
@@ -1,20 +1,20 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2002
+ *  04/30/2002 Narasimha Sharoff nsharoff@us.ibm.com
  *
- *   Copyright (c) International Business Machines  Corp., 2002
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
@@ -45,6 +45,8 @@
 #include <unistd.h>
 #include <ctype.h>
 
+#include "test.h"
+#include "safe_macros.h"
 #include "diotest_routines.h"
 
 /* **** Routines for buffer actions, comparisions **** */
@@ -55,20 +57,15 @@
 */
 void fillbuf(char *buf, int count, char value)
 {
-	while (count > 0) {
-		strncpy(buf, &value, 1);
-		buf++;
-		count = count - 1;
-	}
+	memset(buf, value, count);
 }
 
 void vfillbuf(struct iovec *iv, int vcnt, char value)
 {
 	int i;
 
-	for (i = 0; i < vcnt; iv++, i++) {
+	for (i = 0; i < vcnt; iv++, i++)
 		fillbuf(iv->iov_base, iv->iov_len, (char)value);
-	}
 }
 
 /*
@@ -84,10 +81,10 @@ int bufcmp(char *b1, char *b2, int bsize)
 			fprintf(stderr,
 				"bufcmp: offset %d: Expected: 0x%x, got 0x%x\n",
 				i, b1[i], b2[i]);
-			return (-1);
+			return -1;
 		}
 	}
-	return (0);
+	return 0;
 }
 
 int vbufcmp(struct iovec *iv1, struct iovec *iv2, int vcnt)
@@ -116,16 +113,18 @@ int filecmp(char *f1, char *f2)
 	char buf1[BUFSIZ], buf2[BUFSIZ];
 
 	/* Open the file for read */
-	if ((fd1 = open(f1, O_RDONLY)) == -1) {
+	fd1 = open(f1, O_RDONLY);
+	if (fd1 == -1) {
 		fprintf(stderr, "compare_files: open failed %s: %s",
 			f1, strerror(errno));
-		return (-1);
+		return -1;
 	}
-	if ((fd2 = open(f2, O_RDONLY)) == -1) {
+	fd2 = open(f2, O_RDONLY);
+	if (fd2 == -1) {
 		fprintf(stderr, "compare_files: open failed %s: %s",
 			f2, strerror(errno));
 		close(fd1);
-		return (-1);
+		return -1;
 	}
 
 	/* Compare the files */
@@ -137,7 +136,7 @@ int filecmp(char *f1, char *f2)
 				ret1, f1, ret2, f2);
 			close(fd1);
 			close(fd2);
-			return (-1);
+			return -1;
 		}
 		for (i = 0; i < ret1; i++) {
 			if (strncmp(&buf1[i], &buf2[i], 1)) {
@@ -150,7 +149,7 @@ int filecmp(char *f1, char *f2)
 					isprint(buf2[i]) ? buf2[i] : '.');
 				close(fd1);
 				close(fd2);
-				return (-1);
+				return -1;
 			}
 		}
 	}
@@ -169,13 +168,15 @@ int forkchldrn(int **pidlst, int numchld, int action, int (*chldfunc) ())
 {
 	int i, cpid;
 
-	if ((*pidlst = ((int *)malloc(sizeof(int) * numchld))) == 0) {
+	*pidlst = ((int *) malloc(sizeof(int) * numchld));
+	if (*pidlst == NULL) {
 		fprintf(stderr, "forkchldrn: calloc failed for pidlst: %s\n",
 			strerror(errno));
 		return (-1);
 	}
 	for (i = 0; i < numchld; i++) {
-		if ((cpid = fork()) < 0) {
+		cpid = tst_fork();
+		if (cpid < 0) {
 			fprintf(stderr,
 				"forkchldrn: fork child %d failed, %s\n", i,
 				strerror(errno));
@@ -209,7 +210,7 @@ int killchldrn(int **pidlst, int numchld, int sig)
 			}
 		}
 	}
-	return (errflag);
+	return errflag;
 }
 
 /*
@@ -224,7 +225,8 @@ int waitchldrn(int **pidlst, int numchld)
 		cpid = *(*pidlst + i);
 		if (cpid == 0)
 			continue;
-		if ((ret = waitpid(cpid, &status, 0)) != cpid) {
+		ret = waitpid(cpid, &status, 0);
+		if (ret != cpid) {
 			fprintf(stderr,
 				"waitchldrn: wait failed for child %d, pid %d: %s\n",
 				i, cpid, strerror(errno));
@@ -233,5 +235,5 @@ int waitchldrn(int **pidlst, int numchld)
 		if (status)
 			errflag = -1;
 	}
-	return (errflag);
+	return errflag;
 }
diff --git a/testcases/kernel/io/direct_io/diotest_routines.h b/testcases/kernel/io/direct_io/diotest_routines.h
index e09889f..f5dd746 100644
--- a/testcases/kernel/io/direct_io/diotest_routines.h
+++ b/testcases/kernel/io/direct_io/diotest_routines.h
@@ -1,12 +1,34 @@
-struct iovec;
-extern void fillbuf(char *buf, int count, char value);
-extern void vfillbuf(struct iovec *iv, int vcnt, char value);
-extern int filecmp(char *f1, char *f2);
-extern int bufcmp(char *b1, char *b2, int bsize);
-extern int vbufcmp(struct iovec *iv1, struct iovec *iv2, int vcnt);
+/*
+ * Copyright (c) International Business Machines  Corp., 2002
+ *  04/30/2002 Narasimha Sharoff nsharoff@us.ibm.com
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
 
-extern int forkchldrn(int **pidlst, int numchld, int action, int (*chldfunc)());
-extern int waitchldrn(int **pidlst, int numchld);
-extern int killchldrn(int **pidlst, int numchld, int sig);
+#ifndef DIOTEST_ROUTINES_H
+#define DIOTEST_ROUTINES_H
 
+#include "lapi/fcntl.h"
 
+void fillbuf(char *buf, int count, char value);
+void vfillbuf(struct iovec *iv, int vcnt, char value);
+int filecmp(char *f1, char *f2);
+int bufcmp(char *b1, char *b2, int bsize);
+int vbufcmp(struct iovec *iv1, struct iovec *iv2, int vcnt);
+int forkchldrn(int **pidlst, int numchld, int action, int (*chldfunc)());
+int waitchldrn(int **pidlst, int numchld);
+int killchldrn(int **pidlst, int numchld, int sig);
+
+#endif /* DIOTEST_ROUTINES_H */
-- 
2.1.4

