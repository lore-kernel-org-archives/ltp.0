From: Eryu Guan <eguan@redhat.com>
Date: Thu,  7 Jul 2016 23:05:15 +0800
Subject: [LTP] [PATCH v2 1/3] ltp-aiodio: report posix_memalign errors
	properly
Message-ID: <1467903917-16064-1-git-send-email-eguan@redhat.com>
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
v2:
- include "test.h" when needed to avoid compile error

 testcases/kernel/io/ltp-aiodio/aiodio_append.c |  9 +++++++--
 testcases/kernel/io/ltp-aiodio/aiodio_sparse.c |  7 ++++---
 testcases/kernel/io/ltp-aiodio/dio_append.c    | 10 ++++++++--
 testcases/kernel/io/ltp-aiodio/dio_sparse.c    |  7 ++++---
 testcases/kernel/io/ltp-aiodio/dio_truncate.c  | 17 +++++++++++++----
 5 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_append.c b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
index 56e9c09..77df02c 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
@@ -33,6 +33,8 @@
 
 #include <libaio.h>
 
+#include "test.h"
+
 #define NUM_CHILDREN 8
 
 char *check_zero(unsigned char *buf, int size)
@@ -98,6 +100,7 @@ void aiodio_append(char *filename)
 	void *bufptr;
 	int i;
 	int w;
+	int ret;
 	struct iocb iocb_array[NUM_AIO];
 	struct iocb *iocbs[NUM_AIO];
 	off_t offset = 0;
@@ -115,8 +118,10 @@ void aiodio_append(char *filename)
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
index 878c465..f2e4db4 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
@@ -40,6 +40,8 @@
 #include <unistd.h>
 #include <memory.h>
 #include <limits.h>
+
+#include "test.h"
 #define NUM_CHILDREN 8
 
 char *check_zero(unsigned char *buf, int size)
@@ -99,6 +101,7 @@ void dio_append(char *filename)
 	void *bufptr;
 	int i;
 	int w;
+	int ret;
 
 	fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
 
@@ -107,8 +110,11 @@ void dio_append(char *filename)
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
index 7458a19..7d49766 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_truncate.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
@@ -37,6 +37,8 @@
 #include <string.h>
 #include <limits.h>
 
+#include "test.h"
+
 #define NUM_CHILDREN 8
 
 char *check_zero(unsigned char *buf, int size)
@@ -66,10 +68,13 @@ int dio_read(char *filename)
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
 
@@ -104,6 +109,7 @@ void dio_append(char *filename, int fill)
 	void *bufptr;
 	int i;
 	int w;
+	int ret;
 
 	fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
 
@@ -112,8 +118,11 @@ void dio_append(char *filename, int fill)
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
2.7.4

