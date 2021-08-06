From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Fri,  6 Aug 2021 19:47:25 +0300
Subject: [LTP] [PATCH v2 11/16] syscalls/sched_rr_get_interval03: use
 sys_sched_*()
In-Reply-To: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
References: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210806164730.51040-12-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 .../syscalls/sched_rr_get_interval/sched_rr_get_interval03.c  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
index a61541b8a..f5a88f084 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
@@ -12,9 +12,9 @@
  *     address specified as &tp is invalid
  */
 
-#include <sched.h>
 #include "time64_variants.h"
 #include "tst_timer.h"
+#include "tst_sched.h"
 
 static pid_t unused_pid;
 static pid_t inval_pid = -1;
@@ -55,7 +55,7 @@ static void setup(void)
 	bad_addr = tst_get_bad_addr(NULL);
 	tp.type = tv->ts_type;
 
-	if ((sched_setscheduler(0, SCHED_RR, &p)) == -1)
+	if ((sys_sched_setscheduler(0, SCHED_RR, &p)) == -1)
 		tst_res(TFAIL | TERRNO, "sched_setscheduler() failed");
 
 	unused_pid = tst_get_unused_pid();
-- 
2.25.1

