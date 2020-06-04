From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu,  4 Jun 2020 17:11:44 +0530
Subject: [LTP] [PATCH] clock_gettime03: Fix issues with negative offset
Message-ID: <8b9a7e8ea27894090f1e31e178d7328f118163d0.1591270889.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The tests takes difference between two time readings and check it
against the offset set by the test. When the offset is set to a positive
value (eg 10000 ms), then the diff comes to a value >= 10000 ms (eg
10001 ms), and with divided by 1000, both sides evaluate to 10.

But when the offset is set to -10000 ms, then the delta is >= -10000 ms
(eg -9999) ms. And when divided by 1000, it comes to -9 != -10 and the
test reports error. Over that we are comparing value in seconds, which
is too large of a value. Change the test to compare delta in ms and fix
the false failures.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/clock_gettime/clock_gettime03.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
index e6b9c9c7857c..8341051088d7 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
@@ -76,7 +76,7 @@ static void child(struct test_variants *tv, struct tcase *tc)
 
 	diff = tst_ts_diff_ms(then, now);
 
-	if (diff/1000 != tc->off) {
+	if (diff - tc->off * 1000 > 10) {
 		tst_res(TFAIL, "Wrong offset (%s) read %llims",
 		        tst_clock_name(tc->clk_id), diff);
 	} else {
@@ -86,7 +86,7 @@ static void child(struct test_variants *tv, struct tcase *tc)
 
 	diff = tst_ts_diff_ms(parent_then, now);
 
-	if (diff/1000) {
+	if (diff > 10) {
 		tst_res(TFAIL, "Wrong offset (%s) read %llims",
 		        tst_clock_name(tc->clk_id), diff);
 	} else {
-- 
2.25.0.rc1.19.g042ed3e048af

