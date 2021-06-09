From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Wed,  9 Jun 2021 23:05:53 +0530
Subject: [LTP] [PATCH v2 02/10] getitimer02: Skipped EFAULT tests for libc
 variant.
In-Reply-To: <20210609173601.29352-1-vinay.m.engg@gmail.com>
References: <YL/Wf51Y6V5lRnkM@pevik>
 <20210609173601.29352-1-vinay.m.engg@gmail.com>
Message-ID: <20210609173601.29352-2-vinay.m.engg@gmail.com>
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
 .../kernel/syscalls/getitimer/getitimer02.c   | 81 ++++++++++++++-----
 1 file changed, 60 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/syscalls/getitimer/getitimer02.c b/testcases/kernel/syscalls/getitimer/getitimer02.c
index c2ca8880b..1e5d90a27 100644
--- a/testcases/kernel/syscalls/getitimer/getitimer02.c
+++ b/testcases/kernel/syscalls/getitimer/getitimer02.c
@@ -14,31 +14,70 @@
 #include <errno.h>
 #include <sys/time.h>
 #include "tst_test.h"
+#include "lapi/syscalls.h"
+
+static int libc_getitimer(int which, void *curr_value)
+{
+	return getitimer(which, curr_value);
+}
+
+static int sys_getitimer(int which, void *curr_value)
+{
+	return tst_syscall(__NR_getitimer, which, curr_value);
+}
+
+static struct test_variants
+{
+	int (*getitimer)(int which, void *curr_value);
+	char *desc;
+} variants[] = {
+{ .getitimer = libc_getitimer, .desc = "libc getitimer()"},
+
+#if (__NR_getitimer != __LTP__NR_INVALID_SYSCALL)
+{ .getitimer = sys_getitimer,  .desc = "__NR_getitimer syscall"},
+#endif
+};
 
 static void verify_getitimer(void)
 {
-		/* call with a bad address */
-		TEST(getitimer(ITIMER_REAL, (struct itimerval *)-1));
-
-		if (TST_RET == 0) {
-			tst_res(TFAIL, "call failed to produce "
-				"expected error - errno = %d - %s",
-				TST_ERR, strerror(TST_ERR));
-		}
-
-		switch (TST_ERR) {
-		case EFAULT:
-			tst_res(TPASS, "expected failure - errno = %d - %s",
-				 TST_ERR, strerror(TST_ERR));
-			break;
-		default:
-			tst_res(TFAIL, "call failed to produce "
-					"expected error - errno = %d - %s",
-					TST_ERR, strerror(TST_ERR));
-		}
+	struct test_variants *tv = &variants[tst_variant];
+
+	if (tv->getitimer == libc_getitimer) {
+		tst_res(TCONF, "EFAULT skipped for libc variant");
+		return;
+	}
+
+	/* call with a bad address */
+	TEST(tv->getitimer(ITIMER_REAL, (struct itimerval *)-1));
+
+	if (TST_RET == 0) {
+		tst_res(TFAIL, "call failed to produce "
+			"expected error - errno = %d - %s",
+			TST_ERR, strerror(TST_ERR));
+	}
+
+	switch (TST_ERR) {
+	case EFAULT:
+		tst_res(TPASS, "expected failure - errno = %d - %s",
+			 TST_ERR, strerror(TST_ERR));
+		break;
+	default:
+		tst_res(TFAIL, "call failed to produce "
+			"expected error - errno = %d - %s",
+			TST_ERR, strerror(TST_ERR));
+	}
+}
+
+static void setup(void)
+{
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
 }
 
 static struct tst_test test = {
-			.test_all = verify_getitimer,
-			.needs_root = 1,
+	.test_all = verify_getitimer,
+	.setup = setup,
+	.test_variants = ARRAY_SIZE(variants),
+	.needs_root = 1,
 };
-- 
2.17.1

