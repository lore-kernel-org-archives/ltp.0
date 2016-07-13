From: Eryu Guan <eguan@redhat.com>
Date: Wed, 13 Jul 2016 20:59:00 +0800
Subject: [LTP] [PATCH v3 1/3] ltp-aiodio: report posix_memalign errors
	properly
Message-ID: <1468414742-29413-1-git-send-email-eguan@redhat.com>
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
v3:
- take use of TEST() macro when calling posix_memalign()

v2:
- include "test.h" when needed to avoid compile error

 testcases/kernel/io/ltp-aiodio/aiodio_append.c |  8 ++++++--
 testcases/kernel/io/ltp-aiodio/aiodio_sparse.c |  5 +++--
 testcases/kernel/io/ltp-aiodio/dio_append.c    |  9 +++++++--
 testcases/kernel/io/ltp-aiodio/dio_sparse.c    |  6 ++++--
 testcases/kernel/io/ltp-aiodio/dio_truncate.c  | 14 ++++++++++----
 5 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_append.c b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
index 56e9c09..877b972 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
@@ -28,11 +28,14 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <signal.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <unistd.h>
 
 #include <libaio.h>
 
+#include "test.h"
+
 #define NUM_CHILDREN 8
 
 char *check_zero(unsigned char *buf, int size)
@@ -115,8 +118,9 @@ void aiodio_append(char *filename)
 	io_queue_init(NUM_AIO, &myctx);
 
 	for (i = 0; i < NUM_AIO; i++) {
-		if (posix_memalign(&bufptr, 4096, AIO_SIZE)) {
-			perror("cannot malloc aligned memory");
+		TEST(posix_memalign(&bufptr, 4096, AIO_SIZE));
+		if (TEST_RETURN) {
+			tst_resm(TBROK | TRERRNO, "cannot malloc aligned memory");
 			return;
 		}
 		memset(bufptr, 0, AIO_SIZE);
diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
index 944e12b..49a0915 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
@@ -97,8 +97,9 @@ int aiodio_sparse(char *filename, int align, int writesize, int filesize,
 	for (i = 0; i < num_aio; i++) {
 		void *bufptr;
 
-		if (posix_memalign(&bufptr, align, writesize)) {
-			tst_resm(TBROK | TERRNO, "posix_memalign()");
+		TEST(posix_memalign(&bufptr, align, writesize));
+		if (TEST_RETURN) {
+			tst_resm(TBROK | TRERRNO, "cannot allocate aligned memory");
 			close(fd);
 			unlink(filename);
 			return 1;
diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c b/testcases/kernel/io/ltp-aiodio/dio_append.c
index 878c465..94235a2 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
@@ -35,11 +35,14 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <signal.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <memory.h>
 #include <limits.h>
+
+#include "test.h"
 #define NUM_CHILDREN 8
 
 char *check_zero(unsigned char *buf, int size)
@@ -107,8 +110,10 @@ void dio_append(char *filename)
 		return;
 	}
 
-	if (posix_memalign(&bufptr, 4096, 64 * 1024)) {
-		perror("cannot malloc aligned memory");
+	TEST(posix_memalign(&bufptr, 4096, 64 * 1024));
+	if (TEST_RETURN) {
+		tst_resm(TBROK | TRERRNO, "cannot malloc aligned memory");
+		close(fd);
 		return;
 	}
 
diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index 7ad5f80..df43d5e 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -26,6 +26,7 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <signal.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <unistd.h>
@@ -68,9 +69,10 @@ int dio_sparse(char *filename, int align, int writesize, int filesize)
 
 	SAFE_FTRUNCATE(cleanup, fd, filesize);
 
-	if (posix_memalign(&bufptr, align, writesize)) {
+	TEST(posix_memalign(&bufptr, align, writesize));
+	if (TEST_RETURN) {
+		tst_resm(TBROK | TRERRNO, "cannot allocate aligned memory");
 		close(fd);
-		tst_resm(TBROK | TERRNO, "posix_memalign()");
 		return 1;
 	}
 
diff --git a/testcases/kernel/io/ltp-aiodio/dio_truncate.c b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
index 7458a19..a2a201d 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_truncate.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
@@ -30,6 +30,7 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <signal.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <unistd.h>
@@ -37,6 +38,8 @@
 #include <string.h>
 #include <limits.h>
 
+#include "test.h"
+
 #define NUM_CHILDREN 8
 
 char *check_zero(unsigned char *buf, int size)
@@ -68,8 +71,9 @@ int dio_read(char *filename)
 	int r;
 	void *bufptr;
 
-	if (posix_memalign(&bufptr, 4096, 64 * 1024)) {
-		perror("cannot malloc aligned memory");
+	TEST(posix_memalign(&bufptr, 4096, 64 * 1024));
+	if (TEST_RETURN) {
+		tst_resm(TBROK | TRERRNO, "cannot malloc aligned memory");
 		return -1;
 	}
 
@@ -112,8 +116,10 @@ void dio_append(char *filename, int fill)
 		return;
 	}
 
-	if (posix_memalign(&bufptr, 4096, 64 * 1024)) {
-		perror("cannot malloc aligned memory");
+	TEST(posix_memalign(&bufptr, 4096, 64 * 1024));
+	if (TEST_RETURN) {
+		tst_resm(TBROK | TRERRNO, "cannot malloc aligned memory");
+		close(fd);
 		return;
 	}
 
-- 
2.7.4

