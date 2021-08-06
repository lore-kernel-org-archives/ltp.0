From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Fri,  6 Aug 2021 19:47:24 +0300
Subject: [LTP] [PATCH v2 10/16] syscalls/sched_rr_get_interval02: use
 sys_sched_*()
In-Reply-To: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
References: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210806164730.51040-11-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 .../syscalls/sched_rr_get_interval/sched_rr_get_interval02.c  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
index 9a0b8673d..15e4a3053 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
@@ -8,9 +8,9 @@
  * for tv_sec & tv_nsec.
  */
 
-#include <sched.h>
 #include "time64_variants.h"
 #include "tst_timer.h"
+#include "tst_sched.h"
 
 static struct tst_ts tp;
 
@@ -35,7 +35,7 @@ static void setup(void)
 
 	tp.type = tv->ts_type;
 
-	if ((sched_setscheduler(0, SCHED_FIFO, &p)) == -1)
+	if ((sys_sched_setscheduler(0, SCHED_FIFO, &p)) == -1)
 		tst_res(TFAIL | TERRNO, "sched_setscheduler() failed");
 }
 
-- 
2.25.1

