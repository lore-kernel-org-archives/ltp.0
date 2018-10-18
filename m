From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Oct 2018 13:24:30 +0200
Subject: [LTP] [PATCH 3/6] realtime/configure.ac: Remove unused check
In-Reply-To: <20181018112433.9554-1-pvorel@suse.cz>
References: <20181018112433.9554-1-pvorel@suse.cz>
Message-ID: <20181018112433.9554-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

HAS_PTHREAD_MUTEXATTR_PROTOCOL_FUNCTIONS is not used anywhere.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/realtime/configure.ac | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/testcases/realtime/configure.ac b/testcases/realtime/configure.ac
index af2cbe4c0..3956773d3 100644
--- a/testcases/realtime/configure.ac
+++ b/testcases/realtime/configure.ac
@@ -38,27 +38,6 @@ else
 fi
 
 REALTIME_CHECK_PRIO_INHERIT
-
-if test "x$has_priority_inherit" = xyes; then
-
-	AC_MSG_CHECKING([for pthread mutex attr protocol functions])
-	AC_TRY_COMPILE([
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE
-#endif
-#include <pthread.h>],[int main(void) {
-	pthread_mutexattr_t attr;
-	(void) pthread_mutexattr_getprotocol(&attr, (void*) NULL);
-	(void) pthread_mutexattr_setprotocol(&attr, 0);
-	return 0;
-}],[has_pthread_mutexattr_protocol_functions="yes"])
-fi
-if test "x$has_pthread_mutexattr_protocol_functions" = "xyes" ; then
-	AC_DEFINE(HAS_PTHREAD_MUTEXATTR_PROTOCOL_FUNCTIONS,1,[Define to 1 if you have the pthread_mutexattr protocol APIs])
-	AC_MSG_RESULT(yes)
-else
-	AC_MSG_RESULT(no)
-fi
 REALTIME_CHECK_ROBUST_APIS
 
 LTP_CHECK_EXP10
-- 
2.19.1

