From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 21 Jul 2016 21:26:45 -0700
Subject: [LTP] [PATCH V3 12/23] trace_shed: Adapt to glibc 2.24 removal of
	union wait type
In-Reply-To: <20160722042656.22346-1-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
Message-ID: <20160722042656.22346-12-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is now needed since glibc commit
https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=b49ab5f4503f36dcbf43f821f817da66b2931fe6;hp=5f5682b9654101ccaf375c2814cbddbe6033a725

The thread return status is
either -1 or pointer to the table. So there is no point in passing it to
WEXITSTATUS() and priting the value

fixes below error

trace_sched.c:425:16: error: invalid operands to binary & (have
'thread_sched_t * {aka struct <anonymous> *}' and 'int')
      thrd_ndx, WEXITSTATUS(status));

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/sched/tool/trace_sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/sched/tool/trace_sched.c b/testcases/kernel/sched/tool/trace_sched.c
index 7815686..71caf23 100644
--- a/testcases/kernel/sched/tool/trace_sched.c
+++ b/testcases/kernel/sched/tool/trace_sched.c
@@ -421,8 +421,8 @@ int main(int argc,		/* number of input parameters.                        */
 		} else {
 			if (status == (thread_sched_t *) - 1) {
 				fprintf(stderr,
-					"thread [%d] - process exited with errors %d\n",
-					thrd_ndx, WEXITSTATUS(status));
+					"thread [%d] - process exited with exit code -1\n",
+					thrd_ndx);
 				exit(-1);
 			} else {
 				exp_prio[thrd_ndx] = status->exp_prio;
-- 
2.9.0

