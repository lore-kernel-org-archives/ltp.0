From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Apr 2017 14:06:45 +0200
Subject: [LTP] [COMMITTED] [PATCH 2/2] lib: Fix undefined reference to
	`mq_open'
In-Reply-To: <20170410120645.21076-1-chrubis@suse.cz>
References: <20170410120645.21076-1-chrubis@suse.cz>
Message-ID: <20170410120645.21076-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commit moves the safe_mq_open() function into the header
which fixes undeterministic linker failures.

This fix replaces the reverted commit:

commit fcfb6970002454cfa29cf679a82ba92c94fb59e0
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Wed Mar 29 18:44:44 2017 +0200

    lib: Fix undefined reference to `mq_open' build failures

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Suggested-by: Jan Stancek <jstancek@redhat.com>
---
 include/tst_safe_posix_ipc.h                       | 36 +++++++++++++-
 lib/tst_safe_posix_ipc.c                           | 55 ----------------------
 testcases/kernel/syscalls/mq_open/mq_open01.c      |  2 +-
 .../syscalls/mq_timedreceive/mq_timedreceive01.c   |  2 +-
 4 files changed, 36 insertions(+), 59 deletions(-)
 delete mode 100644 lib/tst_safe_posix_ipc.c

diff --git a/include/tst_safe_posix_ipc.h b/include/tst_safe_posix_ipc.h
index 3802e27..b089f01 100644
--- a/include/tst_safe_posix_ipc.h
+++ b/include/tst_safe_posix_ipc.h
@@ -24,10 +24,42 @@
 #ifndef TST_SAFE_POSIX_IPC_H__
 #define TST_SAFE_POSIX_IPC_H__
 
+#include <mqueue.h>
+#include <stdarg.h>
+
 #define SAFE_MQ_OPEN(pathname, oflags, ...) \
 	safe_mq_open(__FILE__, __LINE__, (pathname), (oflags), ##__VA_ARGS__)
 
-int safe_mq_open(const char *file, const int lineno, const char *pathname,
-	int oflags, ...);
+static inline int safe_mq_open(const char *file, const int lineno,
+			       const char *pathname, int oflags, ...)
+{
+	va_list ap;
+	int rval;
+	mode_t mode;
+	struct mq_attr *attr;
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
 
 #endif /* TST_SAFE_POSIX_IPC_H__ */
diff --git a/lib/tst_safe_posix_ipc.c b/lib/tst_safe_posix_ipc.c
deleted file mode 100644
index 7142a25..0000000
--- a/lib/tst_safe_posix_ipc.c
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <mqueue.h>
-#include <stdarg.h>
-
-#define TST_NO_DEFAULT_MAIN
-#include "tst_test.h"
-#include "tst_safe_posix_ipc.h"
-
-int safe_mq_open(const char *file, const int lineno, const char *pathname,
-	int oflags, ...)
-{
-	va_list ap;
-	int rval;
-	mode_t mode;
-	struct mq_attr *attr;
-
-	va_start(ap, oflags);
-
-	/* Android's NDK's mode_t is smaller than an int, which results in
-	 * SIGILL here when passing the mode_t type.
-	 */
-#ifndef ANDROID
-	mode = va_arg(ap, mode_t);
-#else
-	mode = va_arg(ap, int);
-#endif
-
-	attr = va_arg(ap, struct mq_attr *);
-
-	va_end(ap);
-
-	rval = mq_open(pathname, oflags, mode, attr);
-	if (rval == -1) {
-		tst_brk(TBROK | TERRNO, "%s:%d: mq_open(%s,%d,0%o,%p) failed",
-			 file, lineno, pathname, oflags, mode, attr);
-	}
-
-	return rval;
-}
diff --git a/testcases/kernel/syscalls/mq_open/mq_open01.c b/testcases/kernel/syscalls/mq_open/mq_open01.c
index c2955d8..9d2b136 100644
--- a/testcases/kernel/syscalls/mq_open/mq_open01.c
+++ b/testcases/kernel/syscalls/mq_open/mq_open01.c
@@ -24,9 +24,9 @@
 #include <mqueue.h>
 #include <pwd.h>
 
+#include "tst_test.h"
 #include "tst_safe_file_ops.h"
 #include "tst_safe_posix_ipc.h"
-#include "tst_test.h"
 
 #define QUEUE_NAME	"/test_mqueue"
 #define QUEUE_INIT	"/init_mqueue"
diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index 9d1ed28..32ab7a1 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -24,9 +24,9 @@
 #include <limits.h>
 #include <mqueue.h>
 
+#include "tst_test.h"
 #include "tst_sig_proc.h"
 #include "tst_safe_posix_ipc.h"
-#include "tst_test.h"
 
 static struct sigaction act;
 static pid_t pid;
-- 
2.10.2

