Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WPShj-00028t-Mc
	for ltp-list@lists.sourceforge.net; Mon, 17 Mar 2014 08:15:27 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WPShh-00055S-Gm
	for ltp-list@lists.sourceforge.net; Mon, 17 Mar 2014 08:15:27 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s2H8FAXT003911
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Mar 2014 16:15:10 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Mon, 17 Mar 2014 16:13:30 +0800
Message-Id: <1395044011-31911-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1395044011-31911-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1395044011-31911-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH 2/3] performance_counters/performance_counter02.c:
	cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
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

Some cleanup.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 .../performance_counters/performance_counter02.c   | 247 ++++++++++++---------
 1 file changed, 143 insertions(+), 104 deletions(-)

diff --git a/testcases/kernel/performance_counters/performance_counter02.c b/testcases/kernel/performance_counters/performance_counter02.c
index 5402b81..d31c28a 100644
--- a/testcases/kernel/performance_counters/performance_counter02.c
+++ b/testcases/kernel/performance_counters/performance_counter02.c
@@ -47,9 +47,9 @@ counter->prev_count in arch/powerpc/kernel/perf_counter.c, and I think
 that means that enabling/disabling a group with a task clock counter
 in it won't work correctly (I'll do a test program for that next).
 
-Usage is: ./performance_counter02 [-c num-hw-counters] [-v]
+Usage is: ./performance_counter02 [-C num-hw-counters] [-v]
 
-Use -c N if you have more than 8 hardware counters.  The -v flag makes
+Use -C N if you have more than 8 hardware counters.  The -v flag makes
 it print out the values of each counter.
 */
 
@@ -65,69 +65,82 @@ it print out the values of each counter.
 #include <sys/prctl.h>
 #include <sys/types.h>
 #include <linux/types.h>
+#if HAVE_PERF_EVENT_OPEN_SYSCALL
+#include <linux/perf_event.h>
+#endif
 
-/* Harness Specific Include Files. */
 #include "test.h"
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
 
-#define PR_TASK_PERF_COUNTERS_DISABLE           31
-#define PR_TASK_PERF_COUNTERS_ENABLE            32
+char *TCID = "performance_counter02";
+int TST_TOTAL = 1;
 
-/* Global Variables */
-char *TCID = "performance_counter02";	/* test program identifier.          */
-int TST_TOTAL = 1;		/* total number of tests in this file.   */
+#if HAVE_PERF_EVENT_OPEN_SYSCALL
 
-typedef unsigned int u32;
-typedef unsigned long long u64;
-typedef long long s64;
+#define MAX_CTRS	50
+#define LOOPS		1000000000
+
+static void setup(void);
+static void verify(void);
+static void cleanup(void);
+static void help(void);
+
+static int nhw = 8;
+static int n;
+static int verbose;
+static char *nhw_str;
+static option_t options[] = {
+	{"C:", NULL, &nhw_str},
+	{"v", &verbose, NULL},
+	{NULL, NULL, NULL},
+};
 
-struct perf_counter_hw_event {
-	s64 type;
-	u64 irq_period;
-	u32 record_type;
+static int tsk0;
+static int hwfd[MAX_CTRS], tskfd[MAX_CTRS];
 
-	u32 disabled:1,		/* off by default */
-	 nmi:1,			/* NMI sampling   */
-	 raw:1,			/* raw event type */
-	 __reserved_1:29;
-	u64 __reserved_2;
-};
+int main(int ac, char **av)
+{
+	int i, lc;
+	char *msg;
+
+	msg = parse_opts(ac, av, options, help);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	if (nhw_str) {
+		nhw = atoi(nhw_str);
+		if (nhw < 0 || nhw > MAX_CTRS - 4) {
+			tst_brkm(TCONF, NULL, "invalid number of "
+				 "hw counters specified: %d", nhw);
+		}
+	}
 
-enum hw_event_types {
-	PERF_COUNT_CYCLES = 0,
-	PERF_COUNT_INSTRUCTIONS = 1,
-	PERF_COUNT_CACHE_REFERENCES = 2,
-	PERF_COUNT_CACHE_MISSES = 3,
-	PERF_COUNT_BRANCH_INSTRUCTIONS = 4,
-	PERF_COUNT_BRANCH_MISSES = 5,
+	setup();
 
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
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)
+			verify();
+	}
+
+	cleanup();
+	tst_exit();
+}
 
-int sys_perf_counter_open(struct perf_counter_hw_event *hw_event,
-			  pid_t pid, int cpu, int group_fd, unsigned long flags)
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
 
@@ -135,81 +148,93 @@ void do_work(void)
 		asm volatile (""::"g" (i));
 }
 
-void cleanup(void)
-{				/* Stub function. */
-}
-
-int main(int ac, char **av)
+static void setup(void)
 {
-	int tsk0;
-	int hwfd[MAX_CTRS], tskfd[MAX_CTRS];
-	struct perf_counter_hw_event tsk_event;
-	struct perf_counter_hw_event hw_event;
-	unsigned long long vt0, vt[MAX_CTRS], vh[MAX_CTRS], vtsum, vhsum;
-	int i, n, nhw;
-	int verbose = 0;
-	double ratio;
+	int i;
+	static struct perf_event_attr tsk_event, hw_event;
 
-	nhw = 8;
-	while ((i = getopt(ac, av, "c:v")) != -1) {
-		switch (i) {
-		case 'c':
-			n = atoi(optarg);
-			break;
-		case 'v':
-			verbose = 1;
-			break;
-		case '?':
-			fprintf(stderr, "Usage: %s [-c #hwctrs] [-v]\n", av[0]);
-			exit(1);
-		}
-	}
+	/*
+	 * According to perf_event_open's manpage, the official way of
+	 * knowing if perf_event_open() support is enabled is checking for
+	 * the existence of the file /proc/sys/kernel/perf_event_paranoid.
+	 */
+	if (access("/proc/sys/kernel/perf_event_paranoid", F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Kernel doesn't have perf_event support");
 
-	if (nhw < 0 || nhw > MAX_CTRS - 4) {
-		fprintf(stderr, "invalid number of hw counters specified: %d\n",
-			nhw);
-		exit(1);
-	}
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
 
 	n = nhw + 4;
 
-	memset(&tsk_event, 0, sizeof(tsk_event));
-	tsk_event.type = PERF_COUNT_TASK_CLOCK;
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
@@ -220,23 +245,37 @@ int main(int ac, char **av)
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
+	printf("-C number of hardware counters\n");
+}
+#else
+
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "This system doesn't have "
+		 "required perf_event_open syscall support");
+}
+#endif
-- 
1.8.2.1


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
