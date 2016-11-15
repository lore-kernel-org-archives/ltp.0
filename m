From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Nov 2016 14:49:29 +0100
Subject: [LTP] [PATCH v2 1/1] syscalls/clock_getres01: convert to use new
	test library API
Message-ID: <20161115134929.8471-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
v2:
* use tst_test.test & tst_test.tcnt instead of loop
* put back lapi/posix_clocks.h include
* use pointer to timespec in struct test_case
---
 .../kernel/syscalls/clock_getres/clock_getres01.c  | 128 +++++++--------------
 1 file changed, 43 insertions(+), 85 deletions(-)

diff --git a/testcases/kernel/syscalls/clock_getres/clock_getres01.c b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
index dff456c..3769b8d 100644
--- a/testcases/kernel/syscalls/clock_getres/clock_getres01.c
+++ b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
@@ -27,106 +27,64 @@
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
+#include "tst_test.h"
 #include "lapi/posix_clocks.h"
 
-#define NORMAL		1
-#define NULL_POINTER	0
+static struct timespec res;
 
 static struct test_case {
 	char *name;
 	clockid_t clk_id;
-	int ttype;
+	struct timespec *res;
 	int ret;
 	int err;
 } tcase[] = {
-	{"REALTIME", CLOCK_REALTIME, NORMAL, 0, 0},
-	{"MONOTONIC", CLOCK_MONOTONIC, NORMAL, 0, 0},
-	{"PROCESS_CPUTIME_ID", CLOCK_PROCESS_CPUTIME_ID, NORMAL, 0, 0},
-	{"THREAD_CPUTIME_ID", CLOCK_THREAD_CPUTIME_ID, NORMAL, 0, 0},
-	{"REALTIME", CLOCK_REALTIME, NULL_POINTER, 0, 0},
-	{"CLOCK_MONOTONIC_RAW", CLOCK_MONOTONIC_RAW, NORMAL, 0, 0,},
-	{"CLOCK_REALTIME_COARSE", CLOCK_REALTIME_COARSE, NORMAL, 0, 0,},
-	{"CLOCK_MONOTONIC_COARSE", CLOCK_MONOTONIC_COARSE, NORMAL, 0, 0,},
-	{"CLOCK_BOOTTIME", CLOCK_BOOTTIME, NORMAL, 0, 0,},
-	{"CLOCK_REALTIME_ALARM", CLOCK_REALTIME_ALARM, NORMAL, 0, 0,},
-	{"CLOCK_BOOTTIME_ALARM", CLOCK_BOOTTIME_ALARM, NORMAL, 0, 0,},
-	{"-1", -1, NORMAL, -1, EINVAL},
+	{"REALTIME", CLOCK_REALTIME, &res, 0, 0},
+	{"MONOTONIC", CLOCK_MONOTONIC, &res, 0, 0},
+	{"PROCESS_CPUTIME_ID", CLOCK_PROCESS_CPUTIME_ID, &res, 0, 0},
+	{"THREAD_CPUTIME_ID", CLOCK_THREAD_CPUTIME_ID, &res, 0, 0},
+	{"REALTIME", CLOCK_REALTIME, NULL, 0, 0},
+	{"CLOCK_MONOTONIC_RAW", CLOCK_MONOTONIC_RAW, &res, 0, 0,},
+	{"CLOCK_REALTIME_COARSE", CLOCK_REALTIME_COARSE, &res, 0, 0,},
+	{"CLOCK_MONOTONIC_COARSE", CLOCK_MONOTONIC_COARSE, &res, 0, 0,},
+	{"CLOCK_BOOTTIME", CLOCK_BOOTTIME, &res, 0, 0,},
+	{"CLOCK_REALTIME_ALARM", CLOCK_REALTIME_ALARM, &res, 0, 0,},
+	{"CLOCK_BOOTTIME_ALARM", CLOCK_BOOTTIME_ALARM, &res, 0, 0,},
+	{"-1", -1, &res, -1, EINVAL},
 };
 
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "clock_getres01";
-int TST_TOTAL = ARRAY_SIZE(tcase);
-
-int main(int ac, char **av)
+static void do_test(unsigned int i)
 {
-	int i;
-	int lc;
-	struct timespec res;
-
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
-			} else {
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
-			}
-
+	TEST(clock_getres(tcase[i].clk_id, tcase[i].res));
+
+	if (TEST_RETURN != tcase[i].ret) {
+		if (TEST_ERRNO != EINVAL) {
+				tst_res(TFAIL | TTERRNO,
+				 "clock_getres %s failed",
+				 tcase[i].name);
+		} else {
+				tst_res(TCONF,
+				 "clock_getres %s NO SUPPORTED",
+				 tcase[i].name);
+		}
+	} else {
+		if (TEST_ERRNO != tcase[i].err) {
+				tst_res(TFAIL,
+				 "clock_getres %s failed with "
+				 "unexpect errno: %d",
+				 tcase[i].name, TEST_ERRNO);
+		} else {
+				tst_res(TPASS,
+				 "clock_getres %s succeeded",
+				 tcase[i].name);
 		}
 	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	TEST_PAUSE;
 }
 
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.tid = "clock_getres01",
+	.test = do_test,
+	.tcnt = ARRAY_SIZE(tcase),
+};
-- 
2.10.2

