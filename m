From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Sun, 13 Jun 2021 23:05:27 +0530
Subject: [LTP] [PATCH v3] setitimer02: Skipped EFAULT tests for libc variant.
In-Reply-To: <YMNsdfm7VW2dW9Hw@yuki>
References: <YMNsdfm7VW2dW9Hw@yuki>
Message-ID: <20210613173527.9037-1-vinay.m.engg@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Tested EFAULT cases only for "__NR_setitimer" syscall.

Tests for bad addresses in LTP cases trigger segment
fault in libc on a 32bit system.

Signed-off-by: Vinay Kumar <vinay.m.engg@gmail.com>
---
 testcases/kernel/syscalls/setitimer/setitimer02.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/setitimer/setitimer02.c b/testcases/kernel/syscalls/setitimer/setitimer02.c
index 59da87e8d..2ff051e41 100644
--- a/testcases/kernel/syscalls/setitimer/setitimer02.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer02.c
@@ -16,14 +16,22 @@
 #include <sys/time.h>
 #include <stdlib.h>
 #include "tst_test.h"
+#include "lapi/syscalls.h"
 
 struct itimerval *value;
 
+static int sys_setitimer(int which, void *new_value, void *old_value)
+{
+	return tst_syscall(__NR_setitimer, which, new_value, old_value);
+}
+
 static void verify_setitimer(void)
 {
   /* call with a bad address */
-	TST_EXP_FAIL(setitimer(ITIMER_REAL, value, (struct itimerval *)-1),
+	TST_EXP_FAIL(sys_setitimer(ITIMER_REAL, value, (struct itimerval *)-1),
 		EFAULT, "expected failure - errno = %d - %s", TST_ERR, strerror(TST_ERR));
+
+	tst_res(TCONF, "EFAULT is skipped for libc variant");
 }
 
 static void setup(void)
-- 
2.17.1

