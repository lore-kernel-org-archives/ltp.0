From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 May 2017 16:16:58 +0200
Subject: [LTP] [PATCH v2] [RFC] pselect01: Tune thresholds
Message-ID: <20170512141658.26810-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The testcase was failing frequenty on virtual machines where the
thresholds were too tight and also on hardware without specialized timer
units so I've revisited the threshold computation and came with this
model:

The threshold per one syscall is computed as a sum of:

250 us                            - accomodates for context switches, etc.
2 * CLOCK_MONOTONIC resolution    - accomodates for granurality of the CLOCK_MONOTONIC
0.1% of the sleep capped on 100ms - which is slack allowed in kernel

Then it's multiplied by the number of iterations.

For hardware without specialized timer units (TSC, HPET and such) the threshold
is dominated by the CLOCK_MONOTONIC precision which is, depending on CONFIG_HZ,
something between 100ms and 10ms.

If hardware has high resolution timers, short sleeps are dominated by context
switches while longer sleeps are much more dominated by the slack.

And finally this all works only if the number of iterations is high enough, we
can still hit outliners otherwise so we add 1500us to the threshold to
compensate for them.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/pselect/pselect01.c | 67 ++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/pselect/pselect01.c b/testcases/kernel/syscalls/pselect/pselect01.c
index 6f3b77b..4bb1261 100644
--- a/testcases/kernel/syscalls/pselect/pselect01.c
+++ b/testcases/kernel/syscalls/pselect/pselect01.c
@@ -41,14 +41,38 @@ struct tcase {
 	unsigned int iterations;
 };
 
+static unsigned int monotonic_resolution;
+
 static struct tcase tcases[] = {
-	{{1, 0},         1},
-	{{0, 1000000}, 100},
-	{{0, 2000000}, 100},
-	{{0, 10000000}, 10},
-	{{0, 100000000}, 1},
+	{{0, 1000000},  500},
+	{{0, 2000000},  500},
+	{{0, 10000000}, 300},
+	{{0, 100000000},  1},
+	{{1, 0},          1},
 };
 
+#define MIN(a, b) ((a) < (b) ? @ : (b))
+
+/*
+ * The threshold per one syscall is computed as a sum of:
+ *
+ *  250 us                 - accomodates for context switches, etc.
+ *  2*monotonic_resolution - accomodates for granurality of the CLOCK_MONOTONIC
+ *  slack_per_scall        - 0.1% of the sleep capped on 100ms
+ *                           which is slack allowed in kernel
+ *
+ * We also allow for outliners, i.e. add some number to the threshold in case
+ * that the number of iteration is small. For large enoung number of iterations
+ * outliners are averaged out.
+ */
+static int compute_threshold(long long requested_us, unsigned int iterations)
+{
+	unsigned int slack_per_scall = MIN(100000, requested_us / 1000);
+
+	return (250 + 2 * monotonic_resolution + slack_per_scall) * iterations
+		+ (iterations > 1 ? 0 : 1500);
+}
+
 static void verify_pselect(unsigned int n)
 {
 	fd_set readfds;
@@ -62,6 +86,8 @@ static void verify_pselect(unsigned int n)
 			t->tv.tv_sec, t->tv.tv_nsec, t->iterations);
 
 	for (i = 0; i < t->iterations; i++) {
+		long long elapsed_us;
+
 		FD_ZERO(&readfds);
 		FD_SET(0, &readfds);
 
@@ -71,11 +97,26 @@ static void verify_pselect(unsigned int n)
 		pselect(0, &readfds, NULL, NULL, &tv, NULL);
 		tst_timer_stop();
 
-		slept_us += tst_timer_elapsed_us();
+		elapsed_us = tst_timer_elapsed_us();
+
+		if (elapsed_us >= 10 * tst_timespec_to_us(t->tv)
+		    && elapsed_us > 3 * monotonic_resolution) {
+			tst_res(TINFO,
+				"Found outliner took %lli us, expected %lli us",
+				elapsed_us, tst_timespec_to_us(t->tv));
+		}
+
+		slept_us += elapsed_us;
 	}
 
 	requested_us = tst_timespec_to_us(t->tv) * t->iterations;
-	threshold = requested_us / 100 + 200 * t->iterations;
+	threshold = compute_threshold(tst_timespec_to_us(t->tv), t->iterations);
+
+	if (t->iterations > 1) {
+		tst_res(TINFO, "Mean sleep time %.2f us, expected %lli us, threshold %.2f",
+			1.00 * slept_us / t->iterations,
+			tst_timespec_to_us(t->tv), 1.00 * threshold / t->iterations);
+	}
 
 	if (slept_us < requested_us) {
 		tst_res(TFAIL,
@@ -95,8 +136,20 @@ static void verify_pselect(unsigned int n)
 		slept_us, requested_us, threshold);
 }
 
+static void setup(void)
+{
+	struct timespec t;
+
+	clock_getres(CLOCK_MONOTONIC, &t);
+
+	tst_res(TINFO, "CLOCK_MONOTONIC resolution %li ns", (long)t.tv_nsec);
+
+	monotonic_resolution = t.tv_nsec / 1000;
+}
+
 static struct tst_test test = {
 	.tid = "pselect01",
 	.test = verify_pselect,
+	.setup = setup,
 	.tcnt = ARRAY_SIZE(tcases),
 };
-- 
2.10.2

