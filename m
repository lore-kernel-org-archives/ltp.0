From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  1 Aug 2019 11:26:15 +0200
Subject: [LTP] [RFC PATCH 8/9] syscalls/clock_settime01: Make use of guarded
 buffers.
In-Reply-To: <20190801092616.30553-1-chrubis@suse.cz>
References: <20190801092616.30553-1-chrubis@suse.cz>
Message-ID: <20190801092616.30553-9-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../syscalls/clock_settime/clock_settime01.c  | 29 ++++++++++++-------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime01.c b/testcases/kernel/syscalls/clock_settime/clock_settime01.c
index c68fe59a1..62d349154 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime01.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime01.c
@@ -23,23 +23,24 @@
 #define DELTA_US (long long) (DELTA_SEC * 1000000)
 #define DELTA_EPS (long long) (DELTA_US * 0.1)
 
+static struct timespec *begin, *change, *end;
+
 static void verify_clock_settime(void)
 {
 	long long elapsed;
-	struct timespec begin, change, end;
 
 	/* test 01: move forward */
 
-	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &begin);
+	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, begin);
 
-	change = tst_timespec_add_us(begin, DELTA_US);
+	*change = tst_timespec_add_us(*begin, DELTA_US);
 
-	if (clock_settime(CLOCK_REALTIME, &change) != 0)
+	if (clock_settime(CLOCK_REALTIME, change) != 0)
 		tst_brk(TBROK | TTERRNO, "could not set realtime change");
 
-	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &end);
+	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, end);
 
-	elapsed = tst_timespec_diff_us(end, begin);
+	elapsed = tst_timespec_diff_us(*end, *begin);
 
 	if (elapsed >= DELTA_US && elapsed < (DELTA_US + DELTA_EPS))
 		tst_res(TPASS, "clock_settime(2): was able to advance time");
@@ -48,16 +49,16 @@ static void verify_clock_settime(void)
 
 	/* test 02: move backward */
 
-	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &begin);
+	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, begin);
 
-	change = tst_timespec_sub_us(begin, DELTA_US);
+	*change = tst_timespec_sub_us(*begin, DELTA_US);
 
-	if (clock_settime(CLOCK_REALTIME, &change) != 0)
+	if (clock_settime(CLOCK_REALTIME, change) != 0)
 		tst_brk(TBROK | TTERRNO, "could not set realtime change");
 
-	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &end);
+	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, end);
 
-	elapsed = tst_timespec_diff_us(end, begin);
+	elapsed = tst_timespec_diff_us(*end, *begin);
 
 	if (~(elapsed) <= DELTA_US && ~(elapsed) > (DELTA_US - DELTA_EPS))
 		tst_res(TPASS, "clock_settime(2): was able to recede time");
@@ -69,4 +70,10 @@ static struct tst_test test = {
 	.test_all = verify_clock_settime,
 	.needs_root = 1,
 	.restore_wallclock = 1,
+	.bufs = (struct tst_buffers []) {
+		{&begin, .size = sizeof(*begin)},
+		{&change, .size = sizeof(*change)},
+		{&end, .size = sizeof(*end)},
+		{},
+	}
 };
-- 
2.21.0

