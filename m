From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 21 Jul 2016 21:26:50 -0700
Subject: [LTP] [PATCH V3 17/23] initialize recursive mutex in a portable way
In-Reply-To: <20160722042656.22346-1-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
Message-ID: <20160722042656.22346-17-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP is not in POSIX

use the portable way instead: pthread_once was designed for such
cases.

Link with libpthread wherever libltp is asked for

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 include/mk/testcases.mk                    |  2 +-
 lib/ltp.pc.in                              |  2 +-
 lib/newlib_tests/Makefile                  |  2 +-
 lib/tests/Makefile                         |  2 +-
 lib/tst_res.c                              | 18 +++++++++++++++++-
 testcases/kernel/containers/netns/Makefile |  2 +-
 testcases/kernel/containers/share/Makefile |  2 +-
 7 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
index ea26d4f..eff0eee 100644
--- a/include/mk/testcases.mk
+++ b/include/mk/testcases.mk
@@ -49,7 +49,7 @@ CPPFLAGS	+= -I$(abs_top_builddir)/$(TKI_DIR)
 
 INSTALL_DIR	:= testcases/bin
 
-LDLIBS		+= -lltp
+LDLIBS		+= -lltp -lpthread
 
 $(APICMDS_DIR) $(LIBLTP_DIR) $(abs_top_builddir)/$(TKI_DIR): %:
 	mkdir -p "$@"
diff --git a/lib/ltp.pc.in b/lib/ltp.pc.in
index 9620129..63cd5f4 100644
--- a/lib/ltp.pc.in
+++ b/lib/ltp.pc.in
@@ -6,5 +6,5 @@ libdir=@libdir@
 Name: LTP
 Description: Linux Test Project
 Version: @VERSION@
-Libs: -L${libdir} -lltp
+Libs: -L${libdir} -lltp -lpthread
 Cflags: -I${includedir}
diff --git a/lib/newlib_tests/Makefile b/lib/newlib_tests/Makefile
index 0e4eeb8..9dd69fd 100644
--- a/lib/newlib_tests/Makefile
+++ b/lib/newlib_tests/Makefile
@@ -3,7 +3,7 @@ top_srcdir		?= ../..
 include $(top_srcdir)/include/mk/env_pre.mk
 
 CFLAGS			+= -W -Wall
-LDLIBS			+= -lltp
+LDLIBS			+= -lltp -lpthread
 
 test08: CFLAGS+=-pthread
 test09: CFLAGS+=-pthread
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 73a0f16..bc4476d 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -3,7 +3,7 @@ top_srcdir		?= ../..
 include $(top_srcdir)/include/mk/env_pre.mk
 
 CFLAGS			+= -W
-LDLIBS			+= -lltp
+LDLIBS			+= -lltp -lpthread
 
 tst_cleanup_once: CFLAGS += -pthread
 
diff --git a/lib/tst_res.c b/lib/tst_res.c
index b388d0d..ab995f8 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -79,7 +79,8 @@ int TEST_ERRNO;
 	assert(strlen(buf) > 0);		\
 } while (0)
 
-static pthread_mutex_t tmutex = PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP;
+static pthread_once_t tmutex_once = PTHREAD_ONCE_INIT;
+static pthread_mutex_t tmutex;
 
 static void check_env(void);
 static void tst_condense(int tnum, int ttype, const char *tmesg);
@@ -142,9 +143,20 @@ const char *strttype(int ttype)
 #include "errnos.h"
 #include "signame.h"
 
+static void init_tmutex(void)
+{
+	pthread_mutexattr_t attr;
+
+	pthread_mutexattr_init(&attr);
+	pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
+	pthread_mutex_init(&tmutex, &attr);
+	pthread_mutexattr_destroy(&attr);
+}
+
 static void tst_res__(const char *file, const int lineno, int ttype,
                       const char *arg_fmt, ...)
 {
+	pthread_once(&tmutex_once, init_tmutex);
 	pthread_mutex_lock(&tmutex);
 
 	char tmesg[USERMESG];
@@ -233,6 +245,7 @@ void tst_flush(void)
 {
 	NO_NEWLIB_ASSERT("Unknown", 0);
 
+	pthread_once(&tmutex_once, init_tmutex);
 	pthread_mutex_lock(&tmutex);
 
 	/*
@@ -369,6 +382,7 @@ void tst_exit(void)
 {
 	NO_NEWLIB_ASSERT("Unknown", 0);
 
+	pthread_once(&tmutex_once, init_tmutex);
 	pthread_mutex_lock(&tmutex);
 
 	tst_flush();
@@ -441,6 +455,7 @@ static int tst_brk_entered = 0;
 static void tst_brk__(const char *file, const int lineno, int ttype,
                       void (*func)(void), const char *arg_fmt, ...)
 {
+	pthread_once(&tmutex_once, init_tmutex);
 	pthread_mutex_lock(&tmutex);
 
 	char tmesg[USERMESG];
@@ -505,6 +520,7 @@ void tst_resm_hexd_(const char *file, const int lineno, int ttype,
 {
 	NO_NEWLIB_ASSERT(file, lineno);
 
+	pthread_once(&tmutex_once, init_tmutex);
 	pthread_mutex_lock(&tmutex);
 
 	char tmesg[USERMESG];
diff --git a/testcases/kernel/containers/netns/Makefile b/testcases/kernel/containers/netns/Makefile
index 3756a55..b2411cd 100644
--- a/testcases/kernel/containers/netns/Makefile
+++ b/testcases/kernel/containers/netns/Makefile
@@ -22,6 +22,6 @@ top_srcdir              ?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
-LDLIBS                  := -lclone -lltp
+LDLIBS                  := -lclone -lltp -lpthread
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/containers/share/Makefile b/testcases/kernel/containers/share/Makefile
index 962d688..cd79f99 100644
--- a/testcases/kernel/containers/share/Makefile
+++ b/testcases/kernel/containers/share/Makefile
@@ -17,6 +17,6 @@ top_srcdir              ?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
-LDLIBS                  := -lltp
+LDLIBS                  := -lltp -lpthread
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.9.0

