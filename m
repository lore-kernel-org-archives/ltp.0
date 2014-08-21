Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XKPD5-0003s3-6x
	for ltp-list@lists.sourceforge.net; Thu, 21 Aug 2014 10:03:11 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XKPD3-0001Ma-63
	for ltp-list@lists.sourceforge.net; Thu, 21 Aug 2014 10:03:11 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7LA31BV031978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 21 Aug 2014 06:03:01 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s7LA2xmL024755
	for <ltp-list@lists.sourceforge.net>; Thu, 21 Aug 2014 06:03:00 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 21 Aug 2014 12:02:57 +0200
Message-Id: <e70bae8bd74a29e9959cae96900a849254b37c9f.1408615314.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] safe_macros: turn functions with off_t parameter into
	static inline
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Some functions used to implement safe macros have parameters
of type off_t or structures containing off_t fields.

We don't want these to be compiled into libltp, because
some testcases are compiled with different flags such as:
  -D_FILE_OFFSET_BITS=64 -DOFF_T=__off64_t
which then creates incompatibility and testcases can fail.

For example sendfile06_64 on i386:
    sendfile06_64    1  TFAIL  :  sendfile06.c:90: sendfile(2) failed
          to return expected value, expected: 17592186044442, got: 26

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/safe_macros.h |  167 ++++++++++++++++++++++++++++++++++++++-----------
 lib/safe_macros.c     |  109 --------------------------------
 2 files changed, 130 insertions(+), 146 deletions(-)

diff --git a/include/safe_macros.h b/include/safe_macros.h
index a79c4ad..5ee4d42 100644
--- a/include/safe_macros.h
+++ b/include/safe_macros.h
@@ -16,6 +16,7 @@
 #ifndef __SAFE_MACROS_H__
 #define __SAFE_MACROS_H__
 
+#include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/resource.h>
 #include <sys/stat.h>
@@ -81,12 +82,6 @@ int     safe_rmdir(const char *file, const int lineno,
 #define SAFE_RMDIR(cleanup_fn, pathname) \
 	safe_rmdir(__FILE__, __LINE__, (cleanup_fn), (pathname))
 
-void*	safe_mmap(const char *file, const int lineno,
-	    void (*cleanup_fn)(void), void *addr, size_t length, int prot,
-	    int flags, int fd, off_t offset);
-#define SAFE_MMAP(cleanup_fn, addr, length, prot, flags, fd, offset)	\
-	safe_mmap(__FILE__, __LINE__, (cleanup_fn), (addr), (length), (prot), \
-	    (flags), (fd), (offset))
 
 int	safe_munmap(const char *file, const int lineno,
 	    void (*cleanup_fn)(void), void *addr, size_t length);
@@ -152,12 +147,6 @@ int	safe_link(const char *file, const int lineno,
 #define SAFE_LINK(cleanup_fn, oldpath, newpath) \
         safe_link(__FILE__, __LINE__, cleanup_fn, (oldpath), (newpath))
 
-off_t	safe_lseek(const char *file, const int lineno,
-                   void (cleanup_fn)(void), int fd,
-                   off_t offset, int whence);
-#define SAFE_LSEEK(cleanup_fn, fd, offset, whence) \
-        safe_lseek(__FILE__, __LINE__, cleanup_fn, (fd), (offset), (whence))
-
 int	safe_symlink(const char *file, const int lineno,
                      void (cleanup_fn)(void), const char *oldpath,
                      const char *newpath);
@@ -171,16 +160,6 @@ ssize_t	safe_write(const char *file, const int lineno,
 	safe_write(__FILE__, __LINE__, cleanup_fn, (len_strict), (fildes), \
 	    (buf), (nbyte))
 
-int safe_ftruncate(const char *file, const int lineno,
-	    void (cleanup_fn)(void), int fd, off_t length);
-#define SAFE_FTRUNCATE(cleanup_fn, fd, length) \
-	safe_ftruncate(__FILE__, __LINE__, cleanup_fn, (fd), (length))
-
-int safe_truncate(const char *file, const int lineno,
-	    void (cleanup_fn)(void), const char *path, off_t length);
-#define SAFE_TRUNCATE(cleanup_fn, fd, length) \
-	safe_truncate(__FILE__, __LINE__, cleanup_fn, (path), (length))
-
 long safe_strtol(const char *file, const int lineno,
 	    void (cleanup_fn)(void), char *str, long min, long max);
 #define SAFE_STRTOL(cleanup_fn, str, min, max) \
@@ -196,21 +175,6 @@ long safe_sysconf(const char *file, const int lineno,
 #define SAFE_SYSCONF(cleanup_fn, name) \
 	safe_sysconf(__FILE__, __LINE__, cleanup_fn, name)
 
-int safe_stat(const char *file, const int lineno, void (cleanup_fn)(void),
-              const char *path, struct stat *buf);
-#define SAFE_STAT(cleanup_fn, path, buf) \
-	safe_stat(__FILE__, __LINE__, (cleanup_fn), (path), (buf))
-
-int safe_fstat(const char *file, const int lineno, void (cleanup_fn)(void),
-	       int fd, struct stat *buf);
-#define SAFE_FSTAT(cleanup_fn, fd, buf) \
-	safe_fstat(__FILE__, __LINE__, (cleanup_fn), (fd), (buf))
-
-int safe_lstat(const char *file, const int lineno, void (cleanup_fn)(void),
-               const char *path, struct stat *buf);
-#define SAFE_LSTAT(cleanup_fn, path, buf) \
-	safe_lstat(__FILE__, __LINE__, (cleanup_fn), (path), (buf))
-
 int safe_getrlimit(const char *file, const int lineno, void (cleanup_fn)(void),
 		   int resource, struct rlimit *rlim);
 #define SAFE_GETRLIMIT(cleanup_fn, resource, rlim) \
@@ -271,5 +235,134 @@ int safe_rename(const char *file, const int lineno, void (*cleanup_fn)(void),
 #define SAFE_RENAME(cleanup_fn, oldpath, newpath) \
 	safe_rename(__FILE__, __LINE__, (cleanup_fn), (oldpath), (newpath))
 
+/*
+ * following functions are inline because the behaviour may depend on
+ * -D_FILE_OFFSET_BITS=64 -DOFF_T=__off64_t compile flags
+ */
+
+static inline void *safe_mmap(const char *file, const int lineno,
+	void (*cleanup_fn)(void), void *addr, size_t length,
+	int prot, int flags, int fd, off_t offset)
+{
+	void *rval;
+
+	rval = mmap(addr, length, prot, flags, fd, offset);
+	if (rval == MAP_FAILED) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: mmap(%p,%zu,%d,%d,%d,%ld) failed",
+			 file, lineno, addr, length, prot, flags, fd,
+			 (long) offset);
+	}
+
+	return rval;
+}
+#define SAFE_MMAP(cleanup_fn, addr, length, prot, flags, fd, offset) \
+	safe_mmap(__FILE__, __LINE__, (cleanup_fn), (addr), (length), (prot), \
+	(flags), (fd), (offset))
+
+static inline int safe_ftruncate(const char *file, const int lineno,
+	void (cleanup_fn) (void), int fd, off_t length)
+{
+	int rval;
+
+	rval = ftruncate(fd, length);
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: ftruncate(%d,%ld) failed",
+			 file, lineno, fd, (long)length);
+	}
+
+	return rval;
+}
+#define SAFE_FTRUNCATE(cleanup_fn, fd, length) \
+	safe_ftruncate(__FILE__, __LINE__, cleanup_fn, (fd), (length))
+
+static inline int safe_truncate(const char *file, const int lineno,
+	void (cleanup_fn) (void), const char *path, off_t length)
+{
+	int rval;
+
+	rval = truncate(path, length);
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: truncate(%s,%ld) failed",
+			 file, lineno, path, (long)length);
+	}
+
+	return rval;
+}
+#define SAFE_TRUNCATE(cleanup_fn, fd, length) \
+	safe_truncate(__FILE__, __LINE__, cleanup_fn, (path), (length))
+
+static inline int safe_stat(const char *file, const int lineno,
+	void (cleanup_fn)(void), const char *path, struct stat *buf)
+{
+	int rval;
+
+	rval = stat(path, buf);
+
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: stat(%s,%p) failed", file, lineno, path, buf);
+	}
+
+	return rval;
+}
+#define SAFE_STAT(cleanup_fn, path, buf) \
+	safe_stat(__FILE__, __LINE__, (cleanup_fn), (path), (buf))
+
+static inline int safe_fstat(const char *file, const int lineno,
+	void (cleanup_fn)(void), int fd, struct stat *buf)
+{
+	int rval;
+
+	rval = fstat(fd, buf);
+
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: fstat(%d,%p) failed", file, lineno, fd, buf);
+	}
+
+	return rval;
+}
+#define SAFE_FSTAT(cleanup_fn, fd, buf) \
+	safe_fstat(__FILE__, __LINE__, (cleanup_fn), (fd), (buf))
+
+static inline int safe_lstat(const char *file, const int lineno,
+	void (cleanup_fn)(void), const char *path, struct stat *buf)
+{
+	int rval;
+
+	rval = lstat(path, buf);
+
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: lstat(%s,%p) failed", file, lineno, path, buf);
+	}
+
+	return rval;
+}
+#define SAFE_LSTAT(cleanup_fn, path, buf) \
+	safe_lstat(__FILE__, __LINE__, (cleanup_fn), (path), (buf))
+
+static inline off_t safe_lseek(const char *file, const int lineno,
+	void (cleanup_fn)(void), int fd, off_t offset, int whence)
+{
+	off_t rval;
+
+	rval = lseek(fd, offset, whence);
+
+	if (rval == (off_t) -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			"%s:%d: lseek(%d,%ld,%d) failed",
+			file, lineno, fd, (long)offset, whence);
+	}
+
+	return rval;
+}
+#define SAFE_LSEEK(cleanup_fn, fd, offset, whence) \
+	safe_lseek(__FILE__, __LINE__, cleanup_fn, (fd), (offset), (whence))
+
+
 #endif /* __SAFE_MACROS_H__ */
 #endif /* __TEST_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index eefacae..76d781f 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -185,23 +185,6 @@ int safe_rmdir(const char *file, const int lineno, void (*cleanup_fn) (void),
 	return (rval);
 }
 
-void *safe_mmap(const char *file, const int lineno, void (*cleanup_fn) (void),
-		void *addr, size_t length, int prot, int flags, int fd,
-		off_t offset)
-{
-	void *rval;
-
-	rval = mmap(addr, length, prot, flags, fd, offset);
-	if (rval == MAP_FAILED) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: mmap(%p,%zu,%d,%d,%d,%ld) failed",
-			 file, lineno, addr, length, prot, flags, fd,
-			 (long) offset);
-	}
-
-	return rval;
-}
-
 int safe_munmap(const char *file, const int lineno, void (*cleanup_fn) (void),
                 void *addr, size_t length)
 {
@@ -391,23 +374,6 @@ int safe_link(const char *file, const int lineno,
 	return rval;
 }
 
-off_t safe_lseek(const char *file, const int lineno,
-                 void (cleanup_fn)(void), int fd,
-                 off_t offset, int whence)
-{
-	off_t rval;
-
-	rval = lseek(fd, offset, whence);
-
-	if (rval == (off_t) -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: lseek(%d,%ld,%d) failed",
-			 file, lineno, fd, (long)offset, whence);
-	}
-
-	return rval;
-}
-
 int safe_symlink(const char *file, const int lineno,
                  void (cleanup_fn)(void), const char *oldpath,
                  const char *newpath)
@@ -440,36 +406,6 @@ ssize_t safe_write(const char *file, const int lineno, void (cleanup_fn) (void),
 	return rval;
 }
 
-int safe_ftruncate(const char *file, const int lineno,
-		   void (cleanup_fn) (void), int fd, off_t length)
-{
-	int rval;
-
-	rval = ftruncate(fd, length);
-	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: ftruncate(%d,%ld) failed",
-			 file, lineno, fd, (long)length);
-	}
-
-	return rval;
-}
-
-int safe_truncate(const char *file, const int lineno,
-		  void (cleanup_fn) (void), const char *path, off_t length)
-{
-	int rval;
-
-	rval = truncate(path, length);
-	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: truncate(%s,%ld) failed",
-			 file, lineno, path, (long)length);
-	}
-
-	return rval;
-}
-
 long safe_strtol(const char *file, const int lineno,
 		 void (cleanup_fn) (void), char *str, long min, long max)
 {
@@ -553,51 +489,6 @@ long safe_sysconf(const char *file, const int lineno,
 	return rval;
 }
 
-int safe_stat(const char *file, const int lineno,
-	      void (cleanup_fn)(void), const char *path, struct stat *buf)
-{
-	int rval;
-
-	rval = stat(path, buf);
-
-	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: stat(%s,%p) failed", file, lineno, path, buf);
-	}
-
-	return rval;
-}
-
-int safe_fstat(const char *file, const int lineno,
-	       void (cleanup_fn)(void), int fd, struct stat *buf)
-{
-	int rval;
-
-	rval = fstat(fd, buf);
-
-	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: fstat(%d,%p) failed", file, lineno, fd, buf);
-	}
-
-	return rval;
-}
-
-int safe_lstat(const char *file, const int lineno,
-	       void (cleanup_fn)(void), const char *path, struct stat *buf)
-{
-	int rval;
-
-	rval = lstat(path, buf);
-
-	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: lstat(%s,%p) failed", file, lineno, path, buf);
-	}
-
-	return rval;
-}
-
 int safe_getrlimit(const char *file, const int lineno,
 		   void (cleanup_fn)(void), int resource, struct rlimit *rlim)
 {
-- 
1.7.1


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
