From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue,  4 May 2021 14:40:54 +0100
Subject: [LTP] [PATCH v6 1/7] API: Add safe openat, printfat,
 readat and unlinkat
In-Reply-To: <20210504134100.20666-1-rpalethorpe@suse.com>
References: <20210504134100.20666-1-rpalethorpe@suse.com>
Message-ID: <20210504134100.20666-2-rpalethorpe@suse.com>
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_safe_file_at.h |  61 ++++++++++++
 lib/tst_safe_file_at.c     | 197 +++++++++++++++++++++++++++++++++++++
 2 files changed, 258 insertions(+)
 create mode 100644 include/tst_safe_file_at.h
 create mode 100644 lib/tst_safe_file_at.c

diff --git a/include/tst_safe_file_at.h b/include/tst_safe_file_at.h
new file mode 100644
index 000000000..8df34227f
--- /dev/null
+++ b/include/tst_safe_file_at.h
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 SUSE LLC <rpalethorpe@suse.com>
+ */
+
+#ifndef TST_SAFE_FILE_AT_H
+#define TST_SAFE_FILE_AT_H
+
+#include <sys/types.h>
+#include <stdarg.h>
+
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
+const char *tst_decode_fd(const int fd)
+			  __attribute__((warn_unused_result));
+
+int safe_openat(const char *const file, const int lineno, const int dirfd,
+                const char *const path, const int oflags, ...)
+		__attribute__((nonnull, warn_unused_result));
+
+ssize_t safe_file_readat(const char *const file, const int lineno,
+			 const int dirfd, const char *const path,
+			 char *const buf, const size_t nbyte)
+			 __attribute__ ((nonnull));
+
+int tst_file_vprintfat(const int dirfd, const char *const path,
+		       const char *const fmt, va_list va)
+		       __attribute__((nonnull));
+int tst_file_printfat(const int dirfd, const char *const path,
+		      const char *const fmt, ...)
+		      __attribute__ ((format (printf, 3, 4), nonnull));
+
+int safe_file_vprintfat(const char *const file, const int lineno,
+			const int dirfd, const char *const path,
+			const char *const fmt, va_list va)
+			__attribute__ ((nonnull));
+
+int safe_file_printfat(const char *const file, const int lineno,
+		       const int dirfd, const char *const path,
+		       const char *const fmt, ...)
+		       __attribute__ ((format (printf, 5, 6), nonnull));
+
+int safe_unlinkat(const char *const file, const int lineno,
+		  const int dirfd, const char *const path, const int flags)
+		  __attribute__ ((nonnull));
+
+#endif
diff --git a/lib/tst_safe_file_at.c b/lib/tst_safe_file_at.c
new file mode 100644
index 000000000..ca8ef2f68
--- /dev/null
+++ b/lib/tst_safe_file_at.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 SUSE LLC <rpalethorpe@suse.com>
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include "lapi/fcntl.h"
+#include "tst_safe_file_at.h"
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+static char fd_path[PATH_MAX];
+
+const char *tst_decode_fd(const int fd)
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
+int safe_openat(const char *const file, const int lineno,
+		const int dirfd, const char *const path, const int oflags, ...)
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
+ssize_t safe_file_readat(const char *const file, const int lineno,
+			 const int dirfd, const char *const path,
+			 char *const buf, const size_t nbyte)
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
+int tst_file_vprintfat(const int dirfd, const char *const path,
+		       const char *const fmt, va_list va)
+{
+	const int fd = openat(dirfd, path, O_WRONLY);
+	int ret, errno_cpy;
+
+	if (fd < 0)
+		return -1;
+
+	ret = vdprintf(fd, fmt, va);
+	errno_cpy = errno;
+	close(fd);
+
+	if (ret < 0) {
+		errno = errno_cpy;
+		return -2;
+	}
+
+	return ret;
+}
+
+int tst_file_printfat(const int dirfd, const char *const path,
+		      const char *const fmt, ...)
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
+int safe_file_vprintfat(const char *const file, const int lineno,
+			const int dirfd, const char *const path,
+			const char *const fmt, va_list va)
+{
+	char buf[16];
+	va_list vac;
+	int rval, errno_cpy;
+
+	va_copy(vac, va);
+
+	rval = tst_file_vprintfat(dirfd, path, fmt, va);
+
+	if (rval == -2) {
+		errno_cpy = errno;
+		rval = vsnprintf(buf, sizeof(buf), fmt, vac);
+		va_end(vac);
+
+		if (rval >= (ssize_t)sizeof(buf))
+			strcpy(buf + sizeof(buf) - 5, "...");
+		else if (rval < 0)
+			buf[0] = '\0';
+
+		errno = errno_cpy;
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "vdprintf(%d<%s>, '%s', '%s'<%s>)",
+			 dirfd, tst_decode_fd(dirfd), path, fmt, buf);
+		return -1;
+	}
+
+	va_end(vac);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"openat(%d<%s>, '%s', O_WRONLY)",
+			dirfd, tst_decode_fd(dirfd), path);
+	}
+
+	return rval;
+}
+
+int safe_file_printfat(const char *const file, const int lineno,
+		       const int dirfd, const char *const path,
+		       const char *const fmt, ...)
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
+int safe_unlinkat(const char *const file, const int lineno,
+		  const int dirfd, const char *const path, const int flags)
+{
+	const int rval = unlinkat(dirfd, path, flags);
+	const char *flags_sym;
+
+	if (!rval)
+		return rval;
+
+	switch(flags) {
+	case AT_REMOVEDIR:
+		flags_sym = "AT_REMOVEDIR";
+		break;
+	case 0:
+		flags_sym = "0";
+		break;
+	default:
+		flags_sym = "?";
+		break;
+	}
+
+	tst_brk_(file, lineno, TBROK | TERRNO,
+		 "unlinkat(%d<%s>, '%s', %s)",
+		 dirfd, tst_decode_fd(dirfd), path, flags_sym);
+
+	return rval;
+}
-- 
2.31.1

