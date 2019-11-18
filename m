From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 18 Nov 2019 15:59:55 +0100
Subject: [LTP] [PATCH 1/3] perf_event_open02: migrate to newlib
In-Reply-To: <cover.1574087532.git.jstancek@redhat.com>
References: <cover.1574087532.git.jstancek@redhat.com>
Message-ID: <53c6b3308d3e77fd95cae17b2a7ed1d4e8b2f60e.1574087532.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Migrate code to newlib, no functional changes.

Adjust comment style, replace license text with SPDX.
Reorder includes, drop some unneeded ones.
Rename variable "n" to "totaln".
Move common error handling to function.
Move cpu affinity code to separate function.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../syscalls/perf_event_open/perf_event_open02.c   | 356 ++++++++-------------
 1 file changed, 132 insertions(+), 224 deletions(-)

diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
index c2831aa20d40..584487de8255 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
@@ -1,132 +1,103 @@
-/******************************************************************************/
-/*                                                                            */
-/* Paul Mackerras <paulus@samba.org>, 2009                                    */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
-Here's a little test program that checks whether software counters
-(specifically, the task clock counter) work correctly when they're in
-a group with hardware counters.
-
-What it does is to create several groups, each with one hardware
-counter, counting instructions, plus a task clock counter.  It needs
-to know an upper bound N on the number of hardware counters you have
-(N defaults to 8), and it creates N+4 groups to force them to be
-multiplexed.  It also creates an overall task clock counter.
-
-Then it spins for a while, and then stops all the counters and reads
-them.  It takes the total of the task clock counters in the groups and
-computes the ratio of that total to the overall execution time from
-the overall task clock counter.
-
-That ratio should be equal to the number of actual hardware counters
-that can count instructions.  If the task clock counters in the groups
-don't stop when their group gets taken off the PMU, the ratio will
-instead be close to N+4.  The program will declare that the test fails
-if the ratio is greater than N (actually, N + 0.0001 to allow for FP
-rounding errors).
-
-Could someone run this on x86 on the latest PCL tree and let me know
-what happens?  I don't have an x86 crash box easily to hand.  On
-powerpc, it passes, but I think that is because I am missing setting
-counter->prev_count in arch/powerpc/kernel/perf_counter.c, and I think
-that means that enabling/disabling a group with a task clock counter
-in it won't work correctly (I'll do a test program for that next).
-
-Usage is: ./performance_counter02  [-v]
-
-The -v flag makes it print out the values of each counter.
-*/
+ * Copyright (c) 2009 Paul Mackerras <paulus@samba.org>
+ * Copyright (c) 2019 Linux Test Project
+ */
+/*
+ * Here's a little test program that checks whether software counters
+ * (specifically, the task clock counter) work correctly when they're in
+ * a group with hardware counters.
+ *
+ * What it does is to create several groups, each with one hardware
+ * counter, counting instructions, plus a task clock counter.  It needs
+ * to know an upper bound N on the number of hardware counters you have
+ * (N defaults to 8), and it creates N+4 groups to force them to be
+ * multiplexed.  It also creates an overall task clock counter.
+ *
+ * Then it spins for a while, and then stops all the counters and reads
+ * them.  It takes the total of the task clock counters in the groups and
+ * computes the ratio of that total to the overall execution time from
+ * the overall task clock counter.
+ *
+ * That ratio should be equal to the number of actual hardware counters
+ * that can count instructions.  If the task clock counters in the groups
+ * don't stop when their group gets taken off the PMU, the ratio will
+ * instead be close to N+4.  The program will declare that the test fails
+ * if the ratio is greater than N (actually, N + 0.0001 to allow for FP
+ * rounding errors).
+ */
 
 #define _GNU_SOURCE
-#include <stdio.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <sched.h>
 #include <stddef.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <fcntl.h>
-#include <poll.h>
 #include <unistd.h>
-#include <errno.h>
-#include "config.h"
 #include <sys/prctl.h>
 #include <sys/types.h>
-#include <linux/types.h>
-#include <sched.h>
 
-#if HAVE_PERF_EVENT_ATTR
-# include <linux/perf_event.h>
-#endif
-
-#include "test.h"
-#include "safe_macros.h"
+#include "config.h"
+#include "tst_test.h"
 #include "lapi/cpuset.h"
 #include "lapi/syscalls.h"
 
-char *TCID = "perf_event_open02";
-int TST_TOTAL = 1;
-
 #if HAVE_PERF_EVENT_ATTR
+#include <linux/types.h>
+#include <linux/perf_event.h>
 
 #define MAX_CTRS	1000
 #define LOOPS		100000000
 
-static void setup(void);
-static void verify(void);
-static void cleanup(void);
-static void help(void);
+struct read_format {
+	unsigned long long value;
+	/* if PERF_FORMAT_TOTAL_TIME_ENABLED */
+	unsigned long long time_enabled;
+	/* if PERF_FORMAT_TOTAL_TIME_RUNNING */
+	unsigned long long time_running;
+};
 
-static int n, nhw;
-static int verbose;
-static option_t options[] = {
-	{"v", &verbose, NULL},
+static char *verbose;
+static struct tst_option options[] = {
+	{"v", &verbose, "-v\tverbose output"},
 	{NULL, NULL, NULL},
 };
 
-static int tsk0;
-static int hwfd[MAX_CTRS], tskfd[MAX_CTRS];
+static int ntotal, nhw;
+static int tsk0 = -1, hwfd[MAX_CTRS], tskfd[MAX_CTRS];
 
-int main(int ac, char **av)
+static int perf_event_open(struct perf_event_attr *event, pid_t pid,
+	int cpu, int group_fd, unsigned long flags)
 {
-	int lc;
+	int ret;
 
-	tst_parse_opts(ac, av, options, help);
+	ret = tst_syscall(__NR_perf_event_open, event, pid, cpu,
+		group_fd, flags);
 
-	setup();
+	if (ret != -1)
+		return ret;
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		verify();
+	tst_res(TINFO, "perf_event_open event.type: %"PRIu32
+		", event.config: %"PRIu64, (uint32_t)event->type,
+		(uint64_t)event->config);
+	if (errno == ENOENT || errno == ENODEV) {
+		tst_brk(TCONF | TERRNO,
+			"perf_event_open type/config not supported");
 	}
+	tst_brk(TBROK | TERRNO, "perf_event_open failed");
 
-	cleanup();
-	tst_exit();
+	/* unreachable */
+	return -1;
 }
 
-static int perf_event_open(struct perf_event_attr *hw_event, pid_t pid,
-	int cpu, int group_fd, unsigned long flags)
+static void all_counters_set(int state)
 {
-	int ret;
-
-	ret = ltp_syscall(__NR_perf_event_open, hw_event, pid, cpu,
-			  group_fd, flags);
-	return ret;
+	if (prctl(state) == -1)
+		tst_brk(TBROK | TERRNO, "prctl(%d) failed", state);
 }
 
-
 static void do_work(void)
 {
 	int i;
@@ -135,13 +106,6 @@ static void do_work(void)
 		asm volatile (""::"g" (i));
 }
 
-struct read_format {
-	unsigned long long value;
-	/* if PERF_FORMAT_TOTAL_TIME_ENABLED */
-	unsigned long long time_enabled;
-	/* if PERF_FORMAT_TOTAL_TIME_RUNNING */
-	unsigned long long time_running;
-};
 
 #ifndef __s390__
 static int count_hardware_counters(void)
@@ -162,35 +126,17 @@ static int count_hardware_counters(void)
 
 	for (i = 0; i < MAX_CTRS; i++) {
 		fdarry[i] = perf_event_open(&hw_event, 0, -1, -1, 0);
-		if (fdarry[i] == -1) {
-			if (errno == ENOENT || errno == ENODEV) {
-				tst_brkm(TCONF | TERRNO, cleanup,
-				         "PERF_COUNT_HW_INSTRUCTIONS not supported");
-			}
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "perf_event_open failed@iteration:%d", i);
-		}
-
-		if (prctl(PR_TASK_PERF_EVENTS_ENABLE) == -1) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "prctl(PR_TASK_PERF_EVENTS_ENABLE) failed");
-		}
 
+		all_counters_set(PR_TASK_PERF_EVENTS_ENABLE);
 		do_work();
+		all_counters_set(PR_TASK_PERF_EVENTS_DISABLE);
 
-		if (prctl(PR_TASK_PERF_EVENTS_DISABLE) == -1) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "prctl(PR_TASK_PERF_EVENTS_DISABLE) failed");
-		}
-
-		if (read(fdarry[i], &buf, sizeof(buf)) != sizeof(buf)) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "error reading counter(s)");
-		}
+		if (read(fdarry[i], &buf, sizeof(buf)) != sizeof(buf))
+			tst_brk(TBROK | TERRNO, "error reading counter(s)");
 
-		if (verbose == 1) {
-			printf("at iteration:%d value:%lld time_enabled:%lld "
-			       "time_running:%lld\n", i, buf.value,
+		if (verbose) {
+			tst_res(TINFO, "[%d] value:%lld time_enabled:%lld "
+			       "time_running:%lld", i, buf.value,
 			       buf.time_enabled, buf.time_running);
 		}
 
@@ -213,33 +159,36 @@ static int count_hardware_counters(void)
 	}
 
 	for (i = 0; i <= hwctrs; i++)
-		SAFE_CLOSE(cleanup, fdarry[i]);
+		SAFE_CLOSE(fdarry[i]);
 
 	return hwctrs;
 }
-#endif
+#endif /* __s390__ */
 
-static void setup(void)
+static void bind_to_current_cpu(void)
 {
-	int i;
-	struct perf_event_attr tsk_event, hw_event;
-
 #ifdef HAVE_SCHED_GETCPU
 	int cpu = sched_getcpu();
 	size_t mask_size;
 	cpu_set_t *mask;
 
 	if (cpu == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "sched_getcpu() failed");
+		tst_brk(TBROK | TERRNO, "sched_getcpu() failed");
 
 	mask = CPU_ALLOC(cpu + 1);
 	mask_size = CPU_ALLOC_SIZE(cpu + 1);
 	CPU_ZERO_S(mask_size, mask);
 	CPU_SET(cpu, mask);
 	if (sched_setaffinity(0, mask_size, mask) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "sched_setaffinity() failed");
+		tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");
 	CPU_FREE(mask);
 #endif
+}
+
+static void setup(void)
+{
+	int i;
+	struct perf_event_attr tsk_event, hw_event;
 
 	/*
 	 * According to perf_event_open's manpage, the official way of
@@ -247,12 +196,9 @@ static void setup(void)
 	 * the existence of the file /proc/sys/kernel/perf_event_paranoid.
 	 */
 	if (access("/proc/sys/kernel/perf_event_paranoid", F_OK) == -1)
-		tst_brkm(TCONF, NULL, "Kernel doesn't have perf_event support");
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+		tst_brk(TCONF, "Kernel doesn't have perf_event support");
 
+	bind_to_current_cpu();
 #ifdef __s390__
 	/*
 	 * On s390 the "time_enabled" and "time_running" values are always the
@@ -261,10 +207,10 @@ static void setup(void)
 	 * There are distinct/dedicated counters that can be used independently.
 	 * Use the dedicated counter for instructions here.
 	 */
-	n = nhw = 1;
+	ntotal = nhw = 1;
 #else
 	nhw = count_hardware_counters();
-	n = nhw + 4;
+	ntotal = nhw + 4;
 #endif
 
 	memset(&hw_event, 0, sizeof(struct perf_event_attr));
@@ -281,30 +227,10 @@ static void setup(void)
 	hw_event.config =  PERF_COUNT_HW_INSTRUCTIONS;
 
 	tsk0 = perf_event_open(&tsk_event, 0, -1, -1, 0);
-	if (tsk0 == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup, "perf_event_open failed");
-	} else {
-		tsk_event.disabled = 0;
-		for (i = 0; i < n; ++i) {
-			hwfd[i] = perf_event_open(&hw_event, 0, -1, -1, 0);
-			if (hwfd[i] == -1) {
-				if (errno == ENOENT || errno == ENODEV) {
-					tst_brkm(TCONF | TERRNO, cleanup,
-						"PERF_COUNT_HW_INSTRUCTIONS not supported");
-				}
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "perf_event_open failed");
-			}
-			tskfd[i] = perf_event_open(&tsk_event, 0, -1, hwfd[i], 0);
-			if (tskfd[i] == -1) {
-				if (errno == ENOENT || errno == ENODEV) {
-					tst_brkm(TCONF | TERRNO, cleanup,
-						"PERF_COUNT_SW_TASK_CLOCK not supported");
-				}
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "perf_event_open failed");
-			}
-		}
+	tsk_event.disabled = 0;
+	for (i = 0; i < ntotal; ++i) {
+		hwfd[i] = perf_event_open(&hw_event, 0, -1, -1, 0);
+		tskfd[i] = perf_event_open(&tsk_event, 0, -1, hwfd[i], 0);
 	}
 }
 
@@ -312,15 +238,13 @@ static void cleanup(void)
 {
 	int i;
 
-	for (i = 0; i < n; i++) {
-		if (hwfd[i] > 0 && close(hwfd[i]) == -1)
-			tst_resm(TWARN | TERRNO, "close(%d) failed", hwfd[i]);
-		if (tskfd[i] > 0 && close(tskfd[i]) == -1)
-			tst_resm(TWARN | TERRNO, "close(%d) failed", tskfd[i]);
+	for (i = 0; i < ntotal; i++) {
+		SAFE_CLOSE(hwfd[i]);
+		SAFE_CLOSE(tskfd[i]);
 	}
 
-	if (tsk0 > 0 && close(tsk0) == -1)
-		tst_resm(TWARN | TERRNO, "close(%d) failed", tsk0);
+	if (tsk0 != -1)
+		SAFE_CLOSE(tsk0);
 }
 
 static void verify(void)
@@ -332,82 +256,66 @@ static void verify(void)
 	struct sched_param sparam = {.sched_priority = 1};
 
 	if (sched_setscheduler(0, SCHED_FIFO, &sparam)) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "sched_setscheduler(0, SCHED_FIFO, ...) failed");
-	}
-
-	if (prctl(PR_TASK_PERF_EVENTS_ENABLE) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "prctl(PR_TASK_PERF_EVENTS_ENABLE) failed");
+		tst_brk(TBROK | TERRNO,
+			"sched_setscheduler(0, SCHED_FIFO, ...) failed");
 	}
 
+	all_counters_set(PR_TASK_PERF_EVENTS_ENABLE);
 	do_work();
-
 	/* stop groups with hw counters first before tsk0 */
-	for (i = 0; i < n; i++) {
+	for (i = 0; i < ntotal; i++) {
 		ioctl(hwfd[i], PERF_EVENT_IOC_DISABLE);
 		ioctl(tskfd[i], PERF_EVENT_IOC_DISABLE);
 	}
-
-	if (prctl(PR_TASK_PERF_EVENTS_DISABLE) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "prctl(PR_TASK_PERF_EVENTS_DISABLE) failed");
-	}
+	all_counters_set(PR_TASK_PERF_EVENTS_DISABLE);
 
 	sparam.sched_priority = 0;
 	if (sched_setscheduler(0, SCHED_OTHER, &sparam)) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "sched_setscheduler(0, SCHED_OTHER, ...) failed");
+		tst_brk(TBROK | TERRNO,
+			"sched_setscheduler(0, SCHED_OTHER, ...) failed");
 	}
 
-	if (read(tsk0, &vt0, sizeof(vt0)) != sizeof(vt0)) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "error reading task clock counter");
-	}
+	if (read(tsk0, &vt0, sizeof(vt0)) != sizeof(vt0))
+		tst_brk(TBROK | TERRNO, "error reading task clock counter");
 
-	for (i = 0; i < n; ++i) {
+	for (i = 0; i < ntotal; ++i) {
 		if (read(tskfd[i], &vt[i], sizeof(vt[i])) != sizeof(vt[i]) ||
-		    read(hwfd[i], &vh[i], sizeof(vh[i])) != sizeof(vh[i])) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "error reading counter(s)");
-		}
+		    read(hwfd[i], &vh[i], sizeof(vh[i])) != sizeof(vh[i]))
+			tst_brk(TBROK | TERRNO, "error reading counter(s)");
 		vtsum += vt[i];
 		vhsum += vh[i];
 	}
 
-	tst_resm(TINFO, "overall task clock: %llu", vt0);
-	tst_resm(TINFO, "hw sum: %llu, task clock sum: %llu", vhsum, vtsum);
-
-	if (verbose == 1) {
-		printf("hw counters:");
-		for (i = 0; i < n; ++i)
-			printf(" %llu", vh[i]);
-		printf("\ntask clock counters:");
-		for (i = 0; i < n; ++i)
-			printf(" %llu", vt[i]);
-		printf("\n");
+	tst_res(TINFO, "nhw: %d, overall task clock: %llu", nhw, vt0);
+	tst_res(TINFO, "hw sum: %llu, task clock sum: %llu", vhsum, vtsum);
+
+	if (verbose) {
+		tst_res(TINFO, "hw counters:");
+		for (i = 0; i < ntotal; ++i)
+			tst_res(TINFO, " %llu", vh[i]);
+		tst_res(TINFO, "task clock counters:");
+		for (i = 0; i < ntotal; ++i)
+			tst_res(TINFO, " %llu", vt[i]);
 	}
 
 	ratio = (double)vtsum / vt0;
-	tst_resm(TINFO, "ratio: %lf", ratio);
+	tst_res(TINFO, "ratio: %lf", ratio);
 	if (ratio > nhw + 0.0001) {
-		tst_resm(TFAIL, "test failed (ratio was greater than )");
+		tst_res(TFAIL, "test failed (ratio was greater than %d)", nhw);
 	} else {
-		tst_resm(TPASS, "test passed");
+		tst_res(TPASS, "test passed");
 	}
 }
 
-static void help(void)
-{
-	printf("  -v      Print verbose information\n");
-}
-
-#else
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.options = options,
+	.test_all = verify,
+	.needs_root = 1,
+};
 
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "This system doesn't have "
-		 "header file:<linux/perf_event.h> or "
-		 "no struct perf_event_attr defined");
-}
+#else /* HAVE_PERF_EVENT_ATTR */
+TST_TEST_TCONF("This system doesn't have <linux/perf_event.h> or "
+	"struct perf_event_attr is not defined.");
 #endif
-- 
1.8.3.1

