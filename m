Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WY6KV-000539-PT
	for ltp-list@lists.sourceforge.net; Thu, 10 Apr 2014 04:11:11 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WY6KT-0002su-Ab
	for ltp-list@lists.sourceforge.net; Thu, 10 Apr 2014 04:11:11 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s3A4AgZT032678
	for <ltp-list@lists.sourceforge.net>; Thu, 10 Apr 2014 12:10:42 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Thu, 10 Apr 2014 12:08:46 +0800
Message-ID: <1397102926-2630-3-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1397102926-2630-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1397102926-2630-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 3/3] perf_event_open/perf_event_open02.c: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

According to perf_event_open()'s manpage, the official way of knowing
if perf_event_open() support is enabled is checking for the existence
of the file /proc/sys/kernel/perf_event_paranoid, so add this check.

According to this perf_event_open API description, rewrite this test.
int perf_event_open(struct perf_event_attr *attr,
	pid_t pid, int cpu, int group_fd,
	unsigned long flags);

Performance_counter02 needs to know the number of max available hardware
counters on PMU, we use the below methods to get this number.

Accordind to perf_event_open()'s manpage, once a perf_event_open() fd has
been opened, the values of the events can be read from the file descriptor.
The values are specified by the read_format field in the perf_event_attr
structure at open time. Here is the layout of the data returned by a read:

If PERF_FORMAT_GROUP was not specified:
	struct read_format {
		u64 value;         /* The value of the event */
		u64 time_enabled;  /* if PERF_FORMAT_TOTAL_TIME_ENABLED */
		u64 time_running;  /* if PERF_FORMAT_TOTAL_TIME_RUNNING */
		u64 id;            /* if PERF_FORMAT_ID */
};

Normally time_enabled and time_running are the same value. But if more events are
started than available counter slots on the PMU, then multiplexing happens and
events run only part of the time. Time_enabled and time_running's values will be
different. In this case the time_enabled and time_running values can be used to
scale an estimated value for the count. So if time_enabled and time_running are
not equal, we can think that PMU hardware counters multiplexing happens and the
number of the opened events are the number of max available hardware counters.

Some cleanup.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/syscalls                                   |   1 +
 .../syscalls/perf_event_open/perf_event_open02.c   | 311 ++++++++++++++-------
 2 files changed, 212 insertions(+), 100 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index afbded3..da86dcf 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1354,3 +1354,4 @@ writev05 writev05
 writev06 writev06
 
 perf_event_open01 perf_event_open01
+perf_event_open02 perf_event_open02
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
index 5402b81..77cd122 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
@@ -47,10 +47,9 @@ counter->prev_count in arch/powerpc/kernel/perf_counter.c, and I think
 that means that enabling/disabling a group with a task clock counter
 in it won't work correctly (I'll do a test program for that next).
 
-Usage is: ./performance_counter02 [-c num-hw-counters] [-v]
+Usage is: ./performance_counter02  [-v]
 
-Use -c N if you have more than 8 hardware counters.  The -v flag makes
-it print out the values of each counter.
+The -v flag makes it print out the values of each counter.
 */
 
 #include <stdio.h>
@@ -66,68 +65,71 @@ it print out the values of each counter.
 #include <sys/types.h>
 #include <linux/types.h>
 
-/* Harness Specific Include Files. */
+#if HAVE_PERF_EVENT_ATTR
+#include <linux/perf_event.h>
+#endif
+
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 #include "linux_syscall_numbers.h"
 
-#define PR_TASK_PERF_COUNTERS_DISABLE           31
-#define PR_TASK_PERF_COUNTERS_ENABLE            32
+char *TCID = "performance_counter02";
+int TST_TOTAL = 1;
 
-/* Global Variables */
-char *TCID = "performance_counter02";	/* test program identifier.          */
-int TST_TOTAL = 1;		/* total number of tests in this file.   */
+#if HAVE_PERF_EVENT_ATTR
 
-typedef unsigned int u32;
-typedef unsigned long long u64;
-typedef long long s64;
+#define MAX_CTRS	1000
+#define LOOPS		1000000000
 
-struct perf_counter_hw_event {
-	s64 type;
-	u64 irq_period;
-	u32 record_type;
+static int count_hardware_counters(void);
+static void setup(void);
+static void verify(void);
+static void cleanup(void);
+static void help(void);
 
-	u32 disabled:1,		/* off by default */
-	 nmi:1,			/* NMI sampling   */
-	 raw:1,			/* raw event type */
-	 __reserved_1:29;
-	u64 __reserved_2;
+static int n, nhw;
+static int verbose;
+static option_t options[] = {
+	{"v", &verbose, NULL},
+	{NULL, NULL, NULL},
 };
 
-enum hw_event_types {
-	PERF_COUNT_CYCLES = 0,
-	PERF_COUNT_INSTRUCTIONS = 1,
-	PERF_COUNT_CACHE_REFERENCES = 2,
-	PERF_COUNT_CACHE_MISSES = 3,
-	PERF_COUNT_BRANCH_INSTRUCTIONS = 4,
-	PERF_COUNT_BRANCH_MISSES = 5,
+static int tsk0;
+static int hwfd[MAX_CTRS], tskfd[MAX_CTRS];
 
-	/*
-	 * Special "software" counters provided by the kernel, even if
-	 * the hardware does not support performance counters. These
-	 * counters measure various physical and sw events of the
-	 * kernel (and allow the profiling of them as well):
-	 */
-	PERF_COUNT_CPU_CLOCK = -1,
-	PERF_COUNT_TASK_CLOCK = -2,
-	/*
-	 * Future software events:
-	 */
-	/* PERF_COUNT_PAGE_FAULTS       = -3,
-	   PERF_COUNT_CONTEXT_SWITCHES  = -4, */
-};
+int main(int ac, char **av)
+{
+	int lc;
+	char *msg;
+
+	msg = parse_opts(ac, av, options, help);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-int sys_perf_counter_open(struct perf_counter_hw_event *hw_event,
-			  pid_t pid, int cpu, int group_fd, unsigned long flags)
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+		verify();
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static int perf_event_open(struct perf_event_attr *hw_event, pid_t pid,
+	int cpu, int group_fd, unsigned long flags)
 {
-	return ltp_syscall(__NR_perf_event_open, hw_event, pid, cpu, group_fd,
-		       flags);
+	int ret;
+
+	ret = ltp_syscall(__NR_perf_event_open, hw_event, pid, cpu,
+			  group_fd, flags);
+	return ret;
 }
 
-#define MAX_CTRS	50
-#define LOOPS	1000000000
 
-void do_work(void)
+static void do_work(void)
 {
 	int i;
 
@@ -135,81 +137,175 @@ void do_work(void)
 		asm volatile (""::"g" (i));
 }
 
-void cleanup(void)
-{				/* Stub function. */
-}
+struct read_format {
+	unsigned long long value;
+	/* if PERF_FORMAT_TOTAL_TIME_ENABLED */
+	unsigned long long time_enabled;
+	/* if PERF_FORMAT_TOTAL_TIME_RUNNING */
+	unsigned long long time_running;
+};
 
-int main(int ac, char **av)
+static int count_hardware_counters(void)
 {
-	int tsk0;
-	int hwfd[MAX_CTRS], tskfd[MAX_CTRS];
-	struct perf_counter_hw_event tsk_event;
-	struct perf_counter_hw_event hw_event;
-	unsigned long long vt0, vt[MAX_CTRS], vh[MAX_CTRS], vtsum, vhsum;
-	int i, n, nhw;
-	int verbose = 0;
-	double ratio;
+	struct perf_event_attr hw_event;
+	int i, hwctrs = 0;
+	int fdarry[MAX_CTRS];
+	struct read_format buf;
 
-	nhw = 8;
-	while ((i = getopt(ac, av, "c:v")) != -1) {
-		switch (i) {
-		case 'c':
-			n = atoi(optarg);
-			break;
-		case 'v':
-			verbose = 1;
+	memset(&hw_event, 0, sizeof(struct perf_event_attr));
+
+	hw_event.type = PERF_TYPE_HARDWARE;
+	hw_event.size = sizeof(struct perf_event_attr);
+	hw_event.disabled = 1;
+	hw_event.config =  PERF_COUNT_HW_INSTRUCTIONS;
+	hw_event.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
+		PERF_FORMAT_TOTAL_TIME_RUNNING;
+
+	for (i = 0; i < MAX_CTRS; i++) {
+		fdarry[i] = perf_event_open(&hw_event, 0, -1, -1, 0);
+		if (fdarry[i] == -1) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "perf_event_open failed at iteration:%d", i);
+		}
+
+		if (prctl(PR_TASK_PERF_EVENTS_ENABLE) == -1) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "prctl(PR_TASK_PERF_EVENTS_ENABLE) failed");
+		}
+
+		do_work();
+
+		if (prctl(PR_TASK_PERF_EVENTS_DISABLE) == -1) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "prctl(PR_TASK_PERF_EVENTS_DISABLE) failed");
+		}
+
+		if (read(fdarry[i], &buf, sizeof(buf)) != sizeof(buf)) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "error reading counter(s)");
+		}
+
+		if (verbose == 1) {
+			printf("at iteration:%d value:%lld time_enabled:%lld "
+			       "time_running:%lld\n", i, buf.value,
+			       buf.time_enabled, buf.time_running);
+		}
+
+		/*
+		 * Normally time_enabled and time_running are the same value.
+		 * But if more events are started than available counter slots
+		 * on the PMU, then multiplexing happens and events run only
+		 * part of the time. Time_enabled and time_running's values
+		 * will be different. In this case the time_enabled and time_
+		 * running values can be used to scale an estimated value for
+		 * the count. So if buf.time_enabled and buf.time_running are
+		 * not equal, we can think that PMU hardware counters
+		 * multiplexing happens and the number of the opened events
+		 * are the number of max available hardware counters.
+		 */
+		if (buf.time_enabled != buf.time_running) {
+			hwctrs = i;
 			break;
-		case '?':
-			fprintf(stderr, "Usage: %s [-c #hwctrs] [-v]\n", av[0]);
-			exit(1);
 		}
 	}
 
-	if (nhw < 0 || nhw > MAX_CTRS - 4) {
-		fprintf(stderr, "invalid number of hw counters specified: %d\n",
-			nhw);
-		exit(1);
-	}
+	for (i = 0; i <= hwctrs; i++)
+		SAFE_CLOSE(cleanup, fdarry[i]);
 
+	return hwctrs;
+}
+
+static void setup(void)
+{
+	int i;
+	struct perf_event_attr tsk_event, hw_event;
+
+	/*
+	 * According to perf_event_open's manpage, the official way of
+	 * knowing if perf_event_open() support is enabled is checking for
+	 * the existence of the file /proc/sys/kernel/perf_event_paranoid.
+	 */
+	if (access("/proc/sys/kernel/perf_event_paranoid", F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Kernel doesn't have perf_event support");
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	nhw = count_hardware_counters();
 	n = nhw + 4;
 
-	memset(&tsk_event, 0, sizeof(tsk_event));
-	tsk_event.type = PERF_COUNT_TASK_CLOCK;
+	memset(&hw_event, 0, sizeof(struct perf_event_attr));
+	memset(&tsk_event, 0, sizeof(struct perf_event_attr));
+
+	tsk_event.type =  PERF_TYPE_SOFTWARE;
+	tsk_event.size = sizeof(struct perf_event_attr);
 	tsk_event.disabled = 1;
+	tsk_event.config = PERF_COUNT_SW_TASK_CLOCK;
 
-	memset(&hw_event, 0, sizeof(hw_event));
+	hw_event.type = PERF_TYPE_HARDWARE;
+	hw_event.size = sizeof(struct perf_event_attr);
 	hw_event.disabled = 1;
-	hw_event.type = PERF_COUNT_INSTRUCTIONS;
+	hw_event.config =  PERF_COUNT_HW_INSTRUCTIONS;
 
-	tsk0 = sys_perf_counter_open(&tsk_event, 0, -1, -1, 0);
+	tsk0 = perf_event_open(&tsk_event, 0, -1, -1, 0);
 	if (tsk0 == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "perf_counter_open failed (1)");
+		tst_brkm(TBROK | TERRNO, cleanup, "perf_event_open failed");
 	} else {
-
 		tsk_event.disabled = 0;
 		for (i = 0; i < n; ++i) {
-			hwfd[i] = sys_perf_counter_open(&hw_event, 0, -1,
-							-1, 0);
-			tskfd[i] = sys_perf_counter_open(&tsk_event, 0, -1,
-							 hwfd[i], 0);
+			hwfd[i] = perf_event_open(&hw_event, 0, -1, -1, 0);
+			tskfd[i] = perf_event_open(&tsk_event, 0, -1,
+						   hwfd[i], 0);
 			if (tskfd[i] == -1 || hwfd[i] == -1) {
 				tst_brkm(TBROK | TERRNO, cleanup,
-					 "perf_counter_open failed (2)");
+					 "perf_event_open failed");
 			}
 		}
 	}
+}
+
+static void cleanup(void)
+{
+	int i;
+
+	TEST_CLEANUP;
+
+	for (i = 0; i < n; i++) {
+		if (hwfd[i] > 0 && close(hwfd[i]) == -1)
+			tst_resm(TWARN | TERRNO, "close(%d) failed", hwfd[i]);
+		if (tskfd[i] > 0 && close(tskfd[i]) == -1)
+			tst_resm(TWARN | TERRNO, "close(%d) failed", tskfd[i]);
+	}
+
+	if (tsk0 > 0 && close(tsk0) == -1)
+		tst_resm(TWARN | TERRNO, "close(%d) failed", tsk0);
+}
+
+static void verify(void)
+{
+	unsigned long long vt0, vt[MAX_CTRS], vh[MAX_CTRS];
+	unsigned long long vtsum = 0, vhsum = 0;
+	int i;
+	double ratio;
+
+	if (prctl(PR_TASK_PERF_EVENTS_ENABLE) == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "prctl(PR_TASK_PERF_EVENTS_ENABLE) failed");
+	}
 
-	prctl(PR_TASK_PERF_COUNTERS_ENABLE);
 	do_work();
-	prctl(PR_TASK_PERF_COUNTERS_DISABLE);
+
+	if (prctl(PR_TASK_PERF_EVENTS_DISABLE) == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "prctl(PR_TASK_PERF_EVENTS_DISABLE) failed");
+	}
 
 	if (read(tsk0, &vt0, sizeof(vt0)) != sizeof(vt0)) {
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "error reading task clock counter");
 	}
 
-	vtsum = vhsum = 0;
 	for (i = 0; i < n; ++i) {
 		if (read(tskfd[i], &vt[i], sizeof(vt[i])) != sizeof(vt[i]) ||
 		    read(hwfd[i], &vh[i], sizeof(vh[i])) != sizeof(vh[i])) {
@@ -220,23 +316,38 @@ int main(int ac, char **av)
 		vhsum += vh[i];
 	}
 
-	tst_resm(TINFO, "overall task clock: %lld", vt0);
-	tst_resm(TINFO, "hw sum: %lld, task clock sum: %lld", vhsum, vtsum);
-	if (verbose) {
+	tst_resm(TINFO, "overall task clock: %llu", vt0);
+	tst_resm(TINFO, "hw sum: %llu, task clock sum: %llu", vhsum, vtsum);
+
+	if (verbose == 1) {
 		printf("hw counters:");
 		for (i = 0; i < n; ++i)
-			printf(" %lld", vh[i]);
+			printf(" %llu", vh[i]);
 		printf("\ntask clock counters:");
 		for (i = 0; i < n; ++i)
-			printf(" %lld", vt[i]);
+			printf(" %llu", vt[i]);
 		printf("\n");
 	}
+
 	ratio = (double)vtsum / vt0;
 	tst_resm(TINFO, "ratio: %.2f", ratio);
 	if (ratio > nhw + 0.0001) {
 		tst_resm(TFAIL, "test failed (ratio was greater than )");
 	} else {
-		tst_resm(TINFO, "test passed");
+		tst_resm(TPASS, "test passed");
 	}
-	tst_exit();
 }
+
+static void help(void)
+{
+	printf("-v  print verbose infomation\n");
+}
+#else
+
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "This system doesn't have "
+		 "header file:<linux/perf_event.h> or "
+		 "no struct perf_event_attr defined");
+}
+#endif
-- 
1.8.2.1


------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
