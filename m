From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu, 19 Nov 2020 10:52:27 +0100
Subject: [LTP] [PATCH] realtime/m4: Re-add define for robust mutexattr APIs
Message-ID: <20201119095227.921830-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Mathias Fiedler <mathias.fiedler@aox-tech.de>

This define is required by sbrk_mutex.c and testpi-6.c.
This define was dropped in
commit 3f6e7fe1e7d6afffb1db593e0dc14ca88a01cf66:
realtime: Fix pthread_mutexattr_{g,s}etrobust_np detection

Signed-off-by: Mathias Fiedler <mathias.fiedler@aox-tech.de>
Fixes: 3f6e7fe1e
---
 testcases/realtime/m4/check.m4 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/realtime/m4/check.m4 b/testcases/realtime/m4/check.m4
index 5aa53bd42..e4d4fac75 100644
--- a/testcases/realtime/m4/check.m4
+++ b/testcases/realtime/m4/check.m4
@@ -17,6 +17,7 @@ AC_DEFUN([REALTIME_CHECK_ROBUST_APIS],[
 	AC_CHECK_DECLS([pthread_mutexattr_getrobust, pthread_mutexattr_setrobust],[],[has_robust="no"],[[#include <pthread.h>]])
 	AC_MSG_CHECKING([for pthread_mutexattr_*robust* APIs])
 if test "x$has_robust" != "xno"; then
+	AC_DEFINE(HAS_PTHREAD_MUTEXTATTR_ROBUST_APIS,1,[Define to 1 if you have pthread_mutexattr_*robust* APIs])
 	AC_MSG_RESULT(yes)
 else
 	AC_MSG_RESULT(no)
-- 
2.25.1

