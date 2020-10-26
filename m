From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 26 Oct 2020 17:47:52 +0100
Subject: [LTP] [PATCH 15/19] Unify error handling in
 include/tst_safe_macros.h
In-Reply-To: <20201026164756.30556-1-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
Message-ID: <20201026164756.30556-16-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- Pedantically check invalid syscall return values

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_safe_macros.h | 56 ++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 29ac72568..ee3df4142 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -245,10 +245,14 @@ static inline int safe_ftruncate(const char *file, const int lineno,
 	int rval;
 
 	rval = ftruncate(fd, length);
+
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			 "ftruncate(%d,%ld) failed",
-			 fd, (long)length);
+			"ftruncate(%d,%ld) failed", fd, (long)length);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid ftruncate(%d,%ld) return value %d", fd,
+			(long)length, rval);
 	}
 
 	return rval;
@@ -262,10 +266,14 @@ static inline int safe_truncate(const char *file, const int lineno,
 	int rval;
 
 	rval = truncate(path, length);
+
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			 "truncate(%s,%ld) failed",
-			 path, (long)length);
+			"truncate(%s,%ld) failed", path, (long)length);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid truncate(%s,%ld) return value %d", path,
+			(long)length, rval);
 	}
 
 	return rval;
@@ -282,7 +290,11 @@ static inline int safe_stat(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			 "stat(%s,%p) failed", path, buf);
+			"stat(%s,%p) failed", path, buf);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid stat(%s,%p) return value %d", path, buf,
+			rval);
 	}
 
 	return rval;
@@ -300,6 +312,9 @@ static inline int safe_fstat(const char *file, const int lineno,
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"fstat(%d,%p) failed", fd, buf);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid fstat(%d,%p) return value %d", fd, buf, rval);
 	}
 
 	return rval;
@@ -317,6 +332,10 @@ static inline int safe_lstat(const char *file, const int lineno,
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"lstat(%s,%p) failed", path, buf);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid lstat(%s,%p) return value %d", path, buf,
+			rval);
 	}
 
 	return rval;
@@ -333,7 +352,11 @@ static inline int safe_statfs(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-		         "statfs(%s,%p) failed", path, buf);
+			"statfs(%s,%p) failed", path, buf);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid statfs(%s,%p) return value %d", path, buf,
+			rval);
 	}
 
 	return rval;
@@ -350,8 +373,11 @@ static inline off_t safe_lseek(const char *file, const int lineno,
 
 	if (rval == (off_t) -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			"lseek(%d,%ld,%d) failed",
-			fd, (long)offset, whence);
+			"lseek(%d,%ld,%d) failed", fd, (long)offset, whence);
+	} else if (rval < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid lseek(%d,%ld,%d) return value %ld", fd,
+			(long)offset, whence, (long)rval);
 	}
 
 	return rval;
@@ -368,8 +394,11 @@ static inline int safe_getrlimit(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			"getrlimit(%d,%p) failed",
-			resource, rlim);
+			"getrlimit(%d,%p) failed", resource, rlim);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid getrlimit(%d,%p) return value %d", resource,
+			rlim, rval);
 	}
 
 	return rval;
@@ -386,8 +415,11 @@ static inline int safe_setrlimit(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			 "setrlimit(%d,%p) failed",
-			 resource, rlim);
+			"setrlimit(%d,%p) failed", resource, rlim);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid setrlimit(%d,%p) return value %d", resource,
+			rlim, rval);
 	}
 
 	return rval;
-- 
2.28.0

