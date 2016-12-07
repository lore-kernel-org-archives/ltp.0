From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 7 Dec 2016 13:16:36 +0800
Subject: [LTP] [PATCH v2 1/5] tst_test.h: move test result description to
	tst_res.h
In-Reply-To: <20161123135513.GI3346@rei.lan>
References: <20161123135513.GI3346@rei.lan>
Message-ID: <1481087800-20639-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Move test result description to tst_res.h so that we
can use them independently for new ipc.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/tst_res.h  | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/tst_test.h | 30 +-----------------------------
 2 files changed, 51 insertions(+), 29 deletions(-)
 create mode 100644 include/tst_res.h

diff --git a/include/tst_res.h b/include/tst_res.h
new file mode 100644
index 0000000..0f55b01
--- /dev/null
+++ b/include/tst_res.h
@@ -0,0 +1,50 @@
+/*
+ * Copyright (c) 2016 Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TST_RES_H__
+#define TST_RES_H__
+
+/*
+ * Reports testcase result.
+ */
+void tst_res_(const char *file, const int lineno, int ttype,
+	      const char *fmt, ...)
+	__attribute__ ((format (printf, 4, 5)));
+
+#define tst_res(ttype, arg_fmt, ...) \
+	tst_res_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__)
+
+void tst_resm_hexd_(const char *file, const int lineno, int ttype,
+		    const void *buf, size_t size, const char *arg_fmt, ...)
+	__attribute__ ((format (printf, 6, 7)));
+
+#define tst_res_hexd(ttype, buf, size, arg_fmt, ...) \
+	tst_resm_hexd_(__FILE__, __LINE__, (ttype), (buf), (size), \
+		(arg_fmt), ##__VA_ARGS__)
+
+/*
+ * Reports result and exits a test.
+ */
+void tst_brk_(const char *file, const int lineno, int ttype,
+	      const char *fmt, ...)
+	__attribute__ ((format (printf, 4, 5)))
+	__attribute__ ((noreturn));
+
+#define tst_brk(ttype, arg_fmt, ...) \
+	tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__)
+
+#endif	/* TST_RES_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index 1492ff5..92f2e2c 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -22,6 +22,7 @@
 
 #include "tst_common.h"
 #include "tst_res_flags.h"
+#include "tst_res.h"
 #include "tst_checkpoint.h"
 #include "tst_device.h"
 #include "tst_mkfs.h"
@@ -34,35 +35,6 @@
 #include "tst_kvercmp.h"
 #include "tst_clone.h"
 
-/*
- * Reports testcase result.
- */
-void tst_res_(const char *file, const int lineno, int ttype,
-              const char *fmt, ...)
-              __attribute__ ((format (printf, 4, 5)));
-
-#define tst_res(ttype, arg_fmt, ...) \
-	tst_res_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__)
-
-void tst_resm_hexd_(const char *file, const int lineno, int ttype,
-	const void *buf, size_t size, const char *arg_fmt, ...)
-	__attribute__ ((format (printf, 6, 7)));
-
-#define tst_res_hexd(ttype, buf, size, arg_fmt, ...) \
-	tst_resm_hexd_(__FILE__, __LINE__, (ttype), (buf), (size), \
-			(arg_fmt), ##__VA_ARGS__)
-
-/*
- * Reports result and exits a test.
- */
-void tst_brk_(const char *file, const int lineno, int ttype,
-              const char *fmt, ...)
-              __attribute__ ((format (printf, 4, 5)))
-              __attribute__ ((noreturn));
-
-#define tst_brk(ttype, arg_fmt, ...) \
-	tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__)
-
 pid_t safe_fork(const char *filename, unsigned int lineno);
 #define SAFE_FORK() \
 	safe_fork(__FILE__, __LINE__)
-- 
1.8.3.1



