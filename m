From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  6 Aug 2019 13:10:56 +0200
Subject: [LTP] [PATCH 2/2] clock_getres01: add test variants
In-Reply-To: <76fa74b68aa0794f58e01d5794fffa3a02df0203.1565089789.git.jstancek@redhat.com>
References: <76fa74b68aa0794f58e01d5794fffa3a02df0203.1565089789.git.jstancek@redhat.com>
Message-ID: <a1e04fe183c0f261263d08fded3ae28227324a37.1565089789.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

0 - default, could be either VDSO or syscall
1 - syscall with valid res parameter
2 - syscall with NULL res parameter

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/clock_getres/clock_getres01.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/clock_getres/clock_getres01.c b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
index 6b556965530e..21c003aea50b 100644
--- a/testcases/kernel/syscalls/clock_getres/clock_getres01.c
+++ b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
@@ -13,6 +13,7 @@
 #include <errno.h>
 
 #include "tst_test.h"
+#include "lapi/syscalls.h"
 #include "lapi/posix_clocks.h"
 
 static struct timespec res;
@@ -40,7 +41,18 @@ static struct test_case {
 
 static void do_test(unsigned int i)
 {
-	TEST(clock_getres(tcase[i].clk_id, tcase[i].res));
+	switch (tst_variant) {
+	case 0:
+		TEST(clock_getres(tcase[i].clk_id, tcase[i].res));
+		break;
+	case 1:
+		TEST(tst_syscall(__NR_clock_getres, tcase[i].clk_id,
+			tcase[i].res));
+		break;
+	case 2:
+		TEST(tst_syscall(__NR_clock_getres, tcase[i].clk_id, NULL));
+		break;
+	}
 
 	if (TST_RET != tcase[i].ret) {
 		if (TST_ERR == EINVAL) {
@@ -65,4 +77,5 @@ static void do_test(unsigned int i)
 static struct tst_test test = {
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(tcase),
+	.test_variants = 3,
 };
-- 
1.8.3.1

