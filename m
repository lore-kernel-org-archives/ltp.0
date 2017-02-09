From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  9 Feb 2017 15:44:45 +0100
Subject: [LTP] [PATCH 2/2] newlib: Allow SAFE_MACROS to be called from
	cleanup
In-Reply-To: <20170209144445.22737-1-chrubis@suse.cz>
References: <20170209144445.22737-1-chrubis@suse.cz>
Message-ID: <20170209144445.22737-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Which is done by:

* Dropping attribute ((noreturn)) from all tst_brk_() definitions so
  that the function could actually return in case it's called from
  cleanup.

* Adding brk and res handlers to tst_test.c so that we can temporarily
  replace the tst_brk_() function with function that maps TBROK to TWARN
  and calls tst_vres_().

+ testcase

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test.h          |  3 +--
 lib/ltp_priv.h              |  2 +-
 lib/newlib_tests/.gitignore |  1 +
 lib/newlib_tests/test14.c   | 44 ++++++++++++++++++++++++++++++++++++++++++++
 lib/tst_test.c              | 28 +++++++++++++++++++++++++---
 5 files changed, 72 insertions(+), 6 deletions(-)
 create mode 100644 lib/newlib_tests/test14.c

diff --git a/include/tst_test.h b/include/tst_test.h
index 7dc371c..a8e01fc 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -58,8 +58,7 @@ void tst_resm_hexd_(const char *file, const int lineno, int ttype,
  */
 void tst_brk_(const char *file, const int lineno, int ttype,
               const char *fmt, ...)
-              __attribute__ ((format (printf, 4, 5)))
-              __attribute__ ((noreturn));
+              __attribute__ ((format (printf, 4, 5)));
 
 #define tst_brk(ttype, arg_fmt, ...) \
 	tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__)
diff --git a/lib/ltp_priv.h b/lib/ltp_priv.h
index de45e4a..e678a28 100644
--- a/lib/ltp_priv.h
+++ b/lib/ltp_priv.h
@@ -59,7 +59,7 @@ void tst_vbrk_(const char *file, const int lineno, int ttype,
                const char *fmt, va_list va) __attribute__((noreturn));
 
 void tst_brk_(const char *file, const int lineno, int ttype,
-              const char *msg, ...) __attribute__((noreturn));
+              const char *msg, ...);
 
 void tst_vres_(const char *file, const int lineno, int ttype,
                const char *fmt, va_list va);
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index bc2409c..8e12007 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -11,6 +11,7 @@ test10
 test11
 test12
 test13
+test14
 tst_device
 tst_safe_fileops
 tst_res_hexd
diff --git a/lib/newlib_tests/test14.c b/lib/newlib_tests/test14.c
new file mode 100644
index 0000000..501bd3a
--- /dev/null
+++ b/lib/newlib_tests/test14.c
@@ -0,0 +1,44 @@
+/*
+ * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include "tst_safe_net.h"
+
+static void cleanup(void)
+{
+	int i;
+
+	tst_brk(TBROK, "TBROK in cleanup");
+	SAFE_OPEN("foo", O_RDWR);
+	SAFE_FILE_SCANF("foo", "%i", &i);
+	SAFE_FOPEN("foo", "r");
+	SAFE_SOCKET(AF_UNIX, SOCK_STREAM, -1);
+	tst_res(TINFO, "Test still here");
+}
+
+static void do_test(void)
+{
+	tst_res(TPASS, "Passed");
+}
+
+static struct tst_test test = {
+	.tid = "test14",
+	.test_all = do_test,
+	.cleanup = cleanup,
+};
diff --git a/lib/tst_test.c b/lib/tst_test.c
index e78b412..8d528a7 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -241,12 +241,34 @@ void tst_vres_(const char *file, const int lineno, int ttype,
 }
 
 void tst_vbrk_(const char *file, const int lineno, int ttype,
-               const char *fmt, va_list va) __attribute__((noreturn));
+               const char *fmt, va_list va);
+
+static void (*tst_res_handler)(const char *file, const int lineno, int ttype,
+			       const char *fmt, va_list va) = tst_vres_;
+
+static void (*tst_brk_handler)(const char *file, const int lineno, int ttype,
+			       const char *fmt, va_list va) = tst_vbrk_;
+
+static void tst_cvres(const char *file, const int lineno, int ttype,
+		      const char *fmt, va_list va)
+{
+	if (TTYPE_RESULT(ttype) == TBROK) {
+		ttype &= ~TTYPE_MASK;
+		ttype |= TWARN;
+	}
+
+	print_result(file, lineno, ttype, fmt, va);
+	update_results(file, lineno, TTYPE_RESULT(ttype));
+}
 
 static void do_test_cleanup(void)
 {
+	tst_brk_handler = tst_cvres;
+
 	if (tst_test->cleanup)
 		tst_test->cleanup();
+
+	tst_brk_handler = tst_vbrk_;
 }
 
 void tst_vbrk_(const char *file, const int lineno, int ttype,
@@ -269,7 +291,7 @@ void tst_res_(const char *file, const int lineno, int ttype,
 	va_list va;
 
 	va_start(va, fmt);
-	tst_vres_(file, lineno, ttype, fmt, va);
+	tst_res_handler(file, lineno, ttype, fmt, va);
 	va_end(va);
 }
 
@@ -279,7 +301,7 @@ void tst_brk_(const char *file, const int lineno, int ttype,
 	va_list va;
 
 	va_start(va, fmt);
-	tst_vbrk_(file, lineno, ttype, fmt, va);
+	tst_brk_handler(file, lineno, ttype, fmt, va);
 	va_end(va);
 }
 
-- 
2.10.2

