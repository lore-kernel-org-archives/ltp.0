From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Tue, 20 Jul 2021 16:33:10 +0300
Subject: [LTP] [PATCH 02/16] syscalls/sched_getparam01: use tst_sched_*()
In-Reply-To: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
References: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210720133324.21752-3-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 testcases/kernel/syscalls/sched_getparam/sched_getparam01.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c b/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
index efb697707..c24d1c917 100644
--- a/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
+++ b/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
@@ -21,8 +21,8 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <unistd.h>
-#include <sched.h>
 #include "tst_test.h"
+#include "tst_sched.h"
 
 static pid_t pids[2] = {0, 0};
 
@@ -35,8 +35,8 @@ static void verify_sched_getparam(unsigned int n)
 
 	child_pid = SAFE_FORK();
 	if (!child_pid) {
-		TST_EXP_PASS_SILENT(sched_getparam(pids[n], &param),
-				    "sched_getparam(%d)", pids[n]);
+		TST_EXP_PASS_SILENT(tst_sched_getparam(pids[n], &param),
+				   "sched_getparam(%d)", pids[n]);
 		if (!TST_PASS)
 			exit(0);
 
-- 
2.25.1

