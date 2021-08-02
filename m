From: Martin Doucha <mdoucha@suse.cz>
Date: Mon,  2 Aug 2021 18:09:18 +0200
Subject: [LTP] [PATCH 2/2] perf_event_open02: Use common perf_event_open()
 wrapper
In-Reply-To: <20210802160918.30861-1-mdoucha@suse.cz>
References: <20210802160918.30861-1-mdoucha@suse.cz>
Message-ID: <20210802160918.30861-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../perf_event_open/perf_event_open02.c       | 28 +------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
index eead421ac..7200d35e3 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
@@ -29,7 +29,6 @@
 
 #define _GNU_SOURCE
 #include <errno.h>
-#include <inttypes.h>
 #include <sched.h>
 #include <signal.h>
 #include <stddef.h>
@@ -47,8 +46,7 @@
 #include "lapi/syscalls.h"
 
 #if HAVE_PERF_EVENT_ATTR
-#include <linux/types.h>
-#include <linux/perf_event.h>
+#include "perf_event_open.h"
 
 #define MAX_CTRS	1000
 
@@ -67,30 +65,6 @@ static int tsk0 = -1, hwfd[MAX_CTRS], tskfd[MAX_CTRS];
 static int volatile work_done;
 static unsigned int est_loops;
 
-static int perf_event_open(struct perf_event_attr *event, pid_t pid,
-	int cpu, int group_fd, unsigned long flags)
-{
-	int ret;
-
-	ret = tst_syscall(__NR_perf_event_open, event, pid, cpu,
-		group_fd, flags);
-
-	if (ret != -1)
-		return ret;
-
-	tst_res(TINFO, "perf_event_open event.type: %"PRIu32
-		", event.config: %"PRIu64, (uint32_t)event->type,
-		(uint64_t)event->config);
-	if (errno == ENOENT || errno == ENODEV) {
-		tst_brk(TCONF | TERRNO,
-			"perf_event_open type/config not supported");
-	}
-	tst_brk(TBROK | TERRNO, "perf_event_open failed");
-
-	/* unreachable */
-	return -1;
-}
-
 static void all_counters_set(int state)
 {
 	if (prctl(state) == -1)
-- 
2.32.0

