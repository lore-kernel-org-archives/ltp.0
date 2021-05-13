From: Konstantin Aladyshev <aladyshev22@gmail.com>
Date: Thu, 13 May 2021 15:15:41 +0300
Subject: [LTP] [PATCH] syscalls/sched_rr_get_interval: Fix typos
Message-ID: <20210513121541.1235-1-aladyshev22@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 .../sched_rr_get_interval/sched_rr_get_interval03.c         | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
index 67ad17793..0c9887f36 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
@@ -75,14 +75,14 @@ static void run(unsigned int i)
 	TEST(tv->sched_rr_get_interval(*tc->pid, ts));
 
 	if (TST_RET != -1) {
-		tst_res(TFAIL, "sched_rr_get_interval() passed unexcpectedly");
+		tst_res(TFAIL, "sched_rr_get_interval() passed unexpectedly");
 		return;
 	}
 
 	if (tc->exp_errno == TST_ERR)
-		tst_res(TPASS | TTERRNO, "sched_rr_get_interval() failed as excpected");
+		tst_res(TPASS | TTERRNO, "sched_rr_get_interval() failed as expected");
 	else
-		tst_res(TFAIL | TTERRNO, "sched_rr_get_interval() failed unexcpectedly: %s",
+		tst_res(TFAIL | TTERRNO, "sched_rr_get_interval() failed unexpectedly: %s",
 			tst_strerrno(tc->exp_errno));
 }
 
-- 
2.25.1

