From: Li Wang <liwang@redhat.com>
Date: Wed, 20 Nov 2019 15:23:11 +0800
Subject: [LTP] [PATCH v2] tst_fill_fs: enhance the filesystem filling routine
Message-ID: <20191120072311.32333-1-liwang@redhat.com>
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
---
 lib/tst_fill_fs.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/tst_fill_fs.c b/lib/tst_fill_fs.c
index 4003dce97..3015c066e 100644
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
@@ -37,17 +40,20 @@ void tst_fill_fs(const char *path, int verbose)
 			return;
 		}
 
-		while (len) {
+		while (len >= fi.f_bsize/2) {
 			ret = write(fd, buf, MIN(len, sizeof(buf)));
 
 			if (ret < 0) {
+				if (errno == ENOSPC) {
+					SAFE_FSYNC(fd);
+					len /= 2;
+					continue;
+				}
+
 				SAFE_CLOSE(fd);
 
 				if (errno != ENOSPC)
 					tst_brk(TBROK | TERRNO, "write()");
-
-				tst_res(TINFO | TERRNO, "write()");
-				return;
 			}
 
 			len -= ret;
-- 
2.20.1

