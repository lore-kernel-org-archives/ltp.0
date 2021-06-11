From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Jun 2021 16:38:43 +0200
Subject: [LTP] [PATCH] [COMMITTED] sched_rr_get_interval03: Make use of
 TST_EXP_FAIL()
Message-ID: <20210611143843.10982-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In order to simplify the code a bit.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../sched_rr_get_interval03.c                      | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
index cee9245e6..a61541b8a 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
@@ -78,18 +78,8 @@ static void run(unsigned int i)
 	else
 		ts = tst_ts_get(tc->tp);
 
-	TEST(tv->sched_rr_get_interval(*tc->pid, ts));
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "sched_rr_get_interval() passed unexpectedly");
-		return;
-	}
-
-	if (tc->exp_errno == TST_ERR)
-		tst_res(TPASS | TTERRNO, "sched_rr_get_interval() failed as expected");
-	else
-		tst_res(TFAIL | TTERRNO, "sched_rr_get_interval() failed unexpectedly: %s",
-			tst_strerrno(tc->exp_errno));
+	TST_EXP_FAIL(tv->sched_rr_get_interval(*tc->pid, ts), tc->exp_errno,
+	             "sched_rr_get_interval(%i, %p)", *tc->pid, ts);
 }
 
 static struct tst_test test = {
-- 
2.31.1

