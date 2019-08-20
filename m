From: Xiao Yang <ice_yangxiao@163.com>
Date: Tue, 20 Aug 2019 20:20:17 +0800
Subject: [LTP] [PATCH 2/2] syscalls/ioprio_set01.c: Improve process for
 priority overflow
In-Reply-To: <20190820122017.26015-1-ice_yangxiao@163.com>
References: <20190820122017.26015-1-ice_yangxiao@163.com>
Message-ID: <20190820122017.26015-2-ice_yangxiao@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) If original priority is 0, We should report TCONF for priority overflow
   in second subtest.
   e.g. running ionice -n 0 ./ioprio_set01:
   ----------------------------------------------------------
   ...
   ioprio_set01.c:65: INFO: ioprio_get returned class BEST-EFFORT prio 0
   ioprio.h:89: PASS: ioprio_set new class BEST-EFFORT, new prio 1
   ioprio_set01.c:43: CONF: ioprio decrease out of range (-1)
   ...
   ----------------------------------------------------------

2) If original priority is 7, we should report TCONF for priority overflow
   in first subtest and continue to run second subtest.
   e.g. running ionice -n 7 ./ioprio_set01:
   ----------------------------------------------------------
   ...
   ioprio_set01.c:65: INFO: ioprio_get returned class BEST-EFFORT prio 7
   ioprio_set01.c:28: CONF: ioprio increase out of range (8)
   ioprio.h:89: PASS: ioprio_set new class BEST-EFFORT, new prio 6
   ...
   ---------------------------------------------------------

Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
---
 testcases/kernel/syscalls/ioprio/ioprio_set01.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/ioprio/ioprio_set01.c b/testcases/kernel/syscalls/ioprio/ioprio_set01.c
index 5b89ac81e..19953ba36 100644
--- a/testcases/kernel/syscalls/ioprio/ioprio_set01.c
+++ b/testcases/kernel/syscalls/ioprio/ioprio_set01.c
@@ -23,11 +23,11 @@ static void run(void)
 
 	/* Bump prio to what it was + 1 */
 	class = IOPRIO_CLASS_BE;
-	if (!prio_in_range(prio + 1)) {
-		tst_res(TFAIL, "ioprio increase out of range (%d)", prio + 1);
-		return;
+	prio = prio + 1;
+	if (!prio_in_range(prio)) {
+		tst_res(TCONF, "ioprio increase out of range (%d)", prio);
+		goto second;
 	}
-	prio = (prio + 1);
 
 	TEST(sys_ioprio_set(IOPRIO_WHO_PROCESS, 0,
 			    IOPRIO_PRIO_VALUE(class, prio)));
@@ -36,12 +36,14 @@ static void run(void)
 	else
 		ioprio_check_setting(class, prio, 1);
 
+second:
 	/* Bump prio down two notches */
-	if (!prio_in_range(prio - 2)) {
-		tst_res(TFAIL, "ioprio decrease out of range (%d)", prio - 2);
+	prio = prio - 2;
+	if (!prio_in_range(prio)) {
+		tst_res(TCONF, "ioprio decrease out of range (%d)", prio);
 		return;
 	}
-	prio = (prio - 2);
+
 	TEST(sys_ioprio_set(IOPRIO_WHO_PROCESS, 0,
 			    IOPRIO_PRIO_VALUE(class, prio)));
 	if (TST_RET == -1)
-- 
2.21.0


