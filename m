From: Li Wang <liwang@redhat.com>
Date: Fri, 10 Nov 2017 19:15:19 +0800
Subject: [LTP] [PATCH] fs_fill: switch the SAFE MACROs back to ordinary
	syscall
Message-ID: <20171110111519.27872-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To fix those brokens:
  safe_macros.c:225: BROK: tst_fill_fs.c:43: open(mntpoint/thread48/file0,65,0700) failed: ENOSPC
  safe_macros.c:169: BROK: fs_fill.c:49: mkdir(mntpoint/thread21,0700) failed: ENOSPC

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/tst_fill_fs.c                     |  9 ++++++++-
 testcases/kernel/fs/fs_fill/fs_fill.c | 10 +++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/lib/tst_fill_fs.c b/lib/tst_fill_fs.c
index 6b2bbbc..2775a2c 100644
--- a/lib/tst_fill_fs.c
+++ b/lib/tst_fill_fs.c
@@ -40,7 +40,14 @@ void tst_fill_fs(const char *path, int verbose)
 		if (verbose)
 			tst_res(TINFO, "Creating file %s size %zu", file, len);
 
-		fd = SAFE_OPEN(file, O_WRONLY | O_CREAT, 0700);
+		fd = open(file, O_WRONLY | O_CREAT, 0700);
+		if (fd == -1) {
+			if (errno != ENOSPC)
+				tst_brk(TBROK | TERRNO, "open()");
+
+			tst_res(TINFO | TERRNO, "open()");
+			return;
+		}
 
 		while (len) {
 			ret = write(fd, buf, MIN(len, sizeof(buf)));
diff --git a/testcases/kernel/fs/fs_fill/fs_fill.c b/testcases/kernel/fs/fs_fill/fs_fill.c
index a50a22f..f592cd5 100644
--- a/testcases/kernel/fs/fs_fill/fs_fill.c
+++ b/testcases/kernel/fs/fs_fill/fs_fill.c
@@ -41,12 +41,20 @@ struct worker {
 
 static void *worker(void *p)
 {
+	int ret;
 	struct worker *w = p;
 	DIR *d;
 	struct dirent *ent;
 	char file[PATH_MAX];
 
-	SAFE_MKDIR(w->dir, 0700);
+	ret = mkdir(w->dir, 0700);
+	if (ret == -1) {
+		if (errno != ENOSPC)
+			tst_brk(TBROK | TERRNO, "mkdir()");
+
+		tst_res(TINFO | TERRNO, "mkdir()");
+		return NULL;
+	}
 
 	while (run) {
 		tst_fill_fs(w->dir, 0);
-- 
2.9.3

