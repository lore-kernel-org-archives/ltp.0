From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Wed,  9 Jun 2021 23:05:55 +0530
Subject: [LTP] [PATCH v2 04/10] getrusage02: Skipped EFAULT tests for libc
 variant.
In-Reply-To: <20210609173601.29352-1-vinay.m.engg@gmail.com>
References: <YL/Wf51Y6V5lRnkM@pevik>
 <20210609173601.29352-1-vinay.m.engg@gmail.com>
Message-ID: <20210609173601.29352-4-vinay.m.engg@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Tested EFAULT cases only for "__NR_getrusage" syscall.

Tests for bad addresses in LTP cases trigger segment
fault in libc on a 32bit system.

Signed-off-by: Vinay Kumar <vinay.m.engg@gmail.com>
---
 .../kernel/syscalls/getrusage/getrusage02.c   | 58 ++++++++++++++++---
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage02.c b/testcases/kernel/syscalls/getrusage/getrusage02.c
index c4b3f0f69..07ff04dee 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage02.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage02.c
@@ -19,6 +19,7 @@
 #include <sched.h>
 #include <sys/resource.h>
 #include "tst_test.h"
+#include "lapi/syscalls.h"
 
 #ifndef RUSAGE_BOTH		/* Removed from user space on RHEL4 */
 #define RUSAGE_BOTH (-2)	/* still works on SuSE      */
@@ -26,6 +27,16 @@
 
 static struct rusage usage;
 
+static int libc_getrusage(int who, void *usage)
+{
+	return getrusage(who, usage);
+}
+
+static int sys_getrusage(int who, void *usage)
+{
+	return tst_syscall(__NR_getrusage, who, usage);
+}
+
 struct test_cases_t {
 	int who;
 	struct rusage *usage;
@@ -37,21 +48,50 @@ struct test_cases_t {
 	RUSAGE_SELF, (struct rusage *)-1, EFAULT}
 };
 
+static struct test_variants
+{
+	int (*getrusage)(int who, void *usage);
+	char *desc;
+} variants[] = {
+{ .getrusage = libc_getrusage, .desc = "libc getrusage()"},
+
+#if (__NR_getrusage != __LTP__NR_INVALID_SYSCALL)
+{ .getrusage = sys_getrusage,  .desc = "__NR_getrusage syscall"},
+#endif
+};
+
 static void verify_getrusage(unsigned int i)
 {
-		TEST(getrusage(test_cases[i].who, test_cases[i].usage));
-
-		if (TST_RET == -1 &&
-		    TST_ERR == test_cases[i].exp_errno)
-			tst_res(TPASS | TTERRNO,
-				"getrusage failed as expected");
-		else
-			tst_res(TFAIL | TTERRNO,
-				"getrusage failed unexpectedly");
+	struct test_variants *tv = &variants[tst_variant];
+
+	if (test_cases[i].exp_errno == EFAULT &&
+		tv->getrusage == libc_getrusage) {
+		tst_res(TCONF, "EFAULT is skipped for libc variant");
+		return;
+	}
+
+	TEST(tv->getrusage(test_cases[i].who, test_cases[i].usage));
+
+	if (TST_RET == -1 &&
+		TST_ERR == test_cases[i].exp_errno)
+		tst_res(TPASS | TTERRNO,
+			"getrusage failed as expected");
+	else
+		tst_res(TFAIL | TTERRNO,
+			"getrusage failed unexpectedly");
+}
+
+static void setup(void)
+{
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
 }
 
 static struct tst_test test = {
 	.test = verify_getrusage,
+	.setup = setup,
 	.tcnt = ARRAY_SIZE(test_cases),
+	.test_variants = ARRAY_SIZE(variants),
 	.needs_root = 1,
 };
-- 
2.17.1

