From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 16 Oct 2019 16:05:54 +0200
Subject: [LTP] [PATCH v2] perf_event_open02: make test more reliable on -rt
 kernels
In-Reply-To: <1321370412.6455436.1571229760838.JavaMail.zimbra@redhat.com>
References: <1321370412.6455436.1571229760838.JavaMail.zimbra@redhat.com>
Message-ID: <94fbf60008417c187c1d9b4640d84af6c25afa29.1571234702.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test is failing on -rt kernels quite reliably as reported here:
  https://lkml.org/lkml/2019/8/14/714

Suspected cause is extra time spend in scheduler, which counts towards
test process hw counters.

Pin test process to single CPU (doesn't matter which one) to lessen
effects from scheduling:

ratio     Before        After
mean      5.02582       4.99844
stdev     0.0090435     0.0000272
          95+% FAIL     100% PASS

Tested with "perf_event_open02: stop groups with hw counters first" patch
on RHEL8 kernel-rt 4.18.0-147.rt24.93.el8.x86_64 (HP dl380g7).

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../syscalls/perf_event_open/perf_event_open02.c      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
index 1cfe29bb3d8a..c2831aa20d40 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
@@ -52,6 +52,7 @@ Usage is: ./performance_counter02  [-v]
 The -v flag makes it print out the values of each counter.
 */
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stddef.h>
 #include <stdlib.h>
@@ -72,6 +73,7 @@ The -v flag makes it print out the values of each counter.
 
 #include "test.h"
 #include "safe_macros.h"
+#include "lapi/cpuset.h"
 #include "lapi/syscalls.h"
 
 char *TCID = "perf_event_open02";
@@ -222,6 +224,23 @@ static void setup(void)
 	int i;
 	struct perf_event_attr tsk_event, hw_event;
 
+#ifdef HAVE_SCHED_GETCPU
+	int cpu = sched_getcpu();
+	size_t mask_size;
+	cpu_set_t *mask;
+
+	if (cpu == -1)
+		tst_brkm(TBROK | TERRNO, NULL, "sched_getcpu() failed");
+
+	mask = CPU_ALLOC(cpu + 1);
+	mask_size = CPU_ALLOC_SIZE(cpu + 1);
+	CPU_ZERO_S(mask_size, mask);
+	CPU_SET(cpu, mask);
+	if (sched_setaffinity(0, mask_size, mask) == -1)
+		tst_brkm(TBROK | TERRNO, NULL, "sched_setaffinity() failed");
+	CPU_FREE(mask);
+#endif
+
 	/*
 	 * According to perf_event_open's manpage, the official way of
 	 * knowing if perf_event_open() support is enabled is checking for
-- 
1.8.3.1

