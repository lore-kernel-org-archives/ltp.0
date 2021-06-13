From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Sun, 13 Jun 2021 22:46:42 +0530
Subject: [LTP] [PATCH v3] getrusage02: Skipped EFAULT tests for libc variant.
In-Reply-To: <YMNqQE218QqnPiZY@yuki>
References: <YMNqQE218QqnPiZY@yuki>
Message-ID: <20210613171642.7773-1-vinay.m.engg@gmail.com>
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
 .../kernel/syscalls/getrusage/getrusage02.c   | 42 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage02.c b/testcases/kernel/syscalls/getrusage/getrusage02.c
index 9fc5d7dbb..2dff1a444 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage02.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage02.c
@@ -19,9 +19,20 @@
 #include <sched.h>
 #include <sys/resource.h>
 #include "tst_test.h"
+#include "lapi/syscalls.h"
 
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
@@ -33,13 +44,42 @@ struct test_cases_t {
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
-	TST_EXP_FAIL(getrusage(test_cases[i].who, test_cases[i].usage),
+	struct test_variants *tv = &variants[tst_variant];
+
+	if (test_cases[i].exp_errno == EFAULT &&
+		tv->getrusage == libc_getrusage) {
+		tst_res(TCONF, "EFAULT is skipped for libc variant");
+		return;
+	}
+
+	TST_EXP_FAIL(tv->getrusage(test_cases[i].who, test_cases[i].usage),
 		test_cases[i].exp_errno, "getrusage failed as expected");
 }
 
+static void setup(void)
+{
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+}
+
 static struct tst_test test = {
 	.test = verify_getrusage,
+	.setup = setup,
 	.tcnt = ARRAY_SIZE(test_cases),
+	.test_variants = ARRAY_SIZE(variants),
 };
-- 
2.17.1

