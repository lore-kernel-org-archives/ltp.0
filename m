From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Mon, 12 Apr 2021 19:41:50 +0800
Subject: [LTP] [COMMITTED] syscalls/sched_rr_get_interval: Fix wrong TTERRNO
 usage
Message-ID: <1618227710-27541-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../syscalls/sched_rr_get_interval/sched_rr_get_interval01.c    | 2 +-
 .../syscalls/sched_rr_get_interval/sched_rr_get_interval02.c    | 2 +-
 .../syscalls/sched_rr_get_interval/sched_rr_get_interval03.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
index 9d9ddf32e..5da5fe51d 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
@@ -42,7 +42,7 @@ static void setup(void)
 	tp.type = tv->ts_type;
 
 	if ((sched_setscheduler(0, SCHED_RR, &p)) == -1)
-		tst_res(TFAIL | TTERRNO, "sched_setscheduler() failed");
+		tst_res(TFAIL | TERRNO, "sched_setscheduler() failed");
 
 	proc_flag = !access(PROC_SCHED_RR_TIMESLICE_MS, F_OK);
 }
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
index 0e98fec56..9a0b8673d 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
@@ -36,7 +36,7 @@ static void setup(void)
 	tp.type = tv->ts_type;
 
 	if ((sched_setscheduler(0, SCHED_FIFO, &p)) == -1)
-		tst_res(TFAIL | TTERRNO, "sched_setscheduler() failed");
+		tst_res(TFAIL | TERRNO, "sched_setscheduler() failed");
 }
 
 static void run(void)
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
index 6a64ca2c6..67ad17793 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
@@ -56,7 +56,7 @@ static void setup(void)
 	tp.type = tv->ts_type;
 
 	if ((sched_setscheduler(0, SCHED_RR, &p)) == -1)
-		tst_res(TFAIL | TTERRNO, "sched_setscheduler() failed");
+		tst_res(TFAIL | TERRNO, "sched_setscheduler() failed");
 
 	unused_pid = tst_get_unused_pid();
 }
-- 
2.23.0

