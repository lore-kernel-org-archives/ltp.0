From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue,  2 Mar 2021 15:25:04 +0000
Subject: [LTP] [RFC PATCH v2 1/7] API: Add safe openat, printfat,
 readat and unlinkat
In-Reply-To: <20210302152510.15116-1-rpalethorpe@suse.com>
References: <20210302152510.15116-1-rpalethorpe@suse.com>
Message-ID: <20210302152510.15116-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add 'at' variants for a number of system calls and LTP SAFE API
functions. This avoids using sprintf everywhere to build paths.

Also adds tst_decode_fd which allows us to retrieve the path for an FD
for debugging purposes without having to store it ourselves. However
the proc symlink may not be available on some systems.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_safe_file_ops.h |  39 ++++++++
 lib/tst_safe_file_ops.c     | 171 ++++++++++++++++++++++++++++++++++++
 2 files changed, 210 insertions(+)
 create mode 100644 lib/tst_safe_file_ops.c

diff --git a/include/tst_safe_file_ops.h b/include/tst_safe_file_ops.h
index 223eddd1f..dff6a793c 100644
--- a/include/tst_safe_file_ops.h
+++ b/include/tst_safe_file_ops.h
@@ -57,4 +57,43 @@
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
+char *tst_decode_fd(int fd);
+
+int safe_openat(const char *file, const int lineno,
+		int dirfd, const char *path, int oflags, ...);
+
+ssize_t safe_file_readat(const char *file, const int lineno,
+			 int dirfd, const char *path, char *buf, size_t nbyte);
+
+int tst_file_vprintfat(int dirfd, const char *path, const char *fmt, va_list va);
+int tst_file_printfat(int dirfd, const char *path, const char *fmt, ...)
+			__attribute__ ((format (printf, 3, 4)));
+
+int safe_file_vprintfat(const char *file, const int lineno,
+			int dirfd, const char *path,
+			const char *fmt, va_list va);
+
+int safe_file_printfat(const char *file, const int lineno,
+		       int dirfd, const char *path, const char *fmt, ...)
+			__attribute__ ((format (printf, 5, 6)));
+
+int safe_unlinkat(const char *file, const int lineno,
+		  int dirfd, const char *path, int flags);
+
 #endif /* TST_SAFE_FILE_OPS */
diff --git a/lib/tst_safe_file_ops.c b/lib/tst_safe_file_ops.c
new file mode 100644
index 000000000..af4157476
--- /dev/null
+++ b/lib/tst_safe_file_ops.c
@@ -0,0 +1,171 @@
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include "lapi/fcntl.h"
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+char fd_path[PATH_MAX];
+
+char *tst_decode_fd(int fd)
+{
+	ssize_t ret;
+	char proc_path[32];
+
+	if (fd < 0)
+		return "!";
+
+	sprintf(proc_path, "/proc/self/fd/%d", fd);
+	ret = readlink(proc_path, fd_path, sizeof(fd_path));
+
+	if (ret < 0)
+		return "?";
+
+	fd_path[ret] = '\0';
+
+	return fd_path;
+}
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
+	if (fd > -1)
+		return fd;
+
+	tst_brk_(file, lineno, TBROK | TERRNO,
+		 "openat(%d<%s>, '%s', %o, %o)",
+		 dirfd, tst_decode_fd(dirfd), path, oflags, mode);
+
+	return fd;
+}
+
+ssize_t safe_file_readat(const char *file, const int lineno,
+			 int dirfd, const char *path, char *buf, size_t nbyte)
+{
+	int fd = safe_openat(file, lineno, dirfd, path, O_RDONLY);
+	ssize_t rval;
+
+	if (fd < 0)
+		return -1;
+
+	rval = safe_read(file, lineno, NULL, 0, fd, buf, nbyte - 1);
+	if (rval < 0)
+		return -1;
+
+	close(fd);
+	buf[rval] = '\0';
+
+	if (rval >= (ssize_t)nbyte - 1) {
+		tst_brk_(file, lineno, TBROK,
+			"Buffer length %zu too small to read %d<%s>/%s",
+			nbyte, dirfd, tst_decode_fd(dirfd), path);
+	}
+
+	return rval;
+}
+
+int tst_file_vprintfat(int dirfd, const char *path, const char *fmt, va_list va)
+{
+	int fd = openat(dirfd, path, O_WRONLY);
+
+	if (fd < 0)
+		return -1;
+
+	TEST(vdprintf(fd, fmt, va));
+	close(fd);
+
+	if (TST_RET < 0) {
+		errno = TST_ERR;
+		return -2;
+	}
+
+	return TST_RET;
+}
+
+int tst_file_printfat(int dirfd, const char *path, const char *fmt, ...)
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
+	char buf[16];
+	va_list vac;
+	int rval;
+
+	va_copy(vac, va);
+
+	TEST(tst_file_vprintfat(dirfd, path, fmt, va));
+
+	if (TST_RET == -2) {
+		rval = vsnprintf(buf, sizeof(buf), fmt, vac);
+		va_end(vac);
+
+		if (rval >= (ssize_t)sizeof(buf))
+			strcpy(buf + sizeof(buf) - 5, "...");
+
+		tst_brk_(file, lineno, TBROK | TTERRNO,
+			 "vdprintf(%d<%s>, '%s', '%s'<%s>)",
+			 dirfd, tst_decode_fd(dirfd), path, fmt,
+			 rval > 0 ? buf : "???");
+		return -1;
+	}
+
+	va_end(vac);
+
+	if (TST_RET == -1) {
+		tst_brk_(file, lineno, TBROK | TTERRNO,
+			"openat(%d<%s>, '%s', O_WRONLY)",
+			dirfd, tst_decode_fd(dirfd), path);
+	}
+
+	return TST_RET;
+}
+
+int safe_file_printfat(const char *file, const int lineno,
+		       int dirfd, const char *path,
+		       const char *fmt, ...)
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
+	if (rval > -1)
+		return rval;
+
+	tst_brk_(file, lineno, TBROK | TERRNO,
+		 "unlinkat(%d<%s>, '%s', %s)", dirfd, tst_decode_fd(dirfd), path,
+		 flags == AT_REMOVEDIR ? "AT_REMOVEDIR" : (flags ? "?" : "0"));
+
+	return rval;
+}
-- 
2.30.0

