From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 13 Apr 2017 10:31:12 +0800
Subject: [LTP] [PATCH v2] syscalls/lseek11.c: fix syncfs() && SEEK_DATA
In-Reply-To: <20170412114225.GA25790@rei>
References: <20170412114225.GA25790@rei>
Message-ID: <1492050672-29779-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) We add SAFE_FSYNC().
2) Compilation failed on RHEL6.9GA because syncfs() was not defined.
   this function is introduced since linux 2.6.39, so we could use
   SAFE_FSYNC() instead of syncfs().
3) We add a check if SEEK_DATA was implemented in get_blocksize(),
   and remove this check in setup().

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/tst_safe_macros.h                 |  3 +++
 lib/safe_macros.c                         | 14 ++++++++++++++
 testcases/kernel/syscalls/lseek/lseek11.c | 23 ++++++++++++-----------
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 7683109..a25a4f0 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -427,4 +427,7 @@ int safe_removexattr(const char *file, const int lineno, const char *path,
 #define SAFE_REMOVEXATTR(path, name) \
 	safe_removexattr(__FILE__, __LINE__, (path), (name))
 
+int safe_fsync(const char *file, const int lineno, int fd);
+#define SAFE_FSYNC(fd) safe_fsync(__FILE__, __LINE__, (fd))
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index df0df7f..bffc5a1 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -874,3 +874,17 @@ int safe_removexattr(const char *file, const int lineno, const char *path,
 
 	return rval;
 }
+
+int safe_fsync(const char *file, const int lineno, int fd)
+{
+	int rval;
+
+	rval = fsync(fd);
+
+	if (rval) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			"%s:%d: fsync(%i) failed", file, lineno, fd);
+	}
+
+	return rval;
+}
diff --git a/testcases/kernel/syscalls/lseek/lseek11.c b/testcases/kernel/syscalls/lseek/lseek11.c
index fe226b5..4c5bb00 100644
--- a/testcases/kernel/syscalls/lseek/lseek11.c
+++ b/testcases/kernel/syscalls/lseek/lseek11.c
@@ -116,8 +116,15 @@ static void get_blocksize(void)
 		offset <<= 1;
 		SAFE_FTRUNCATE(fd, 0);
 		SAFE_PWRITE(1, fd, "a", 1, offset);
-		syncfs(fd);
-		pos = SAFE_LSEEK(fd, 0, SEEK_DATA);
+		SAFE_FSYNC(fd);
+		pos = lseek(fd, 0, SEEK_DATA);
+		if (pos == -1) {
+			if (errno == EINVAL) {
+				tst_brk(TCONF | TERRNO, "SEEK_DATA "
+					"and SEEK_HOLE not implemented");
+			}
+			tst_brk(TBROK | TERRNO, "SEEK_DATA failed");
+		}
 	}
 
 	/* bisect for double check */
@@ -125,7 +132,7 @@ static void get_blocksize(void)
 	while (shift && offset < (st.st_blksize * 2)) {
 		SAFE_FTRUNCATE(fd, 0);
 		SAFE_PWRITE(1, fd, "a", 1, offset);
-		syncfs(fd);
+		SAFE_FSYNC(fd);
 		pos = SAFE_LSEEK(fd, 0, SEEK_DATA);
 		offset += pos ? -shift : shift;
 		shift >>= 1;
@@ -175,13 +182,7 @@ static void setup(void)
 	 */
 	SAFE_FTRUNCATE(fd, FILE_BLOCKS * block_size);
 
-	if (lseek(fd, 0, SEEK_HOLE) < 0) {
-		if (errno == EINVAL) {
-			tst_brk(TCONF | TERRNO,
-				"SEEK_DATA and SEEK_HOLE not implemented");
-		}
-		tst_brk(TBROK | TERRNO, "SEEK_HOLE failed");
-	}
+	SAFE_LSEEK(fd, 0, SEEK_HOLE);
 
 	for (i = 0; i < UNIT_COUNT; i++) {
 		offset = UNIT_BLOCKS * block_size * i;
@@ -192,7 +193,7 @@ static void setup(void)
 	SAFE_LSEEK(fd, -128, SEEK_END);
 	write_data(fd, i + 1);
 
-	syncfs(fd);
+	SAFE_FSYNC(fd);
 	SAFE_LSEEK(fd, 0, SEEK_SET);
 }
 
-- 
1.8.3.1



