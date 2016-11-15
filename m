From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Nov 2016 10:53:07 +0100
Subject: [LTP] [PATCH 1/1] syscalls/clock_getres01: convert to use new test
	library API
Message-ID: <20161115095307.27985-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/syscalls/clock_getres/clock_getres01.c  | 96 ++++++++--------------
 1 file changed, 32 insertions(+), 64 deletions(-)

diff --git a/testcases/kernel/syscalls/clock_getres/clock_getres01.c b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
index dff456c..30393cf 100644
--- a/testcases/kernel/syscalls/clock_getres/clock_getres01.c
+++ b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
@@ -27,20 +27,9 @@
  * Description: This tests the clock_getres() syscall
  */
 
-#include <sys/syscall.h>
-#include <sys/types.h>
-#include <getopt.h>
-#include <string.h>
-#include <stdlib.h>
-#include <libgen.h>
 #include <errno.h>
-#include <stdio.h>
-#include <time.h>
-#include "config.h"
-#include "include_j_h.h"
 
-#include "test.h"
-#include "lapi/posix_clocks.h"
+#include "tst_test.h"
 
 #define NORMAL		1
 #define NULL_POINTER	0
@@ -66,67 +55,46 @@ static struct test_case {
 	{"-1", -1, NORMAL, -1, EINVAL},
 };
 
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "clock_getres01";
 int TST_TOTAL = ARRAY_SIZE(tcase);
 
-int main(int ac, char **av)
+static void do_test(void)
 {
 	int i;
-	int lc;
 	struct timespec res;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; ++i) {
-			if (tcase[i].ttype == NULL_POINTER)
-				TEST(clock_getres(tcase[i].clk_id, NULL));
-			else
-				TEST(clock_getres(tcase[i].clk_id, &res));
-
-			if (TEST_RETURN != tcase[i].ret) {
-				if (TEST_ERRNO != EINVAL) {
-					tst_resm(TFAIL | TTERRNO,
-						 "clock_getres %s failed",
-						 tcase[i].name);
-				} else {
-					tst_resm(TCONF,
-						 "clock_getres %s NO SUPPORTED",
-						 tcase[i].name);
-				}
+	for (i = 0; i < TST_TOTAL; ++i) {
+		if (tcase[i].ttype == NULL_POINTER)
+			TEST(clock_getres(tcase[i].clk_id, NULL));
+		else
+			TEST(clock_getres(tcase[i].clk_id, &res));
+
+		if (TEST_RETURN != tcase[i].ret) {
+			if (TEST_ERRNO != EINVAL) {
+					tst_res(TFAIL | TTERRNO,
+					 "clock_getres %s failed",
+					 tcase[i].name);
 			} else {
-				if (TEST_ERRNO != tcase[i].err) {
-					tst_resm(TFAIL,
-						 "clock_getres %s failed with "
-						 "unexpect errno: %d",
-						 tcase[i].name, TEST_ERRNO);
-				} else {
-					tst_resm(TPASS,
-						 "clock_getres %s succeeded",
-						 tcase[i].name);
-				}
+					tst_res(TCONF,
+					 "clock_getres %s NO SUPPORTED",
+					 tcase[i].name);
+			}
+		} else {
+			if (TEST_ERRNO != tcase[i].err) {
+					tst_res(TFAIL,
+					 "clock_getres %s failed with "
+					 "unexpect errno: %d",
+					 tcase[i].name, TEST_ERRNO);
+			} else {
+					tst_res(TPASS,
+					 "clock_getres %s succeeded",
+					 tcase[i].name);
 			}
-
 		}
-	}
-
-	cleanup();
-	tst_exit();
-}
 
-static void setup(void)
-{
-	TEST_PAUSE;
+	}
 }
 
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.tid = "clock_getres01",
+	.test_all = do_test,
+};
-- 
2.10.2

