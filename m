From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Tue, 20 Jul 2021 16:33:22 +0300
Subject: [LTP] [PATCH 14/16] syscalls/sched_setscheduler03: use tst_sched_*()
In-Reply-To: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
References: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210720133324.21752-15-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 .../syscalls/sched_setscheduler/sched_setscheduler03.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c
index 9045d0366..af4b29300 100644
--- a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c
@@ -17,13 +17,13 @@
 #include <stdio.h>
 #include <errno.h>
 #include <pwd.h>
-#include <sched.h>
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <sys/wait.h>
 #include <stdlib.h>
 
 #include "tst_test.h"
+#include "tst_sched.h"
 
 #define RLIMIT_NICE_NORMAL 20
 
@@ -96,8 +96,8 @@ static void verify_fn(unsigned int i)
 		"Verifying case[%d]: policy = %d, priority = %d",
 		i + 1, cases[i].policy, cases[i].sched_param->sched_priority);
 
-	TEST(sched_setscheduler(*cases[i].pid, cases[i].policy,
-					cases[i].sched_param));
+	TEST(tst_sched_setscheduler(*cases[i].pid, cases[i].policy,
+				    cases[i].sched_param));
 	if (TST_RET)
 		tst_res(TFAIL | TTERRNO, "case[%d] expected: %d, got: ",
 			i + 1, cases[i].error);
@@ -129,11 +129,11 @@ static void setup(void)
 	l_rlimit_setup(RLIMIT_NICE, &limit);
 
 	tst_res(TINFO, "Setting init sched policy to SCHED_OTHER");
-	if (sched_setscheduler(0, SCHED_OTHER, &param[0]) != 0)
+	if (tst_sched_setscheduler(0, SCHED_OTHER, &param[0]) != 0)
 		tst_res(TFAIL | TERRNO,
 			 "ERROR sched_setscheduler: (0, SCHED_OTHER, param)");
 
-	if (sched_getscheduler(0) != SCHED_OTHER)
+	if (tst_sched_getscheduler(0) != SCHED_OTHER)
 		tst_res(TFAIL | TERRNO, "ERROR sched_setscheduler");
 
 	tst_res(TINFO, "Setting euid to nobody to drop privilege");
-- 
2.25.1

