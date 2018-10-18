From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Oct 2018 13:24:31 +0200
Subject: [LTP] [PATCH 4/6] Use POSIX variants of pthread robust mutex
	functions
In-Reply-To: <20181018112433.9554-1-pvorel@suse.cz>
References: <20181018112433.9554-1-pvorel@suse.cz>
Message-ID: <20181018112433.9554-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

POSIX added pthread_mutexattr_setrobust, pthread_mutexattr_getrobust,
PTHREAD_MUTEX_ROBUST in POSIX.1-2008. There is no need to use their
glibc specific (now deprecated) variants. While they're on some other
libc (including uclibc-ng), they're not (at least) in musl and bionic.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../open_posix_testsuite/functional/threads/pi_test/README  | 4 ++--
 testcases/realtime/00_Descriptions.txt                      | 2 +-
 testcases/realtime/func/pi-tests/sbrk_mutex.c               | 4 ++--
 testcases/realtime/func/pi-tests/testpi-6.c                 | 6 +++---
 testcases/realtime/m4/check.m4                              | 3 +--
 5 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/README b/testcases/open_posix_testsuite/functional/threads/pi_test/README
index 7dfec9d87..dca5b5f2f 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/README
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/README
@@ -33,14 +33,14 @@ Robust Mutex Tests
 The tests are under <rtnptl-tests>/robust_test directory.
 
 rt-nptl supports 'robust' behavior, there will be two robust modes,
-one is PTHREAD_MUTEX_ROBUST_NP mode, the other is
+one is PTHREAD_MUTEX_ROBUST mode, the other is
 PTHREAD_MUTEX_ROBUST_SUN_NP mode. When the owner of a mutex dies in
 the first mode, the waiter will set the mutex to ENOTRECOVERABLE
 state, while in the second mode, the waiter needs to call
 pthread_mutex_setconsistency_np to change the state manually.
 
 The tests with name robust*-sun are used to test the
-PTHREAD_MUTEX_ROBUST_NP mode, other tests with name robust*-mode2 are
+PTHREAD_MUTEX_ROBUST mode, other tests with name robust*-mode2 are
 used to test the PTHREAD_MUTEX_ROBUST_SUN_NP mode. Please refer to the
 description in the tests for the detailed information.
 
diff --git a/testcases/realtime/00_Descriptions.txt b/testcases/realtime/00_Descriptions.txt
index 61aa88fee..829496824 100644
--- a/testcases/realtime/00_Descriptions.txt
+++ b/testcases/realtime/00_Descriptions.txt
@@ -127,7 +127,7 @@ testpi-5.c:
    twice.
 
 testpi-6.c:
-- Uses robust mutex lock (PTHREAD_MUTEX_ROBUST_NP) and uses test-skeleton for
+- Uses robust mutex lock (PTHREAD_MUTEX_ROBUST) and uses test-skeleton for
   other things.
 
 testpi-7.c:
diff --git a/testcases/realtime/func/pi-tests/sbrk_mutex.c b/testcases/realtime/func/pi-tests/sbrk_mutex.c
index 5c325b4dc..c0431d7da 100644
--- a/testcases/realtime/func/pi-tests/sbrk_mutex.c
+++ b/testcases/realtime/func/pi-tests/sbrk_mutex.c
@@ -109,11 +109,11 @@ int main(int argc, char *argv[])
 	if (pthread_mutexattr_init(&mutexattr) != 0) {
 		printf("Failed to init mutexattr\n");
 	}
-	if (pthread_mutexattr_setrobust_np(&mutexattr, PTHREAD_MUTEX_ROBUST_NP)
+	if (pthread_mutexattr_setrobust(&mutexattr, PTHREAD_MUTEX_ROBUST)
 	    != 0) {
 		printf("Can't set mutexattr robust\n");
 	}
-	if (pthread_mutexattr_getrobust_np(&mutexattr, &robust) != 0) {
+	if (pthread_mutexattr_getrobust(&mutexattr, &robust) != 0) {
 		printf("Can't get mutexattr robust\n");
 	} else {
 		printf("robust in mutexattr is %d\n", robust);
diff --git a/testcases/realtime/func/pi-tests/testpi-6.c b/testcases/realtime/func/pi-tests/testpi-6.c
index f715eeeed..96321f622 100644
--- a/testcases/realtime/func/pi-tests/testpi-6.c
+++ b/testcases/realtime/func/pi-tests/testpi-6.c
@@ -74,11 +74,11 @@ int do_test(int argc, char **argv)
 	if (pthread_mutexattr_init(&mutexattr) != 0)
 		printf("Failed to init mutexattr\n");
 
-	if (pthread_mutexattr_setrobust_np(&mutexattr,
-					   PTHREAD_MUTEX_ROBUST_NP) != 0)
+	if (pthread_mutexattr_setrobust(&mutexattr,
+					   PTHREAD_MUTEX_ROBUST) != 0)
 		printf("Can't set robust mutex\n");
 
-	if (pthread_mutexattr_getrobust_np(&mutexattr, &robust) != 0)
+	if (pthread_mutexattr_getrobust(&mutexattr, &robust) != 0)
 		printf("Can't get mutexattr protocol\n");
 	else
 		printf("robust in mutexattr is %d\n", robust);
diff --git a/testcases/realtime/m4/check.m4 b/testcases/realtime/m4/check.m4
index 957f452c3..5aa53bd42 100644
--- a/testcases/realtime/m4/check.m4
+++ b/testcases/realtime/m4/check.m4
@@ -14,8 +14,7 @@ fi
 ])
 
 AC_DEFUN([REALTIME_CHECK_ROBUST_APIS],[
-	AC_CHECK_DECLS([pthread_mutexattr_getrobust_np, pthread_mutexattr_setrobust_np],[],[has_robust="no"],[[#define _GNU_SOURCE
-#include <pthread.h>]])
+	AC_CHECK_DECLS([pthread_mutexattr_getrobust, pthread_mutexattr_setrobust],[],[has_robust="no"],[[#include <pthread.h>]])
 	AC_MSG_CHECKING([for pthread_mutexattr_*robust* APIs])
 if test "x$has_robust" != "xno"; then
 	AC_MSG_RESULT(yes)
-- 
2.19.1

