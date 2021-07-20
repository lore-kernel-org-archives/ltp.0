From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Tue, 20 Jul 2021 16:33:11 +0300
Subject: [LTP] [PATCH 03/16] syscalls/sched_getparam03: use tst_sched_*()
In-Reply-To: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
References: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210720133324.21752-4-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 testcases/kernel/syscalls/sched_getparam/sched_getparam03.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c b/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
index 19ecaf147..451bfdc50 100644
--- a/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
+++ b/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
@@ -17,8 +17,8 @@
  */
 
 #include <errno.h>
-#include <sched.h>
 #include "tst_test.h"
+#include "tst_sched.h"
 
 static struct sched_param param;
 static pid_t unused_pid;
@@ -43,7 +43,7 @@ static void verify_sched_getparam(unsigned int n)
 {
 	struct test_case_t *tc = &test_cases[n];
 
-	TST_EXP_FAIL(sched_getparam(*(tc->pid), tc->p), tc->exp_errno, "%s", tc->desc);
+	TST_EXP_FAIL(tst_sched_getparam(*(tc->pid), tc->p), tc->exp_errno, "%s", tc->desc);
 }
 
 static void setup(void)
-- 
2.25.1

