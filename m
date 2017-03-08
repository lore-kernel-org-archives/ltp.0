From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  8 Mar 2017 15:21:53 +0100
Subject: [LTP] [PATCH v4 2/3] lib: SAFE_MQ_OPEN() macro
In-Reply-To: <20170308142154.25916-1-pvorel@suse.cz>
References: <20170308142154.25916-1-pvorel@suse.cz>
Message-ID: <20170308142154.25916-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_safe_posix_ipc.h | 33 +++++++++++++++++++++++++++++++++
 lib/tst_safe_posix_ipc.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 include/tst_safe_posix_ipc.h
 create mode 100644 lib/tst_safe_posix_ipc.c

diff --git a/include/tst_safe_posix_ipc.h b/include/tst_safe_posix_ipc.h
new file mode 100644
index 000000000..3802e2783
--- /dev/null
+++ b/include/tst_safe_posix_ipc.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2017 Petr Vorel pvorel@suse.cz
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program with
+ * other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef TST_SAFE_POSIX_IPC_H__
+#define TST_SAFE_POSIX_IPC_H__
+
+#define SAFE_MQ_OPEN(pathname, oflags, ...) \
+	safe_mq_open(__FILE__, __LINE__, (pathname), (oflags), ##__VA_ARGS__)
+
+int safe_mq_open(const char *file, const int lineno, const char *pathname,
+	int oflags, ...);
+
+#endif /* TST_SAFE_POSIX_IPC_H__ */
diff --git a/lib/tst_safe_posix_ipc.c b/lib/tst_safe_posix_ipc.c
new file mode 100644
index 000000000..5f9fda6ae
--- /dev/null
+++ b/lib/tst_safe_posix_ipc.c
@@ -0,0 +1,41 @@
+#include <mqueue.h>
+#include <stdarg.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_safe_posix_ipc.h"
+
+int safe_mq_open(const char *file, const int lineno, const char *pathname,
+	int oflags, ...)
+{
+	va_list ap;
+	int rval;
+	mode_t mode;
+	struct mq_attr *attr;
+
+	mode = 0;
+	attr = NULL;
+
+	va_start(ap, oflags);
+
+	/* Android's NDK's mode_t is smaller than an int, which results in
+	 * SIGILL here when passing the mode_t type.
+	 */
+#ifndef ANDROID
+	mode = va_arg(ap, mode_t);
+#else
+	mode = va_arg(ap, int);
+#endif
+
+	attr = va_arg(ap, struct mq_attr *);
+
+	va_end(ap);
+
+	rval = mq_open(pathname, oflags, mode, attr);
+	if (rval == -1) {
+		tst_brk(TBROK | TERRNO, "%s:%d: mq_open(%s,%d,0%o,%p) failed",
+			 file, lineno, pathname, oflags, mode, attr);
+	}
+
+	return rval;
+}
-- 
2.12.0

