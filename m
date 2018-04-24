From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Apr 2018 14:49:57 +0200
Subject: [LTP] [PATCH] [RFC] syscalls/perf_event_open02: Fix failures
Message-ID: <20180424124957.15634-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The testcase was failing randomly, it could be reproduced easily when
the machine is under load. To reproduce the issue just run a few
dd if=/dev/zero of=/dev/null to saturate your CPUs.

It has been sugessted that the reason for the failure are rounding
errors caused by a frequent preemption. I haven't got a definitive
answer from kernel devs for this but it's true that changing the process
pritority to realtime SCHED_FIFO for the measurement does fix the issue.

So we either delete the test or apply this patch.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/perf_event_open/perf_event_open02.c     | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
index 13a17948a..0590ffb43 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
@@ -64,6 +64,7 @@ The -v flag makes it print out the values of each counter.
 #include <sys/prctl.h>
 #include <sys/types.h>
 #include <linux/types.h>
+#include <sched.h>
 
 #if HAVE_PERF_EVENT_ATTR
 # include <linux/perf_event.h>
@@ -286,6 +287,12 @@ static void verify(void)
 	unsigned long long vtsum = 0, vhsum = 0;
 	int i;
 	double ratio;
+	struct sched_param sparam = {.sched_priority = 1};
+
+	if (sched_setscheduler(0, SCHED_FIFO, &sparam)) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "sched_setscheduler(0, SCHED_FIFO, ...) failed");
+	}
 
 	if (prctl(PR_TASK_PERF_EVENTS_ENABLE) == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup,
@@ -299,6 +306,12 @@ static void verify(void)
 			 "prctl(PR_TASK_PERF_EVENTS_DISABLE) failed");
 	}
 
+	sparam.sched_priority = 0;
+	if (sched_setscheduler(0, SCHED_OTHER, &sparam)) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "sched_setscheduler(0, SCHED_OTHER, ...) failed");
+	}
+
 	if (read(tsk0, &vt0, sizeof(vt0)) != sizeof(vt0)) {
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "error reading task clock counter");
-- 
2.13.6

