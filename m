From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Date: Tue,  6 Oct 2020 05:53:09 -0300
Subject: [LTP] [PATCH] syscalls/timer_settime01: adjust for rounding from
 nsec to usec
Message-ID: <20201006085309.32227-1-cascardo@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When using TIMER_ABSTIME, the value is added to the current clock time.
However, usecs is used instead of nsecs, leading to a possible rounding up from
tst_ts_to_us.

That rounding can lead to up to 500 nsecs of difference between the current
time and the absolute time used for setting the timer. When reading the timer
back, that same difference can be found, which leads to a test failure.

Accounting for that possible difference in the time allows the test to pass.

This can be easily reproducible by booting linux with clocksource=jiffies.

Fixes: b34e243e85dd (syscalls/timer_settime01: Make sure the timer fires)
Reported-by: Kelsey Skunberg <kelsey.skunberg@canonical.com>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 testcases/kernel/syscalls/timer_settime/timer_settime01.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime01.c b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
index 67143e8f88b2..7ecf0c18d1c4 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime01.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
@@ -149,10 +149,15 @@ static void run(unsigned int n)
 		if (TST_RET != 0) {
 			tst_res(TFAIL | TTERRNO, "timer_gettime(%s) failed",
 				get_clock_str(clock));
+		/*
+		 * With TIMER_ABSTIME, we add to the current clock after
+		 * rounding up by 500 ns to the value. Do the same here after
+		 * reading the timer back.
+		 */
 		} else if ((tst_its_get_interval_nsec(new_set) !=
 				tc->it_interval_tv_usec * 1000) ||
 			   (tst_its_get_value_nsec(new_set) >
-				MAX(tc->it_value_tv_usec * 1000, tc->it_interval_tv_usec * 1000))) {
+				MAX(tc->it_value_tv_usec * 1000 + 500, tc->it_interval_tv_usec * 1000))) {
 			tst_res(TFAIL | TTERRNO,
 				"timer_gettime(%s) reported bad values (%llu: %llu)",
 				get_clock_str(clock),
-- 
2.25.1

