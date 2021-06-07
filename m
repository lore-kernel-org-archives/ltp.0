From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Mon,  7 Jun 2021 16:15:09 +0530
Subject: [LTP] [PATCH 1/7] getitimer02: Skipped EFAULT tests for libc
 variant.
Message-ID: <20210607104515.29838-1-vinay.m.engg@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Tested EFAULT cases only for "__NR_getitimer" syscall.

Signed-off-by: Vinay Kumar <vinay.m.engg@gmail.com>
---
 .../kernel/syscalls/getitimer/getitimer02.c   | 54 +++++++++++++++----
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/getitimer/getitimer02.c b/testcases/kernel/syscalls/getitimer/getitimer02.c
index b9c03143a..356453d4d 100644
--- a/testcases/kernel/syscalls/getitimer/getitimer02.c
+++ b/testcases/kernel/syscalls/getitimer/getitimer02.c
@@ -30,6 +30,7 @@
 
 #include <errno.h>
 #include <sys/time.h>
+#include "lapi/syscalls.h"
 
 char *TCID = "getitimer02";
 int TST_TOTAL = 1;
@@ -39,9 +40,35 @@ int TST_TOTAL = 1;
 static void cleanup(void);
 static void setup(void);
 
+static int libc_getitimer(int which, void *curr_value)
+{
+	return getitimer(which, curr_value);
+}
+
+static int sys_getitimer(int which, void *curr_value)
+{
+	return ltp_syscall(__NR_getitimer, which, curr_value);
+}
+
+static struct test_variants
+{
+	int (*getitimer)(int which, void *curr_value);
+	char *desc;
+} variants[] = {
+	{ .getitimer = libc_getitimer, .desc = "libc getitimer()"},
+
+#if (__NR_getitimer != __LTP__NR_INVALID_SYSCALL)
+	{ .getitimer = sys_getitimer,  .desc = "__NR_getitimer syscall"},
+#endif
+};
+
+unsigned int tst_variant_t;
+int TST_VARIANTS = ARRAY_SIZE(variants);
+
 int main(int ac, char **av)
 {
-	int lc;
+	int lc, i;
+	struct test_variants *tv = &variants[tst_variant_t];
 
 	tst_parse_opts(ac, av, NULL, NULL);
 
@@ -50,16 +77,25 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		/* call with a bad address */
-		TEST(getitimer(ITIMER_REAL, (struct itimerval *)-1));
+		for (i = 0; i < TST_VARIANTS; i++) {
+			tst_resm(TINFO, "Testing variant: %s", tv->desc);
 
-		if (TEST_RETURN == 0) {
-			tst_resm(TFAIL, "call failed to produce "
-				 "expected error - errno = %d - %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			continue;
-		}
+			/* call with a bad address */
+			if (tv->getitimer == libc_getitimer) {
+				tst_resm(TCONF, "EFAULT skipped for libc variant");
+				tv++;
+				continue;
+			}
 
+		TEST(tv->getitimer(ITIMER_REAL, (struct itimerval *)-1));
+
+			if (TEST_RETURN == 0) {
+				tst_resm(TFAIL, "call failed to produce "
+					 "expected error - errno = %d - %s",
+					TEST_ERRNO, strerror(TEST_ERRNO));
+				continue;
+			}
+		}
 		switch (TEST_ERRNO) {
 		case EFAULT:
 			tst_resm(TPASS, "expected failure - errno = %d - %s",
-- 
2.17.1

