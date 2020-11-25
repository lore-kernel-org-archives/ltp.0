From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Nov 2020 15:48:18 +0100
Subject: [LTP] [PATCH] [COMMITTED] lib: Fix SAFE_MACROS() redirection to new
 library
Message-ID: <20201125144818.24542-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Previously the redirection into the newlib tst_brk_() in the test
library was defined only for tst_brkm() so after the changes to call
tst_brkm_() in the test library we ended up hitting abort() in the
tst_brkm_() in tst_res.c when SAFE_MACRO() has failed.

This commit adds redirection for tst_brkm_() as well so that the
messages are properly routed to the new library as well.

Fixes: f63b8afc24b8 (Unify error handling in lib/safe_macros.c)
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/old/test.h        | 13 ++++++++++---
 lib/newlib_tests/test02.c |  4 ++--
 lib/tst_res.c             |  8 +++-----
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/old/test.h b/include/old/test.h
index 604254eea..2ae7dba71 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -129,7 +129,7 @@ void tst_resm_hexd_(const char *file, const int lineno, int ttype,
 	tst_resm_hexd_(__FILE__, __LINE__, (ttype), (buf), (size), \
 		       (arg_fmt), ##__VA_ARGS__)
 
-void tst_brkm_(const char *file, const int lineno, int ttype,
+void tst_brkm__(const char *file, const int lineno, int ttype,
 	void (*func)(void), const char *arg_fmt, ...)
 	__attribute__ ((format (printf, 5, 6))) LTP_ATTRIBUTE_NORETURN;
 
@@ -139,11 +139,18 @@ void tst_brkm_(const char *file, const int lineno, int ttype,
 	if (tst_test) \
 		tst_brk_(__FILE__, __LINE__, flags, fmt, ##__VA_ARGS__); \
 	else \
-		tst_brkm_(__FILE__, __LINE__, flags, cleanup, fmt, ##__VA_ARGS__); \
+		tst_brkm__(__FILE__, __LINE__, flags, cleanup, fmt, ##__VA_ARGS__); \
+	} while (0)
+
+#define tst_brkm_(file, lineno, flags, cleanup, fmt, ...) do { \
+	if (tst_test) \
+		tst_brk_(file, lineno, flags, fmt, ##__VA_ARGS__); \
+	else \
+		tst_brkm__(file, lineno, flags, cleanup, fmt, ##__VA_ARGS__); \
 	} while (0)
 #else
 # define tst_brkm(flags, cleanup, fmt, ...) do { \
-		tst_brkm_(__FILE__, __LINE__, flags, cleanup, fmt, ##__VA_ARGS__); \
+		tst_brkm__(__FILE__, __LINE__, flags, cleanup, fmt, ##__VA_ARGS__); \
 	} while (0)
 #endif
 
diff --git a/lib/newlib_tests/test02.c b/lib/newlib_tests/test02.c
index f1b6a7ca4..ec2a1d13d 100644
--- a/lib/newlib_tests/test02.c
+++ b/lib/newlib_tests/test02.c
@@ -10,7 +10,7 @@
 #include "tst_test.h"
 
 void tst_resm_(char *, int, int, char *);
-void tst_brkm_(char *, int, int, void (*)(void), char *);
+void tst_brkm__(char *, int, int, void (*)(void), char *);
 
 static void cleanup(void)
 {
@@ -24,7 +24,7 @@ static void do_test(unsigned int i)
 		tst_resm_(__FILE__, __LINE__, TPASS, "passed message");
 	break;
 	case 1:
-		tst_brkm_(__FILE__, __LINE__, TCONF, cleanup, "Non-NULL cleanup");
+		tst_brkm__(__FILE__, __LINE__, TCONF, cleanup, "Non-NULL cleanup");
 	break;
 	}
 }
diff --git a/lib/tst_res.c b/lib/tst_res.c
index c35f41b74..c9ba0fa66 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -575,7 +575,7 @@ void tst_resm_hexd_(const char *file, const int lineno, int ttype,
 	}
 }
 
-void tst_brkm_(const char *file, const int lineno, int ttype,
+void tst_brkm__(const char *file, const int lineno, int ttype,
 	void (*func)(void), const char *arg_fmt, ...)
 {
 	char tmesg[USERMESG];
@@ -587,12 +587,10 @@ void tst_brkm_(const char *file, const int lineno, int ttype,
 			tst_brk_(file, lineno, TBROK,
 			         "Non-NULL cleanup in newlib!");
 		}
-
-		tst_brk_(file, lineno, ttype, "%s", tmesg);
-	} else {
-		tst_brk__(file, lineno, ttype, func, "%s", tmesg);
 	}
 
+	tst_brk__(file, lineno, ttype, func, "%s", tmesg);
+
 	/* Shouldn't be reached, but fixes build time warnings about noreturn. */
 	abort();
 }
-- 
2.26.2

