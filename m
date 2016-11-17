From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 17 Nov 2016 17:36:22 +0800
Subject: [LTP] [PATCH 1/2] SAFE_MACROS: Add SAFE_SETPRIORITY() && Drop
	redundant space
Message-ID: <1479375382-28964-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 include/tst_safe_macros.h |  5 +++++
 lib/safe_macros.c         | 37 ++++++++++++++++++++++++++-----------
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 59cba1a..8e511d5 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -437,4 +437,9 @@ int safe_getpriority(const char *file, const int lineno, int which, id_t who);
 #define SAFE_GETPRIORITY(which, who) \
 	safe_getpriority(__FILE__, __LINE__, (which), (who))
 
+int safe_setpriority(const char *file, const int lineno, int which, id_t who,
+	int prio);
+#define SAFE_SETPRIORITY(which, who, prio) \
+	safe_setpriority(__FILE__, __LINE__, (which), (who), (prio))
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index b97f43d..de7c1e1 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -384,7 +384,7 @@ int safe_link(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: link(%s,%s) failed",
+			 "%s:%d: link(%s,%s) failed",
 			 file, lineno, oldpath, newpath);
 	}
 
@@ -436,7 +436,7 @@ int safe_symlink(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: symlink(%s,%s) failed",
+			 "%s:%d: symlink(%s,%s) failed",
 			 file, lineno, oldpath, newpath);
 	}
 
@@ -452,7 +452,7 @@ ssize_t safe_write(const char *file, const int lineno, void (cleanup_fn) (void),
 	if (rval == -1 || (len_strict && (size_t)rval != nbyte)) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
 			 "%s:%d: write(%d,%p,%zu) failed",
-		         file, lineno, fildes, buf, rval);
+			 file, lineno, fildes, buf, rval);
 	}
 
 	return rval;
@@ -598,8 +598,8 @@ int safe_chown(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			"%s:%d: chown(%s,%d,%d) failed",
-			file, lineno, path, owner, group);
+			 "%s:%d: chown(%s,%d,%d) failed",
+			 file, lineno, path, owner, group);
 	}
 
 	return rval;
@@ -614,7 +614,7 @@ int safe_fchown(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: fchown(%d,%d,%d) failed",
+			 "%s:%d: fchown(%d,%d,%d) failed",
 			 file, lineno, fd, owner, group);
 	}
 
@@ -689,7 +689,7 @@ int safe_mkfifo(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: mkfifo(%s, 0%o) failed",
+			 "%s:%d: mkfifo(%s, 0%o) failed",
 			 file, lineno, pathname, mode);
 	}
 
@@ -756,7 +756,7 @@ DIR* safe_opendir(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	if (!rval) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: opendir(%s) failed", file, lineno, name);
+			 "%s:%d: opendir(%s) failed", file, lineno, name);
 	}
 
 	return rval;
@@ -771,7 +771,7 @@ int safe_closedir(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	if (rval) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: closedir(%p) failed", file, lineno, dirp);
+			 "%s:%d: closedir(%p) failed", file, lineno, dirp);
 	}
 
 	return rval;
@@ -788,7 +788,7 @@ struct dirent *safe_readdir(const char *file, const int lineno, void (cleanup_fn
 
 	if (!rval && errno) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: readdir(%p) failed", file, lineno, dirp);
+			 "%s:%d: readdir(%p) failed", file, lineno, dirp);
 	}
 
 	errno = err;
@@ -803,10 +803,25 @@ int safe_getpriority(const char *file, const int lineno, int which, id_t who)
 	rval = getpriority(which, who);
 	if (errno) {
 		tst_brkm(TBROK | TERRNO, NULL,
-		         "%s:%d getpriority(%i, %i) failed",
+			 "%s:%d getpriority(%i, %i) failed",
 			 file, lineno, which, who);
 	}
 
 	errno = err;
 	return rval;
 }
+
+int safe_setpriority(const char *file, const int lineno, int which, id_t who,
+	int prio)
+{
+	int rval;
+
+	rval = setpriority(which, who, prio);
+	if (rval) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d setpriority(%i, %i, %i) failed",
+			 file, lineno, which, who, prio);
+	}
+
+	return rval;
+}
-- 
1.8.4.2



