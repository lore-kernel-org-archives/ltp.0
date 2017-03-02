From: Eryu Guan <eguan@redhat.com>
Date: Thu,  2 Mar 2017 21:33:21 +0800
Subject: [LTP] [PATCH 1/3] diotest: use user specified bufsize correctly
Message-ID: <20170302133323.5262-1-eguan@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In diotestN, option b is used to specify the buffer size used in the
tests, but some tests are overriding this user specified size with
the default value (BUFSIZE).

So always use 'bufsize' once it's initialized by user specified
value.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 testcases/kernel/io/direct_io/diotest2.c |  9 +++++----
 testcases/kernel/io/direct_io/diotest3.c |  1 -
 testcases/kernel/io/direct_io/diotest4.c | 10 +++++-----
 testcases/kernel/io/direct_io/diotest5.c |  2 +-
 testcases/kernel/io/direct_io/diotest6.c |  6 +++---
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/io/direct_io/diotest2.c b/testcases/kernel/io/direct_io/diotest2.c
index 15ae932..c32dbeb 100644
--- a/testcases/kernel/io/direct_io/diotest2.c
+++ b/testcases/kernel/io/direct_io/diotest2.c
@@ -69,6 +69,10 @@ int TST_TOTAL = 3;		/* Total number of test conditions */
 #define WRITE_DIRECT 2
 #define RDWR_DIRECT 3
 
+int fd1 = -1;
+char filename[LEN];
+int bufsize = BUFSIZE;
+
 /*
  * runtest: write the data to the file. Read the data from the file and compare.
  *	For each iteration, write data starting at offse+iter*bufsize
@@ -78,7 +82,7 @@ int runtest(int fd_r, int fd_w, int iter, off64_t offset, int action)
 {
 	char *buf1;
 	char *buf2;
-	int i, bufsize = BUFSIZE;
+	int i;
 
 	/* Allocate for buffers */
 	if ((buf1 = valloc(bufsize)) == 0) {
@@ -129,15 +133,12 @@ void prg_usage()
 	exit(1);
 }
 
-int fd1 = -1;
-char filename[LEN];
 static void setup(void);
 static void cleanup(void);
 
 int main(int argc, char *argv[])
 {
 	int iter = 100;		/* Iterations. Default 100 */
-	int bufsize = BUFSIZE;	/* Buffer size. Default 4k */
 	off64_t offset = 0;	/* Offset. Default 0 */
 	int i, action, fd_r, fd_w;
 	int fail_count = 0, total = 0, failed = 0;
diff --git a/testcases/kernel/io/direct_io/diotest3.c b/testcases/kernel/io/direct_io/diotest3.c
index 5e204e7..efbc79d 100644
--- a/testcases/kernel/io/direct_io/diotest3.c
+++ b/testcases/kernel/io/direct_io/diotest3.c
@@ -96,7 +96,6 @@ int runtest(int fd_r, int fd_w, int childnum, int action)
 	char *buf1;
 	char *buf2;
 	off_t seekoff;
-	int bufsize = BUFSIZE;
 	int i;
 
 	/* Allocate for buffers */
diff --git a/testcases/kernel/io/direct_io/diotest4.c b/testcases/kernel/io/direct_io/diotest4.c
index e9a7ac4..d8a3a42 100644
--- a/testcases/kernel/io/direct_io/diotest4.c
+++ b/testcases/kernel/io/direct_io/diotest4.c
@@ -224,19 +224,19 @@ int main(int argc, char *argv[])
 		tst_brkm(TBROK, cleanup, "open failed for %s: %s",
 			 filename, strerror(errno));
 	}
-	if ((buf0 = valloc(BUFSIZE)) == NULL) {
+	if ((buf0 = valloc(bufsize)) == NULL) {
 		tst_brkm(TBROK, cleanup, "valloc() buf0 failed: %s",
 			 strerror(errno));
 	}
 	for (i = 1; i < fblocks; i++) {
-		fillbuf(buf0, BUFSIZE, (char)i);
-		if (write(fd, buf0, BUFSIZE) < 0) {
+		fillbuf(buf0, bufsize, (char)i);
+		if (write(fd, buf0, bufsize) < 0) {
 			tst_brkm(TBROK, cleanup, "write failed for %s: %s",
 				 filename, strerror(errno));
 		}
 	}
 	close(fd);
-	if ((buf2 = valloc(BUFSIZE)) == NULL) {
+	if ((buf2 = valloc(bufsize)) == NULL) {
 		tst_brkm(TBROK, cleanup, "valloc() buf2 failed: %s",
 			 strerror(errno));
 	}
@@ -284,7 +284,7 @@ int main(int argc, char *argv[])
 	total++;
 
 	/* Test-4: Read beyond the file size */
-	offset = BUFSIZE * (fblocks + 10);
+	offset = bufsize * (fblocks + 10);
 	count = bufsize;
 	if (lseek(fd, offset, SEEK_SET) < 0) {
 		tst_resm(TFAIL, "lseek failed: %s", strerror(errno));
diff --git a/testcases/kernel/io/direct_io/diotest5.c b/testcases/kernel/io/direct_io/diotest5.c
index 2c3774a..dc4ecd1 100644
--- a/testcases/kernel/io/direct_io/diotest5.c
+++ b/testcases/kernel/io/direct_io/diotest5.c
@@ -84,7 +84,7 @@ static int fd1 = -1;
 */
 int runtest(int fd_r, int fd_w, int iter, off64_t offset, int action)
 {
-	int i, bufsize = BUFSIZE;
+	int i;
 	struct iovec *iov1, *iov2, *iovp;
 
 	/* Allocate for buffers and data pointers */
diff --git a/testcases/kernel/io/direct_io/diotest6.c b/testcases/kernel/io/direct_io/diotest6.c
index 42e1d34..5594e04 100644
--- a/testcases/kernel/io/direct_io/diotest6.c
+++ b/testcases/kernel/io/direct_io/diotest6.c
@@ -85,11 +85,11 @@ static void prg_usage(void)
 int runtest(int fd_r, int fd_w, int childnum, int action)
 {
 	off64_t seekoff;
-	int i, bufsize = BUFSIZE;
+	int i;
 	char *buf1, *buf2;
 
-	buf1 = valloc(BUFSIZE);
-	buf2 = valloc(BUFSIZE);
+	buf1 = valloc(bufsize);
+	buf2 = valloc(bufsize);
 
 	if (!buf1 || !buf2) {
 		tst_resm(TBROK | TERRNO, "valloc() failed");
-- 
2.9.3

