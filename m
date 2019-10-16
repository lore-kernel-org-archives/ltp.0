From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 16 Oct 2019 13:24:44 +0200
Subject: [LTP] [PATCH 1/2] perf_event_open02: stop groups with hw counters
 first
Message-ID: <9c5134dc4b39f870f6e6cfab55c193f05b204b78.1571225074.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Nick reports that prctl(PR_TASK_PERF_EVENTS_DISABLE) doesn't stop tsk0
as last one, which sometimes causes test to fail, because of way test
calculates 'ratio' value and very low tolerance.

Looking at implementation, prctl() walks the list and does appear to
disable events in order they were created (tsk0 first).

Stop groups with hw counters before tsk0.

ratio     Before        After
mean      4.99921       4.99871
stdev     0.00006315    0.0000746

Fixes: #588
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/perf_event_open/perf_event_open02.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
index 95e30519fe42..1cfe29bb3d8a 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
@@ -324,6 +324,12 @@ static void verify(void)
 
 	do_work();
 
+	/* stop groups with hw counters first before tsk0 */
+	for (i = 0; i < n; i++) {
+		ioctl(hwfd[i], PERF_EVENT_IOC_DISABLE);
+		ioctl(tskfd[i], PERF_EVENT_IOC_DISABLE);
+	}
+
 	if (prctl(PR_TASK_PERF_EVENTS_DISABLE) == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "prctl(PR_TASK_PERF_EVENTS_DISABLE) failed");
-- 
1.8.3.1

