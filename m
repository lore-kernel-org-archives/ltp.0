From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Mon,  7 Jun 2021 16:15:14 +0530
Subject: [LTP] [PATCH 6/7] sched_rr_get_interval03: Skipped EFAULT tests for
 libc variant.
In-Reply-To: <20210607104515.29838-1-vinay.m.engg@gmail.com>
References: <20210607104515.29838-1-vinay.m.engg@gmail.com>
Message-ID: <20210607104515.29838-6-vinay.m.engg@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Tested EFAULT cases only for "__NR_sched_rr_get_interval" and "__NR_sched_rr_get_interval_time64"

Signed-off-by: Vinay Kumar <vinay.m.engg@gmail.com>
---
 .../sched_rr_get_interval/sched_rr_get_interval03.c         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
index 0c9887f36..cee9245e6 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
@@ -67,6 +67,12 @@ static void run(unsigned int i)
 	struct test_cases_t *tc = &test_cases[i];
 	struct timerspec *ts;
 
+	if (tc->exp_errno == EFAULT
+		&& tv->sched_rr_get_interval == libc_sched_rr_get_interval) {
+		tst_res(TCONF, "EFAULT skipped for libc_variant");
+		return;
+	}
+
 	if (tc->exp_errno == EFAULT)
 		ts = bad_addr;
 	else
-- 
2.17.1

