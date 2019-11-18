From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 18 Nov 2019 15:59:56 +0100
Subject: [LTP] [PATCH 2/3] perf_event_open02: make do_work() run for
 specified time
In-Reply-To: <cover.1574087532.git.jstancek@redhat.com>
References: <cover.1574087532.git.jstancek@redhat.com>
Message-ID: <5b0f2a837117f3af1351d8b3da357cacecaa1463.1574087532.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

do_work() runtime varies a lot, because it's based on a fixed
number of iterations. Set a timer and run for at least specified
time. We don't need fine accuracy, just some coarse runtime
across all systems. verify() function is using larger value to
get more precision for "ratio" calculation.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../syscalls/perf_event_open/perf_event_open02.c   | 36 +++++++++++++++++-----
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
index 584487de8255..5891694eb894 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
@@ -31,12 +31,14 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <sched.h>
+#include <signal.h>
 #include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
 #include <sys/prctl.h>
+#include <sys/time.h>
 #include <sys/types.h>
 
 #include "config.h"
@@ -49,7 +51,6 @@
 #include <linux/perf_event.h>
 
 #define MAX_CTRS	1000
-#define LOOPS		100000000
 
 struct read_format {
 	unsigned long long value;
@@ -67,6 +68,7 @@ static struct tst_option options[] = {
 
 static int ntotal, nhw;
 static int tsk0 = -1, hwfd[MAX_CTRS], tskfd[MAX_CTRS];
+static int volatile work_done;
 
 static int perf_event_open(struct perf_event_attr *event, pid_t pid,
 	int cpu, int group_fd, unsigned long flags)
@@ -98,14 +100,34 @@ static void all_counters_set(int state)
 		tst_brk(TBROK | TERRNO, "prctl(%d) failed", state);
 }
 
-static void do_work(void)
+void alarm_handler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+	work_done = 1;
+}
+
+static void do_work(int time_ms)
 {
 	int i;
+	struct sigaction sa;
+	struct itimerval val;
 
-	for (i = 0; i < LOOPS; ++i)
-		asm volatile (""::"g" (i));
-}
+	work_done = 0;
+	memset(&val, 0, sizeof(val));
+	val.it_value.tv_sec = time_ms / 1000;
+	val.it_value.tv_usec = (time_ms % 1000) * 1000;
 
+	sa.sa_handler = alarm_handler;
+	sa.sa_flags = SA_RESETHAND;
+	SAFE_SIGACTION(SIGALRM, &sa, NULL);
+
+	if (setitimer(ITIMER_REAL, &val, NULL))
+		tst_brk(TBROK | TERRNO, "setitimer");
+
+	while (!work_done) {
+		for (i = 0; i < 100000; ++i)
+			asm volatile (""::"g" (i));
+	}
+}
 
 #ifndef __s390__
 static int count_hardware_counters(void)
@@ -128,7 +150,7 @@ static int count_hardware_counters(void)
 		fdarry[i] = perf_event_open(&hw_event, 0, -1, -1, 0);
 
 		all_counters_set(PR_TASK_PERF_EVENTS_ENABLE);
-		do_work();
+		do_work(500);
 		all_counters_set(PR_TASK_PERF_EVENTS_DISABLE);
 
 		if (read(fdarry[i], &buf, sizeof(buf)) != sizeof(buf))
@@ -261,7 +283,7 @@ static void verify(void)
 	}
 
 	all_counters_set(PR_TASK_PERF_EVENTS_ENABLE);
-	do_work();
+	do_work(4000);
 	/* stop groups with hw counters first before tsk0 */
 	for (i = 0; i < ntotal; i++) {
 		ioctl(hwfd[i], PERF_EVENT_IOC_DISABLE);
-- 
1.8.3.1

