From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 15 Dec 2016 18:49:54 +0800
Subject: [LTP] [PATCH v2 1/4] Cleanup && Drop redundant space in safe macros
In-Reply-To: <20161215104356.GB29787@rei.suse.cz>
References: <20161215104356.GB29787@rei.suse.cz>
Message-ID: <1481798997-2320-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 include/tst_safe_macros.h | 22 +++++++++++-----------
 lib/safe_macros.c         | 28 ++++++++++++++--------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index d352d5a3..32b2556 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -146,7 +146,7 @@ static inline int safe_setpgid(const char *file, const int lineno,
 	rval = setpgid(pid, pgid);
 	if (rval) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-		         "setpgid(%i, %i) failed", pid, pgid);
+			 "setpgid(%i, %i) failed", pid, pgid);
 	}
 
 	return rval;
@@ -292,8 +292,8 @@ static inline void *safe_mmap(const char *file, const int lineno,
 	rval = mmap(addr, length, prot, flags, fd, offset);
 	if (rval == MAP_FAILED) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			"mmap(%p,%zu,%d,%d,%d,%ld) failed",
-			addr, length, prot, flags, fd, (long) offset);
+			 "mmap(%p,%zu,%d,%d,%d,%ld) failed",
+			 addr, length, prot, flags, fd, (long) offset);
 	}
 
 	return rval;
@@ -362,7 +362,7 @@ static inline int safe_fstat(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			"fstat(%d,%p) failed", fd, buf);
+			 "fstat(%d,%p) failed", fd, buf);
 	}
 
 	return rval;
@@ -379,7 +379,7 @@ static inline int safe_lstat(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			"lstat(%s,%p) failed", path, buf);
+			 "lstat(%s,%p) failed", path, buf);
 	}
 
 	return rval;
@@ -396,8 +396,8 @@ static inline off_t safe_lseek(const char *file, const int lineno,
 
 	if (rval == (off_t) -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			"lseek(%d,%ld,%d) failed",
-			fd, (long)offset, whence);
+			 "lseek(%d,%ld,%d) failed",
+			 fd, (long)offset, whence);
 	}
 
 	return rval;
@@ -414,8 +414,8 @@ static inline int safe_getrlimit(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			"getrlimit(%d,%p) failed",
-			resource, rlim);
+			 "getrlimit(%d,%p) failed",
+			 resource, rlim);
 	}
 
 	return rval;
@@ -451,8 +451,8 @@ static inline sighandler_t safe_signal(const char *file, const int lineno,
 
 	if (rval == SIG_ERR) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			"signal(%d,%p) failed",
-			signum, handler);
+			 "signal(%d,%p) failed",
+			 signum, handler);
 	}
 
 	return rval;
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 094e5c7..d5c8753 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -369,7 +369,7 @@ int safe_link(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: link(%s,%s) failed",
+			 "%s:%d: link(%s,%s) failed",
 			 file, lineno, oldpath, newpath);
 	}
 
@@ -421,7 +421,7 @@ int safe_symlink(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: symlink(%s,%s) failed",
+			 "%s:%d: symlink(%s,%s) failed",
 			 file, lineno, oldpath, newpath);
 	}
 
@@ -437,7 +437,7 @@ ssize_t safe_write(const char *file, const int lineno, void (cleanup_fn) (void),
 	if (rval == -1 || (len_strict && (size_t)rval != nbyte)) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
 			 "%s:%d: write(%d,%p,%zu) failed",
-		         file, lineno, fildes, buf, rval);
+			 file, lineno, fildes, buf, rval);
 	}
 
 	return rval;
@@ -567,8 +567,8 @@ int safe_chown(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			"%s:%d: chown(%s,%d,%d) failed",
-			file, lineno, path, owner, group);
+			 "%s:%d: chown(%s,%d,%d) failed",
+			 file, lineno, path, owner, group);
 	}
 
 	return rval;
@@ -583,7 +583,7 @@ int safe_fchown(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: fchown(%d,%d,%d) failed",
+			 "%s:%d: fchown(%d,%d,%d) failed",
 			 file, lineno, fd, owner, group);
 	}
 
@@ -658,7 +658,7 @@ int safe_mkfifo(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: mkfifo(%s, 0%o) failed",
+			 "%s:%d: mkfifo(%s, 0%o) failed",
 			 file, lineno, pathname, mode);
 	}
 
@@ -725,7 +725,7 @@ DIR* safe_opendir(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	if (!rval) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: opendir(%s) failed", file, lineno, name);
+			 "%s:%d: opendir(%s) failed", file, lineno, name);
 	}
 
 	return rval;
@@ -740,7 +740,7 @@ int safe_closedir(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	if (rval) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: closedir(%p) failed", file, lineno, dirp);
+			 "%s:%d: closedir(%p) failed", file, lineno, dirp);
 	}
 
 	return rval;
@@ -757,7 +757,7 @@ struct dirent *safe_readdir(const char *file, const int lineno, void (cleanup_fn
 
 	if (!rval && errno) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: readdir(%p) failed", file, lineno, dirp);
+			 "%s:%d: readdir(%p) failed", file, lineno, dirp);
 	}
 
 	errno = err;
@@ -772,7 +772,7 @@ int safe_getpriority(const char *file, const int lineno, int which, id_t who)
 	rval = getpriority(which, who);
 	if (errno) {
 		tst_brkm(TBROK | TERRNO, NULL,
-		         "%s:%d getpriority(%i, %i) failed",
+			 "%s:%d getpriority(%i, %i) failed",
 			 file, lineno, which, who);
 	}
 
@@ -795,7 +795,7 @@ int safe_setxattr(const char *file, const int lineno, const char *path,
 		}
 
 		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: setxattr() failed",
-			     file, lineno);
+			 file, lineno);
 	}
 
 	return rval;
@@ -816,7 +816,7 @@ int safe_lsetxattr(const char *file, const int lineno, const char *path,
 		}
 
 		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: lsetxattr() failed",
-			     file, lineno);
+			 file, lineno);
 	}
 
 	return rval;
@@ -837,7 +837,7 @@ int safe_fsetxattr(const char *file, const int lineno, int fd, const char *name,
 		}
 
 		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: fsetxattr() failed",
-			     file, lineno);
+			 file, lineno);
 	}
 
 	return rval;
-- 
1.8.4.2



