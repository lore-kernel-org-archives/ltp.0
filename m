From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  9 Feb 2017 15:44:44 +0100
Subject: [LTP] [PATCH 1/2] SAFE_MACROS: Redirect to tst_brk_() early
Message-ID: <20170209144445.22737-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is first patch of a patchset that would allow us to use
SAFE_MACROS() in newlib testcases. After the patch we redirect to
tst_brk_() in case of newlib tests directly in the safe_* functions.

This is needed since the tst_brkm_() from the old library is marked as
attribute ((noreturn)) and because of that the return address is not
saved on stack and hence we cannot return from the function. Removing
the atrribute is not an option either since that generates ~1000
"control reaches end of non-void function" warnings.

So this commit adds brkm_redirect.h internal header that defines macros
that calls tst_brkm_()/tst_brk_() depending on if we are running
oldlib/newlib testcase, that are then applied to the safe macros
sources. With that the code never reaches the tst_brkm_() from which we
cannot return.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/brkm_redirect.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/safe_file_ops.c | 35 ++++++++++++++++++-----------------
 lib/safe_macros.c   |  1 +
 lib/safe_net.c      |  5 +++--
 lib/safe_stdio.c    |  1 +
 5 files changed, 71 insertions(+), 19 deletions(-)
 create mode 100644 lib/brkm_redirect.h

diff --git a/lib/brkm_redirect.h b/lib/brkm_redirect.h
new file mode 100644
index 0000000..4ef0679
--- /dev/null
+++ b/lib/brkm_redirect.h
@@ -0,0 +1,48 @@
+/*
+ * Copyright (c) 2017 Cyril Hrubis chrubis@suse.cz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef BRKM_REDIRECT_H__
+#define BRKM_REDIRECT_H__
+
+#include "ltp_priv.h"
+
+#ifdef tst_brkm
+# undef tst_brkm
+#endif
+
+#define tst_brkm(flags, cleanup, fmt, ...) do { \
+	if (tst_test) \
+		tst_brk_(__FILE__, __LINE__, flags, fmt, ##__VA_ARGS__); \
+	else \
+                tst_brkm_(__FILE__, __LINE__, flags, cleanup, fmt, ##__VA_ARGS__); \
+	} while (0)
+
+#define tst_brkr(rval, flags, cleanup, fmt, ...) do { \
+		tst_brkm(flags, cleanup, fmt, ##__VA_ARGS__); \
+		return rval; \
+	} while (0)
+
+#define tst_brkv(flags, cleanup, fmt, ...) do { \
+		tst_brkm(flags, cleanup, fmt, ##__VA_ARGS__); \
+		return; \
+	} while (0)
+
+#endif /* BRKM_REDIRECT_H__ */
diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
index 01f64ed..51853b4 100644
--- a/lib/safe_file_ops.c
+++ b/lib/safe_file_ops.c
@@ -33,6 +33,7 @@
 
 #include "test.h"
 #include "safe_file_ops_fn.h"
+#include "brkm_redirect.h"
 
 /*
  * Count number of expected assigned conversions. Any conversion starts with '%'.
@@ -139,7 +140,7 @@ void safe_file_scanf(const char *file, const int lineno,
 	f = fopen(path, "r");
 
 	if (f == NULL) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
+		tst_brkv(TBROK | TERRNO, cleanup_fn,
 			 "Failed to open FILE '%s' for reading at %s:%d",
 			 path, file, lineno);
 	}
@@ -151,19 +152,19 @@ void safe_file_scanf(const char *file, const int lineno,
 	va_end(va);
 
 	if (ret == EOF) {
-		tst_brkm(TBROK, cleanup_fn,
+		tst_brkv(TBROK, cleanup_fn,
 			 "The FILE '%s' ended prematurely at %s:%d",
 			 path, file, lineno);
 	}
 
 	if (ret != exp_convs) {
-		tst_brkm(TBROK, cleanup_fn,
+		tst_brkv(TBROK, cleanup_fn,
 			 "Expected %i conversions got %i FILE '%s' at %s:%d",
 			 exp_convs, ret, path, file, lineno);
 	}
 
 	if (fclose(f)) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
+		tst_brkv(TBROK | TERRNO, cleanup_fn,
 			 "Failed to close FILE '%s' at %s:%d",
 			 path, file, lineno);
 	}
@@ -186,13 +187,13 @@ int file_lines_scanf(const char *file, const int lineno,
 	va_list ap;
 
 	if (!fmt) {
-		tst_brkm(TBROK, cleanup_fn, "pattern is NULL, %s:%d",
+		tst_brkr(-1, TBROK, cleanup_fn, "pattern is NULL, %s:%d",
 			file, lineno);
 	}
 
 	fp = fopen(path, "r");
 	if (fp == NULL) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
+		tst_brkr(-1, TBROK | TERRNO, cleanup_fn,
 			"Failed to open FILE '%s' for reading at %s:%d",
 			path, file, lineno);
 	}
@@ -210,7 +211,7 @@ int file_lines_scanf(const char *file, const int lineno,
 	fclose(fp);
 
 	if (strict && ret != arg_count)
-		tst_brkm(TBROK, cleanup_fn, "Expected %i conversions got %i"
+		tst_brkr(-1, TBROK, cleanup_fn, "Expected %i conversions got %i"
 			" at %s:%d", arg_count, ret, file, lineno);
 
 	return !(ret == arg_count);
@@ -270,7 +271,7 @@ void safe_file_printf(const char *file, const int lineno,
 	f = fopen(path, "w");
 
 	if (f == NULL) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
+		tst_brkv(TBROK | TERRNO, cleanup_fn,
 			 "Failed to open FILE '%s' for writing at %s:%d",
 			 path, file, lineno);
 	}
@@ -278,7 +279,7 @@ void safe_file_printf(const char *file, const int lineno,
 	va_start(va, fmt);
 
 	if (vfprintf(f, fmt, va) < 0) {
-		tst_brkm(TBROK, cleanup_fn,
+		tst_brkv(TBROK, cleanup_fn,
 			 "Failed to print to FILE '%s' at %s:%d",
 			 path, file, lineno);
 	}
@@ -286,7 +287,7 @@ void safe_file_printf(const char *file, const int lineno,
 	va_end(va);
 
 	if (fclose(f)) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
+		tst_brkv(TBROK | TERRNO, cleanup_fn,
 			 "Failed to close FILE '%s' at %s:%d",
 			 path, file, lineno);
 	}
@@ -305,7 +306,7 @@ void safe_cp(const char *file, const int lineno,
 	ret = system(buf);
 
 	if (ret) {
-		tst_brkm(TBROK, cleanup_fn,
+		tst_brkv(TBROK, cleanup_fn,
 			 "Failed to copy '%s' to '%s' at %s:%d",
 			 src, dst, file, lineno);
 	}
@@ -343,20 +344,20 @@ void safe_touch(const char *file, const int lineno,
 
 	ret = open(pathname, O_CREAT | O_WRONLY, defmode);
 	if (ret == -1)
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
+		tst_brkv(TBROK | TERRNO, cleanup_fn,
 			"Failed to open file '%s' at %s:%d",
 			pathname, file, lineno);
 
 	ret = close(ret);
 	if (ret == -1)
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
+		tst_brkv(TBROK | TERRNO, cleanup_fn,
 			"Failed to close file '%s' at %s:%d",
 			pathname, file, lineno);
 
 	if (mode != 0) {
 		ret = chmod(pathname, mode);
 		if (ret == -1)
-			tst_brkm(TBROK | TERRNO, cleanup_fn,
+			tst_brkv(TBROK | TERRNO, cleanup_fn,
 				"Failed to chmod file '%s' at %s:%d",
 				pathname, file, lineno);
 	}
@@ -373,13 +374,13 @@ void safe_touch(const char *file, const int lineno,
 
 		ret = stat(pathname, &sb);
 		if (ret == -1)
-			tst_brkm(TBROK | TERRNO, cleanup_fn,
+			tst_brkv(TBROK | TERRNO, cleanup_fn,
 				"Failed to stat file '%s' at %s:%d",
 				pathname, file, lineno);
 
 		ret = gettimeofday(cotimes, NULL);
 		if (ret == -1)
-			tst_brkm(TBROK | TERRNO, cleanup_fn,
+			tst_brkv(TBROK | TERRNO, cleanup_fn,
 				"Failed to gettimeofday() at %s:%d",
 				file, lineno);
 		cotimes[1] = cotimes[0];
@@ -393,7 +394,7 @@ void safe_touch(const char *file, const int lineno,
 	}
 #endif
 	if (ret == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
+		tst_brkv(TBROK | TERRNO, cleanup_fn,
 			"Failed to update the access/modification time on file"
 			" '%s'@%s:%d", pathname, file, lineno);
 	}
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index d696a0b..efa1897 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -17,6 +17,7 @@
 #include <malloc.h>
 #include "test.h"
 #include "safe_macros.h"
+#include "brkm_redirect.h"
 
 char *safe_basename(const char *file, const int lineno,
 		    void (*cleanup_fn) (void), char *path)
diff --git a/lib/safe_net.c b/lib/safe_net.c
index cae77b5..5ba6b85 100644
--- a/lib/safe_net.c
+++ b/lib/safe_net.c
@@ -19,6 +19,7 @@
 #include <errno.h>
 #include "test.h"
 #include "safe_net_fn.h"
+#include "brkm_redirect.h"
 
 char *tst_sock_addr(const struct sockaddr *sa, socklen_t salen, char *res,
 		    size_t len)
@@ -109,7 +110,7 @@ int safe_bind(const char *file, const int lineno, void (cleanup_fn)(void),
 			return 0;
 
 		if (errno != EADDRINUSE) {
-			tst_brkm(TBROK | TERRNO, cleanup_fn,
+			tst_brkr(-1, TBROK | TERRNO, cleanup_fn,
 				 "%s:%d: bind(%d, %s, %d) failed", file, lineno,
 				 socket, tst_sock_addr(address, address_len,
 						       buf, sizeof(buf)),
@@ -124,7 +125,7 @@ int safe_bind(const char *file, const int lineno, void (cleanup_fn)(void),
 		sleep(1);
 	}
 
-	tst_brkm(TBROK | TERRNO, cleanup_fn,
+	tst_brkr(-1, TBROK | TERRNO, cleanup_fn,
 		 "%s:%d: Failed to bind(%d, %s, %d) after 120 retries", file,
 		 lineno, socket,
 		 tst_sock_addr(address, address_len, buf, sizeof(buf)),
diff --git a/lib/safe_stdio.c b/lib/safe_stdio.c
index 966a039..ef78114 100644
--- a/lib/safe_stdio.c
+++ b/lib/safe_stdio.c
@@ -22,6 +22,7 @@
 #include <errno.h>
 #include "test.h"
 #include "safe_stdio_fn.h"
+#include "brkm_redirect.h"
 
 FILE *safe_fopen(const char *file, const int lineno, void (cleanup_fn)(void),
                  const char *path, const char *mode)
-- 
2.10.2

