From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 21 Feb 2020 12:50:33 +0100
Subject: [LTP] [PATCH] syscalls/timerfd01: Port to new library & cleanup
In-Reply-To: <20200115155156.5891-1-jcronenberg@suse.de>
References: <20200115155156.5891-1-jcronenberg@suse.de>
Message-ID: <20200221115033.GB24332@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Nice cleanup, I've added a few more assertions and pushed, thanks.

My changes were:

diff --git a/testcases/kernel/syscalls/timerfd/timerfd01.c b/testcases/kernel/syscalls/timerfd/timerfd01.c
index 6d17357f1..af19b4399 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd01.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd01.c
@@ -18,6 +18,7 @@
 #define _GNU_SOURCE
 #include <poll.h>
 #include "tst_test.h"
+#include "tst_timer.h"
 #include "lapi/timerfd.h"
 
 static struct tcase {
@@ -40,30 +41,25 @@ static unsigned long long getustime(int clockid)
 	return 1000000ULL * tp.tv_sec + tp.tv_nsec / 1000;
 }
 
-static void set_timespec(struct timespec *tmr, unsigned long long ustime)
-{
-	tmr->tv_sec = (time_t) (ustime / 1000000ULL);
-	tmr->tv_nsec = (long)(1000ULL * (ustime % 1000000ULL));
-}
-
 static void settime(int tfd, struct itimerspec *tmr, int tflags,
-	unsigned long long tvalue, int tinterval)
+                    unsigned long long tvalue, int tinterval)
 {
-	set_timespec(&tmr->it_value, tvalue);
-	set_timespec(&tmr->it_interval, tinterval);
+	tmr->it_value = tst_us_to_timespec(tvalue);
+	tmr->it_interval = tst_us_to_timespec(tinterval);
+
 	if (timerfd_settime(tfd, tflags, tmr, NULL))
-		tst_brk(TFAIL | TERRNO, "timerfd_settime() failed");
+		tst_brk(TBROK | TERRNO, "timerfd_settime() failed");
 }
 
-static void waittmr(int tfd, int timeo)
+static void waittmr(int tfd, unsigned int exp_ticks)
 {
-	u_int64_t ticks;
+	uint64_t ticks;
 	struct pollfd pfd;
 
 	pfd.fd = tfd;
 	pfd.events = POLLIN;
 	pfd.revents = 0;
-	if (poll(&pfd, 1, timeo) < 0) {
+	if (poll(&pfd, 1, -1) < 0) {
 		tst_res(TFAIL | TERRNO, "poll() failed");
 		return;
 	}
@@ -73,48 +69,58 @@ static void waittmr(int tfd, int timeo)
 	}
 	SAFE_READ(0, tfd, &ticks, sizeof(ticks));
 
-	if (ticks <= 0)
-		tst_res(TFAIL, "got no timer");
+	if (ticks != exp_ticks) {
+		tst_res(TFAIL, "got %u tick(s) expected %u",
+		        (unsigned int)ticks, exp_ticks);
+	} else {
+		tst_res(TPASS, "got %u tick(s)", exp_ticks);
+	}
 }
 
 static void run(unsigned int n)
 {
 	int tfd;
 	unsigned long long tnow;
-	u_int64_t uticks;
+	uint64_t uticks;
 	struct itimerspec tmr;
 	struct tcase *clks = &tcases[n];
 
-	if (TFD_TIMER_ABSTIME == 0)
-		tst_brk(TCONF, "Test not suited for this system");
-
 	tst_res(TINFO, "testing %s", clks->name);
 
 	tfd = timerfd_create(clks->id, 0);
 	if (tfd == -1)
 		tst_brk(TFAIL | TERRNO, "timerfd_create() failed");
 
-	tst_res(TINFO, "relative timer (500 ms)");
-	settime(tfd, &tmr, 0, 500 * 1000, 0);
-	waittmr(tfd, -1);
+	tst_res(TINFO, "relative timer (100 ms)");
+	settime(tfd, &tmr, 0, 100 * 1000, 0);
+	waittmr(tfd, 1);
 
-	tst_res(TINFO, "absolute timer (500 ms)");
+	tst_res(TINFO, "absolute timer (100 ms)");
 	tnow = getustime(clks->id);
-	settime(tfd, &tmr, TFD_TIMER_ABSTIME, tnow + 500 * 1000, 0);
-	waittmr(tfd, -1);
+	settime(tfd, &tmr, TFD_TIMER_ABSTIME, tnow + 100 * 1000, 0);
+	waittmr(tfd, 1);
 
-	tst_res(TINFO, "sequential timer (100 ms)");
+	tst_res(TINFO, "sequential timer (50 ms)");
 	tnow = getustime(clks->id);
-	settime(tfd, &tmr, TFD_TIMER_ABSTIME, tnow + 100 * 1000, 100 * 1000);
+	settime(tfd, &tmr, TFD_TIMER_ABSTIME, tnow + 50 * 1000, 50 * 1000);
 
+	memset(&tmr, 0, sizeof(tmr));
 	if (timerfd_gettime(tfd, &tmr))
 		tst_res(TFAIL | TERRNO, "timerfd_gettime() failed");
 
-	waittmr(tfd, -1);
+
+	if (tmr.it_value.tv_sec != 0 || tmr.it_value.tv_nsec > 50 * 1000000)
+		tst_res(TFAIL, "Timer read back value not relative");
+	else
+		tst_res(TPASS, "Timer read back value is relative");
+
+	usleep(160000);
+
+	waittmr(tfd, 3);
 
 	tst_res(TINFO, "testing with O_NONBLOCK");
 	settime(tfd, &tmr, 0, 100 * 1000, 0);
-	waittmr(tfd, -1);
+	waittmr(tfd, 1);
 
 	SAFE_FCNTL(tfd, F_SETFL, fcntl(tfd, F_GETFL, 0) | O_NONBLOCK);
 
@@ -122,13 +128,11 @@ static void run(unsigned int n)
 	if (TST_RET > 0)
 		tst_res(TFAIL, "timer ticks not zero");
 	else if (TST_ERR != EAGAIN)
-		tst_res(TFAIL | TERRNO, "expected errno EAGAIN got");
+		tst_res(TFAIL | TERRNO, "read should fail with EAGAIN got");
 	else
-		tst_res(TPASS, "Passed test %s", clks->name);
+		tst_res(TPASS | TERRNO, "read failed with");
 
-	SAFE_FCNTL(tfd, F_SETFL, fcntl(tfd, F_GETFL, 0) & ~O_NONBLOCK);
 	SAFE_CLOSE(tfd);
-
 }
 
 static struct tst_test test = {

-- 
Cyril Hrubis
chrubis@suse.cz
