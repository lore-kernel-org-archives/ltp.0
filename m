From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 16 Dec 2020 10:01:17 +0000
Subject: [LTP] [RFC PATCH 1/5] safe_file_ops: Introduce openat and printfat
 API
In-Reply-To: <20201216100121.16683-1-rpalethorpe@suse.com>
References: <20201216100121.16683-1-rpalethorpe@suse.com>
Message-ID: <20201216100121.16683-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Create safe wrappers for the *at commands. This allows us to print to
files in a directory without constructing the full file path using
sprintf.
---
 include/tst_safe_file_ops.h |  38 +++++++++++
 lib/tst_safe_file_ops.c     | 126 ++++++++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)
 create mode 100644 lib/tst_safe_file_ops.c

diff --git a/include/tst_safe_file_ops.h b/include/tst_safe_file_ops.h
index 894c16123..fb3510557 100644
--- a/include/tst_safe_file_ops.h
+++ b/include/tst_safe_file_ops.h
@@ -46,4 +46,42 @@
 #define TST_MOUNT_OVERLAY() \
 	(mount_overlay(__FILE__, __LINE__, 0) == 0)
 
+#define SAFE_OPENAT(dirfd, path, oflags, ...)			\
+	safe_openat(__FILE__, __LINE__,				\
+		    (dirfd), (path), (oflags), ## __VA_ARGS__)
+
+#define SAFE_FILE_READAT(dirfd, path, buf, nbyte)			\
+	safe_file_readat(__FILE__, __LINE__,				\
+			 (dirfd), (path), (buf), (nbyte))
+
+
+#define SAFE_FILE_PRINTFAT(dirfd, path, fmt, ...)			\
+	safe_file_printfat(__FILE__, __LINE__,				\
+			   (dirfd), (path), (fmt), __VA_ARGS__)
+
+#define SAFE_UNLINKAT(dirfd, path, flags)				\
+	safe_unlinkat(__FILE__, __LINE__, (dirfd), (path), (flags))
+
+
+int safe_openat(const char *file, const int lineno,
+		int dirfd, const char *path, int oflags, ...);
+
+ssize_t safe_file_readat(const char *file, const int lineno,
+			 int dirfd, const char *path, char *buf, size_t nbyte);
+
+int tst_file_vprintfat(int dirfd, const char *path, const char *fmt, va_list va);
+int tst_file_printfat(int dirfd, const char *path, char *fmt, ...)
+			__attribute__ ((format (printf, 3, 4)));
+
+int safe_file_vprintfat(const char *file, const int lineno,
+			int dirfd, const char *path,
+			const char *fmt, va_list va);
+
+int safe_file_printfat(const char *file, const int lineno,
+		       int dirfd, const char *path, char *fmt, ...)
+			__attribute__ ((format (printf, 5, 6)));
+
+int safe_unlinkat(const char *file, const int lineno,
+		  int dirfd, const char *path, int flags);
+
 #endif /* TST_SAFE_FILE_OPS */
diff --git a/lib/tst_safe_file_ops.c b/lib/tst_safe_file_ops.c
new file mode 100644
index 000000000..e857bdd14
--- /dev/null
+++ b/lib/tst_safe_file_ops.c
@@ -0,0 +1,126 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include "lapi/fcntl.h"
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+int safe_openat(const char *file, const int lineno,
+		int dirfd, const char *path, int oflags, ...)
+{
+	va_list ap;
+	int fd;
+	mode_t mode;
+
+	va_start(ap, oflags);
+	mode = va_arg(ap, int);
+	va_end(ap);
+
+	fd = openat(dirfd, path, oflags, mode);
+
+	if (fd < 0) {
+		tst_brk(TBROK | TERRNO, "%s:%d: openat(%d, \"%s\", O_RDONLY)",
+			file, lineno, dirfd, path);
+	}
+
+	return fd;
+}
+
+ssize_t safe_file_readat(const char *file, const int lineno,
+			 int dirfd, const char *path, char *buf, size_t nbyte)
+{
+	int fd = safe_openat(file, lineno, dirfd, path, O_RDONLY);
+	ssize_t rval = safe_read(file, lineno, NULL, 0, fd, buf, nbyte - 1);
+
+	close(fd);
+	buf[rval] = '\0';
+
+	if (rval >= (ssize_t)nbyte - 1) {
+		tst_brk(TBROK,
+			"%s:%d: Buffer length %zu too small to read (%d)/%s",
+			file, lineno, nbyte, dirfd, path);
+	}
+
+	return rval;
+}
+
+int tst_file_vprintfat(int dirfd, const char *path, const char *fmt, va_list va)
+{
+	int fd = openat(dirfd, path, O_WRONLY);
+
+	if (fd < 0) {
+		tst_res(TINFO | TERRNO,
+			"openat(%d, %s, O_WRONLY)", dirfd, path);
+		return fd;
+	}
+
+	TEST(vdprintf(fd, fmt, va));
+	close(fd);
+
+	if (TST_RET < 0)
+		tst_res(TINFO | TTERRNO, "vdprintf(%d, %s, ...)", fd, fmt);
+	errno = TST_ERR;
+
+	return TST_RET;
+}
+
+int tst_file_printfat(int dirfd, const char *path, char *fmt, ...)
+{
+	va_list va;
+	int rval;
+
+	va_start(va, fmt);
+	rval = tst_file_vprintfat(dirfd, path, fmt, va);
+	va_end(va);
+
+	return rval;
+}
+
+int safe_file_vprintfat(const char *file, const int lineno,
+			int dirfd, const char *path,
+			const char *fmt, va_list va)
+{
+	int rval, fd = safe_openat(file, lineno, dirfd, path, O_WRONLY);
+
+	if (fd < 1)
+		return fd;
+
+	rval = vdprintf(fd, fmt, va);
+
+	if (rval > -1)
+		return rval;
+
+	tst_brk(TBROK | TERRNO, "%s:%d: printfat((%d)/%s, %s, ...)",
+		file, lineno, dirfd, path, fmt);
+
+	return 0;
+}
+
+int safe_file_printfat(const char *file, const int lineno,
+		       int dirfd, const char *path, char *fmt, ...)
+{
+	va_list va;
+	int rval;
+
+	va_start(va, fmt);
+	rval = safe_file_vprintfat(file, lineno, dirfd, path, fmt, va);
+	va_end(va);
+
+	return rval;
+}
+
+int safe_unlinkat(const char *file, const int lineno,
+		  int dirfd, const char *path, int flags)
+{
+	int rval = unlinkat(dirfd, path, flags);
+
+	if (rval < 0) {
+		tst_brk(TBROK | TERRNO,
+			"%s:%d: unlinkat(%d, %s, %s)", file, lineno,
+			dirfd, path,
+			flags == AT_REMOVEDIR ? "AT_REMOVEDIR" :
+						(flags ? "?" : "0"));
+	}
+
+	return rval;
+}
-- 
2.29.2

