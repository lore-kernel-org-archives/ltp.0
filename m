From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Fri,  6 Aug 2021 19:47:17 +0300
Subject: [LTP] [PATCH v2 03/16] syscalls/sched_getparam03: use
 libc/sys_sched_*()
In-Reply-To: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
References: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210806164730.51040-4-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 .../syscalls/sched_getparam/sched_getparam03.c      | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c b/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
index 19ecaf147..3cbfae149 100644
--- a/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
+++ b/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
@@ -17,14 +17,19 @@
  */
 
 #include <errno.h>
-#include <sched.h>
 #include "tst_test.h"
+#include "tst_sched.h"
 
 static struct sched_param param;
 static pid_t unused_pid;
 static pid_t zero_pid;
 static pid_t inval_pid = -1;
 
+static struct sched_variants variants[] = {
+	{ .sched_getparam = libc_sched_getparam, .desc = "libc"},
+	{ .sched_getparam = sys_sched_getparam, .desc = "syscall"},
+};
+
 static struct test_case_t {
 	char *desc;
 	pid_t *pid;
@@ -42,17 +47,21 @@ static struct test_case_t {
 static void verify_sched_getparam(unsigned int n)
 {
 	struct test_case_t *tc = &test_cases[n];
+	struct sched_variants *tv = &variants[tst_variant];
 
-	TST_EXP_FAIL(sched_getparam(*(tc->pid), tc->p), tc->exp_errno, "%s", tc->desc);
+	TST_EXP_FAIL(tv->sched_getparam(*(tc->pid), tc->p), tc->exp_errno,
+		     "%s", tc->desc);
 }
 
 static void setup(void)
 {
+	tst_res(TINFO, "Testing %s variant", variants[tst_variant].desc);
 	unused_pid = tst_get_unused_pid();
 }
 
 static struct tst_test test = {
 	.setup = setup,
+	.test_variants = ARRAY_SIZE(variants),
 	.tcnt = ARRAY_SIZE(test_cases),
 	.test = verify_sched_getparam,
 };
-- 
2.25.1

