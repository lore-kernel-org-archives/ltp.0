From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 29 Jun 2020 17:13:23 +0530
Subject: [LTP] [PATCH 1/2] syscalls/timer_settime01: Improve print messages
Message-ID: <7c68854a1b6ef828ed8dd83cb611bd5b5d53c2f8.1593430825.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This improves the print messages by providing additional information
about the tests.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../syscalls/timer_settime/timer_settime01.c  | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime01.c b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
index 08fb56e4943a..52c435ee3d91 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime01.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
@@ -82,12 +82,12 @@ static void run(unsigned int n)
 		if (TST_RET != 0) {
 			if (possibly_unsupported(clock) &&
 				(TST_ERR == EINVAL || TST_ERR == ENOTSUP)) {
-				tst_res(TCONF | TTERRNO, "%s unsupported",
-					get_clock_str(clock));
+				tst_res(TCONF | TTERRNO, "%s: %s unsupported",
+					tv->desc, get_clock_str(clock));
 			} else {
 				tst_res(TFAIL | TTERRNO,
-					"timer_create(%s) failed",
-					get_clock_str(clock));
+					"%s: timer_create(%s) failed",
+					tv->desc, get_clock_str(clock));
 			}
 			continue;
 		}
@@ -102,9 +102,8 @@ static void run(unsigned int n)
 		if (tc->flag & TIMER_ABSTIME) {
 			timenow.type = tv->type;
 			if (tv->gettime(clock, tst_ts_get(&timenow)) < 0) {
-				tst_res(TFAIL,
-					"clock_gettime(%s) failed - skipping the test",
-					get_clock_str(clock));
+				tst_res(TFAIL, "%s: clock_gettime(%s) failed - skipping the test",
+					tv->desc, get_clock_str(clock));
 				continue;
 			}
 			val += tst_ts_get_sec(timenow);
@@ -115,19 +114,21 @@ static void run(unsigned int n)
 		tst_its_set_value_sec(&new_set, val);
 		tst_its_set_value_nsec(&new_set, 0);
 
-		TEST(tv->func(timer, tc->flag, tst_its_get(&new_set), tst_its_get(tc->old_ptr)));
-
+		TEST(tv->func(timer, tc->flag, tst_its_get(&new_set),
+			      tst_its_get(tc->old_ptr)));
 		if (TST_RET != 0) {
-			tst_res(TFAIL | TTERRNO, "%s failed",
-					get_clock_str(clock));
+			tst_res(TFAIL | TTERRNO, "%s: timer_settime(%s) failed",
+				tv->desc, get_clock_str(clock));
 		} else {
-			tst_res(TPASS, "%s was successful",
-					get_clock_str(clock));
+			tst_res(TPASS, "%s: timer_settime(%s) was successful",
+				tv->desc, get_clock_str(clock));
 		}
 
 		TEST(tst_syscall(__NR_timer_delete, timer));
-		if (TST_RET != 0)
-			tst_res(TFAIL | TTERRNO, "timer_delete() failed!");
+		if (TST_RET != 0) {
+			tst_res(TFAIL | TTERRNO, "%s: %s: timer_delete() failed!",
+				tv->desc, get_clock_str(clock));
+		}
 	}
 }
 
-- 
2.25.0.rc1.19.g042ed3e048af

