From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri,  5 May 2017 15:18:55 +0200
Subject: [LTP] [RFC] [PATCH] pselect01: Tune thresholds
Message-ID: <20170505131855.32545-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The testcase was failing frequenty on virtual machines where the
thresholds were too tight so I've revisited the threshold computation
and came with this model:

The kernel timers are allowed to slack for 0.1% of the sleep time capped
at 100ms we add 40us to this number to accomodate for context switches,
etc. and multiply the number by the number of iterations. This works
fine when the number of iterations is large enough (> 400) where the
outliners are averaged out, but the test was still failing rarely when
we hit outliner when the number of iterations was relatively small. The
solution is to add an arbitrary number divided by the number of
iterations to the threshold so that the thresholds for large enough
number of iterations are not affected.

We should probably also tune the thresholds separately for virtual
machines and for real hardware and maybe we should also put this piece
of code into the test library so that it could be easily reused in all
testcases that are measuring calls that can sleep in kernel. I will look
into this later once we are done with the release and the git is open
not only to important fixes.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/pselect/pselect01.c | 51 +++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/pselect/pselect01.c b/testcases/kernel/syscalls/pselect/pselect01.c
index 6f3b77b..a544ae5 100644
--- a/testcases/kernel/syscalls/pselect/pselect01.c
+++ b/testcases/kernel/syscalls/pselect/pselect01.c
@@ -42,13 +42,34 @@ struct tcase {
 };
 
 static struct tcase tcases[] = {
-	{{1, 0},         1},
-	{{0, 1000000}, 100},
-	{{0, 2000000}, 100},
-	{{0, 10000000}, 10},
-	{{0, 100000000}, 1},
+	{{0, 1000000},  800},
+	{{0, 2000000},  500},
+	{{0, 10000000}, 100},
+	{{0, 100000000},  1},
+	{{1, 0},          1},
 };
 
+#define MIN(a, b) ((a) < (b) ? @ : (b))
+
+/*
+ * The threshold is computed as 0.1% of the runtime capped@100ms (which is
+ * what what kernel timers are allowed to slack off) + 40us to accomodate for
+ * context switches, etc. multiplied by the number of iterations.
+ *
+ * We also allow for outliners, i.e. add some number to the threshold in case
+ * that the number of iteration is small. For large enoung number of iterations
+ * outliners are averaged out.
+ *
+ * With this the test can pass reliably even on virtual machine with the host
+ * under heavy CPU load.
+ */
+static int compute_threshold(long long requested_us, unsigned int iterations)
+{
+	unsigned int slack_per_run = MIN(100000, requested_us / 1000);
+
+	return (40 + slack_per_run) * iterations + 20000 / (iterations/200 + 1);
+}
+
 static void verify_pselect(unsigned int n)
 {
 	fd_set readfds;
@@ -62,6 +83,8 @@ static void verify_pselect(unsigned int n)
 			t->tv.tv_sec, t->tv.tv_nsec, t->iterations);
 
 	for (i = 0; i < t->iterations; i++) {
+		long long elapsed_us;
+
 		FD_ZERO(&readfds);
 		FD_SET(0, &readfds);
 
@@ -71,11 +94,25 @@ static void verify_pselect(unsigned int n)
 		pselect(0, &readfds, NULL, NULL, &tv, NULL);
 		tst_timer_stop();
 
-		slept_us += tst_timer_elapsed_us();
+		elapsed_us = tst_timer_elapsed_us();
+
+		if (elapsed_us >= 10 * tst_timespec_to_us(t->tv)) {
+			tst_res(TINFO,
+				"Found outliner took %lli us, expected %lli us",
+				elapsed_us, tst_timespec_to_us(t->tv));
+		}
+
+		slept_us += elapsed_us;
 	}
 
 	requested_us = tst_timespec_to_us(t->tv) * t->iterations;
-	threshold = requested_us / 100 + 200 * t->iterations;
+	threshold = compute_threshold(requested_us, t->iterations);
+
+	if (t->iterations > 1) {
+		tst_res(TINFO, "Mean sleep time %.2f us, expected %lli us, threshold %.2f",
+			1.00 * slept_us / t->iterations,
+			tst_timespec_to_us(t->tv), 1.00 * threshold / t->iterations);
+	}
 
 	if (slept_us < requested_us) {
 		tst_res(TFAIL,
-- 
2.10.2

