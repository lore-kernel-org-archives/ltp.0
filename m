From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Mon,  7 Jun 2021 16:15:10 +0530
Subject: [LTP] [PATCH 2/7] getrusage02: Skipped EFAULT tests for libc
 variant.
In-Reply-To: <20210607104515.29838-1-vinay.m.engg@gmail.com>
References: <20210607104515.29838-1-vinay.m.engg@gmail.com>
Message-ID: <20210607104515.29838-2-vinay.m.engg@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Tested EFAULT cases only for "__NR_getrusage" syscall.

Signed-off-by: Vinay Kumar <vinay.m.engg@gmail.com>
---
 .../kernel/syscalls/getrusage/getrusage02.c   | 53 ++++++++++++++++---
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage02.c b/testcases/kernel/syscalls/getrusage/getrusage02.c
index 8077606a2..00c1af805 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage02.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage02.c
@@ -71,6 +71,7 @@
 #include <sched.h>
 #include <sys/resource.h>
 #include "test.h"
+#include "lapi/syscalls.h"
 
 #ifndef RUSAGE_BOTH		/* Removed from user space on RHEL4 */
 #define RUSAGE_BOTH (-2)	/* still works on SuSE      */
@@ -83,6 +84,16 @@ char *TCID = "getrusage02";
 
 static struct rusage usage;
 
+static int libc_getrusage(int who, void *usage)
+{
+	return getrusage(who, usage);
+}
+
+static int sys_getrusage(int who, void *usage)
+{
+	return ltp_syscall(__NR_getrusage, who, usage);
+}
+
 struct test_cases_t {
 	int who;
 	struct rusage *usage;
@@ -96,12 +107,26 @@ struct test_cases_t {
 #endif
 };
 
+static struct test_variants
+{
+	int (*getrusage)(int who, void *usage);
+	char *desc;
+} variants[] = {
+	{ .getrusage = libc_getrusage, .desc = "libc getrusage()"},
+
+#if (__NR_getrusage != __LTP__NR_INVALID_SYSCALL)
+	{ .getrusage = sys_getrusage,  .desc = "__NR_getrusage syscall"},
+#endif
+};
+
+unsigned int tst_variant_t;
+int TST_VARIANTS = ARRAY_SIZE(variants);
 int TST_TOTAL = ARRAY_SIZE(test_cases);
 
 int main(int ac, char **av)
 {
-
-	int lc, i;
+	struct test_variants *tv = &variants[tst_variant_t];
+	int lc, i, j;
 
 	tst_parse_opts(ac, av, NULL, NULL);
 
@@ -111,18 +136,30 @@ int main(int ac, char **av)
 
 		tst_count = 0;
 
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(getrusage(test_cases[i].who, test_cases[i].usage));
+		for (j = 0; j < TST_VARIANTS; j++) {
+
+			tst_resm(TINFO, "Testing variant: %s", tv->desc);
+			for (i = 0; i < TST_TOTAL; i++) {
+
+				if (test_cases[i].exp_errno == EFAULT &&
+					tv->getrusage == libc_getrusage) {
+					tst_resm(TCONF, "EFAULT is skipped for libc variant");
+					tv++;
+					continue;
+				}
+
+			TEST(tv->getrusage(test_cases[i].who, test_cases[i].usage));
 
 			if (TEST_RETURN == -1 &&
-			    TEST_ERRNO == test_cases[i].exp_errno)
+				TEST_ERRNO == test_cases[i].exp_errno)
 				tst_resm(TPASS | TTERRNO,
-					 "getrusage failed as expected");
+				"getrusage failed as expected");
 			else
 				tst_resm(TFAIL | TTERRNO,
-					 "getrusage failed unexpectedly");
+				"getrusage failed unexpectedly");
+				}
+			}
 		}
-	}
 
 	cleanup();
 
-- 
2.17.1

