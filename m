From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 19 Mar 2021 09:18:31 +0000
Subject: [LTP] [PATCH v3 1/7] fzsync: Add self tests
In-Reply-To: <20210319091837.27319-1-rpalethorpe@suse.com>
References: <20210319091837.27319-1-rpalethorpe@suse.com>
Message-ID: <20210319091837.27319-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add validation tests for the Fuzzy Sync library. They have a range of
data races which Fuzzy Sync must reproduce. This is much easier to
setup and run than reproducing real kernel bugs.

We don't explicitly cover races where there is a large amount of
volatility in the timings. This can be simulated by running the tests
in parallel. However it is not really a concern as a high level of
volatility should make the delay phase redundant.

We also don't cover every possible combination of parameters. We test
every unique category of race as identified by the order of critical
sections. Additionally we test variations to the timings, but not much
more.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/newlib_tests/.gitignore         |   2 +
 lib/newlib_tests/Makefile           |   2 +
 lib/newlib_tests/test16.c           |   2 +
 lib/newlib_tests/tst_fuzzy_sync01.c | 232 ++++++++++++++++++++++++++++
 lib/newlib_tests/tst_fuzzy_sync02.c | 179 +++++++++++++++++++++
 5 files changed, 417 insertions(+)
 create mode 100644 lib/newlib_tests/tst_fuzzy_sync01.c
 create mode 100644 lib/newlib_tests/tst_fuzzy_sync02.c

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 6c2612259..bebecad8b 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -40,3 +40,5 @@ tst_bool_expr
 test_macros01
 test_macros02
 test_macros03
+tst_fuzzy_sync01
+tst_fuzzy_sync02
diff --git a/lib/newlib_tests/Makefile b/lib/newlib_tests/Makefile
index 2fc50160a..7acdd1ff7 100644
--- a/lib/newlib_tests/Makefile
+++ b/lib/newlib_tests/Makefile
@@ -11,6 +11,8 @@ test15: CFLAGS+=-pthread
 test16: CFLAGS+=-pthread
 test16: LDLIBS+=-lrt
 tst_expiration_timer: LDLIBS+=-lrt
+tst_fuzzy_sync01: CFLAGS+=-pthread
+tst_fuzzy_sync02: CFLAGS+=-pthread
 
 ifeq ($(ANDROID),1)
 FILTER_OUT_MAKE_TARGETS	+= test08
diff --git a/lib/newlib_tests/test16.c b/lib/newlib_tests/test16.c
index 0d74e1eae..7a9b5f20e 100644
--- a/lib/newlib_tests/test16.c
+++ b/lib/newlib_tests/test16.c
@@ -9,6 +9,8 @@
  * which they should take it in turns to update.
  */
 
+#define _GNU_SOURCE
+
 #include <stdlib.h>
 #include "tst_test.h"
 #include "tst_safe_pthread.h"
diff --git a/lib/newlib_tests/tst_fuzzy_sync01.c b/lib/newlib_tests/tst_fuzzy_sync01.c
new file mode 100644
index 000000000..8db102bdc
--- /dev/null
+++ b/lib/newlib_tests/tst_fuzzy_sync01.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Richard Palethorpe <rpalethorpe@suse.com>
+ */
+/*\
+ * [DESCRIPTION]
+ *
+ * This verifies Fuzzy Sync's basic ability to reproduce a particular
+ * outcome to a data race when the critical sections are not aligned.
+ *
+ * We make the simplifying assumptions that:
+ * - Each thread contains a single contiguous critical section.
+ * - The threads only interact through a single variable.
+ * - The various timings are constant except for variations introduced
+ *   by the environment.
+ *
+ * If a single data race has N critical sections then we may remove
+ * N-1 sections to produce a more difficult race. We may then test
+ * only the more difficult race and induce from this the outcome of
+ * testing the easier races.
+ *
+ * In real code, the threads may interact through many side
+ * effects. While some of these side effects may not result in a bug,
+ * they may effect the total time it takes to execute either
+ * thread. This will be handled in tst_fuzzy_sync02.
+ *
+ * The number of variables which two threads interact through is
+ * irrelevant as the combined state of two variables can be
+ * represented with a single variable. We may also reduce the number
+ * of states to simply those required to show the thread is inside or
+ * outside of the critical section.
+ *
+ * There are two fundamental races which require alignment under these
+ * assumptions:
+ *      1        2
+ * A +-----+  +----+	The outer box is total execution time.
+ *   | #   |  | #  |	The '#' is the critical section.
+ *
+ *   |  # |   |   # |
+ * B +----+   +-----+
+ *
+ * So we can either have the critical section of the shorter race
+ * before that of the longer one. Or the critical section of the
+ * longer one before the shorter.
+ *
+ * In reality both threads will never be the same length, but we can
+ * test that anyway. We also test with both A as the shorter and B as
+ * the shorter. We also vary the distance of the critical section from
+ * the start or end. The delay times are cubed to ensure that a delay
+ * range is required.
+ *
+ * When entering their critical sections, both threads increment the
+ * 'c' counter variable atomically. They both also increment it when
+ * leaving their critical sections. We record the value of 'c' when A
+ * increments it. From the recorded values of 'c' we can deduce if the
+ * critical sections overlap and their ordering.
+ *
+ * 	Start (cs)	| End (ct)	| Ordering
+ * 	--------------------------------------------
+ * 	1		| 2		| A before B
+ * 	3		| 4		| B before A
+ *
+ * Any other combination of 'cs' and 'ct' means the critical sections
+ * overlapped.
+\*/
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "tst_fuzzy_sync.h"
+
+#define TIME_SCALE(x) ((x) * (x) * (x))
+
+/* The time signature of a code path containing a critical section. */
+struct window {
+	/* The delay until the start of the critical section */
+	const int critical_s;
+	/* The length of the critical section */
+	const int critical_t;
+	/* The remaining delay until the method returns */
+	const int return_t;
+};
+
+/* The time signatures of threads A and B */
+struct race {
+	const struct window a;
+	const struct window b;
+};
+
+static int c;
+static struct tst_fzsync_pair pair;
+
+static const struct race races[] = {
+	/* Degnerate cases where the critical sections are already
+	 * aligned. The first case will fail when ncpu < 2 as a yield
+	 * inside the critical section is required for the other
+	 * thread to run.
+	 */
+	{ .a = { 0, 0, 0 }, .b = { 0, 0, 0 } },
+	{ .a = { 0, 1, 0 }, .b = { 0, 1, 0 } },
+	{ .a = { 1, 1, 1 }, .b = { 1, 1, 1 } },
+	{ .a = { 3, 1, 1 }, .b = { 3, 1, 1 } },
+
+	/* Both windows are the same length */
+	{ .a = { 3, 1, 1 }, .b = { 1, 1, 3 } },
+	{ .a = { 1, 1, 3 }, .b = { 3, 1, 1 } },
+
+	/* Different sized windows */
+	{ .a = { 3, 1, 1 }, .b = { 1, 1, 2 } },
+	{ .a = { 1, 1, 3 }, .b = { 2, 1, 1 } },
+	{ .a = { 2, 1, 1 }, .b = { 1, 1, 3 } },
+	{ .a = { 1, 1, 2 }, .b = { 3, 1, 1 } },
+
+	/* Same as above, but with critical section@entry or exit */
+	{ .a = { 3, 1, 0 }, .b = { 0, 1, 3 } },
+	{ .a = { 0, 1, 3 }, .b = { 3, 1, 0 } },
+
+	{ .a = { 3, 1, 0 }, .b = { 0, 1, 2 } },
+	{ .a = { 0, 1, 3 }, .b = { 2, 1, 0 } },
+	{ .a = { 2, 1, 0 }, .b = { 0, 1, 3 } },
+	{ .a = { 0, 1, 2 }, .b = { 3, 1, 0 } },
+
+	/* One side is very short */
+	{ .a = { 3, 1, 1 }, .b = { 0, 1, 0 } },
+	{ .a = { 1, 1, 3 }, .b = { 0, 1, 0 } },
+	{ .a = { 0, 1, 0 }, .b = { 1, 1, 3 } },
+	{ .a = { 0, 1, 0 }, .b = { 3, 1, 1 } },
+
+	{ .a = { 3, 1, 1 }, .b = { 0, 0, 0 } },
+	{ .a = { 1, 1, 3 }, .b = { 0, 0, 0 } },
+	{ .a = { 0, 0, 0 }, .b = { 1, 1, 3 } },
+	{ .a = { 0, 0, 0 }, .b = { 3, 1, 1 } },
+
+};
+
+static void cleanup(void)
+{
+	tst_fzsync_pair_cleanup(&pair);
+}
+
+static void setup(void)
+{
+	pair.min_samples = 10000;
+
+	tst_fzsync_pair_init(&pair);
+}
+
+static void delay(const int t)
+{
+	int k = TIME_SCALE(t);
+
+	while (k--)
+		sched_yield();
+}
+
+static void *worker(void *v)
+{
+	unsigned int i = *(unsigned int *)v;
+	const struct window b = races[i].b;
+
+	while (tst_fzsync_run_b(&pair)) {
+		if (tst_atomic_load(&c))
+			tst_brk(TBROK, "Counter should now be zero");
+
+		tst_fzsync_start_race_b(&pair);
+		delay(b.critical_s);
+
+		tst_atomic_add_return(1, &c);
+		delay(b.critical_t);
+		tst_atomic_add_return(1, &c);
+
+		delay(b.return_t);
+		tst_fzsync_end_race_b(&pair);
+	}
+
+	return NULL;
+}
+
+static void run(unsigned int i)
+{
+	const struct window a = races[i].a;
+	struct tst_fzsync_run_thread wrap_run_b = {
+		.func = worker,
+		.arg = &i,
+	};
+	int cs, ct, r, too_early = 0, critical = 0, too_late = 0;
+
+	tst_fzsync_pair_reset(&pair, NULL);
+	SAFE_PTHREAD_CREATE(&pair.thread_b, 0, tst_fzsync_thread_wrapper,
+			    &wrap_run_b);
+
+	while (tst_fzsync_run_a(&pair)) {
+
+		tst_fzsync_start_race_a(&pair);
+		delay(a.critical_s);
+
+		cs = tst_atomic_add_return(1, &c);
+		delay(a.critical_t);
+		ct = tst_atomic_add_return(1, &c);
+
+		delay(a.return_t);
+		tst_fzsync_end_race_a(&pair);
+
+		if (cs == 1 && ct == 2)
+			too_early++;
+		else if (cs == 3 && ct == 4)
+			too_late++;
+		else
+			critical++;
+
+		r = tst_atomic_add_return(-4, &c);
+		if (r)
+			tst_brk(TBROK, "cs = %d, ct = %d, r = %d", cs, ct, r);
+
+		if (critical > 100) {
+			tst_fzsync_pair_cleanup(&pair);
+			break;
+		}
+	}
+
+	tst_res(critical > 50 ? TPASS : TFAIL,
+		"cs:%-2d ct:%-2d rt:%-2d | =:%-4d -:%-4d +:%-4d",
+		a.critical_s, a.critical_t, a.return_t,
+		critical, too_early, too_late);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(races),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};
diff --git a/lib/newlib_tests/tst_fuzzy_sync02.c b/lib/newlib_tests/tst_fuzzy_sync02.c
new file mode 100644
index 000000000..22ac539b5
--- /dev/null
+++ b/lib/newlib_tests/tst_fuzzy_sync02.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Richard Palethorpe <rpalethorpe@suse.com>
+ */
+/*\
+ * [DESCRIPTION]
+ *
+ * This verifies Fuzzy Sync's ability to reproduce a particular
+ * outcome to a data race when multiple races are present.
+ *
+ * We make the simplifying assumptions that:
+ * - There is one data race we want to hit and one to avoid.
+ * - Each thread contains two contiguous critical sections. One for each race.
+ * - The threads only interact through two variables, one for each race.
+ * - If we hit the race we want to avoid then it causes thread A to exit early.
+ *
+ * We don't consider more complicated dynamic interactions between the
+ * two threads. Fuzzy Sync will eventually trigger a race so long as
+ * the delay range is large enough. Assuming the race is possible to
+ * reproduce without further tampering to increase the race window (a
+ * technique specific to each race). So I conject that beyond a lower
+ * threshold of complexity, increasing the complexity of the race is
+ * no different from adding random noise.
+ *
+ * Emperically this appears to be true. So far we have seen in
+ * reproducers that there are no more than two significant data
+ * races. One we wish to reproduce and one we wish to avoid. It is
+ * possible that the code contains multiple data races, but that they
+ * appear only as two to us.
+ *
+ * Indeed it is also only possible to add a delay to A or B. So
+ * regardless of the underlying complexity we really only have two
+ * options.
+ *
+ * Here we only test a bias to delay B. A delay of A would be
+ * identical except that the necessary delay bias would be negative.
+ *
+\*/
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "tst_fuzzy_sync.h"
+
+/* The time signature of a code path containing a critical section. */
+struct window {
+	/* The delay until the start of the critical section */
+	const int critical_s;
+	/* The length of the critical section */
+	const int critical_t;
+	/* The remaining delay until the method returns */
+	const int return_t;
+};
+
+/* The time signatures of threads A and B. We interlace the two
+ * windows for each thread. bd.return_t is ignored, but ad.return_t is
+ * used instead of a.return_t if the ad and bd critical sections
+ * overlap. This may result in the critical section of a never being
+ * reached.
+ */
+struct race {
+	const struct window ad;
+	const struct window a;
+	const struct window bd;
+	const struct window b;
+};
+
+static int c, d;
+static struct tst_fzsync_pair pair;
+
+static const struct race races[] = {
+	{ .a =  { 1, 1, 1 }, .b =  { 1, 1, 1 },
+	  .ad = { 0, 1, 0 }, .bd = { 0, 1, 0 } },
+	{ .a =  { 30, 1, 1 }, .b =  { 1, 1,  1 },
+	  .ad = { 0,  1, 0 }, .bd = { 0, 20, 0 } },
+	{ .a =  { 40, 1,  0 }, .b =  { 1, 1,  20 },
+	  .ad = { 1,  10, 0 }, .bd = { 1, 10, 0 } },
+};
+
+static void cleanup(void)
+{
+	tst_fzsync_pair_cleanup(&pair);
+}
+
+static void setup(void)
+{
+	pair.min_samples = 10000;
+
+	tst_fzsync_pair_init(&pair);
+}
+
+static struct window to_abs(const struct window w)
+{
+	const struct window wc = {
+		w.critical_s,
+		w.critical_s + w.critical_t,
+		w.critical_s + w.critical_t + w.return_t,
+	};
+
+	return wc;
+}
+
+static void *worker(void *v)
+{
+	unsigned int i = *(unsigned int *)v;
+	const struct window b = to_abs(races[i].b);
+	const struct window bd = to_abs(races[i].bd);
+	int now, fin = MAX(b.return_t, bd.return_t);
+
+	while (tst_fzsync_run_b(&pair)) {
+		tst_fzsync_start_race_b(&pair);
+		for (now = 0; now <= fin; now++) {
+			if (now == b.critical_s || now == b.critical_t)
+				tst_atomic_add_return(1, &c);
+			if (now == bd.critical_s || now == bd.critical_t)
+				tst_atomic_add_return(1, &d);
+
+			sched_yield();
+		}
+		tst_fzsync_end_race_b(&pair);
+	}
+
+	return NULL;
+}
+
+static void run(unsigned int i)
+{
+	const struct window a = to_abs(races[i].a);
+	const struct window ad = to_abs(races[i].ad);
+	struct tst_fzsync_run_thread wrap_run_b = {
+		.func = worker,
+		.arg = &i,
+	};
+	int critical = 0;
+	int now, fin;
+
+	tst_fzsync_pair_reset(&pair, NULL);
+	SAFE_PTHREAD_CREATE(&pair.thread_b, 0, tst_fzsync_thread_wrapper,
+			    &wrap_run_b);
+
+	while (tst_fzsync_run_a(&pair)) {
+		c = 0;
+		d = 0;
+		fin = a.return_t;
+
+		tst_fzsync_start_race_a(&pair);
+		for (now = 0; now <= fin; now++) {
+			if (now >= ad.critical_s &&
+			    now <= ad.critical_t && tst_atomic_load(&d) > 0)
+				fin = ad.return_t;
+
+			if (now >= a.critical_s &&
+			    now <= a.critical_t && tst_atomic_load(&c) == 1) {
+				tst_atomic_add_return(1, &c);
+				critical++;
+			}
+
+			sched_yield();
+		}
+		tst_fzsync_end_race_a(&pair);
+
+		if (fin == ad.return_t)
+			tst_fzsync_pair_add_bias(&pair, 1);
+
+		if (critical > 100) {
+			tst_fzsync_pair_cleanup(&pair);
+			break;
+		}
+	}
+
+	tst_res(critical > 50 ? TPASS : TFAIL, "%d| =:%-4d", i, critical);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(races),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.30.1

