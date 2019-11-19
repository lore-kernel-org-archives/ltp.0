From: Li Wang <liwang@redhat.com>
Date: Tue, 19 Nov 2019 17:41:56 +0800
Subject: [LTP] [PATCH] tst_fill_fs: enhance the filesystem filling routine
Message-ID: <20191119094156.20348-1-liwang@redhat.com>
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
---
 lib/tst_fill_fs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/tst_fill_fs.c b/lib/tst_fill_fs.c
index 4003dce97..00adf7287 100644
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
@@ -37,10 +40,15 @@ void tst_fill_fs(const char *path, int verbose)
 			return;
 		}
 
-		while (len) {
+		while (len >= fi.f_bsize) {
 			ret = write(fd, buf, MIN(len, sizeof(buf)));
 
 			if (ret < 0) {
+				if (errno == ENOSPC) {
+					len /= 2;
+					continue;
+				}
+
 				SAFE_CLOSE(fd);
 
 				if (errno != ENOSPC)
-- 
2.20.1

