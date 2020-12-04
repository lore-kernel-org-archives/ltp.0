From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri,  4 Dec 2020 06:25:32 +0100
Subject: [LTP] [PATCH] realtime: Remove robust_api check
Message-ID: <20201204052532.409635-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

pthread_mutexattr_*robust is implemented in glibc for the last 10 years.
It is not required anymore to check if it is available.
Additonally the implementation is broken, because the macro
HAS_PTHREAD_MUTEXTATTR_ROBUST_APIS was not set.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 testcases/realtime/configure.ac               |  1 -
 testcases/realtime/func/pi-tests/sbrk_mutex.c | 11 -----------
 testcases/realtime/func/pi-tests/testpi-6.c   |  8 --------
 testcases/realtime/m4/check.m4                | 10 ----------
 4 files changed, 30 deletions(-)

diff --git a/testcases/realtime/configure.ac b/testcases/realtime/configure.ac
index 46a616bfc..e483caf0d 100644
--- a/testcases/realtime/configure.ac
+++ b/testcases/realtime/configure.ac
@@ -36,7 +36,6 @@ else
 fi
 
 REALTIME_CHECK_PRIO_INHERIT
-REALTIME_CHECK_ROBUST_APIS
 
 LTP_CHECK_EXP10
 
diff --git a/testcases/realtime/func/pi-tests/sbrk_mutex.c b/testcases/realtime/func/pi-tests/sbrk_mutex.c
index c0431d7da..7ed7969d9 100644
--- a/testcases/realtime/func/pi-tests/sbrk_mutex.c
+++ b/testcases/realtime/func/pi-tests/sbrk_mutex.c
@@ -45,8 +45,6 @@
 #include <unistd.h>
 #include "librttest.h"
 
-#if HAS_PTHREAD_MUTEXTATTR_ROBUST_APIS
-
 #define NUM_MUTEXES 5000
 #define NUM_THREADS 50
 #define NUM_CONCURRENT_LOCKS 50
@@ -150,12 +148,3 @@ int main(int argc, char *argv[])
 
 	return 0;
 }
-
-#else
-int main(void)
-{
-	printf
-	    ("Your system doesn't support the pthread robust mutexattr APIs\n");
-	return 1;
-}
-#endif
diff --git a/testcases/realtime/func/pi-tests/testpi-6.c b/testcases/realtime/func/pi-tests/testpi-6.c
index 96321f622..637d38355 100644
--- a/testcases/realtime/func/pi-tests/testpi-6.c
+++ b/testcases/realtime/func/pi-tests/testpi-6.c
@@ -41,7 +41,6 @@
 #include <unistd.h>
 #include <librttest.h>
 
-#if HAS_PTHREAD_MUTEXTATTR_ROBUST_APIS
 pthread_mutex_t child_mutex;
 
 void *child_thread(void *arg)
@@ -92,12 +91,5 @@ int do_test(int argc, char **argv)
 
 	return 0;
 }
-#else
-int do_test(int argc, char **argv)
-{
-	printf("Your system doesn't have robust pthread mutex support\n");
-	return 1;
-}
-#endif
 
 #include "test-skeleton.c"
diff --git a/testcases/realtime/m4/check.m4 b/testcases/realtime/m4/check.m4
index 5aa53bd42..e60ae1928 100644
--- a/testcases/realtime/m4/check.m4
+++ b/testcases/realtime/m4/check.m4
@@ -12,13 +12,3 @@ else
 	AC_MSG_RESULT(no)
 fi
 ])
-
-AC_DEFUN([REALTIME_CHECK_ROBUST_APIS],[
-	AC_CHECK_DECLS([pthread_mutexattr_getrobust, pthread_mutexattr_setrobust],[],[has_robust="no"],[[#include <pthread.h>]])
-	AC_MSG_CHECKING([for pthread_mutexattr_*robust* APIs])
-if test "x$has_robust" != "xno"; then
-	AC_MSG_RESULT(yes)
-else
-	AC_MSG_RESULT(no)
-fi
-])
-- 
2.25.1

