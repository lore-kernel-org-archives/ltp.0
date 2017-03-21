From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 21 Mar 2017 16:08:28 +0800
Subject: [LTP] [PATCH] ltp-aiodio: Create the file before fork
In-Reply-To: <58A27792.2090306@cn.fujitsu.com>
References: <58A27792.2090306@cn.fujitsu.com>
Message-ID: <1490083708-32597-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Currently, child's waiting for the file to appear in a loop with
usleep(100000) sometimes is too late to do the read before child
process is killed by parent process, which lead to child misses
the whole test.  Create and truncate the file before fork, then
drop the loop of waiting in read_sparse().

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/io/ltp-aiodio/aiodio_sparse.c | 32 +++++++++-----------------
 testcases/kernel/io/ltp-aiodio/common_sparse.h | 17 +-------------
 testcases/kernel/io/ltp-aiodio/dio_sparse.c    | 28 +++++++++-------------
 3 files changed, 23 insertions(+), 54 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
index 49a0915..d40e45b 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
@@ -43,6 +43,7 @@
 #define NUM_CHILDREN 1000
 
 int debug;
+int fd;
 
 static void setup(void);
 static void cleanup(void);
@@ -56,10 +57,8 @@ int TST_TOTAL = 1;
 /*
  * do async DIO writes to a sparse file
  */
-int aiodio_sparse(char *filename, int align, int writesize, int filesize,
-		  int num_aio)
+int aiodio_sparse(int fd, int align, int writesize, int filesize, int num_aio)
 {
-	int fd;
 	int i, w;
 	struct iocb **iocbs;
 	off_t offset;
@@ -81,15 +80,6 @@ int aiodio_sparse(char *filename, int align, int writesize, int filesize,
 		}
 	}
 
-	fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT | O_EXCL, 0600);
-
-	if (fd < 0) {
-		tst_resm(TBROK | TERRNO, "open()");
-		return 1;
-	}
-
-	SAFE_FTRUNCATE(cleanup, fd, filesize);
-
 	/*
 	 * allocate the iocbs array and iocbs with buffers
 	 */
@@ -100,8 +90,6 @@ int aiodio_sparse(char *filename, int align, int writesize, int filesize,
 		TEST(posix_memalign(&bufptr, align, writesize));
 		if (TEST_RETURN) {
 			tst_resm(TBROK | TRERRNO, "cannot allocate aligned memory");
-			close(fd);
-			unlink(filename);
 			return 1;
 		}
 		memset(bufptr, 0, writesize);
@@ -114,8 +102,6 @@ int aiodio_sparse(char *filename, int align, int writesize, int filesize,
 	 */
 	if ((w = io_submit(myctx, num_aio, iocbs)) < 0) {
 		tst_resm(TBROK, "io_submit() returned %i", w);
-		close(fd);
-		unlink(filename);
 		return 1;
 	}
 
@@ -205,9 +191,6 @@ int aiodio_sparse(char *filename, int align, int writesize, int filesize,
 		}
 	}
 
-	close(fd);
-	unlink(filename);
-
 	return 0;
 }
 
@@ -275,11 +258,16 @@ int main(int argc, char **argv)
 	tst_resm(TINFO, "Dirtying free blocks");
 	dirty_freeblocks(filesize);
 
+	fd = SAFE_OPEN(cleanup, filename,
+		O_DIRECT | O_WRONLY | O_CREAT | O_EXCL, 0600);
+	SAFE_FTRUNCATE(cleanup, fd, filesize);
+
 	tst_resm(TINFO, "Starting I/O tests");
 	signal(SIGTERM, SIG_DFL);
 	for (i = 0; i < num_children; i++) {
 		switch (pid[i] = fork()) {
 		case 0:
+			SAFE_CLOSE(NULL, fd);
 			read_sparse(filename, filesize);
 			break;
 		case -1:
@@ -293,7 +281,7 @@ int main(int argc, char **argv)
 	}
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	ret = aiodio_sparse(filename, alignment, writesize, filesize, num_aio);
+	ret = aiodio_sparse(fd, alignment, writesize, filesize, num_aio);
 
 	tst_resm(TINFO, "Killing childrens(s)");
 
@@ -332,6 +320,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
+	if (fd > 0 && close(fd))
+		tst_resm(TWARN | TERRNO, "Failed to close file");
+
 	tst_rmdir();
-	tst_exit();
 }
diff --git a/testcases/kernel/io/ltp-aiodio/common_sparse.h b/testcases/kernel/io/ltp-aiodio/common_sparse.h
index f7f4ef4..e8b906e 100644
--- a/testcases/kernel/io/ltp-aiodio/common_sparse.h
+++ b/testcases/kernel/io/ltp-aiodio/common_sparse.h
@@ -110,22 +110,7 @@ static void read_sparse(char *filename, int filesize)
 	int  i, j, r;
 	char buf[4096];
 
-	/*
-	 * Wait for the file to appear.
-	 */
-	for (i = 0; i < 10000; i++) {
-		fd = open(filename, O_RDONLY);
-
-		if (fd != -1)
-			break;
-
-		if (debug)
-			fprintf(stderr, "Child %i waits for '%s' to appear\n",
-			        getpid(), filename);
-
-		usleep(100000);
-	}
-
+	fd = open(filename, O_RDONLY);
 	if (fd == -1) {
 		if (debug)
 			fprintf(stderr, "Child %i failed to open '%s'\n",
diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index 41b9929..67b338b 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -45,6 +45,7 @@ static void setup(void);
 static void cleanup(void);
 static void usage(void);
 static int debug = 0;
+static int fd;
 
 char *TCID = "dio_sparse";
 int TST_TOTAL = 1;
@@ -54,25 +55,14 @@ int TST_TOTAL = 1;
 /*
  * Write zeroes using O_DIRECT into sparse file.
  */
-int dio_sparse(char *filename, int align, int writesize, int filesize, int offset)
+int dio_sparse(int fd, int align, int writesize, int filesize, int offset)
 {
-	int fd;
 	void *bufptr;
 	int i, w;
 
-	fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT | O_EXCL, 0600);
-
-	if (fd < 0) {
-		tst_resm(TBROK | TERRNO, "open()");
-		return 1;
-	}
-
-	SAFE_FTRUNCATE(cleanup, fd, filesize);
-
 	TEST(posix_memalign(&bufptr, align, writesize));
 	if (TEST_RETURN) {
 		tst_resm(TBROK | TRERRNO, "cannot allocate aligned memory");
-		close(fd);
 		return 1;
 	}
 
@@ -81,16 +71,12 @@ int dio_sparse(char *filename, int align, int writesize, int filesize, int offse
 	for (i = offset; i < filesize;) {
 		if ((w = write(fd, bufptr, writesize)) != writesize) {
 			tst_resm(TBROK | TERRNO, "write() returned %d", w);
-			close(fd);
 			return 1;
 		}
 
 		i += w;
 	}
 
-	close(fd);
-	unlink(filename);
-
 	return 0;
 }
 
@@ -156,11 +142,16 @@ int main(int argc, char **argv)
 	tst_resm(TINFO, "Dirtying free blocks");
 	dirty_freeblocks(filesize);
 
+	fd = SAFE_OPEN(cleanup, filename,
+		O_DIRECT | O_WRONLY | O_CREAT | O_EXCL, 0600);
+	SAFE_FTRUNCATE(cleanup, fd, filesize);
+
 	tst_resm(TINFO, "Starting I/O tests");
 	signal(SIGTERM, SIG_DFL);
 	for (i = 0; i < num_children; i++) {
 		switch (pid[i] = fork()) {
 		case 0:
+			SAFE_CLOSE(NULL, fd);
 			read_sparse(filename, filesize);
 			break;
 		case -1:
@@ -174,7 +165,7 @@ int main(int argc, char **argv)
 	}
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	ret = dio_sparse(filename, alignment, writesize, filesize, offset);
+	ret = dio_sparse(fd, alignment, writesize, filesize, offset);
 
 	tst_resm(TINFO, "Killing childrens(s)");
 
@@ -213,5 +204,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
+	if (fd > 0 && close(fd))
+		tst_resm(TWARN | TERRNO, "Failed to close file");
+
 	tst_rmdir();
 }
-- 
1.8.4.2



