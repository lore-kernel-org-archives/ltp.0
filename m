From: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
Date: Sat, 26 Nov 2016 11:30:01 +0300
Subject: [LTP] [PATCH] safe_macros: make safe_pread() and safe_pwrite()
	inline
In-Reply-To: <20160927125625.GE12308@rei.suse.cz>
References: <20160927125625.GE12308@rei.suse.cz>
Message-ID: <1480149001-4844-1-git-send-email-nyushchenko@dev.rtsoft.ru>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These routines have an argument of type off_t, which has size dependent
on compile options on 32-bit builds. Thus having there rotines compiled
inside library cause ABI issues.

Signed-off-by: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
---
 include/old/safe_macros.h | 39 +++++++++++++++++++++++++++++++++++++++
 include/safe_macros_fn.h  |  8 --------
 include/tst_safe_macros.h | 38 ++++++++++++++++++++++++++++++++++++--
 lib/safe_macros.c         | 32 --------------------------------
 4 files changed, 75 insertions(+), 42 deletions(-)

diff --git a/include/old/safe_macros.h b/include/old/safe_macros.h
index 8ed2eb4..e3be1f2 100644
--- a/include/old/safe_macros.h
+++ b/include/old/safe_macros.h
@@ -70,6 +70,26 @@
 	safe_read(__FILE__, __LINE__, cleanup_fn, (len_strict), (fildes), \
 	    (buf), (nbyte))
 
+/*
+ * inline function that uses off_t since sizeof(off_t) depends on compile flags
+ */
+static inline ssize_t safe_pread(const char *file, const int lineno,
+		void (*cleanup_fn)(void), char len_strict,
+		int fildes, void *buf, size_t nbyte, off_t offset)
+{
+	ssize_t rval;
+
+	rval = pread(fildes, buf, nbyte, offset);
+
+	if (rval == -1 || (len_strict && (size_t)rval != nbyte)) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: pread(%d,%p,%zu,%lld) failed, returned %zd",
+			 file, lineno, fildes, buf, nbyte, (long long)offset,
+			 rval);
+	}
+
+	return rval;
+}
 #define SAFE_PREAD(cleanup_fn, len_strict, fildes, buf, nbyte, offset)   \
 	safe_pread(__FILE__, __LINE__, cleanup_fn, (len_strict), (fildes), \
 	    (buf), (nbyte), (offset))
@@ -112,6 +132,25 @@
 	safe_write(__FILE__, __LINE__, cleanup_fn, (len_strict), (fildes), \
 	    (buf), (nbyte))
 
+/*
+ * inline function that uses off_t since sizeof(off_t) depends on compile flags
+ */
+static inline ssize_t safe_pwrite(const char *file, const int lineno,
+		void (*cleanup_fn)(void), char len_strict,
+		int fildes, const void *buf, size_t nbyte, off_t offset)
+{
+	ssize_t rval;
+
+	rval = pwrite(fildes, buf, nbyte, offset);
+	if (rval == -1 || (len_strict && (size_t)rval != nbyte)) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: pwrite(%d,%p,%zu,%lld) failed, returned %zd",
+			 file, lineno, fildes, buf, nbyte, (long long)offset,
+			 rval);
+	}
+
+	return rval;
+}
 #define SAFE_PWRITE(cleanup_fn, len_strict, fildes, buf, nbyte, offset) \
 	safe_pwrite(__FILE__, __LINE__, cleanup_fn, (len_strict), (fildes), \
 	    (buf), (nbyte), (offset))
diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
index 121a8fb..dcea775 100644
--- a/include/safe_macros_fn.h
+++ b/include/safe_macros_fn.h
@@ -71,10 +71,6 @@ ssize_t	safe_read(const char *file, const int lineno,
                   void (*cleanup_fn)(void), char len_strict, int fildes,
                   void *buf, size_t nbyte);
 
-ssize_t safe_pread(const char *file, const int lineno,
-                   void (*cleanup_fn)(void), char len_strict,
-                   int fildes, void *buf, size_t nbyte, off_t offset);
-
 int safe_setegid(const char *file, const int lineno,
                  void (*cleanup_fn)(void), gid_t egid);
 
@@ -118,10 +114,6 @@ ssize_t	safe_write(const char *file, const int lineno,
                    void (cleanup_fn)(void), char len_strict, int fildes,
                    const void *buf, size_t nbyte);
 
-ssize_t safe_pwrite(const char *file, const int lineno,
-                    void (cleanup_fn)(void), char len_strict, int fildes,
-		    const void *buf, size_t nbyte, off_t offset);
-
 long safe_strtol(const char *file, const int lineno,
                  void (cleanup_fn)(void), char *str, long min, long max);
 
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 59cba1a..e91dbd2 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -97,8 +97,27 @@ static inline int safe_dup(const char *file, const int lineno,
 #define SAFE_READ(len_strict, fildes, buf, nbyte) \
 	safe_read(__FILE__, __LINE__, NULL, (len_strict), (fildes), (buf), (nbyte))
 
+/*
+ * inline function that uses off_t since sizeof(off_t) depends on compile flags
+ */
+static inline ssize_t safe_pread(const char *file, const int lineno,
+		char len_strict, int fildes, void *buf, size_t nbyte,
+		off_t offset)
+{
+	ssize_t rval;
+
+	rval = pread(fildes, buf, nbyte, offset);
+
+	if (rval == -1 || (len_strict && (size_t)rval != nbyte)) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "pread(%d,%p,%zu,%lld) failed",
+			 fildes, buf, nbyte, (long long)offset);
+	}
+
+	return rval;
+}
 #define SAFE_PREAD(len_strict, fildes, buf, nbyte, offset) \
-	safe_pread(__FILE__, __LINE__, NULL, (len_strict), (fildes), \
+	safe_pread(__FILE__, __LINE__, (len_strict), (fildes), \
 	           (buf), (nbyte), (offset))
 
 #define SAFE_SETEGID(egid) \
@@ -170,8 +189,23 @@ static inline pid_t safe_getpgid(const char *file, const int lineno,
 #define SAFE_WRITE(len_strict, fildes, buf, nbyte) \
 	safe_write(__FILE__, __LINE__, NULL, (len_strict), (fildes), (buf), (nbyte))
 
+static inline ssize_t safe_pwrite(const char *file, const int lineno,
+		char len_strict, int fildes, const void *buf, size_t nbyte,
+		off_t offset)
+{
+	ssize_t rval;
+
+	rval = pwrite(fildes, buf, nbyte, offset);
+	if (rval == -1 || (len_strict && (size_t)rval != nbyte)) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "pwrite(%d,%p,%zu,%lld) failed",
+			 fildes, buf, nbyte, (long long)offset);
+	}
+
+	return rval;
+}
 #define SAFE_PWRITE(len_strict, fildes, buf, nbyte, offset) \
-	safe_pwrite(__FILE__, __LINE__, NULL, (len_strict), (fildes), \
+	safe_pwrite(__FILE__, __LINE__, (len_strict), (fildes), \
 	            (buf), (nbyte), (offset))
 
 #define SAFE_STRTOL(str, min, max) \
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index b97f43d..31dc61c 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -252,22 +252,6 @@ ssize_t safe_read(const char *file, const int lineno, void (*cleanup_fn) (void),
 	return rval;
 }
 
-ssize_t safe_pread(const char *file, const int lineno, void (*cleanup_fn)(void),
-		   char len_strict, int fildes, void *buf, size_t nbyte,
-		   off_t offset)
-{
-	ssize_t rval;
-
-	rval = pread(fildes, buf, nbyte, offset);
-	if (rval == -1 || (len_strict && (size_t)rval != nbyte)) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: read(%d,%p,%zu,%ld) failed, returned %zd",
-			 file, lineno, fildes, buf, nbyte, offset, rval);
-	}
-
-	return rval;
-}
-
 int safe_setegid(const char *file, const int lineno, void (*cleanup_fn) (void),
                  gid_t egid)
 {
@@ -458,22 +442,6 @@ ssize_t safe_write(const char *file, const int lineno, void (cleanup_fn) (void),
 	return rval;
 }
 
-ssize_t safe_pwrite(const char *file, const int lineno,
-		    void (cleanup_fn) (void), char len_strict, int fildes,
-		    const void *buf, size_t nbyte, off_t offset)
-{
-	ssize_t rval;
-
-	rval = pwrite(fildes, buf, nbyte, offset);
-	if (rval == -1 || (len_strict && (size_t)rval != nbyte)) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: pwrite(%d,%p,%zu,%ld) failed",
-			 file, lineno, fildes, buf, rval, offset);
-	}
-
-	return rval;
-}
-
 long safe_strtol(const char *file, const int lineno,
 		 void (cleanup_fn) (void), char *str, long min, long max)
 {
-- 
2.1.4

