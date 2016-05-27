From: Eryu Guan <eguan@redhat.com>
Date: Fri, 27 May 2016 20:15:02 +0800
Subject: [LTP] [PATCH 1/3] ltp-aiodio: report posix_memalign errors properly
Message-ID: <1464351304-31405-1-git-send-email-eguan@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From posix_memalign(3) the value of errno is indeterminate after a call
to posix_memalign(). So TERRNO doesn't work in this case.
dio_sparse    1  TBROK  :  dio_sparse.c:75: posix_memalign(): errno=SUCCESS(0): Success

Report posix_memalign() errors by calling strerror on the return value.
dio_sparse    1  TBROK  :  dio_sparse.c:74: posix_memalign(): EINVAL

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 testcases/kernel/io/ltp-aiodio/aiodio_append.c |  7 +++++--
 testcases/kernel/io/ltp-aiodio/aiodio_sparse.c |  7 ++++---
 testcases/kernel/io/ltp-aiodio/dio_append.c    |  8 ++++++--
 testcases/kernel/io/ltp-aiodio/dio_sparse.c    |  7 ++++---
 testcases/kernel/io/ltp-aiodio/dio_truncate.c  | 15 +++++++++++----
 5 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_append.c b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
index 56e9c09..1670351 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
@@ -98,6 +98,7 @@ void aiodio_append(char *filename)
 	void *bufptr;
 	int i;
 	int w;
+	int ret;
 	struct iocb iocb_array[NUM_AIO];
 	struct iocb *iocbs[NUM_AIO];
 	off_t offset = 0;
@@ -115,8 +116,10 @@ void aiodio_append(char *filename)
 	io_queue_init(NUM_AIO, &myctx);
 
 	for (i = 0; i < NUM_AIO; i++) {
-		if (posix_memalign(&bufptr, 4096, AIO_SIZE)) {
-			perror("cannot malloc aligned memory");
+		ret = posix_memalign(&bufptr, 4096, AIO_SIZE);
+		if (ret) {
+			tst_resm(TBROK, "cannot malloc aligned memory: %s",
+					tst_strerrno(ret));
 			return;
 		}
 		memset(bufptr, 0, AIO_SIZE);
diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
index 944e12b..edd3cc2 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
@@ -60,7 +60,7 @@ int aiodio_sparse(char *filename, int align, int writesize, int filesize,
 		  int num_aio)
 {
 	int fd;
-	int i, w;
+	int i, w, ret;
 	struct iocb **iocbs;
 	off_t offset;
 	io_context_t myctx;
@@ -97,8 +97,9 @@ int aiodio_sparse(char *filename, int align, int writesize, int filesize,
 	for (i = 0; i < num_aio; i++) {
 		void *bufptr;
 
-		if (posix_memalign(&bufptr, align, writesize)) {
-			tst_resm(TBROK | TERRNO, "posix_memalign()");
+		ret = posix_memalign(&bufptr, align, writesize);
+		if (ret) {
+			tst_resm(TBROK, "posix_memalign(): %s", tst_strerrno(ret));
 			close(fd);
 			unlink(filename);
 			return 1;
diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c b/testcases/kernel/io/ltp-aiodio/dio_append.c
index 878c465..0460a0e 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
@@ -99,6 +99,7 @@ void dio_append(char *filename)
 	void *bufptr;
 	int i;
 	int w;
+	int ret;
 
 	fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
 
@@ -107,8 +108,11 @@ void dio_append(char *filename)
 		return;
 	}
 
-	if (posix_memalign(&bufptr, 4096, 64 * 1024)) {
-		perror("cannot malloc aligned memory");
+	ret = posix_memalign(&bufptr, 4096, 64 * 1024);
+	if (ret) {
+		tst_resm(TBROK, "cannot malloc aligned memory: %s",
+				tst_strerrno(ret));
+		close(fd);
 		return;
 	}
 
diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index 7ad5f80..12e478e 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -55,7 +55,7 @@ int TST_TOTAL = 1;
  */
 int dio_sparse(char *filename, int align, int writesize, int filesize)
 {
-	int fd;
+	int fd, ret;
 	void *bufptr;
 	int i, w;
 
@@ -68,9 +68,10 @@ int dio_sparse(char *filename, int align, int writesize, int filesize)
 
 	SAFE_FTRUNCATE(cleanup, fd, filesize);
 
-	if (posix_memalign(&bufptr, align, writesize)) {
+	ret = posix_memalign(&bufptr, align, writesize);
+	if (ret) {
+		tst_resm(TBROK, "posix_memalign(): %s", tst_strerrno(ret));
 		close(fd);
-		tst_resm(TBROK | TERRNO, "posix_memalign()");
 		return 1;
 	}
 
diff --git a/testcases/kernel/io/ltp-aiodio/dio_truncate.c b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
index 7458a19..a9b3c96 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_truncate.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
@@ -66,10 +66,13 @@ int dio_read(char *filename)
 {
 	int fd;
 	int r;
+	int ret;
 	void *bufptr;
 
-	if (posix_memalign(&bufptr, 4096, 64 * 1024)) {
-		perror("cannot malloc aligned memory");
+	ret = posix_memalign(&bufptr, 4096, 64 * 1024);
+	if (ret) {
+		tst_resm(TBROK, "cannot malloc aligned memory: %s",
+				tst_strerrno(ret));
 		return -1;
 	}
 
@@ -104,6 +107,7 @@ void dio_append(char *filename, int fill)
 	void *bufptr;
 	int i;
 	int w;
+	int ret;
 
 	fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
 
@@ -112,8 +116,11 @@ void dio_append(char *filename, int fill)
 		return;
 	}
 
-	if (posix_memalign(&bufptr, 4096, 64 * 1024)) {
-		perror("cannot malloc aligned memory");
+	ret = posix_memalign(&bufptr, 4096, 64 * 1024);
+	if (ret) {
+		tst_resm(TBROK, "cannot malloc aligned memory: %s",
+				tst_strerrno(ret));
+		close(fd);
 		return;
 	}
 
-- 
2.5.5

