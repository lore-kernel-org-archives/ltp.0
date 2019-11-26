From: Li Wang <liwang@redhat.com>
Date: Tue, 26 Nov 2019 12:54:22 +0800
Subject: [LTP] [PATCH v3] tst_fill_fs: enhance the filesystem filling routine
Message-ID: <20191126045422.12808-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Do more tries with size in half when write() getting ENOSPC, until the size
is less than the filesystem block size. Though we can't really fill a filesystem
full, this could make the routine more robust.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Jan Stancek <jstancek@redhat.com>
Cc: Martin Doucha <mdoucha@suse.cz>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
---

Notes:
    v2 --> v3
       * move the condition judgment into while loop
       * reserve the print&return part in the loop

 lib/tst_fill_fs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/tst_fill_fs.c b/lib/tst_fill_fs.c
index 4003dce97..121dd2f20 100644
--- a/lib/tst_fill_fs.c
+++ b/lib/tst_fill_fs.c
@@ -6,6 +6,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/statvfs.h>
 
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
@@ -19,6 +20,8 @@ void tst_fill_fs(const char *path, int verbose)
 	size_t len;
 	ssize_t ret;
 	int fd;
+	struct statvfs fi;
+	statvfs(path, &fi);
 
 	for (;;) {
 		len = random() % (1024 * 102400);
@@ -41,6 +44,13 @@ void tst_fill_fs(const char *path, int verbose)
 			ret = write(fd, buf, MIN(len, sizeof(buf)));
 
 			if (ret < 0) {
+				/* retry on ENOSPC to make sure filesystem is really full */
+				if (errno == ENOSPC && len >= fi.f_bsize/2) {
+					SAFE_FSYNC(fd);
+					len /= 2;
+					continue;
+				}
+
 				SAFE_CLOSE(fd);
 
 				if (errno != ENOSPC)
-- 
2.20.1

