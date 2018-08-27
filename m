From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 27 Aug 2018 11:30:52 +0200
Subject: [LTP] [PATCH v2 3/4] Convert futex_wait_bitset tests to newlib
In-Reply-To: <20180827093053.24658-1-rpalethorpe@suse.com>
References: <20180827093053.24658-1-rpalethorpe@suse.com>
Message-ID: <20180827093053.24658-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 .../kernel/syscalls/futex/futex_wait_bitset.h | 54 ++++++++++++-------
 .../syscalls/futex/futex_wait_bitset01.c      | 22 ++------
 .../syscalls/futex/futex_wait_bitset02.c      | 23 ++------
 3 files changed, 43 insertions(+), 56 deletions(-)

diff --git a/testcases/kernel/syscalls/futex/futex_wait_bitset.h b/testcases/kernel/syscalls/futex/futex_wait_bitset.h
index 81a5d93ab..090dc51d2 100644
--- a/testcases/kernel/syscalls/futex/futex_wait_bitset.h
+++ b/testcases/kernel/syscalls/futex/futex_wait_bitset.h
@@ -18,6 +18,7 @@
  */
 
 #define TRESHOLD_US 100000
+#define DEFAULT_TIMEOUT_US 100010
 
 static void verify_futex_wait_bitset(long long wait_us, clock_t clk_id)
 {
@@ -26,8 +27,8 @@ static void verify_futex_wait_bitset(long long wait_us, clock_t clk_id)
 	u_int32_t bitset = 0xffffffff;
 	int flags = clk_id == CLOCK_REALTIME ? FUTEX_CLOCK_REALTIME : 0;
 
-	tst_resm(TINFO, "testing futex_wait_bitset() timeout with %s",
-	         clk_id == CLOCK_REALTIME ? "CLOCK_REALTIME" : "CLOCK_MONOTONIC");
+	tst_res(TINFO, "testing futex_wait_bitset() timeout with %s",
+		clk_id == CLOCK_REALTIME ? "CLOCK_REALTIME" : "CLOCK_MONOTONIC");
 
 	clock_gettime(clk_id, &start);
 	to = tst_timespec_add_us(start, wait_us);
@@ -36,38 +37,53 @@ static void verify_futex_wait_bitset(long long wait_us, clock_t clk_id)
 
 	clock_gettime(clk_id, &end);
 
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "futex_wait_bitset() returned %li, expected -1",
-		         TEST_RETURN);
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "futex_wait_bitset() returned %li, expected -1",
+			TST_RET);
 		return;
 	}
 
-	if (TEST_ERRNO == ENOSYS) {
-		tst_resm(TCONF, "In this kernel, futex() does not support "
-			 "FUTEX_WAIT_BITSET operation");
+	if (TST_ERR == ENOSYS) {
+		tst_res(TCONF,
+			"In this kernel, futex() does not support FUTEX_WAIT_BITSET operation");
 		return;
 	}
 
-	if (TEST_ERRNO != ETIMEDOUT) {
-		tst_resm(TFAIL | TTERRNO, "expected %s",
-		         tst_strerrno(ETIMEDOUT));
+	if (TST_ERR != ETIMEDOUT) {
+		tst_res(TFAIL | TTERRNO, "expected %s",
+			tst_strerrno(ETIMEDOUT));
 		return;
 	}
 
 	if (tst_timespec_lt(end, to)) {
-		tst_resm(TFAIL,
-		         "futex_wait_bitset() woken up prematurely %llius, expected %llius",
-			 tst_timespec_diff_us(end, start), wait_us);
+		tst_res(TFAIL,
+			"futex_wait_bitset() woken up prematurely %llius, expected %llius",
+			tst_timespec_diff_us(end, start), wait_us);
 		return;
 	}
 
 	if (tst_timespec_diff_us(end, to) > TRESHOLD_US) {
-		tst_resm(TFAIL,
-		         "futex_wait_bitset() waited too long %llius, expected %llius",
-			 tst_timespec_diff_us(end, start), wait_us);
+		tst_res(TFAIL,
+			"futex_wait_bitset() waited too long %llius, expected %llius",
+			tst_timespec_diff_us(end, start), wait_us);
 		return;
 	}
 
-	tst_resm(TPASS, "futex_wait_bitset() waited %llius, expected %llius",
-	         tst_timespec_diff_us(end, start), wait_us);
+	tst_res(TPASS, "futex_wait_bitset() waited %llius, expected %llius",
+		tst_timespec_diff_us(end, start), wait_us);
 }
+
+static void setup(void)
+{
+	tst_timer_check(USE_CLOCK);
+}
+
+static void run(void)
+{
+	verify_futex_wait_bitset(DEFAULT_TIMEOUT_US, USE_CLOCK);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+};
diff --git a/testcases/kernel/syscalls/futex/futex_wait_bitset01.c b/testcases/kernel/syscalls/futex/futex_wait_bitset01.c
index e5fd621e5..371febb3b 100644
--- a/testcases/kernel/syscalls/futex/futex_wait_bitset01.c
+++ b/testcases/kernel/syscalls/futex/futex_wait_bitset01.c
@@ -24,25 +24,11 @@
 
 #include <errno.h>
 
-#include "test.h"
+#include "tst_test.h"
+#include "tst_timer.h"
 #include "futextest.h"
-#include "futex_wait_bitset.h"
-
-const char *TCID="futex_wait_bitset01";
-const int TST_TOTAL=1;
-
-#define DEFAULT_TIMEOUT_US 100010
 
-int main(int argc, char *argv[])
-{
-	int lc;
+#define USE_CLOCK CLOCK_MONOTONIC
 
-	tst_timer_check(CLOCK_MONOTONIC);
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		verify_futex_wait_bitset(DEFAULT_TIMEOUT_US, CLOCK_MONOTONIC);
+#include "futex_wait_bitset.h"
 
-	tst_exit();
-}
diff --git a/testcases/kernel/syscalls/futex/futex_wait_bitset02.c b/testcases/kernel/syscalls/futex/futex_wait_bitset02.c
index 820c65c26..e727a1b38 100644
--- a/testcases/kernel/syscalls/futex/futex_wait_bitset02.c
+++ b/testcases/kernel/syscalls/futex/futex_wait_bitset02.c
@@ -24,25 +24,10 @@
 
 #include <errno.h>
 
-#include "test.h"
+#include "tst_test.h"
+#include "tst_timer.h"
 #include "futextest.h"
-#include "futex_wait_bitset.h"
-
-const char *TCID="futex_wait_bitset02";
-const int TST_TOTAL=1;
-
-#define DEFAULT_TIMEOUT_US 100010
-
-int main(int argc, char *argv[])
-{
-	int lc;
 
-	tst_timer_check(CLOCK_REALTIME);
+#define USE_CLOCK CLOCK_REALTIME
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		verify_futex_wait_bitset(DEFAULT_TIMEOUT_US, CLOCK_REALTIME);
-
-	tst_exit();
-}
+#include "futex_wait_bitset.h"
-- 
2.18.0

