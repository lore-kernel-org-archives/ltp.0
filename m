From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 10 Feb 2017 10:38:57 +0100
Subject: [LTP] [PATCH 1/2] SAFE_MACROS: Redirect to tst_brk_() early
In-Reply-To: <151709822.2486191.1486715702857.JavaMail.zimbra@redhat.com>
References: <20170209144445.22737-1-chrubis@suse.cz>
 <1235532957.2260942.1486655806975.JavaMail.zimbra@redhat.com>
 <20170209161120.GA23109@rei>
 <1865245988.2484651.1486715227566.JavaMail.zimbra@redhat.com>
 <151709822.2486191.1486715702857.JavaMail.zimbra@redhat.com>
Message-ID: <3c1b0f37-f237-d26a-0d92-c5b37dd5bbc4@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

SNIP

How about we provide different version of tst_brkm for library and different
for tests? For library we obviously want to allow calls from both oldlib and
newlib code, and redirect as needed. But for tests (users of library) we
would allow only oldlib tests to call tst_brkm.

So for tests tst_brkm_ stays the same - NORETURN, for library code, we
use either tst_brk_ or tst_brkm_, which means we'll need to fix any
potential warnings only in library.

This also forbids usage of tst_brkm from newlib tests, previously
it was OK if you didn't provide cleanup, now it would reject all
calls from newlib tests.

$ grep -l tst_brkm -r include/
include/old/safe_macros.h
include/old/test.h
include/tst_fs.h -> only comments
include/tst_process_state.h -> only comments

(compile-tested only)

diff --git a/include/old/safe_macros.h b/include/old/safe_macros.h
index 25001e806c12..96fb0c21876e 100644
--- a/include/old/safe_macros.h
+++ b/include/old/safe_macros.h
@@ -331,10 +331,10 @@ static inline int safe_setrlimit(const char *file, const int lineno,

 #define SAFE_IOCTL(cleanup_fn, fd, request, ...)             \
        ({int ret = ioctl(fd, request, __VA_ARGS__);         \
-         ret < 0 ?                                          \
-          tst_brkm(TBROK | TERRNO, cleanup_fn,              \
-                   "ioctl(%i,%s,...) failed", fd, #request) \
-        : ret;})
+         if (ret < 0)                                       \
+             tst_brkm(TBROK | TERRNO, cleanup_fn,           \
+                   "ioctl(%i,%s,...) failed", fd, #request); \
+         ret;})

 #endif /* __SAFE_MACROS_H__ */
 #endif /* __TEST_H__ */
diff --git a/include/old/test.h b/include/old/test.h
index d49256073741..768c32d41609 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -153,9 +153,20 @@ void tst_resm_hexd_(const char *file, const int lineno, int ttype,
 void tst_brkm_(const char *file, const int lineno, int ttype,
        void (*func)(void), const char *arg_fmt, ...)
        __attribute__ ((format (printf, 5, 6))) LTP_ATTRIBUTE_NORETURN;
-#define tst_brkm(ttype, func, arg_fmt, ...) \
-       tst_brkm_(__FILE__, __LINE__, (ttype), (func), \
-                 (arg_fmt), ##__VA_ARGS__)
+
+#ifdef LTPLIB
+#include "ltp_priv.h"
+# define tst_brkm(flags, cleanup, fmt, ...) do { \
+               if (tst_test) \
+                       tst_brk_(__FILE__, __LINE__, flags, fmt, ##__VA_ARGS__); \
+               else \
+                       tst_brkm_(__FILE__, __LINE__, flags, cleanup, fmt, ##__VA_ARGS__); \
+               } while (0)
+#else
+# define tst_brkm(flags, cleanup, fmt, ...) do { \
+                       tst_brkm_(__FILE__, __LINE__, flags, cleanup, fmt, ##__VA_ARGS__); \
+               } while (0)
+#endif

 void tst_require_root(void);
 void tst_exit(void) LTP_ATTRIBUTE_NORETURN;
diff --git a/lib/Makefile b/lib/Makefile
index 663455ee31ad..6b3f6e1917fb 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -24,7 +24,7 @@ top_srcdir            ?= ..

 include $(top_srcdir)/include/mk/env_pre.mk

-CFLAGS                 += -I.
+CFLAGS                 += -I. -DLTPLIB

 ifneq ($(ANDROID),1)
 FILTER_OUT_DIRS                += android_libpthread android_librt
diff --git a/lib/tst_res.c b/lib/tst_res.c
index 96f0c1f1dc07..2b0ffa706cb2 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -566,16 +566,10 @@ void tst_brkm_(const char *file, const int lineno, int ttype,

        EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);

-       if (tst_test) {
-               if (func) {
-                       tst_brk_(file, lineno, TBROK,
-                                "Non-NULL cleanup in newlib!");
-               }
-
-               tst_brk_(file, lineno, ttype, "%s", tmesg);
-       } else {
+       if (tst_test)
+               tst_brk__(file, lineno, TBROK, NULL, "newlib test calls tst_brkm()");
+       else
                tst_brk__(file, lineno, ttype, func, "%s", tmesg);
-       }

        /* Shouldn't be reached, but fixes build time warnings about noreturn. */
        abort();
