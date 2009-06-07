Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MIYL9-0004sE-IP
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 01:28:55 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MIYL8-0005R6-0a
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 01:28:55 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7A7E610661EB7
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Jun 2009 03:05:18 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #277) id 1MIXyH-0003lZ-00
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 03:05:17 +0200
Date: Sun, 07 Jun 2009 12:09:36 +0200
From: "Jiri Palecek >" <"<jirka"@suse.de>(none)
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.uvwirkq3lwynca@debian>
Subject: [LTP] [PATCH] Setup and cleanup routines for diotest
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20090607100936.sqM-Jtdm3wrg0iy_AsQZf7uNliapuTehVLjeayXRaKE@z>

Hello,

this patch makes the cleanup procedure in diotest more robust. Particularly:

 - simplify cleanup by creating setup and cleanup routines

 - use tst_tmpdir() to create the test files in a temporary
   directory. Note that you can still make it use a different path
   with the -f filename option

 - delete the file in the case it was created, but couldn't be opened
   with O_DIRECT

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/kernel/io/direct_io/diotest2.c  |   67 +++++++++-------
 testcases/kernel/io/direct_io/diotest3.c  |   43 +++++++---
 testcases/kernel/io/direct_io/diotest4.c  |  123 +++++++++++++---------------
 testcases/kernel/io/direct_io/diotest5.c  |   62 +++++++++------
 testcases/kernel/io/direct_io/diotest6.c  |   41 ++++++++--
 5 files changed, 207 insertions(+), 143 deletions(-)

diff --git a/testcases/kernel/io/direct_io/diotest2.c b/testcases/kernel/io/direct_io/diotest2.c
index 3e2feb8..fb87094 100644
--- a/testcases/kernel/io/direct_io/diotest2.c
+++ b/testcases/kernel/io/direct_io/diotest2.c
@@ -133,6 +133,10 @@ prg_usage()
 	tst_exit();
 }
 
+int fd1 = -1;
+char	filename[LEN];
+static void setup(void);
+static void cleanup(void);
 
 int
 main(int argc, char *argv[])
@@ -140,9 +144,8 @@ main(int argc, char *argv[])
 	int	iter = 100;		/* Iterations. Default 100 */
 	int	bufsize = BUFSIZE;	/* Buffer size. Default 4k */
 	off64_t	offset = 0;		/* Offset. Default 0 */
-	int	i, action, fd_r, fd_w, fd1;
+	int	i, action, fd_r, fd_w;
 	int	fail_count = 0, total = 0, failed = 0;
-	char	filename[LEN];
 
 	/* Options */
 	sprintf(filename,"testdata-2.%ld", syscall(__NR_gettid));
@@ -178,27 +181,17 @@ main(int argc, char *argv[])
 		}
 	}
 
-        /* Test for filesystem support of O_DIRECT */
-        if ((fd1 = open(filename, O_DIRECT|O_CREAT, 0666)) < 0) {
-                 tst_resm(TCONF,"O_DIRECT is not supported by this filesystem.");
-                 tst_exit();
-        }else{
-                close(fd1);
-        }
+	setup();
 
 	/* Testblock-1: Read with Direct IO, Write without */
 	action = READ_DIRECT;
 	if ((fd_w = open(filename, O_WRONLY|O_CREAT, 0666)) < 0) {
-		tst_resm(TFAIL, "fd_w,open failed for %s: %s",
+		tst_brkm(TBROK, cleanup, "fd_w,open failed for %s: %s",
 			filename, strerror(errno));
-		tst_exit ();
 	}
 	if ((fd_r = open(filename, O_DIRECT|O_RDONLY, 0666)) < 0) {
-		tst_resm(TFAIL, "fd_r,open failed for %s: %s",
+		tst_brkm(TBROK, cleanup, "fd_r,open failed for %s: %s",
 			filename, strerror(errno));
-		close(fd_w);
-		unlink (filename);
-		tst_exit();
 	}
 	if (runtest(fd_r, fd_w, iter, offset, action) < 0) {
 		failed = TRUE;
@@ -217,16 +210,12 @@ main(int argc, char *argv[])
 	/* Testblock-2: Write with Direct IO, Read without */
 	action = WRITE_DIRECT;
 	if ((fd_w = open(filename, O_DIRECT|O_WRONLY|O_CREAT, 0666)) < 0) {
-		tst_resm(TFAIL, "fd_w,open failed for %s: %s",
+		tst_brkm(TBROK, cleanup, "fd_w,open failed for %s: %s",
 			filename, strerror(errno));
-		tst_exit();
 	}
 	if ((fd_r = open(filename, O_RDONLY|O_CREAT, 0666)) < 0) {
-		tst_resm(TFAIL, "fd_r,open failed for %s: %s",
+		tst_brkm(TBROK, cleanup, "fd_r,open failed for %s: %s",
 			filename, strerror(errno));
-		close(fd_w);
-		unlink (filename);
-		tst_exit();
 	}
 	if (runtest(fd_r, fd_w, iter, offset, action) < 0) {
 		failed = TRUE;
@@ -243,16 +232,12 @@ main(int argc, char *argv[])
 	/* Testblock-3: Read, Write with Direct IO. */
 	action = RDWR_DIRECT;
 	if ((fd_w = open(filename, O_DIRECT|O_WRONLY|O_CREAT, 0666)) < 0) {
-		tst_resm(TFAIL, "fd_w,open failed for %s: %s",
+		tst_brkm(TBROK, cleanup, "fd_w,open failed for %s: %s",
 			filename, strerror(errno));
-		tst_exit();
 	}
 	if ((fd_r = open(filename, O_DIRECT|O_RDONLY|O_CREAT, 0666)) < 0) {
-		tst_resm(TFAIL, "fd_r,open failed for %s: %s",
+		tst_brkm(TBROK, cleanup, "fd_r,open failed for %s: %s",
 			filename, strerror(errno));
-		close (fd_w);
-		unlink (filename);
-		tst_exit();
 	}
 	if (runtest(fd_r, fd_w, iter, offset, action) < 0) {
 		failed = TRUE;
@@ -273,10 +258,36 @@ main(int argc, char *argv[])
 		tst_resm(TINFO, "%d testblocks %d iterations completed",
 			total, iter);
 	}
-	tst_exit ();
+	cleanup();
 	return 0;
 }
 
+static void setup(void)
+{
+	tst_tmpdir();
+
+	if ((fd1 = open(filename, O_CREAT|O_EXCL, 0600)) < 0) {
+		tst_brkm(TBROK, cleanup, "Couldn't create test file %s: %s", filename, strerror(errno));
+	}
+	close(fd1);
+
+	/* Test for filesystem support of O_DIRECT */
+	if ((fd1 = open(filename, O_DIRECT, 0600)) < 0) {
+		tst_brkm(TCONF, cleanup, "O_DIRECT is not supported by this filesystem. %s", strerror(errno));
+	}
+
+}
+
+static void cleanup(void)
+{
+	if(fd1 != -1)
+		unlink(filename);
+
+	tst_rmdir();
+
+	tst_exit();
+}
+
 #else /* O_DIRECT */
 
 int
diff --git a/testcases/kernel/io/direct_io/diotest3.c b/testcases/kernel/io/direct_io/diotest3.c
index db6815b..5ef5d67 100644
--- a/testcases/kernel/io/direct_io/diotest3.c
+++ b/testcases/kernel/io/direct_io/diotest3.c
@@ -227,6 +227,9 @@ child_function(int childnum, int action)
 	exit(0);
 }
 
+static void setup(void);
+static void cleanup(void);
+static int fd1 = -1;
 
 int
 main(int argc, char *argv[])
@@ -234,7 +237,6 @@ main(int argc, char *argv[])
 	int	*pidlst;
 	int	numchild = 1;	/* Number of children. Default 5 */
 	int	i, fail_count = 0, failed = 0, total = 0;
-	int     fd1;
 
 	/* Options */
 	while ((i = getopt(argc, argv, "b:o:i:n:f:")) != -1) {
@@ -276,13 +278,7 @@ main(int argc, char *argv[])
 	}
 	sprintf(filename,"testdata-3.%ld", syscall(__NR_gettid));
 
-        /* Test for filesystem support of O_DIRECT */
-        if ((fd1 = open(filename, O_DIRECT|O_CREAT, 0666)) < 0) {
-                 tst_resm(TCONF,"O_DIRECT is not supported by this filesystem.");
-                 tst_exit();
-        }else{
-                close(fd1);
-        }
+	setup();
 
 
 	/* Testblock-1: Read with Direct IO, Write without */
@@ -346,15 +342,38 @@ main(int argc, char *argv[])
 	if (failed) {
 		tst_resm(TINFO, "%d/%d testblocks failed",
 			fail_count, total);
-		tst_exit();
 	}
-	tst_resm(TINFO, "%d testblocks %d iterations with %d children completed",
-			total, iter, numchild);
-	tst_exit();
+	else
+		tst_resm(TINFO, "%d testblocks %d iterations with %d children completed",
+						 total, iter, numchild);
+	cleanup();
 	return 0;
 }
 
+static void setup(void)
+{
+	tst_tmpdir();
+
+	if ((fd1 = open(filename, O_CREAT|O_EXCL, 0600)) < 0) {
+		tst_brkm(TBROK, cleanup, "Couldn't create test file %s: %s", filename, strerror(errno));
+	}
+	close(fd1);
+
+	/* Test for filesystem support of O_DIRECT */
+	if ((fd1 = open(filename, O_DIRECT, 0600)) < 0) {
+		tst_brkm(TCONF, cleanup, "O_DIRECT is not supported by this filesystem. %s", strerror(errno));
+	}
+}
+
+static void cleanup(void)
+{
+	if(fd1 != -1)
+		unlink(filename);
+
+	tst_rmdir();
 
+	tst_exit();
+}
 #else /* O_DIRECT */
 
 int
diff --git a/testcases/kernel/io/direct_io/diotest4.c b/testcases/kernel/io/direct_io/diotest4.c
index 362b993..1c3fa0e 100644
--- a/testcases/kernel/io/direct_io/diotest4.c
+++ b/testcases/kernel/io/direct_io/diotest4.c
@@ -178,6 +178,11 @@ prg_usage()
         exit(1);
 }
 
+static void setup(void);
+static void cleanup(void);
+static int fd1 = -1;
+static char filename[LEN];
+
 int
 main(int argc, char *argv[])
 {
@@ -185,15 +190,13 @@ main(int argc, char *argv[])
         int     bufsize = BUFSIZE;
         int     count, ret;
 	int     offset;
-        int     fd, newfd, fd1;
+        int     fd, newfd;
         int     i, l_fail = 0, fail_count = 0, total = 0;
 	int	failed = 0;
 	int	shmsz = SHMLBA;
 	int	pagemask = ~(sysconf(_SC_PAGE_SIZE) - 1);
         char    *buf0, *buf1, *buf2;
-	char	filename[LEN];
 	caddr_t	shm_base;
-	struct	sigaction act;
 
 	/* Options */
 	while ((i = getopt(argc, argv, "b:")) != -1) {
@@ -208,50 +211,31 @@ main(int argc, char *argv[])
 			prg_usage();
 		}
 	}
-	act.sa_handler = SIG_IGN;
-	(void) sigaction(SIGXFSZ, &act, NULL);
-        sprintf(filename,"testdata-4.%ld", syscall(__NR_gettid));
-
-        /* Test for filesystem support of O_DIRECT */
-        if ((fd1 = open(filename, O_DIRECT|O_CREAT, 0666)) < 0) {
-                 tst_resm(TCONF,"O_DIRECT is not supported by this filesystem.");
-                 tst_exit();
-        }else{
-                close(fd1);
-        }
+
+	setup();
 
 	/* Open file and fill, allocate for buffer */
         if ((fd = open(filename, O_DIRECT|O_RDWR|O_CREAT, 0666)) < 0) {
-		tst_resm(TFAIL, "open failed for %s: %s",
+		tst_brkm(TBROK, cleanup, "open failed for %s: %s",
 			filename, strerror(errno));
-                tst_exit();
         }
         if ((buf0 = valloc(BUFSIZE)) == NULL) {
-		tst_resm(TFAIL, "valloc() buf0 failed: %s", strerror(errno));
-                unlink(filename);
-                tst_exit();
+		tst_brkm(TBROK, cleanup, "valloc() buf0 failed: %s", strerror(errno));
         }
         for (i = 1; i < fblocks; i++) {
                 fillbuf(buf0, BUFSIZE, (char)i);
                 if (write(fd, buf0, BUFSIZE) < 0) {
-			tst_resm(TFAIL, "write failed for %s: %s",
+			tst_brkm(TBROK, cleanup, "write failed for %s: %s",
 				filename, strerror(errno));
-			close(fd);
-                        unlink(filename);
-                        tst_exit();
                 }
         }
 	close(fd);
         if ((buf2 = valloc(BUFSIZE)) == NULL) {
-		tst_resm(TFAIL, "valloc() buf2 failed: %s", strerror(errno));
-                unlink(filename);
-                tst_exit();
+		tst_brkm(TBROK, cleanup, "valloc() buf2 failed: %s", strerror(errno));
         }
         if ((fd = open(filename, O_DIRECT|O_RDWR)) < 0) {
-		tst_resm(TFAIL, "open failed for %s: %s",
+		tst_brkm(TBROK, cleanup, "open failed for %s: %s",
 				filename, strerror(errno));
-                unlink(filename);
-                tst_exit();
         }
 
 	/* Test-1: Negative Offset */
@@ -349,9 +333,7 @@ main(int argc, char *argv[])
 	offset = 4096;
 	count = bufsize;
         if (close(fd) < 0) {
-		tst_resm(TFAIL, "can't close fd %d: %s", fd, strerror(errno));
-                unlink(filename);
-                tst_exit();
+		tst_brkm(TBROK, cleanup, "can't close fd %d: %s", fd, strerror(errno));
         }
 	ret = runtest_f(fd, buf2, offset, count, EBADF, 7, "closed fd");
 	if (ret != 0) {
@@ -387,24 +369,18 @@ main(int argc, char *argv[])
 	/* Test-10: read, write to a mmaped file */
 	shm_base = (char *)(((long)sbrk(0) + (shmsz-1)) & ~(shmsz-1));
         if (shm_base == NULL) {
-		tst_resm(TFAIL, "sbrk failed: %s", strerror(errno));
-                unlink(filename);
-                tst_exit();
+		tst_brkm(TBROK, cleanup, "sbrk failed: %s", strerror(errno));
         }
 	offset = 4096;
 	count = bufsize;
 	if ((fd = open(filename, O_DIRECT|O_RDWR)) < 0) {
-		tst_resm(TFAIL, "can't open %s: %s",
+		tst_brkm(TBROK, cleanup, "can't open %s: %s",
 			filename, strerror(errno));
-                unlink(filename);
-                tst_exit();
         }
 	shm_base = mmap(shm_base, 0x100000, PROT_READ|PROT_WRITE,
 		        MAP_SHARED|MAP_FIXED, fd, 0);
         if (shm_base == (caddr_t)-1) {
-                tst_resm(TFAIL, "can't mmap file: %s", strerror(errno));
-                unlink(filename);
-                tst_exit();
+		tst_brkm(TBROK, cleanup, "can't mmap file: %s", strerror(errno));
         }
 	ret = runtest_s(fd, buf2, offset, count, 10, "mmapped file");
 	if (ret != 0) {
@@ -419,9 +395,7 @@ main(int argc, char *argv[])
 
 	/* Test-11: read, write to an unmaped file with munmap */
 	if ((ret = munmap(shm_base, 0x100000)) < 0) {
-                tst_resm(TFAIL, "can't unmap file: %s", strerror(errno));
-                unlink(filename);
-                tst_exit();
+		tst_brkm(TBROK, cleanup, "can't unmap file: %s", strerror(errno));
         }
 	ret = runtest_s(fd, buf2, offset, count, 11, "unmapped file");
 	if (ret != 0) {
@@ -438,10 +412,8 @@ main(int argc, char *argv[])
 	offset = 4096;
 	count = bufsize;
         if ((fd = open(filename, O_DIRECT|O_WRONLY)) < 0) {
-		tst_resm(TFAIL, "can't open %s: %s",
+		tst_brkm(TBROK, cleanup, "can't open %s: %s",
 			filename, strerror(errno));
-                unlink(filename);
-                tst_exit();
         }
 	if (lseek(fd, offset, SEEK_SET) < 0) {
 		tst_resm(TFAIL, "lseek failed: %s", strerror(errno));
@@ -466,10 +438,8 @@ main(int argc, char *argv[])
 	offset = 4096;
 	count = bufsize;
 	if ((fd = open(filename, O_DIRECT|O_RDONLY)) < 0) {
-		tst_resm(TFAIL, "can't open %s: %s",
+		tst_brkm(TBROK, cleanup, "can't open %s: %s",
 			filename, strerror(errno));
-		unlink(filename);
-		tst_exit();
 	}
 	if (lseek(fd, offset, SEEK_SET) < 0) {
 		tst_resm(TFAIL, "lseek failed: %s", strerror(errno));
@@ -495,10 +465,8 @@ main(int argc, char *argv[])
 	count = bufsize;
 	l_fail = 0;
         if ((fd = open(filename, O_DIRECT|O_RDWR)) < 0) {
-		tst_resm(TFAIL, "can't open %s: %s",
+		tst_brkm(TBROK, cleanup, "can't open %s: %s",
 			filename, strerror(errno));
-                unlink(filename);
-                tst_exit();
         }
 	if (lseek(fd, offset, SEEK_SET) < 0) {
 		tst_resm(TFAIL, "lseek before read failed: %s",
@@ -540,10 +508,8 @@ main(int argc, char *argv[])
 	count = bufsize;
 	l_fail = 0;
         if ((fd = open(filename, O_DIRECT|O_RDWR)) < 0) {
-                tst_resm(TFAIL, "can't open %s: %s",
+                tst_brkm(TBROK, cleanup, "can't open %s: %s",
 			filename, strerror(errno));
-                unlink(filename);
-                tst_exit();
         }
 	if (lseek(fd, offset, SEEK_SET) < 0) {
 		tst_resm(TFAIL, "lseek before read failed: %s",
@@ -585,15 +551,11 @@ main(int argc, char *argv[])
 	offset = 4096;
 	count = bufsize;
 	if ((buf1 = (char *) (((long)sbrk(0) + (shmsz-1)) & ~(shmsz-1))) == NULL) {
-                tst_resm(TFAIL,"sbrk: %s", strerror(errno));
-                unlink(filename);
-                tst_exit();
+                tst_brkm(TBROK, cleanup,"sbrk: %s", strerror(errno));
         }
         if ((fd = open(filename, O_DIRECT|O_RDWR)) < 0) {
-		tst_resm(TFAIL, "can't open %s: %s",
+		tst_brkm(TBROK, cleanup, "can't open %s: %s",
 			filename, strerror(errno));
-                unlink(filename);
-                tst_exit();
         }
 	ret =runtest_f(fd, buf1, offset, count, EFAULT, 16, " nonexistant space");
 	if (ret != 0) {
@@ -610,10 +572,8 @@ main(int argc, char *argv[])
 	offset = 4096;
 	count = bufsize;
         if ((fd = open(filename,O_DIRECT|O_RDWR|O_SYNC)) < 0) {
-		tst_resm(TFAIL, "can't open %s: %s",
+		tst_brkm(TBROK, cleanup, "can't open %s: %s",
 			filename, strerror(errno));
-                unlink(filename);
-                tst_exit();
         }
 	ret = runtest_s(fd, buf2, offset, count, 17, "opened with O_SYNC");
 	if (ret != 0) {
@@ -634,10 +594,41 @@ main(int argc, char *argv[])
 		tst_resm(TINFO, "%d testblocks completed",
 		 		 total);
 	}
-	tst_exit();
+	cleanup();
 	return 0;
 }
 
+static void setup(void)
+{
+	struct	sigaction act;
+
+	tst_tmpdir();
+
+	act.sa_handler = SIG_IGN;
+	(void) sigaction(SIGXFSZ, &act, NULL);
+	sprintf(filename,"testdata-4.%ld", syscall(__NR_gettid));
+
+	if ((fd1 = open(filename, O_CREAT|O_EXCL, 0600)) < 0) {
+		tst_brkm(TBROK, cleanup, "Couldn't create test file %s: %s", filename, strerror(errno));
+	}
+	close(fd1);
+
+	/* Test for filesystem support of O_DIRECT */
+	if ((fd1 = open(filename, O_DIRECT, 0600)) < 0) {
+		tst_brkm(TCONF, cleanup, "O_DIRECT is not supported by this filesystem. %s", strerror(errno));
+	}
+}
+
+static void cleanup(void)
+{
+	if(fd1 != -1)
+		unlink(filename);
+
+	tst_rmdir();
+
+	tst_exit();
+}
+
 #else /* O_DIRECT */
 
 int
diff --git a/testcases/kernel/io/direct_io/diotest5.c b/testcases/kernel/io/direct_io/diotest5.c
index 6b0b4e5..bda2291 100644
--- a/testcases/kernel/io/direct_io/diotest5.c
+++ b/testcases/kernel/io/direct_io/diotest5.c
@@ -79,7 +79,7 @@ static int	iter = 20;		/* Iterations. Default 20 */
 static int	nvector = 20;		/* Vector array. Default 20 */
 static off64_t	offset = 0;		/* Start offset. Default 0 */
 static char	filename[LEN];		/* Test data file */
-
+static int fd1 = -1;
 /*
  * runtest: Write the data in vector array to the file. Read the data
  *	from the file into another vectory array and verify. Repeat the test.
@@ -166,10 +166,13 @@ prg_usage()
 	exit(1);
 }
 
+static void setup(void);
+static void cleanup(void);
+
 int
 main(int argc, char *argv[])
 {
-	int	i, action, fd_r, fd_w, fd1;
+	int	i, action, fd_r, fd_w;
 	int	fail_count = 0, total = 0, failed = 0;
 
 	/* Options */
@@ -212,26 +215,17 @@ main(int argc, char *argv[])
 		}
 	}
 
-        /* Test for filesystem support of O_DIRECT */
-        if ((fd1 = open(filename, O_DIRECT|O_CREAT, 0666)) < 0) {
-                 tst_resm(TCONF,"O_DIRECT is not supported by this filesystem.");
-                 tst_exit();
-        }else{
-                close(fd1);
-        }
+	setup();
 
 	/* Testblock-1: Read with Direct IO, Write without */
 	action = READ_DIRECT;
 	if ((fd_w = open(filename, O_WRONLY|O_CREAT, 0666)) < 0) {
-		tst_resm(TFAIL, "fd_w open failed for %s: %s",
+		tst_brkm(TBROK, cleanup, "fd_w open failed for %s: %s",
 			filename, strerror(errno));
-		tst_exit();
 	}
 	if ((fd_r = open64(filename, O_DIRECT|O_RDONLY|O_CREAT, 0666)) < 0) {
-		tst_resm(TFAIL, "fd_r open failed for %s: %s",
+		tst_brkm(TBROK, cleanup, "fd_r open failed for %s: %s",
 			filename, strerror(errno));
-		close(fd_w);
-		tst_exit();
 	}
 	if (runtest(fd_r, fd_w, iter, offset, action) < 0) {
 		failed = TRUE;
@@ -249,15 +243,12 @@ main(int argc, char *argv[])
 	/* Testblock-2: Write with Direct IO, Read without */
 	action = WRITE_DIRECT;
 	if ((fd_w = open(filename, O_DIRECT|O_WRONLY|O_CREAT, 0666)) < 0) {
-		tst_resm(TFAIL, "fd_w open failed for %s: %s",
+		tst_brkm(TBROK, cleanup, "fd_w open failed for %s: %s",
 			filename, strerror(errno));
-		tst_exit();
 	}
 	if ((fd_r = open64(filename, O_RDONLY|O_CREAT, 0666)) < 0) {
-		tst_resm(TFAIL, "fd_r open failed for %s: %s",
+		tst_brkm(TBROK, cleanup, "fd_r open failed for %s: %s",
 			filename, strerror(errno));
-		close (fd_w);
-		tst_exit();
 	}
 	if (runtest(fd_r, fd_w, iter, offset, action) < 0) {
 		failed = TRUE;
@@ -274,15 +265,12 @@ main(int argc, char *argv[])
 	/* Testblock-3: Read, Write with Direct IO */
 	action = RDWR_DIRECT;
 	if ((fd_w = open(filename, O_DIRECT|O_WRONLY|O_CREAT, 0666)) < 0) {
-		tst_resm(TFAIL, "fd_w open failed for %s: %s",
+		tst_brkm(TBROK, cleanup, "fd_w open failed for %s: %s",
 			filename, strerror(errno));
-		tst_exit();
 	}
 	if ((fd_r = open64(filename, O_DIRECT|O_RDONLY|O_CREAT, 0666)) < 0) {
-		tst_resm(TFAIL, "fd_r open failed for %s: %s",
+		tst_brkm(TBROK, cleanup, "fd_r open failed for %s: %s",
 			filename, strerror(errno));
-		close (fd_w);
-		tst_exit();
 	}
 	if (runtest(fd_r, fd_w, iter, offset, action) < 0) {
 		failed = TRUE;
@@ -303,11 +291,35 @@ main(int argc, char *argv[])
 		tst_resm(TINFO, "%d testblocks %d iterations with %d vector array completed",
 			total, iter, nvector);
 
-	tst_exit();
+	cleanup();
 
 	return 0;
 }
 
+static void setup(void)
+{
+	tst_tmpdir();
+
+	if ((fd1 = open(filename, O_CREAT|O_EXCL, 0600)) < 0) {
+		tst_brkm(TBROK, cleanup, "Couldn't create test file %s: %s", filename, strerror(errno));
+	}
+	close(fd1);
+
+	/* Test for filesystem support of O_DIRECT */
+	if ((fd1 = open(filename, O_DIRECT, 0600)) < 0) {
+		tst_brkm(TCONF, cleanup, "O_DIRECT is not supported by this filesystem. %s", strerror(errno));
+	}
+}
+
+static void cleanup(void)
+{
+	if(fd1 != -1)
+		unlink(filename);
+
+	tst_rmdir();
+
+	tst_exit();
+}
 #else /* O_DIRECT */
 
 int
diff --git a/testcases/kernel/io/direct_io/diotest6.c b/testcases/kernel/io/direct_io/diotest6.c
index a6d3ca8..65718ca 100644
--- a/testcases/kernel/io/direct_io/diotest6.c
+++ b/testcases/kernel/io/direct_io/diotest6.c
@@ -76,6 +76,10 @@ static int	bufsize = BUFSIZE;	/* Buffersize. Default 4k */
 static off64_t	offset = 0;		/* Offset. Default 0 */
 static int	nvector = 20;		/* Vector array. Default 20 */
 static char	filename[LEN];		/* Test data file */
+static int fd1 = -1;
+
+static void setup(void);
+static void cleanup(void);
 
 /*
  * prg_usage: display the program usage
@@ -185,6 +189,7 @@ child_function(int childnum, int action)
 			tst_resm(TFAIL, "fd_r open failed for %s: %s",
 				filename, strerror(errno));
 			close(fd_w);
+			unlink(filename);
 			return(-1);
 		}
 		if (runtest(fd_r, fd_w, childnum, action) == -1) {
@@ -205,6 +210,7 @@ child_function(int childnum, int action)
 			tst_resm(TFAIL, "fd_r open failed for %s: %s",
 				filename, strerror(errno));
 			close(fd_w);
+			unlink(filename);
 			return(-1);
 		}
 		if (runtest(fd_r, fd_w, childnum, action) == -1) {
@@ -251,7 +257,6 @@ main(int argc, char *argv[])
 	int	*pidlst;
 	int	numchild = 1;	/* Number of children. Default 5 */
 	int	i, fail_count = 0, failed = 0, total = 0;
-	int	fd1;
 
 	/* Options */
 	sprintf(filename,"testdata-6.%ld", syscall(__NR_gettid));
@@ -299,13 +304,7 @@ main(int argc, char *argv[])
 		}
 	}
 
-        /* Test for filesystem support of O_DIRECT */
-        if ((fd1 = open(filename, O_DIRECT|O_CREAT, 0666)) < 0) {
-                 tst_resm(TCONF,"O_DIRECT is not supported by this filesystem.");
-                 tst_exit();
-        }else{
-                close(fd1);
-        }
+	setup();
 
 	/* Testblock-1: Read with Direct IO, Write without */
 	if (forkchldrn(&pidlst, numchild, READ_DIRECT, child_function) < 0 ) {
@@ -371,10 +370,34 @@ main(int argc, char *argv[])
 	else
 		tst_resm(TINFO, "%d testblocks %d iterations with %d children completed",
 			total, iter, numchild);
-	tst_exit();
+	cleanup();
 	return 0;
 }
 
+static void setup(void)
+{
+	tst_tmpdir();
+
+	if ((fd1 = open(filename, O_CREAT|O_EXCL, 0600)) < 0) {
+		tst_brkm(TBROK, cleanup, "Couldn't create test file %s: %s", filename, strerror(errno));
+	}
+	close(fd1);
+
+	/* Test for filesystem support of O_DIRECT */
+	if ((fd1 = open(filename, O_DIRECT, 0600)) < 0) {
+		tst_brkm(TCONF, cleanup, "O_DIRECT is not supported by this filesystem. %s", strerror(errno));
+	}
+}
+
+static void cleanup(void)
+{
+	if(fd1 != -1)
+		unlink(filename);
+
+	tst_rmdir();
+
+	tst_exit();
+}
 
 #else /* O_DIRECT */
 

-- 
1.6.3.1




------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
