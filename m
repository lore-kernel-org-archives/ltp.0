From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Mon,  7 Jun 2021 16:15:15 +0530
Subject: [LTP] [PATCH 7/7] setitimer02: Skipped EFAULT tests for libc
 variant.
In-Reply-To: <20210607104515.29838-1-vinay.m.engg@gmail.com>
References: <20210607104515.29838-1-vinay.m.engg@gmail.com>
Message-ID: <20210607104515.29838-7-vinay.m.engg@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Tested EFAULT cases only for "__NR_setitimer"

Signed-off-by: Vinay Kumar <vinay.m.engg@gmail.com>
---
 .../kernel/syscalls/setitimer/setitimer02.c   | 82 +++++++++++++------
 1 file changed, 59 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/syscalls/setitimer/setitimer02.c b/testcases/kernel/syscalls/setitimer/setitimer02.c
index 4d13cd1e0..ee0748884 100644
--- a/testcases/kernel/syscalls/setitimer/setitimer02.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer02.c
@@ -56,6 +56,7 @@
 
 #include <errno.h>
 #include <sys/time.h>
+#include "lapi/syscalls.h"
 
 void cleanup(void);
 void setup(void);
@@ -63,12 +64,38 @@ void setup(void);
 char *TCID = "setitimer02";
 int TST_TOTAL = 1;
 
+static int libc_setitimer(int which, void *new_value, void *old_value)
+{
+	return setitimer(which, new_value, old_value);
+}
+
+static int sys_setitimer(int which, void *new_value, void *old_value)
+{
+	return ltp_syscall(__NR_setitimer, which, new_value, old_value);
+}
+
+static struct test_variants
+{
+	int (*setitimer)(int which, void *new_value, void *old_value);
+	char *desc;
+} variants[] = {
+	{ .setitimer = libc_setitimer, .desc = "libc setitimer()"},
+
+#if (__NR_setitimer != __LTP__NR_INVALID_SYSCALL)
+	{ .setitimer = sys_setitimer,  .desc = "__NR_setitimer syscall"},
+#endif
+};
+
+unsigned int tst_variant_t;
+int TST_VARIANTS = ARRAY_SIZE(variants);
+
 #if !defined(UCLINUX)
 
 int main(int ac, char **av)
 {
-	int lc;
+	int lc, i;
 	struct itimerval *value;
+	struct test_variants *tv = &variants[tst_variant_t];
 
 	tst_parse_opts(ac, av, NULL, NULL);
 
@@ -87,7 +114,6 @@ int main(int ac, char **av)
 		}
 
 		/* set up some reasonable values */
-
 		value->it_value.tv_sec = 30;
 		value->it_value.tv_usec = 0;
 		value->it_interval.tv_sec = 0;
@@ -97,27 +123,37 @@ int main(int ac, char **av)
 		 * ITIMER_REAL = 0, ITIMER_VIRTUAL = 1 and ITIMER_PROF = 2
 		 */
 
-		/* call with a bad address */
-		TEST(setitimer(ITIMER_REAL, value, (struct itimerval *)-1));
-
-		if (TEST_RETURN == 0) {
-			tst_resm(TFAIL, "call failed to produce EFAULT error "
-				 "- errno = %d - %s", TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-			continue;
+		for (i = 0; i < TST_VARIANTS; i++) {
+
+			tst_resm(TINFO, "Testing variant: %s", tv->desc);
+
+			/* call with a bad address */
+			if (tv->setitimer == libc_setitimer) {
+				tst_resm(TCONF, "EFAULT is skipped for libc variant");
+				tv++;
+				continue;
+			}
+
+			TEST(tv->setitimer(ITIMER_REAL, value, (struct itimerval *)-1));
+
+			if (TEST_RETURN == 0) {
+				tst_resm(TFAIL, "call failed to produce EFAULT error "
+					"- errno = %d - %s", TEST_ERRNO,
+					strerror(TEST_ERRNO));
+					continue;
+			}
+
+			switch (TEST_ERRNO) {
+			case EFAULT:
+				tst_resm(TPASS, "expected failure - errno = %d - %s",
+					 TEST_ERRNO, strerror(TEST_ERRNO));
+				break;
+			default:
+				tst_resm(TFAIL, "call failed to produce EFAULT error "
+					 "- errno = %d - %s", TEST_ERRNO,
+					 strerror(TEST_ERRNO));
+			}
 		}
-
-		switch (TEST_ERRNO) {
-		case EFAULT:
-			tst_resm(TPASS, "expected failure - errno = %d - %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		default:
-			tst_resm(TFAIL, "call failed to produce EFAULT error "
-				 "- errno = %d - %s", TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-		}
-
 		/*
 		 * clean up things in case we are looping
 		 */
@@ -153,7 +189,7 @@ void setup(void)
 
 /*
  * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
+ *		or premature exit.
  */
 void cleanup(void)
 {
-- 
2.17.1

