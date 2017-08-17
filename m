From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Thu, 17 Aug 2017 15:00:25 +0000
Subject: [LTP] [PATCH V3] ltp: Add a zero latency constraint for the timer
	tests library
In-Reply-To: <20170817135029.GA31322@rei>
References: <20170817135029.GA31322@rei>
Message-ID: <1502982026-4113-1-git-send-email-daniel.lezcano@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The ltp test suites provides a set of tests. Some of them are checking the test
happens in a specified amount of time.

Unfortunately, some platforms have slow power management routines adding more
than 1.5ms to wakeup from a deep idle state. This duration is far too long to
be acceptable when we are trying the measure a speficied routine with a timeout
reasonably delayed.

All the timers test measure the deviation between the measured and the expected
timeouts and check the gap is reasonable. A slow platform with the slow idle
states will introduce a latency breaking the tests randomly (eg. when the cpu
freq is low).

More precisely, the following tests fail randomly on a hikey 96board:

-------------------------------------------------
| latency constraint    infinite         0      |
-------------------------------------------------
| nanosleep01           failed          pass    |
-------------------------------------------------
| nanosleep02           pass            pass    |
-------------------------------------------------
| fcntl33               pass            pass    |
-------------------------------------------------
| clock_nanosleep02     failed          pass    |
-------------------------------------------------
| epoll_wait02          failed          pass    |
-------------------------------------------------
| futex_wait0           failed          pass    |
-------------------------------------------------

In order to reduce the impact of the energy framework on the tests, let's
specify a temporary latency constraint by setting the cpu_dma_latency to zero.

The constraint ends when the file descriptor to /dev/cpu_dma_latency is closed,
we let that happen when the process exits.

Note the access to /dev/cpu_dma_latency requires the root privileges. Without
them, the test will run without the latency constraint which is fine for most
of the platforms ltp runs on.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 lib/tst_timer_test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index 7539c62..cd4ebca 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -335,6 +335,17 @@ void do_timer_test(long long usec, unsigned int nsamples)
 
 static void parse_timer_opts(void);
 
+static int set_latency(void)
+{
+        int fd, latency = 0;
+
+        fd = open("/dev/cpu_dma_latency", O_WRONLY);
+        if (fd < 0)
+                return fd;
+
+        return write(fd, &latency, sizeof(latency));
+}
+
 static void timer_setup(void)
 {
 	struct timespec t;
@@ -365,6 +376,9 @@ static void timer_setup(void)
 
 	samples = SAFE_MALLOC(sizeof(long long) * MAX(MAX_SAMPLES, sample_cnt));
 
+	if (set_latency() < 0)
+		tst_res(TINFO, "Failed to set zero latency constraint: %m");
+
 	if (setup)
 		setup();
 }
-- 
2.1.4

