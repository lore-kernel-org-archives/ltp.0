From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Fri,  6 Aug 2021 19:47:28 +0300
Subject: [LTP] [PATCH v2 14/16] syscalls/sched_setscheduler03: use
 libc/sys_sched_*()
In-Reply-To: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
References: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210806164730.51040-15-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 .../sched_setscheduler/sched_setscheduler03.c | 39 ++++++++++++-------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c
index 9045d0366..01385a08d 100644
--- a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c
@@ -17,19 +17,30 @@
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
 
 static pid_t zero_pid;
 static struct sched_param param[1] = { {0} };
 
+static struct sched_variants variants[] = {
+	{ .sched_setscheduler = libc_sched_setscheduler,
+	  .sched_getscheduler = libc_sched_getscheduler,
+	  .desc = "libc"
+	},
+	{ .sched_setscheduler = sys_sched_setscheduler,
+	  .sched_getscheduler = sys_sched_getscheduler,
+	  .desc = "syscall"
+	},
+};
+
 struct test_case_t {
 	pid_t *pid;
 	int policy;
@@ -92,26 +103,25 @@ static void l_rlimit_setup(const int type, struct rlimit *limit)
 
 static void verify_fn(unsigned int i)
 {
-	tst_res(TINFO,
-		"Verifying case[%d]: policy = %d, priority = %d",
+	struct sched_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Verifying case[%d]: policy = %d, priority = %d",
 		i + 1, cases[i].policy, cases[i].sched_param->sched_priority);
 
-	TEST(sched_setscheduler(*cases[i].pid, cases[i].policy,
-					cases[i].sched_param));
-	if (TST_RET)
-		tst_res(TFAIL | TTERRNO, "case[%d] expected: %d, got: ",
-			i + 1, cases[i].error);
-	else
-		tst_res(TPASS, "case[%d] succeeded", i + 1);
+	TST_EXP_PASS(tv->sched_setscheduler(*cases[i].pid, cases[i].policy,
+		     cases[i].sched_param));
 }
 
 static void setup(void)
 {
+	struct sched_variants *tv = &variants[tst_variant];
 	uid_t ruid, euid, suid;
 	struct rlimit limit;
 	struct passwd *pw;
 	uid_t nobody_uid;
 
+	tst_res(TINFO, "Testing %s variant", tv->desc);
+
 	pw = SAFE_GETPWNAM("nobody");
 	nobody_uid = pw->pw_uid;
 	l_rlimit_show(RLIMIT_NICE, &limit);
@@ -129,11 +139,9 @@ static void setup(void)
 	l_rlimit_setup(RLIMIT_NICE, &limit);
 
 	tst_res(TINFO, "Setting init sched policy to SCHED_OTHER");
-	if (sched_setscheduler(0, SCHED_OTHER, &param[0]) != 0)
-		tst_res(TFAIL | TERRNO,
-			 "ERROR sched_setscheduler: (0, SCHED_OTHER, param)");
-
-	if (sched_getscheduler(0) != SCHED_OTHER)
+	TST_EXP_PASS_SILENT(tv->sched_setscheduler(0, SCHED_OTHER, &param[0]),
+			    "sched_setscheduler(0, SCHED_OTHER, 0)");
+	if (tv->sched_getscheduler(0) != SCHED_OTHER)
 		tst_res(TFAIL | TERRNO, "ERROR sched_setscheduler");
 
 	tst_res(TINFO, "Setting euid to nobody to drop privilege");
@@ -159,6 +167,7 @@ static void do_test(unsigned int i)
 }
 
 static struct tst_test test = {
+	.test_variants = ARRAY_SIZE(variants),
 	.tcnt = ARRAY_SIZE(cases),
 	.test = do_test,
 	.setup = setup,
-- 
2.25.1

