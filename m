From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Mon, 23 May 2016 13:45:34 +0800
Subject: [LTP] [PATCH] sched_setaffinity/sched_setaffinity01:kill child only
 when pid is positive
Message-ID: <20160523054534.GA9258@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If fork() failed, the privileged_pid will be equal to -1. Then the
kill() in the cleanup() will kill almost all processes on the system.

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c b/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
index dbaee26..70fda2c 100644
--- a/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
+++ b/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
@@ -84,7 +84,7 @@ static void cleanup(void)
 
 	SAFE_SETEUID(NULL, uid);
 
-	if (privileged_pid != 0) {
+	if (privileged_pid > 0) {
 		kill(privileged_pid, SIGKILL);
 		waitpid(privileged_pid, NULL, 0);
 		privileged_pid = 0;
-- 
1.9.3

