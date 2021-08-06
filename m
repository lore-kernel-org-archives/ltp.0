From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Fri,  6 Aug 2021 19:47:16 +0300
Subject: [LTP] [PATCH v2 02/16] syscalls/sched_getparam01: use
 libc/sys_sched_*()
In-Reply-To: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
References: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210806164730.51040-3-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 .../syscalls/sched_getparam/sched_getparam01.c  | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c b/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
index efb697707..46cf946a5 100644
--- a/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
+++ b/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
@@ -21,22 +21,28 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <unistd.h>
-#include <sched.h>
 #include "tst_test.h"
+#include "tst_sched.h"
+
+static struct sched_variants variants[] = {
+	{ .sched_getparam = libc_sched_getparam, .desc = "libc" },
+	{ .sched_getparam = sys_sched_getparam, .desc = "syscall" },
+};
 
 static pid_t pids[2] = {0, 0};
 
 static void verify_sched_getparam(unsigned int n)
 {
 	pid_t child_pid;
+	struct sched_variants *tv = &variants[tst_variant];
 	struct sched_param param = {
 		.sched_priority = 100,
 	};
 
 	child_pid = SAFE_FORK();
 	if (!child_pid) {
-		TST_EXP_PASS_SILENT(sched_getparam(pids[n], &param),
-				    "sched_getparam(%d)", pids[n]);
+		TST_EXP_PASS_SILENT(tv->sched_getparam(pids[n], &param),
+				   "sched_getparam(%d)", pids[n]);
 		if (!TST_PASS)
 			exit(0);
 
@@ -59,12 +65,17 @@ static void verify_sched_getparam(unsigned int n)
 
 static void setup(void)
 {
+	struct sched_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing %s variant", tv->desc);
+
 	pids[1] = getpid();
 }
 
 static struct tst_test test = {
 	.forks_child = 1,
 	.setup = setup,
+	.test_variants = ARRAY_SIZE(variants),
 	.tcnt = ARRAY_SIZE(pids),
 	.test = verify_sched_getparam,
 };
-- 
2.25.1

