From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 May 2017 14:33:54 +0200
Subject: [LTP] [RFC] [PATCH] syscalls: Add timer measurement library
Message-ID: <20170526123354.8564-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commit adds a timer measurement library, mostly based on changes
done to the pselect01.c test and changes all tests that measure timer
precision to use it.

The timer testcases that measure timeouts now just define sampling function and
optional setup and cleanup. The rest of the functionality is implemented in the
lib/tst_timer_test.c library. This change not only removes fair amount of
duplicated code but also allows us to tune thresholds and define testcases in a
single place for all testcases.

The timer measurement library also supports for passing sleep time and
number of iterations as a command-line parameters, can print nifty
frequency plot into the terminal, as well as save test measurements into
a text file.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_timer.h                                |  26 ++
 include/tst_timer_test.h                           |  74 ++++
 lib/tst_timer_test.c                               | 434 +++++++++++++++++++++
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 .../syscalls/clock_nanosleep/clock_nanosleep01.c   |  67 +---
 .../syscalls/clock_nanosleep/clock_nanosleep02.c   |  49 +++
 .../kernel/syscalls/epoll_wait/epoll_wait02.c      | 125 ++----
 testcases/kernel/syscalls/futex/futex_wait05.c     |  61 +--
 testcases/kernel/syscalls/nanosleep/nanosleep01.c  |  56 +--
 testcases/kernel/syscalls/poll/poll02.c            | 104 ++---
 testcases/kernel/syscalls/pselect/pselect01.c      | 161 ++------
 testcases/kernel/syscalls/select/select04.c        | 103 ++---
 13 files changed, 746 insertions(+), 516 deletions(-)
 create mode 100644 include/tst_timer_test.h
 create mode 100644 lib/tst_timer_test.c
 create mode 100644 testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c

diff --git a/include/tst_timer.h b/include/tst_timer.h
index f0a10bd45..0448f4428 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -77,6 +77,32 @@ static inline struct timeval tst_us_to_timeval(long long us)
 }
 
 /*
+ * Converts ms to struct timespec
+ */
+static inline struct timespec tst_ms_to_timespec(long long us)
+{
+	struct timespec ret;
+
+	ret.tv_sec = us / 1000;
+	ret.tv_nsec = (us % 1000) * 1000000;
+
+	return ret;
+}
+
+/*
+ * Converts us to struct timespec
+ */
+static inline struct timespec tst_us_to_timespec(long long us)
+{
+	struct timespec ret;
+
+	ret.tv_sec = us / 1000000;
+	ret.tv_nsec = (us % 1000000) * 1000;
+
+	return ret;
+}
+
+/*
  * Comparsions
  */
 static inline int tst_timespec_lt(struct timespec t1, struct timespec t2)
diff --git a/include/tst_timer_test.h b/include/tst_timer_test.h
new file mode 100644
index 000000000..eab00fb7c
--- /dev/null
+++ b/include/tst_timer_test.h
@@ -0,0 +1,74 @@
+/*
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+ /*
+
+    Timer measuring library.
+
+    The test is supposed to define sampling function and fill in tst_time_test
+    structure the rest of the work is then done by the library.
+
+    int sample(int clk_id, long long usec)
+    {
+	// Any setup done here
+
+	tst_timer_start(clk_id);
+	// Call that is being measured sleeps for usec
+	tst_timer_stop();
+	tst_timer_sample();
+
+	// Any cleanup done here
+
+	// Non-zero return exits the test
+    }
+
+    struct tst_timer_test timer_test = {
+	.scall = "syscall_name()",
+	.sample_fn = sample,
+    };
+
+  */
+
+#ifndef TST_TIMER_TEST__
+#define TST_TIMER_TEST__
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_timer.h"
+
+void tst_timer_sample(void);
+
+struct tst_timer_test {
+	const char *scall;
+	int (*sample)(int clk_id, long long usec);
+	void (*setup)(void);
+	void (*cleanup)(void);
+};
+
+void tst_run_timer_tcases(int argc, char *argv[],
+			  struct tst_timer_test *ttest);
+
+# ifndef TST_NO_DEFAULT_TIMER_MAIN
+
+static struct tst_timer_test timer_test;
+
+int main(int argc, char *argv[])
+{
+	tst_run_timer_tcases(argc, argv, &timer_test);
+}
+# endif /* TST_NO_DEFAULT_TIMER_MAIN */
+#endif /* TST_TIMER_TEST__ */
diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
new file mode 100644
index 000000000..7566180c3
--- /dev/null
+++ b/lib/tst_timer_test.c
@@ -0,0 +1,434 @@
+/*
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <sys/prctl.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <limits.h>
+
+#define TST_NO_DEFAULT_TIMER_MAIN
+#include "tst_timer_test.h"
+
+#define MAX_SAMPLES 500
+
+static struct tst_timer_test *timer_test;
+static long long *samples;
+static unsigned int cur_sample;
+static unsigned int monotonic_resolution;
+static unsigned int timerslack;
+
+static char *print_frequency_plot;
+static char *file_name;
+static char *str_sleep_time;
+static char *str_sample_cnt;
+static int sleep_time = -1;
+static int sample_cnt;
+
+static void print_line(char c, int len)
+{
+	while (len-- > 0)
+		fputc(c, stderr);
+}
+
+static unsigned int ceilu(float f)
+{
+	if (f - (int)f > 0)
+		return (unsigned int)f + 1;
+
+	return (unsigned int)f;
+}
+
+static unsigned int flooru(float f)
+{
+	return (unsigned int)f;
+}
+
+static float bucket_len(unsigned int bucket, unsigned int max_bucket,
+		        unsigned int cols)
+{
+	return 1.00 * bucket * cols / max_bucket;
+}
+
+static const char *table_heading = " Time: us ";
+
+/*
+ * Line Header: '10023 | '
+ */
+static unsigned int header_len(long long max_sample)
+{
+	unsigned int l = 1;
+
+	while (max_sample/=10)
+		l++;
+
+	return MAX(strlen(table_heading) + 2, l + 3);
+}
+
+static void frequency_plot(void)
+{
+	unsigned int cols = 80;
+	unsigned int rows = 20;
+	unsigned int i, buckets[rows];
+	long long max_sample = samples[0];
+	long long min_sample = samples[cur_sample-1];
+	unsigned int line_header_len = header_len(max_sample);
+	unsigned int plot_line_len = cols - line_header_len;
+	unsigned int bucket_size;
+
+	memset(buckets, 0, sizeof(buckets));
+
+	/*
+	 * We work with discrete data buckets smaller than 1 does not make
+	 * sense as well as it's a good idea to keep buckets integer sized
+	 * to avoid scaling artifacts.
+	 */
+	bucket_size = MAX(1u, ceilu(1.00 * (max_sample - min_sample)/(rows-1)));
+
+	for (i = 0; i < cur_sample; i++) {
+		unsigned int bucket;
+		bucket = flooru(1.00 * (samples[i] - min_sample)/bucket_size);
+		buckets[bucket]++;
+	}
+
+	unsigned int max_bucket = buckets[0];
+	for (i = 1; i < rows; i++)
+		max_bucket = MAX(max_bucket, buckets[i]);
+
+	fprintf(stderr, "\n%*s| Frequency\n", line_header_len - 2, table_heading);
+
+	print_line('-', cols);
+	fputc('\n', stderr);
+
+	unsigned int l, r;
+
+	for (l = 0; l < rows; l++) {
+		if (buckets[l])
+			break;
+	}
+
+	for (r = rows-1; r > l; r--) {
+		if (buckets[r])
+			break;
+	}
+
+	for (i = l; i <= r; i++) {
+		float len = bucket_len(buckets[i], max_bucket, plot_line_len);
+
+		fprintf(stderr, "%*lli | ",
+			line_header_len - 3, min_sample + bucket_size*i);
+		print_line('*', len);
+
+		if ((len - (int)len) >= 0.5)
+			fputc('+', stderr);
+		else if ((len - (int)len) >= 0.25)
+			fputc('-', stderr);
+		else if (len < 0.25 && buckets[i])
+			fputc('.', stderr);
+
+		fputc('\n', stderr);
+	}
+
+	print_line('-', cols);
+	fputc('\n', stderr);
+
+	float scale = 1.00 * plot_line_len / max_bucket;
+
+	fprintf(stderr,
+		"%*uus | 1 sample = %.5f '*', %.5f '+', %.5f '-', non-zero '.'\n",
+		line_header_len - 5, bucket_size, scale, scale * 2, scale * 4);
+
+	fputc('\n', stderr);
+}
+
+void tst_timer_sample(void)
+{
+	samples[cur_sample++] = tst_timer_elapsed_us();
+}
+
+static int cmp(const void *a, const void *b)
+{
+	const long long *aa = a, *bb = b;
+
+	return *aa < *bb;
+}
+
+/*
+ * The threshold per one syscall is computed as a sum of:
+ *
+ *  250 us                 - accomodates for context switches, etc.
+ *  2*monotonic_resolution - accomodates for granurality of the CLOCK_MONOTONIC
+ *  slack_per_scall        - max of 0.1% of the sleep capped on 100ms or
+ *                           current->timer_slack_ns, which is slack allowed
+ *                           in kernel
+ *
+ * We also allow for outliners, i.e. add some number to the threshold in case
+ * that the number of iteration is small. For large enoung number of iterations
+ * outliners are discarded and averaged out.
+ */
+static long long compute_threshold(long long requested_us,
+				   unsigned int nsamples)
+{
+	unsigned int slack_per_scall = MIN(100000, requested_us / 1000);
+
+	slack_per_scall = MAX(slack_per_scall, timerslack);
+
+	return (250 + 2 * monotonic_resolution + slack_per_scall) * nsamples
+		+ 3000/nsamples;
+}
+
+/*
+ * Returns number of samples to discard.
+ *
+ * We set it to either at least 1 if number of samples > 1 or 5%.
+ */
+static unsigned int compute_discard(unsigned int nsamples)
+{
+	if (nsamples == 1)
+		return 0;
+
+	return MAX(1u, nsamples / 20);
+}
+
+static void write_to_file(void)
+{
+	unsigned int i;
+	FILE *f;
+
+	if (!file_name)
+		return;
+
+	f = fopen(file_name, "w");
+
+	if (!f) {
+		tst_res(TWARN | TERRNO,
+			"Failed to open '%s'", file_name);
+		return;
+	}
+
+	for (i = 0; i < cur_sample; i++)
+		fprintf(f, "%lli\n", samples[i]);
+
+	if (fclose(f)) {
+		tst_res(TWARN | TERRNO,
+			"Failed to close file '%s'", file_name);
+	}
+}
+
+
+/*
+ * Timer testing function.
+ *
+ * What we do here is:
+ *
+ * * Take nsamples measurements of the timer function, the function
+ *   to be sampled is defined in the the actual test.
+ *
+ * * We sort the array of samples, then:
+ *
+ *   - look for outliners which are samples where the sleep time has exceeded
+ *     requested sleep time by an order of magnitude
+ *
+ *   - samples where the call has woken up too early which is a plain old bug
+ *
+ *   - then we compute truncated mean and compare that with the requested sleep
+ *     time increased by a threshold
+ */
+void do_timer_test(long long usec, unsigned int nsamples)
+{
+	long long trunc_mean, median;
+	unsigned int discard = compute_discard(nsamples);
+	unsigned int keep_samples = nsamples - discard;
+	long long threshold = compute_threshold(usec, keep_samples);
+	unsigned int i;
+	int failed = 0;
+
+	tst_res(TINFO,
+		"%s sleeping for %llius %u iterations, threshold %.2fus",
+		timer_test->scall, usec, nsamples,
+		1.00 * threshold / (keep_samples));
+
+	cur_sample = 0;
+	for (i = 0; i < nsamples; i++) {
+		if (timer_test->sample(CLOCK_REALTIME, usec)) {
+			tst_res(TINFO, "sampling function failed, exitting");
+			return;
+		}
+	}
+
+	qsort(samples, nsamples, sizeof(samples[0]), cmp);
+
+	write_to_file();
+
+	for (i = 0; samples[i] > 10 * usec; i++) {
+		if (samples[i] <= 3 * monotonic_resolution)
+			break;
+	}
+
+	if (i > 0) {
+		tst_res(TINFO, "Found %i outliners in [%lli,%lli] range",
+			i, samples[0], samples[i-1]);
+	}
+
+	for (i = nsamples - 1; samples[i] < usec; i--);
+
+	if (i < nsamples - 1) {
+		tst_res(TFAIL, "%s woken up early %u times range: [%lli,%lli]",
+			timer_test->scall, nsamples - 1 - i,
+			samples[i+1], samples[nsamples-1]);
+		failed = 1;
+	}
+
+	median = samples[nsamples/2];
+
+	trunc_mean = 0;
+
+	for (i = discard; i < nsamples; i++)
+		trunc_mean += samples[i];
+
+	tst_res(TINFO,
+		"min %llius, max %llius, median %llius, trunc mean %.2fus (discarded %u)",
+		samples[nsamples-1], samples[0], median,
+		1.00 * trunc_mean / keep_samples, discard);
+
+	if (trunc_mean > (nsamples - discard) * usec + threshold) {
+		tst_res(TFAIL, "%s slept for too long", timer_test->scall);
+
+		if (!print_frequency_plot)
+			frequency_plot();
+
+		failed = 1;
+	}
+
+	if (print_frequency_plot)
+		frequency_plot();
+
+	if (!failed)
+		tst_res(TPASS, "Measured times are within thresholds");
+}
+
+static void parse_timer_opts(void);
+
+static void timer_setup(void)
+{
+	struct timespec t;
+	int ret;
+
+	clock_getres(CLOCK_MONOTONIC, &t);
+
+	tst_res(TINFO, "CLOCK_MONOTONIC resolution %lins", (long)t.tv_nsec);
+
+	monotonic_resolution = t.tv_nsec / 1000;
+
+	ret = prctl(PR_GET_TIMERSLACK);
+	if (ret < 0) {
+		tst_res(TINFO, "prctl(PR_GET_TIMERSLACK) = -1, using 50us");
+		timerslack = 50;
+	} else {
+		timerslack = ret / 1000;
+		tst_res(TINFO, "prctl(PR_GET_TIMERSLACK) = %ius", timerslack);
+	}
+
+	parse_timer_opts();
+
+	samples = SAFE_MALLOC(sizeof(long long) * MAX(MAX_SAMPLES, sample_cnt));
+
+	if (timer_test->setup)
+		timer_test->setup();
+}
+
+static void timer_cleanup(void)
+{
+	free(samples);
+
+	if (timer_test->cleanup)
+		timer_test->cleanup();
+}
+
+static struct tst_timer_tcase {
+	long long usec;
+	unsigned int samples;
+} tcases[] = {
+	{1000,  500},
+	{2000,  500},
+	{5000,  300},
+	{10000, 100},
+	{25000,  50},
+	{100000, 10},
+	{1000000, 2},
+};
+
+static void timer_test_fn(unsigned int n)
+{
+	do_timer_test(tcases[n].usec, tcases[n].samples);
+}
+
+static void single_timer_test(void)
+{
+	do_timer_test(sleep_time, sample_cnt);
+}
+
+static struct tst_option options[] = {
+	{"p", &print_frequency_plot, "-p       Print frequency plot"},
+	{"s:", &str_sleep_time, "-s us    Sleep time"},
+	{"n:", &str_sample_cnt, "-n uint  Number of samples to take"},
+	{"f:", &file_name, "-f fname Write measured samples into a file"},
+	{NULL, NULL, NULL}
+};
+
+struct tst_test test = {
+	.setup = timer_setup,
+	.cleanup = timer_cleanup,
+	.options = options,
+	.test = timer_test_fn,
+	.tcnt = ARRAY_SIZE(tcases),
+};
+
+static void parse_timer_opts(void)
+{
+	if (str_sleep_time) {
+		if (tst_parse_int(str_sleep_time, &sleep_time, 0, INT_MAX)) {
+			tst_brk(TBROK,
+				"Invalid sleep time '%s'", str_sleep_time);
+		}
+	}
+
+	if (str_sample_cnt) {
+		if (tst_parse_int(str_sample_cnt, &sample_cnt, 1, INT_MAX)) {
+			tst_brk(TBROK,
+				"Invalid sample count '%s'", str_sample_cnt);
+		}
+	}
+
+	if (str_sleep_time || str_sample_cnt) {
+		if (sleep_time < 0)
+			sleep_time = 10000;
+
+		if (!sample_cnt)
+			sample_cnt = 500;
+
+		test.test_all = single_timer_test;
+		test.test = NULL;
+		test.tcnt = 0;
+	}
+}
+
+void tst_run_timer_tcases(int argc, char *argv[],
+			  struct tst_timer_test *ttest)
+{
+	timer_test = ttest;
+	tst_run_tcases(argc, argv, &test);
+}
diff --git a/runtest/syscalls b/runtest/syscalls
index 06ce51e92..12a38eeab 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -74,6 +74,7 @@ chroot04 chroot04
 
 clock_getres01 clock_getres01
 clock_nanosleep01 clock_nanosleep01
+clock_nanosleep02 clock_nanosleep02
 clock_nanosleep2_01 clock_nanosleep2_01
 
 clone01 clone01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 497e58ef5..46a29e99e 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -53,6 +53,7 @@
 /chroot/chroot04
 /clock_getres/clock_getres01
 /clock_nanosleep/clock_nanosleep01
+/clock_nanosleep/clock_nanosleep02
 /clock_nanosleep2/clock_nanosleep2_01
 /clone/clone01
 /clone/clone02
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
index a4458e898..20a54dc87 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
@@ -27,8 +27,6 @@
 #include "tst_timer.h"
 #include "tst_test.h"
 
-#define MAX_MSEC_DIFF   20
-
 static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
 {
 }
@@ -58,22 +56,6 @@ struct test_case {
 
 static struct test_case tcase[] = {
 	{
-		.clk_id = CLOCK_REALTIME,
-		TYPE_NAME(NORMAL),
-		.flags = 0,
-		.rq = (struct timespec) {.tv_sec = 0, .tv_nsec = 500000000},
-		.exp_ret = 0,
-		.exp_err = 0,
-	},
-	{
-		.clk_id = CLOCK_MONOTONIC,
-		TYPE_NAME(NORMAL),
-		.flags = 0,
-		.rq = (struct timespec) {.tv_sec = 0, .tv_nsec = 500000000},
-		.exp_ret = 0,
-		.exp_err = 0,
-	},
-	{
 		TYPE_NAME(NORMAL),
 		.clk_id = CLOCK_REALTIME,
 		.flags = 0,
@@ -110,60 +92,45 @@ static struct test_case tcase[] = {
 void setup(void)
 {
 	SAFE_SIGNAL(SIGINT, sighandler);
-	tst_timer_check(CLOCK_MONOTONIC);
 }
 
 static void do_test(unsigned int i)
 {
 	struct test_case *tc = &tcase[i];
 	struct timespec rm = {0};
-	long long elapsed_ms, expect_ms, remain_ms = 0;
 	pid_t pid = 0;
 
 	tst_res(TINFO, "case %s", tc->desc);
 
-	/* setup */
 	if (tc->ttype == SEND_SIGINT)
 		pid = create_sig_proc(SIGINT, 40, 500000);
 
-	/* test */
-	tst_timer_start(CLOCK_MONOTONIC);
 	TEST(clock_nanosleep(tc->clk_id, tc->flags, &tc->rq, &rm));
-	tst_timer_stop();
-	elapsed_ms = tst_timer_elapsed_ms();
-	expect_ms = tst_timespec_to_ms(tc->rq);
 
-	if (tc->ttype == SEND_SIGINT) {
-		tst_res(TINFO, "remain time: %lds %ldns", rm.tv_sec, rm.tv_nsec);
-		remain_ms = tst_timespec_to_ms(rm);
-	}
-
-	/* cleanup */
 	if (pid) {
 		SAFE_KILL(pid, SIGTERM);
 		SAFE_WAIT(NULL);
 	}
 
-	/* result check */
-	if (!TEST_RETURN && (elapsed_ms < expect_ms - MAX_MSEC_DIFF
-		|| elapsed_ms > expect_ms + MAX_MSEC_DIFF)) {
-
-		tst_res(TFAIL| TTERRNO, "The clock_nanosleep() haven't slept correctly,"
-			" measured %lldms, expected %lldms +- %d",
-			elapsed_ms, expect_ms, MAX_MSEC_DIFF);
-		return;
-	}
+	if (tc->ttype == SEND_SIGINT) {
+		long long expect_ms = tst_timespec_to_ms(tc->rq);
+		long long remain_ms = tst_timespec_to_ms(rm);
 
-	if (tc->ttype == SEND_SIGINT && !rm.tv_sec && !rm.tv_nsec) {
-		tst_res(TFAIL | TTERRNO, "The clock_nanosleep() haven't updated"
-			" timestamp with remaining time");
-		return;
-	}
+		tst_res(TINFO, "remain time: %lds %ldns", rm.tv_sec, rm.tv_nsec);
 
-	if (tc->ttype == SEND_SIGINT && remain_ms > expect_ms) {
-		tst_res(TFAIL| TTERRNO, "remaining time > requested time (%lld > %lld)",
-			remain_ms, expect_ms);
-		return;
+		if (!rm.tv_sec && !rm.tv_nsec) {
+			tst_res(TFAIL | TTERRNO,
+				"The clock_nanosleep() haven't updated"
+				" timestamp with remaining time");
+			return;
+		}
+
+		if (remain_ms > expect_ms) {
+			tst_res(TFAIL| TTERRNO,
+				"remaining time > requested time (%lld > %lld)",
+				remain_ms, expect_ms);
+			return;
+		}
 	}
 
 	if (TEST_RETURN != tc->exp_ret) {
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
new file mode 100644
index 000000000..138bcd4a4
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
@@ -0,0 +1,49 @@
+/*
+ * Copyright (C) 2017 Cyril Hrubis <chrubis@suse.cz>
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+/*
+ * Test Description:
+ *  clock_nanosleep() should return with value 0 and the process should be
+ *  suspended for time specified by timespec structure.
+ */
+
+#include <errno.h>
+#include "tst_timer_test.h"
+
+int sample_fn(int clk_id, long long usec)
+{
+	struct timespec t = tst_us_to_timespec(usec);
+
+	tst_timer_start(clk_id);
+	TEST(clock_nanosleep(clk_id, 0, &t, NULL));
+	tst_timer_stop();
+	tst_timer_sample();
+
+	if (TEST_RETURN != 0) {
+		tst_res(TFAIL | TERRNO,
+			"nanosleep() returned %li", TEST_RETURN);
+		return 1;
+	}
+
+	return 0;
+}
+
+static struct tst_timer_test timer_test = {
+	.scall = "nanosleep()",
+	.sample = sample_fn,
+};
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
index a32e82e23..3e0fa171e 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (c) 2016 Fujitsu Ltd.
- * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ *  Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -17,7 +18,6 @@
  */
 
 /*
- * Description:
  *  Check that epoll_wait(2) timeouts correctly.
  */
 
@@ -25,121 +25,60 @@
 #include <unistd.h>
 #include <errno.h>
 
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "epoll_wait02";
-int TST_TOTAL = 1;
+#include "tst_timer_test.h"
 
 static int epfd, fds[2];
-static char *opt_sleep_ms;
 static struct epoll_event epevs[1] = {
-	{.events = EPOLLIN}
-};
-
-static option_t opts[] = {
-	{"s:", NULL, &opt_sleep_ms},
-	{NULL, NULL, NULL}
+       {.events = EPOLLIN}
 };
 
-static void setup(void);
-static void cleanup(void);
-static void help(void);
-
-int main(int ac, char **av)
+int sample_fn(int clk_id, long long usec)
 {
-	int lc, threshold;
-	long long elapsed_ms, sleep_ms = 100;
-
-	tst_parse_opts(ac, av, opts, help);
-
-	if (opt_sleep_ms) {
-		sleep_ms = atoll(opt_sleep_ms);
-
-		if (sleep_ms == 0) {
-			tst_brkm(TBROK, NULL,
-				 "Invalid timeout '%s'", opt_sleep_ms);
-		}
-	}
-
-	threshold = sleep_ms / 100 + 10;
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	unsigned int sleep_ms = usec / 1000;
 
-		tst_timer_start(CLOCK_MONOTONIC);
-		TEST(epoll_wait(epfd, epevs, 1, sleep_ms));
-		tst_timer_stop();
+	tst_timer_start(clk_id);
+	TEST(epoll_wait(epfd, epevs, 1, sleep_ms));
+	tst_timer_stop();
+	tst_timer_sample();
 
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "epoll_wait() failed");
-			continue;
-		}
-
-		if (TEST_RETURN != 0) {
-			tst_resm(TFAIL, "epoll_wait() returned %li, expected 0",
-				 TEST_RETURN);
-			continue;
-		}
-
-		elapsed_ms = tst_timer_elapsed_ms();
-
-		if (elapsed_ms < sleep_ms) {
-			tst_resm(TFAIL, "epoll_wait() woken up too early %llims, "
-				 "expected %llims", elapsed_ms, sleep_ms);
-			continue;
-		}
-
-		if (elapsed_ms - sleep_ms > threshold) {
-			tst_resm(TFAIL, "epoll_wait() slept too long %llims, "
-				 "expected %llims, threshold %i",
-				 elapsed_ms, sleep_ms, threshold);
-			continue;
-		}
-
-		tst_resm(TPASS, "epoll_wait() slept %llims, expected %llims, "
-			 "threshold %i", elapsed_ms, sleep_ms, threshold);
+	if (TEST_RETURN != 0) {
+		tst_res(TFAIL | TTERRNO,
+			"epoll_wait() returned %li", TEST_RETURN);
+		return 1;
 	}
 
-	cleanup();
-	tst_exit();
+	return 0;
 }
 
 static void setup(void)
 {
-	tst_timer_check(CLOCK_MONOTONIC);
-
-	SAFE_PIPE(NULL, fds);
+	SAFE_PIPE(fds);
 
 	epfd = epoll_create(1);
-	if (epfd == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "failed to create epoll instance");
-	}
+	if (epfd == -1)
+		tst_brk(TBROK | TERRNO, "epoll_create()");
 
 	epevs[0].data.fd = fds[0];
 
-	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[0], &epevs[0])) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "failed to register epoll target");
-	}
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[0], &epevs[0]))
+		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
 }
 
 static void cleanup(void)
 {
-	if (epfd > 0 && close(epfd))
-		tst_resm(TWARN | TERRNO, "failed to close epfd");
+	if (epfd > 0)
+		SAFE_CLOSE(epfd);
 
-	if (close(fds[0]))
-		tst_resm(TWARN | TERRNO, "close(fds[0]) failed");
+	if (fds[0] > 0)
+		SAFE_CLOSE(fds[0]);
 
-	if (close(fds[1]))
-		tst_resm(TWARN | TERRNO, "close(fds[1]) failed");
+	if (fds[1] > 0)
+		SAFE_CLOSE(fds[1]);
 }
 
-static void help(void)
-{
-	printf("  -s      epoll_wait() timeout length in ms\n");
-}
+static struct tst_timer_test timer_test = {
+	.scall = "epoll_wait()",
+	.sample = sample_fn,
+	.setup = setup,
+	.cleanup = cleanup,
+};
diff --git a/testcases/kernel/syscalls/futex/futex_wait05.c b/testcases/kernel/syscalls/futex/futex_wait05.c
index 6b99cede1..29faa1f39 100644
--- a/testcases/kernel/syscalls/futex/futex_wait05.c
+++ b/testcases/kernel/syscalls/futex/futex_wait05.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (C) 2015-2017 Cyril Hrubis <chrubis@suse.cz>
  *
  * Licensed under the GNU GPLv2 or later.
  * This program is free software;  you can redistribute it and/or modify
@@ -23,64 +23,35 @@
 
 #include <errno.h>
 
-#include "test.h"
+#include "tst_timer_test.h"
 #include "futextest.h"
 
-#define TRESHOLD_US 100000
-
-const char *TCID="futex_wait05";
-const int TST_TOTAL=1;
-
-static void verify_futex_wait(clock_t clk_id, int fflags)
+int sample_fn(int clk_id, long long usec)
 {
-	struct timespec to = {.tv_sec = 0, .tv_nsec = 100010000};
+	struct timespec to = tst_us_to_timespec(usec);
 	futex_t futex = FUTEX_INITIALIZER;
 
 	tst_timer_start(clk_id);
-	TEST(futex_wait(&futex, futex, &to, fflags));
+	TEST(futex_wait(&futex, futex, &to, 0));
 	tst_timer_stop();
+	tst_timer_sample();
 
 	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "futex_wait() returned %li, expected -1",
+		tst_res(TFAIL, "futex_wait() returned %li, expected -1",
 		         TEST_RETURN);
-		return;
+		return 1;
 	}
 
 	if (TEST_ERRNO != ETIMEDOUT) {
-
-		tst_resm(TFAIL | TTERRNO, "expected errno=%s",
-		         tst_strerrno(ETIMEDOUT));
-		return;
-	}
-
-	if (tst_timespec_lt(tst_timer_elapsed(), to)) {
-		tst_resm(TFAIL,
-		         "futex_wait() woken up prematurely %llius, expected %llius",
-			 tst_timer_elapsed_us(), tst_timespec_to_us(to));
-		return;
-	}
-
-	if (tst_timespec_diff_us(tst_timer_elapsed(), to) > TRESHOLD_US) {
-		tst_resm(TFAIL,
-		         "futex_wait() waited too long %llius, expected %llius",
-			 tst_timer_elapsed_us(), tst_timespec_to_us(to));
-		return;
+		tst_res(TFAIL | TTERRNO, "expected errno=%s",
+		        tst_strerrno(ETIMEDOUT));
+		return 1;
 	}
 
-	tst_resm(TPASS, "futex_wait() waited %llius, expected %llius",
-	         tst_timer_elapsed_us(), tst_timespec_to_us(to));
+	return 0;
 }
 
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	tst_timer_check(CLOCK_MONOTONIC);
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		verify_futex_wait(CLOCK_MONOTONIC, 0);
-
-	tst_exit();
-}
+static struct tst_timer_test timer_test = {
+	.scall = "futex_wait()",
+	.sample = sample_fn,
+};
diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep01.c b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
index 4d9d083b1..a51a6aa70 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep01.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  *  07/2001 Ported by Wayne Boyer
- * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (C) 2015-2017 Cyril Hrubis <chrubis@suse.cz>
  *
  * This program is free software;  you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -19,56 +19,34 @@
  */
 
 /*
- * Test Name: nanosleep01
- *
  * Test Description:
  *  nanosleep() should return with value 0 and the process should be
  *  suspended for time specified by timespec structure.
  */
 
 #include <errno.h>
-#include "test.h"
-
-char *TCID = "nanosleep01";
-int TST_TOTAL = 1;
 
-static void setup(void);
+#include "tst_timer_test.h"
 
-int main(int ac, char **av)
+int sample_fn(int clk_id, long long usec)
 {
-	int lc;
-	struct timespec timereq = {.tv_sec = 2, .tv_nsec = 9999};
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	struct timespec t = tst_us_to_timespec(usec);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_timer_start(CLOCK_MONOTONIC);
-		TEST(nanosleep(&timereq, NULL));
-		tst_timer_stop();
+	tst_timer_start(clk_id);
+	TEST(nanosleep(&t, NULL));
+	tst_timer_stop();
+	tst_timer_sample();
 
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TERRNO, "nanosleep() failed");
-			continue;
-		}
-
-		if (tst_timespec_lt(tst_timer_elapsed(), timereq)) {
-			tst_resm(TFAIL,
-			         "nanosleep() suspended for %lli us, expected %lli",
-				 tst_timer_elapsed_us(), tst_timespec_to_us(timereq));
-		} else {
-			tst_resm(TPASS, "nanosleep() suspended for %lli us",
-			         tst_timer_elapsed_us());
-		}
+	if (TEST_RETURN != 0) {
+		tst_res(TFAIL | TERRNO,
+			"nanosleep() returned %li", TEST_RETURN);
+		return 1;
 	}
 
-	tst_exit();
+	return 0;
 }
 
-static void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, NULL);
-	tst_timer_check(CLOCK_MONOTONIC);
-	TEST_PAUSE;
-}
+static struct tst_timer_test timer_test = {
+	.scall = "nanosleep()",
+	.sample = sample_fn,
+};
diff --git a/testcases/kernel/syscalls/poll/poll02.c b/testcases/kernel/syscalls/poll/poll02.c
index 66affed01..5da432857 100644
--- a/testcases/kernel/syscalls/poll/poll02.c
+++ b/testcases/kernel/syscalls/poll/poll02.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (C) 2015-2017 Cyril Hrubis <chrubis@suse.cz>
  *
  * This program is free software;  you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -19,105 +19,53 @@
 /*
  * Check that poll() timeouts correctly.
  */
-#include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <sys/wait.h>
 #include <sys/poll.h>
 
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "poll02";
-int TST_TOTAL = 1;
-
-static char *opt_sleep_ms;
-
-static option_t opts[] = {
-	{"s:", NULL, &opt_sleep_ms},
-	{NULL, NULL, NULL},
-};
-
-static void help(void);
-static void setup(void);
-static void cleanup(void);
+#include "tst_timer_test.h"
 
 static int fds[2];
 
-int main(int ac, char **av)
+int sample_fn(int clk_id, long long usec)
 {
-	int lc, treshold;
-	long long elapsed_ms, sleep_ms = 100;
+	unsigned int sleep_ms = usec / 1000;
 
-	tst_parse_opts(ac, av, opts, help);
+	struct pollfd pfds[] = {
+		{.fd = fds[0], .events = POLLIN}
+	};
 
-	if (opt_sleep_ms) {
-		sleep_ms = atoll(opt_sleep_ms);
+	tst_timer_start(clk_id);
+	TEST(poll(pfds, 1, sleep_ms));
+	tst_timer_stop();
+	tst_timer_sample();
 
-		if (sleep_ms == 0)
-			tst_brkm(TBROK, NULL, "Invalid timeout '%s'", opt_sleep_ms);
+	if (TEST_RETURN != 0) {
+		tst_res(TFAIL | TTERRNO, "poll() returned %li", TEST_RETURN);
+		return 1;
 	}
 
-	treshold = sleep_ms / 100 + 10;
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		struct pollfd pfds[] = {
-			{.fd = fds[0], .events = POLLIN}
-		};
-
-		tst_timer_start(CLOCK_MONOTONIC);
-		TEST(poll(pfds, 1, sleep_ms));
-		tst_timer_stop();
-
-		if (TEST_RETURN != 0) {
-			tst_resm(TFAIL, "poll() haven't timeouted ret=%li",
-				 TEST_RETURN);
-			continue;
-		}
-
-		elapsed_ms = tst_timer_elapsed_ms();
-
-		if (elapsed_ms < sleep_ms) {
-			tst_resm(TFAIL,
-			         "poll() woken up too early %llims, expected %llims",
-				 elapsed_ms, sleep_ms);
-			continue;
-		}
-
-		if (elapsed_ms - sleep_ms > treshold) {
-			tst_resm(TFAIL,
-			         "poll() slept too long %llims, expected %llims, threshold %i",
-				 elapsed_ms, sleep_ms, treshold);
-			continue;
-		}
-
-		tst_resm(TPASS, "poll() slept %llims, expected %llims, treshold %i",
-		         elapsed_ms, sleep_ms, treshold);
-	}
-
-	cleanup();
-	tst_exit();
+	return 0;
 }
 
 static void setup(void)
 {
-	tst_timer_check(CLOCK_MONOTONIC);
-
-	SAFE_PIPE(NULL, fds);
+	SAFE_PIPE(fds);
 }
 
 static void cleanup(void)
 {
-	if (close(fds[0]))
-		tst_resm(TWARN | TERRNO, "close(fds[0]) failed");
+	if (fds[0] > 0)
+		SAFE_CLOSE(fds[0]);
 
-	if (close(fds[1]))
-		tst_resm(TWARN | TERRNO, "close(fds[1]) failed");
+	if (fds[1] > 0)
+		SAFE_CLOSE(fds[1]);
 }
 
-static void help(void)
-{
-	printf("  -s      poll() timeout lenght in ms\n");
-}
+static struct tst_timer_test timer_test = {
+	.scall = "poll()",
+	.sample = sample_fn,
+	.setup = setup,
+	.cleanup = cleanup,
+};
diff --git a/testcases/kernel/syscalls/pselect/pselect01.c b/testcases/kernel/syscalls/pselect/pselect01.c
index 1e8eccecb..8c9fc70f4 100644
--- a/testcases/kernel/syscalls/pselect/pselect01.c
+++ b/testcases/kernel/syscalls/pselect/pselect01.c
@@ -1,152 +1,49 @@
 /*
- * Copyright (c) International Business Machines  Corp., 2005
- * Copyright (c) Wipro Technologies Ltd, 2005.  All Rights Reserved.
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
  *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * AUTHORS:
- *    Prashant P Yendigeri <prashant.yendigeri@wipro.com>
- *    Robbie Williamson <robbiew@us.ibm.com>
- *
- * DESCRIPTION
- *      This is a Phase I test for the pselect01(2) system call.
- *      It is intended to provide a limited exposure of the system call.
- *
- **********************************************************/
-
-#include <stdio.h>
-#include <fcntl.h>
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
 #include <sys/select.h>
 #include <sys/time.h>
 #include <sys/types.h>
-#include <time.h>
-#include <unistd.h>
 #include <errno.h>
 
-#include "tst_test.h"
-#include "tst_timer.h"
-
-struct tcase {
-	struct timespec tv;
-	unsigned int iterations;
-};
-
-static unsigned int monotonic_resolution;
-
-static struct tcase tcases[] = {
-	{{0, 1000000},  500},
-	{{0, 2000000},  500},
-	{{0, 10000000}, 300},
-	{{0, 100000000},  1},
-	{{1, 0},          1},
-};
-
-/*
- * The threshold per one syscall is computed as a sum of:
- *
- *  250 us                 - accomodates for context switches, etc.
- *  2*monotonic_resolution - accomodates for granurality of the CLOCK_MONOTONIC
- *  slack_per_scall        - 0.1% of the sleep capped on 100ms
- *                           which is slack allowed in kernel
- *
- * We also allow for outliners, i.e. add some number to the threshold in case
- * that the number of iteration is small. For large enoung number of iterations
- * outliners are averaged out.
- */
-static int compute_threshold(long long requested_us, unsigned int iterations)
-{
-	unsigned int slack_per_scall = MIN(100000, requested_us / 1000);
-
-	return (250 + 2 * monotonic_resolution + slack_per_scall) * iterations
-		+ (iterations > 1 ? 0 : 1500);
-}
+#include "tst_timer_test.h"
 
-static void verify_pselect(unsigned int n)
+int sample_fn(int clk_id, long long usec)
 {
 	fd_set readfds;
-	struct timespec tv;
-	long long requested_us, slept_us = 0;
-	unsigned int i;
-	int threshold;
-	struct tcase *t = &tcases[n];
+	struct timespec tv = tst_us_to_timespec(usec);
 
-	tst_res(TINFO, "pselect() sleeping for %li secs %li nsec %i iterations",
-			t->tv.tv_sec, t->tv.tv_nsec, t->iterations);
+	FD_ZERO(&readfds);
+	FD_SET(0, &readfds);
 
-	for (i = 0; i < t->iterations; i++) {
-		long long elapsed_us;
+	tst_timer_start(clk_id);
+	TEST(pselect(0, &readfds, NULL, NULL, &tv, NULL));
+	tst_timer_stop();
+	tst_timer_sample();
 
-		FD_ZERO(&readfds);
-		FD_SET(0, &readfds);
-
-		tv = t->tv;
-
-		tst_timer_start(CLOCK_MONOTONIC);
-		pselect(0, &readfds, NULL, NULL, &tv, NULL);
-		tst_timer_stop();
-
-		elapsed_us = tst_timer_elapsed_us();
-
-		if (elapsed_us >= 10 * tst_timespec_to_us(t->tv)
-		    && elapsed_us > 3 * monotonic_resolution) {
-			tst_res(TINFO,
-				"Found outliner took %lli us, expected %lli us",
-				elapsed_us, tst_timespec_to_us(t->tv));
-		}
-
-		slept_us += elapsed_us;
-	}
-
-	requested_us = tst_timespec_to_us(t->tv) * t->iterations;
-	threshold = compute_threshold(tst_timespec_to_us(t->tv), t->iterations);
-
-	if (t->iterations > 1) {
-		tst_res(TINFO, "Mean sleep time %.2f us, expected %lli us, threshold %.2f",
-			1.00 * slept_us / t->iterations,
-			tst_timespec_to_us(t->tv), 1.00 * threshold / t->iterations);
-	}
-
-	if (slept_us < requested_us) {
-		tst_res(TFAIL,
-			"pselect() woken up too early %llius, expected %llius",
-			slept_us, requested_us);
-		return;
-	}
-
-	if (slept_us - requested_us > threshold) {
-		tst_res(TFAIL,
-			"pselect() slept for too long %llius, expected %llius, threshold %i",
-			slept_us, requested_us, threshold);
-		return;
+	if (TEST_RETURN != 0) {
+		tst_res(TFAIL | TTERRNO,
+			"pselect() returned %li on timeout", TEST_RETURN);
+		return 1;
 	}
 
-	tst_res(TPASS, "pselect() slept for %llius, requested %llius, treshold %i",
-		slept_us, requested_us, threshold);
-}
-
-static void setup(void)
-{
-	struct timespec t;
-
-	clock_getres(CLOCK_MONOTONIC, &t);
-
-	tst_res(TINFO, "CLOCK_MONOTONIC resolution %li ns", (long)t.tv_nsec);
-
-	monotonic_resolution = t.tv_nsec / 1000;
+	return 0;
 }
 
-static struct tst_test test = {
-	.test = verify_pselect,
-	.setup = setup,
-	.tcnt = ARRAY_SIZE(tcases),
+static struct tst_timer_test timer_test = {
+	.scall = "pselect()",
+	.sample = sample_fn,
 };
diff --git a/testcases/kernel/syscalls/select/select04.c b/testcases/kernel/syscalls/select/select04.c
index 76253c4ba..3ce8db9cd 100644
--- a/testcases/kernel/syscalls/select/select04.c
+++ b/testcases/kernel/syscalls/select/select04.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (C) 2015-2017 Cyril Hrubis <chrubis@suse.cz>
  *
  * This program is free software;  you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -25,104 +25,49 @@
 #include <sys/types.h>
 #include <fcntl.h>
 
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "select04";
-int TST_TOTAL = 1;
-
-static char *opt_sleep_us;
-
-static option_t opts[] = {
-	{"s:", NULL, &opt_sleep_us},
-	{NULL, NULL, NULL},
-};
-
-static void help(void);
-static void setup(void);
-static void cleanup(void);
+#include "tst_timer_test.h"
 
 static int fds[2];
 
-int main(int ac, char **av)
+static int sample_fn(int clk_id, long long usec)
 {
-	int lc, treshold;
-	long long elapsed_us, sleep_us = 100000;
-	struct timeval timeout;
+	struct timeval timeout = tst_us_to_timeval(usec);
 	fd_set sfds;
 
-	tst_parse_opts(ac, av, opts, help);
-
-	if (opt_sleep_us) {
-		sleep_us = atoll(opt_sleep_us);
-
-		if (sleep_us == 0) {
-			tst_brkm(TBROK, NULL, "Invalid timeout '%s'",
-			         opt_sleep_us);
-		}
-	}
-
-	treshold = sleep_us / 100 + 20000;
-
-	setup();
-
 	FD_ZERO(&sfds);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		FD_SET(fds[0], &sfds);
-		timeout = tst_us_to_timeval(sleep_us);
-
-		tst_timer_start(CLOCK_MONOTONIC);
-		TEST(select(1, &sfds, NULL, NULL, &timeout));
-		tst_timer_stop();
-
-		if (TEST_RETURN != 0) {
-			tst_resm(TFAIL, "select() haven't timeouted ret=%li",
-				 TEST_RETURN);
-			continue;
-		}
-
-		elapsed_us = tst_timer_elapsed_us();
-
-		if (elapsed_us < sleep_us) {
-			tst_resm(TFAIL,
-			         "select() woken up too early %llius, expected %llius",
-				 elapsed_us, sleep_us);
-			continue;
-		}
+	FD_SET(fds[0], &sfds);
 
-		if (elapsed_us - sleep_us > treshold) {
-			tst_resm(TFAIL,
-			         "select() slept too long %llius, expected %llius, threshold %i",
-				 elapsed_us, sleep_us, treshold);
-			continue;
-		}
+	tst_timer_start(clk_id);
+	TEST(select(1, &sfds, NULL, NULL, &timeout));
+	tst_timer_stop();
+	tst_timer_sample();
 
-		tst_resm(TPASS, "select() slept %llius, expected %llius, treshold %i",
-		         elapsed_us, sleep_us, treshold);
+	if (TEST_RETURN != 0) {
+		tst_res(TFAIL | TTERRNO, "select() returned %li", TEST_RETURN);
+		return 1;
 	}
 
-	cleanup();
-	tst_exit();
+	return 0;
 }
 
 static void setup(void)
 {
-	tst_timer_check(CLOCK_MONOTONIC);
-
-	SAFE_PIPE(NULL, fds);
+	SAFE_PIPE(fds);
 }
 
 static void cleanup(void)
 {
-	if (close(fds[0]))
-		tst_resm(TWARN | TERRNO, "close(fds[0]) failed");
+	if (fds[0] > 0)
+		SAFE_CLOSE(fds[0]);
 
-	if (close(fds[1]))
-		tst_resm(TWARN | TERRNO, "close(fds[1]) failed");
+	if (fds[1] > 0)
+		SAFE_CLOSE(fds[1]);
 }
 
-static void help(void)
-{
-	printf("  -s      select() timeout lenght in us\n");
-}
+static struct tst_timer_test timer_test = {
+	.scall = "select()",
+	.sample = sample_fn,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.13.0

