From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Sun, 13 Jun 2021 22:24:15 +0530
Subject: [LTP] [PATCH v3] getitimer02: Skipped EFAULT tests for libc variant.
In-Reply-To: <YMNoeLR3J9Ah1eAZ@yuki>
References: <YMNoeLR3J9Ah1eAZ@yuki>
Message-ID: <20210613165415.6432-1-vinay.m.engg@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Tested EFAULT cases only for "__NR_getitimer" syscall.

Tests for bad addresses in LTP cases trigger segment
fault in libc on a 32bit system.

Signed-off-by: Vinay Kumar <vinay.m.engg@gmail.com>
---
 testcases/kernel/syscalls/getitimer/getitimer02.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/getitimer/getitimer02.c b/testcases/kernel/syscalls/getitimer/getitimer02.c
index 2eb3f3a94..6039be6f9 100644
--- a/testcases/kernel/syscalls/getitimer/getitimer02.c
+++ b/testcases/kernel/syscalls/getitimer/getitimer02.c
@@ -14,12 +14,20 @@
 #include <errno.h>
 #include <sys/time.h>
 #include "tst_test.h"
+#include "lapi/syscalls.h"
+
+static int sys_getitimer(int which, void *curr_value)
+{
+	return tst_syscall(__NR_getitimer, which, curr_value);
+}
 
 static void verify_getitimer(void)
 {
 	/* call with a bad address */
-	TST_EXP_FAIL(getitimer(ITIMER_REAL, (struct itimerval *)-1),
+	TST_EXP_FAIL(sys_getitimer(ITIMER_REAL, (struct itimerval *)-1),
 		EFAULT, "expected failure - errno = %d - %s", TST_ERR, strerror(TST_ERR));
+
+	tst_res(TCONF, "EFAULT is skipped for libc variant");
 }
 
 static struct tst_test test = {
-- 
2.17.1

