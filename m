From: Eryu Guan <eguan@redhat.com>
Date: Tue,  3 May 2016 17:33:50 +0800
Subject: [LTP] [PATCH 2/2] ltp-aiodio: report posix_memalign errors properly
In-Reply-To: <1462268030-21958-1-git-send-email-eguan@redhat.com>
References: <1462268030-21958-1-git-send-email-eguan@redhat.com>
Message-ID: <1462268030-21958-2-git-send-email-eguan@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From posix_memalign(3) the value of errno is indeterminate after a call
to posix_memalign(). So TERRNO doesn't work in this case.
dio_sparse    1  TBROK  :  dio_sparse.c:75: posix_memalign(): errno=SUCCESS(0): Success

Report posix_memalign() errors by calling strerror on the return value.
dio_sparse    1  TBROK  :  dio_sparse.c:74: posix_memalign(): Invalid argument

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 testcases/kernel/io/ltp-aiodio/dio_sparse.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index 7ad5f80..d07f111 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -28,6 +28,7 @@
 #include <signal.h>
 #include <fcntl.h>
 #include <stdio.h>
+#include <string.h>
 #include <unistd.h>
 #include <memory.h>
 #include <sys/mman.h>
@@ -55,7 +56,7 @@ int TST_TOTAL = 1;
  */
 int dio_sparse(char *filename, int align, int writesize, int filesize)
 {
-	int fd;
+	int fd, ret;
 	void *bufptr;
 	int i, w;
 
@@ -68,9 +69,10 @@ int dio_sparse(char *filename, int align, int writesize, int filesize)
 
 	SAFE_FTRUNCATE(cleanup, fd, filesize);
 
-	if (posix_memalign(&bufptr, align, writesize)) {
+	ret = posix_memalign(&bufptr, align, writesize);
+	if (ret) {
+		tst_resm(TBROK, "posix_memalign(): %s", strerror(ret));
 		close(fd);
-		tst_resm(TBROK | TERRNO, "posix_memalign()");
 		return 1;
 	}
 
-- 
2.5.5

