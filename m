From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Jul 2019 14:16:00 +0200
Subject: [LTP] [PATCH v1 2/3] timers/timer_settime0{2,
 3}: Ported to new library
In-Reply-To: <20190723070817.637-2-camann@suse.com>
References: <20190723070817.637-1-camann@suse.com>
 <20190723070817.637-2-camann@suse.com>
Message-ID: <20190724121600.GB19478@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor enhancements, thanks.

diff --git a/testcases/kernel/timers/timer_settime/timer_settime02.c b/testcases/kernel/timers/timer_settime/timer_settime02.c
index 36d9a745f..6c431c53d 100644
--- a/testcases/kernel/timers/timer_settime/timer_settime02.c
+++ b/testcases/kernel/timers/timer_settime/timer_settime02.c
@@ -32,15 +32,14 @@ static kernel_timer_t timer;
 static struct testcase {
 	struct itimerspec	*old_ptr;
 	int			it_value_tv_sec;
-	int			it_internal_tv_sec;
-	int			check_clock_gettime;
+	int			it_interval_tv_sec;
 	int			flag;
 	char			*description;
 } tcases[] = {
-	{NULL, 5, 0, 0, 0, "general initialization"},
-	{&old_set, 5, 0, 0, 0, "setting old_value"},
-	{&old_set, 0, 5, 0, 0, "using periodic timer"},
-	{&old_set, 5, 0, 1, TIMER_ABSTIME, "using absolute time"},
+	{NULL,     5, 0, 0, "general initialization"},
+	{&old_set, 5, 0, 0, "setting old_value"},
+	{&old_set, 0, 5, 0, "using periodic timer"},
+	{&old_set, 5, 0, TIMER_ABSTIME, "using absolute time"},
 };
 
 static void run(unsigned int n)
@@ -77,16 +76,16 @@ static void run(unsigned int n)
 		memset(&old_set, 0, sizeof(old_set));
 
 		new_set.it_value.tv_sec = tc->it_value_tv_sec;
-		new_set.it_interval.tv_sec = tc->it_internal_tv_sec;
+		new_set.it_interval.tv_sec = tc->it_interval_tv_sec;
 
-		if (tc->check_clock_gettime) {
+		if (tc->flag & TIMER_ABSTIME) {
 			if (clock_gettime(clock, &timenow) < 0) {
 				tst_res(TBROK,
 					"clock_gettime(%s) failed - skipping the test",
 					get_clock_str(clock));
 				continue;
 			}
-			new_set.it_value.tv_sec = timenow.tv_sec + 25;
+			new_set.it_value.tv_sec += timenow.tv_sec;
 		}
 
 		TEST(tst_syscall(__NR_timer_settime, timer,
diff --git a/testcases/kernel/timers/timer_settime/timer_settime03.c b/testcases/kernel/timers/timer_settime/timer_settime03.c
index 80861995f..bc3a0f2c8 100644
--- a/testcases/kernel/timers/timer_settime/timer_settime03.c
+++ b/testcases/kernel/timers/timer_settime/timer_settime03.c
@@ -26,7 +26,8 @@
 #include "common_timers.h"
 
 static struct itimerspec new_set, old_set;
-static kernel_timer_t timer, timer_inval;
+static kernel_timer_t timer;
+static kernel_timer_t timer_inval = -1;
 
 /* separate description-array to (hopefully) improve readability */
 static const char * const descriptions[] = {
@@ -111,14 +112,8 @@ static void run(unsigned int n)
 	}
 }
 
-static void setup(void)
-{
-	timer_inval = -1;
-}
-
 static struct tst_test test = {
 	.test = run,
 	.needs_root = 1,
 	.tcnt = ARRAY_SIZE(tcases),
-	.setup = setup,
 };

-- 
Cyril Hrubis
chrubis@suse.cz
