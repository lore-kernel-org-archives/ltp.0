From: Khem Raj <raj.khem@gmail.com>
Date: Fri,  8 Jan 2016 08:11:49 +0000
Subject: [LTP] [PATCH 29/31] trace_shed: Fix build with musl
In-Reply-To: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
References: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452240711-51180-29-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Errors on musl are

trace_sched.c:425:16: error: invalid operands to binary & (have
'thread_sched_t * {aka struct <anonymous> *}' and 'int')
      thrd_ndx, WEXITSTATUS(status));

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/sched/tool/trace_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/sched/tool/trace_sched.c b/testcases/kernel/sched/tool/trace_sched.c
index 7815686..30dca5f 100644
--- a/testcases/kernel/sched/tool/trace_sched.c
+++ b/testcases/kernel/sched/tool/trace_sched.c
@@ -422,7 +422,7 @@ int main(int argc,		/* number of input parameters.                        */
 			if (status == (thread_sched_t *) - 1) {
 				fprintf(stderr,
 					"thread [%d] - process exited with errors %d\n",
-					thrd_ndx, WEXITSTATUS(status));
+					thrd_ndx, WEXITSTATUS((int)status));
 				exit(-1);
 			} else {
 				exp_prio[thrd_ndx] = status->exp_prio;
-- 
2.7.0

