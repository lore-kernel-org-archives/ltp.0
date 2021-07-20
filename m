From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Tue, 20 Jul 2021 16:33:17 +0300
Subject: [LTP] [PATCH 09/16] syscalls/sched_rr_get_interval01: use
 tst_sched_*()
In-Reply-To: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
References: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210720133324.21752-10-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 .../syscalls/sched_rr_get_interval/sched_rr_get_interval01.c  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
index 5da5fe51d..cd6525414 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
@@ -11,9 +11,9 @@
  * timeslice tuning knob in milliseconds").
  */
 
-#include <sched.h>
 #include "time64_variants.h"
 #include "tst_timer.h"
+#include "tst_sched.h"
 
 #define PROC_SCHED_RR_TIMESLICE_MS	"/proc/sys/kernel/sched_rr_timeslice_ms"
 static int proc_flag;
@@ -41,7 +41,7 @@ static void setup(void)
 
 	tp.type = tv->ts_type;
 
-	if ((sched_setscheduler(0, SCHED_RR, &p)) == -1)
+	if ((tst_sched_setscheduler(0, SCHED_RR, &p)) == -1)
 		tst_res(TFAIL | TERRNO, "sched_setscheduler() failed");
 
 	proc_flag = !access(PROC_SCHED_RR_TIMESLICE_MS, F_OK);
-- 
2.25.1

