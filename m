From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 18 Nov 2019 15:59:57 +0100
Subject: [LTP] [PATCH 3/3] perf_event_open02: workaround for Pentium4
In-Reply-To: <cover.1574087532.git.jstancek@redhat.com>
References: <cover.1574087532.git.jstancek@redhat.com>
Message-ID: <2d3bb4bc702e3fee3d356340a9384d68a4297f33.1574087532.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

perf_event_open02 has been observed to fail reliably on Pentium4,
because it detects wrong number of HW counters. This is because
time_enabled and time_running differ by a small value.

On Pentium4, p4_pmu_schedule_events() appears to be called repeatedly
for a group, for example when hwc pointer is being reused by different
cpu [1]. So, a group can fail to get scheduled on pmu on first attempt,
but *sched_in/*sched_out actions still happen. Event state changes
between ACTIVE/INACTIVE couple times, ctx->timestamp is updated as well.
Every time state changes a __perf_update_times() function is called,
which updates time_enabled and time_running. If state is INACTIVE,
only time_enabled is updated.

To workaround that, don't look at/compare absolute values. Instead
let process run for a bit and then look at increments. If both
are of same value, assume that no multiplexing happened and increase
"hwctrs" value.

Also always print time_enabled/time_running values. Number of HW
counters should be low and this data might come handy if a failure
is observed.

[1] 13beacee817d ("perf/x86/p4: Fix counter corruption when using lots of perf groups")

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../syscalls/perf_event_open/perf_event_open02.c   | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
index 5891694eb894..e89726dbcfdd 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
@@ -135,7 +135,7 @@ static int count_hardware_counters(void)
 	struct perf_event_attr hw_event;
 	int i, hwctrs = 0;
 	int fdarry[MAX_CTRS];
-	struct read_format buf;
+	struct read_format buf, buf2, diff;
 
 	memset(&hw_event, 0, sizeof(struct perf_event_attr));
 
@@ -151,16 +151,20 @@ static int count_hardware_counters(void)
 
 		all_counters_set(PR_TASK_PERF_EVENTS_ENABLE);
 		do_work(500);
+		if (read(fdarry[i], &buf, sizeof(buf)) != sizeof(buf))
+			tst_brk(TBROK | TERRNO, "error reading counter(s) #1");
+		do_work(500);
 		all_counters_set(PR_TASK_PERF_EVENTS_DISABLE);
+		if (read(fdarry[i], &buf2, sizeof(buf2)) != sizeof(buf2))
+			tst_brk(TBROK | TERRNO, "error reading counter(s) #2");
 
-		if (read(fdarry[i], &buf, sizeof(buf)) != sizeof(buf))
-			tst_brk(TBROK | TERRNO, "error reading counter(s)");
+		diff.value = buf2.value - buf.value;
+		diff.time_enabled = buf2.time_enabled - buf.time_enabled;
+		diff.time_running = buf2.time_running - buf.time_running;
 
-		if (verbose) {
-			tst_res(TINFO, "[%d] value:%lld time_enabled:%lld "
-			       "time_running:%lld", i, buf.value,
-			       buf.time_enabled, buf.time_running);
-		}
+		tst_res(TINFO, "[%d] value:%lld time_enabled:%lld "
+		       "time_running:%lld", i, diff.value,
+		       diff.time_enabled, diff.time_running);
 
 		/*
 		 * Normally time_enabled and time_running are the same value.
@@ -174,7 +178,7 @@ static int count_hardware_counters(void)
 		 * multiplexing happens and the number of the opened events
 		 * are the number of max available hardware counters.
 		 */
-		if (buf.time_enabled != buf.time_running) {
+		if (diff.time_enabled != diff.time_running) {
 			hwctrs = i;
 			break;
 		}
-- 
1.8.3.1

