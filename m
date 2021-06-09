From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Wed,  9 Jun 2021 23:05:57 +0530
Subject: [LTP] [PATCH v2 06/10] setitimer02: Skipped EFAULT tests for libc
 variant.
In-Reply-To: <20210609173601.29352-1-vinay.m.engg@gmail.com>
References: <YL/Wf51Y6V5lRnkM@pevik>
 <20210609173601.29352-1-vinay.m.engg@gmail.com>
Message-ID: <20210609173601.29352-6-vinay.m.engg@gmail.com>
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
 .../kernel/syscalls/setitimer/setitimer02.c   | 41 ++++++++++++++++++-
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/setitimer/setitimer02.c b/testcases/kernel/syscalls/setitimer/setitimer02.c
index 656cf7d6a..77e01b018 100644
--- a/testcases/kernel/syscalls/setitimer/setitimer02.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer02.c
@@ -16,10 +16,34 @@
 #include <sys/time.h>
 #include <stdlib.h>
 #include "tst_test.h"
+#include "lapi/syscalls.h"
+
+static int libc_setitimer(int which, void *new_value, void *old_value)
+{
+	return setitimer(which, new_value, old_value);
+}
+
+static int sys_setitimer(int which, void *new_value, void *old_value)
+{
+	return tst_syscall(__NR_setitimer, which, new_value, old_value);
+}
+
+static struct test_variants
+{
+	int (*setitimer)(int which, void *new_value, void *old_value);
+	char *desc;
+} variants[] = {
+{ .setitimer = libc_setitimer, .desc = "libc setitimer()"},
+
+#if (__NR_setitimer != __LTP__NR_INVALID_SYSCALL)
+{ .setitimer = sys_setitimer,  .desc = "__NR_setitimer syscall"},
+#endif
+};
 
 static void verify_setitimer(void)
 {
 	struct itimerval *value;
+	struct test_variants *tv = &variants[tst_variant];
 
 	/* allocate some space for a timer structure */
 	if ((value = malloc((size_t)sizeof(struct itimerval))) ==
@@ -37,8 +61,13 @@ static void verify_setitimer(void)
 	 * ITIMER_REAL = 0, ITIMER_VIRTUAL = 1 and ITIMER_PROF = 2
 	 */
 
+	if (tv->setitimer == libc_setitimer) {
+		tst_res(TCONF, "EFAULT is skipped for libc variant");
+		return;
+	}
+
 	/* call with a bad address */
-	TEST(setitimer(ITIMER_REAL, value, (struct itimerval *)-1));
+	TEST(tv->setitimer(ITIMER_REAL, value, (struct itimerval *)-1));
 
 	if (TST_RET == 0) {
 		tst_res(TFAIL, "call failed to produce EFAULT error "
@@ -64,8 +93,16 @@ static void verify_setitimer(void)
 	value = NULL;
 }
 
+static void setup(void)
+{
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+}
+
 static struct tst_test test = {
 	.test_all = verify_setitimer,
+	.setup = setup,
+	.test_variants = ARRAY_SIZE(variants),
 	.needs_root = 1,
 };
-
-- 
2.17.1

