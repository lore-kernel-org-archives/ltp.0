From: Jan Stancek <jstancek@redhat.com>
Date: Mon,  8 Jun 2020 16:45:00 +0200
Subject: [LTP] [PATCH COMMITTED] syscalls/sched_rr_get_interval: add missing
 TERRNO
Message-ID: <94e6163082055700db700c33ed0eab537420fdaf.1591627489.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../syscalls/sched_rr_get_interval/sched_rr_get_interval01.c    | 2 +-
 .../syscalls/sched_rr_get_interval/sched_rr_get_interval02.c    | 2 +-
 .../syscalls/sched_rr_get_interval/sched_rr_get_interval03.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
index b6084f673ca7..6ebf873de798 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
@@ -128,7 +128,7 @@ void setup(void)
 
 	/* Change scheduling policy to SCHED_RR */
 	if ((sched_setscheduler(0, SCHED_RR, &p)) == -1) {
-		tst_brkm(TBROK, cleanup, "sched_setscheduler() failed");
+		tst_brkm(TBROK|TERRNO, cleanup, "sched_setscheduler() failed");
 	}
 }
 
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
index 6bf743f78c5e..367d9e3ff486 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
@@ -132,7 +132,7 @@ void setup(void)
 
 	/* Change scheduling policy to SCHED_FIFO */
 	if ((sched_setscheduler(0, SCHED_FIFO, &p)) == -1) {
-		tst_brkm(TBROK, cleanup, "sched_setscheduler() failed");
+		tst_brkm(TBROK|TERRNO, cleanup, "sched_setscheduler() failed");
 	}
 }
 
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
index 56f2fcf28269..40b636b4dc65 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
@@ -155,7 +155,7 @@ void setup(void)
 
 	/* Change scheduling policy to SCHED_RR */
 	if ((sched_setscheduler(0, SCHED_RR, &p)) == -1) {
-		tst_brkm(TBROK, cleanup, "sched_setscheduler() failed");
+		tst_brkm(TBROK|TERRNO, cleanup, "sched_setscheduler() failed");
 	}
 
 	unused_pid = tst_get_unused_pid(cleanup);
-- 
2.18.1

