From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Oct 2018 13:24:29 +0200
Subject: [LTP] [PATCH 2/6] realtime: Fix pthread_mutexattr_{g,
	s}etrobust_np detection
In-Reply-To: <20181018112433.9554-1-pvorel@suse.cz>
References: <20181018112433.9554-1-pvorel@suse.cz>
Message-ID: <20181018112433.9554-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

This fixes build failure on libc which does not have it (e.g. musl),
see bellow.

Also remove _GNU_SOURCE from PTHREAD_PRIO_INHERIT check as is not needed
(it requires _XOPEN_SOURCE=500 definition => POSIX 1995).

sbrk_mutex.c:112:6: warning: implicit declaration of function ‘pthread_mutexattr_setrobust_np’; did you mean ‘pthread_mutexattr_setrobust’? [-Wimplicit-function-declaration]
  if (pthread_mutexattr_setrobust_np(&mutexattr, PTHREAD_MUTEX_ROBUST_NP)
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      pthread_mutexattr_setrobust
sbrk_mutex.c:112:49: error: ‘PTHREAD_MUTEX_ROBUST_NP’ undeclared (first use in this function); did you mean ‘PTHREAD_MUTEX_ROBUST’?
  if (pthread_mutexattr_setrobust_np(&mutexattr, PTHREAD_MUTEX_ROBUST_NP)
                                                 ^~~~~~~~~~~~~~~~~~~~~~~
                                                 PTHREAD_MUTEX_ROBUST
sbrk_mutex.c:112:49: note: each undeclared identifier is reported only once for each function it appears in
sbrk_mutex.c:116:6: warning: implicit declaration of function ‘pthread_mutexattr_getrobust_np’; did you mean ‘pthread_mutexattr_getrobust’? [-Wimplicit-function-declaration]
  if (pthread_mutexattr_getrobust_np(&mutexattr, &robust) != 0) {
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      pthread_mutexattr_getrobust

testpi-6.c:78:9: error: ‘PTHREAD_MUTEX_ROBUST_NP’ undeclared (first use in this function); did you mean ‘PTHREAD_MUTEX_ROBUST’?
         PTHREAD_MUTEX_ROBUST_NP) != 0)
         ^~~~~~~~~~~~~~~~~~~~~~~
         PTHREAD_MUTEX_ROBUST
testpi-6.c:78:9: note: each undeclared identifier is reported only once for each function it appears in
testpi-6.c:81:6: warning: implicit declaration of function ‘pthread_mutexattr_getrobust_np’; did you mean ‘pthread_mutexattr_getrobust’? [-Wimplicit-function-declaration]
  if (pthread_mutexattr_getrobust_np(&mutexattr, &robust) != 0)
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      pthread_mutexattr_getrobust

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/realtime/m4/check.m4 | 36 ++++------------------------------
 1 file changed, 4 insertions(+), 32 deletions(-)

diff --git a/testcases/realtime/m4/check.m4 b/testcases/realtime/m4/check.m4
index 2517e3960..957f452c3 100644
--- a/testcases/realtime/m4/check.m4
+++ b/testcases/realtime/m4/check.m4
@@ -1,9 +1,6 @@
 AC_DEFUN([REALTIME_CHECK_PRIO_INHERIT],[
 AC_MSG_CHECKING([for PTHREAD_PRIO_INHERIT])
 AC_TRY_COMPILE([
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE
-#endif
 #include <pthread.h>],[int main(void) {
 	pthread_mutexattr_t attr;
 	return pthread_mutexattr_setprotocol(&attr, PTHREAD_PRIO_INHERIT);
@@ -17,35 +14,10 @@ fi
 ])
 
 AC_DEFUN([REALTIME_CHECK_ROBUST_APIS],[
-AC_MSG_CHECKING([for pthread_mutexattr_*robust* APIs])
-AC_TRY_COMPILE([
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE
-#endif
-#include <pthread.h>],[int main(void) {
-	pthread_mutexattr_t attr;
-	return pthread_mutexattr_setrobust_np(&attr, 0);
-}],[has_robust="yes"])
-if test "x$has_robust" = "xyes" ; then
-	AC_DEFINE(HAS_PTHREAD_MUTEXTATTR_ROBUST_APIS,1,[Define to 1 if you have pthread_mutexattr_*robust* APIs])
-	AC_MSG_RESULT(yes)
-else
-	AC_MSG_RESULT(no)
-fi
-])
-
-AC_DEFUN([REALTIME_CHECK_ROBUST_APIS],[
-AC_MSG_CHECKING([for pthread_mutexattr_*robust* APIs])
-AC_TRY_COMPILE([
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE
-#endif
-#include <pthread.h>],[int main(void) {
-	pthread_mutexattr_t attr;
-	return pthread_mutexattr_setrobust_np(&attr, 0);
-}],[has_robust="yes"])
-if test "x$has_robust" = "xyes" ; then
-	AC_DEFINE(HAS_PTHREAD_MUTEXTATTR_ROBUST_APIS,1,[Define to 1 if you have pthread_mutexattr_*robust* APIs])
+	AC_CHECK_DECLS([pthread_mutexattr_getrobust_np, pthread_mutexattr_setrobust_np],[],[has_robust="no"],[[#define _GNU_SOURCE
+#include <pthread.h>]])
+	AC_MSG_CHECKING([for pthread_mutexattr_*robust* APIs])
+if test "x$has_robust" != "xno"; then
 	AC_MSG_RESULT(yes)
 else
 	AC_MSG_RESULT(no)
-- 
2.19.1

