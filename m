From: Xiao Yang <ice_yangxiao@163.com>
Date: Tue, 20 Aug 2019 20:20:16 +0800
Subject: [LTP] [PATCH 1/2] syscalls/ioprio_set01.c: Stop decreasing priority
 continuously in loops
Message-ID: <20190820122017.26015-1-ice_yangxiao@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Running ioprio_set01 -i 5 gets the following error:
-------------------------------------------------
...
ioprio_set01.c:29: INFO: ioprio_get returned class BEST-EFFORT prio 1
ioprio.h:89: PASS: ioprio_set new class BEST-EFFORT, new prio 2
ioprio.h:89: PASS: ioprio_set new class BEST-EFFORT, new prio 0
ioprio_set01.c:29: INFO: ioprio_get returned class BEST-EFFORT prio 0
ioprio.h:89: PASS: ioprio_set new class BEST-EFFORT, new prio 1
ioprio_set01.c:49: FAIL: ioprio increase out of range (-1)
...
-------------------------------------------------

The I/O scheduling priority of process is decreased by 1 continuously
in loops so that it is out of range(i.e. 0~7) finally.  We fix the
issue by setting priority to original value before running test.

Also fix a typo because second subtest actually decreases priority.

Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
---
 .../kernel/syscalls/ioprio/ioprio_set01.c     | 33 +++++++++++--------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/ioprio/ioprio_set01.c b/testcases/kernel/syscalls/ioprio/ioprio_set01.c
index 24bf8a9ca..5b89ac81e 100644
--- a/testcases/kernel/syscalls/ioprio/ioprio_set01.c
+++ b/testcases/kernel/syscalls/ioprio/ioprio_set01.c
@@ -14,20 +14,12 @@
 #include "lapi/syscalls.h"
 #include "ioprio.h"
 
+static int orig_class;
+static int orig_prio;
+
 static void run(void)
 {
-	int class, prio;
-
-	/* Get the I/O priority for the current process */
-	TEST(sys_ioprio_get(IOPRIO_WHO_PROCESS, 0));
-
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "ioprio_get failed");
-
-	class = IOPRIO_PRIO_CLASS(TST_RET);
-	prio = IOPRIO_PRIO_LEVEL(TST_RET);
-	tst_res(TINFO, "ioprio_get returned class %s prio %d",
-		to_class_str[class], prio);
+	int class = orig_class, prio = orig_prio;
 
 	/* Bump prio to what it was + 1 */
 	class = IOPRIO_CLASS_BE;
@@ -46,7 +38,7 @@ static void run(void)
 
 	/* Bump prio down two notches */
 	if (!prio_in_range(prio - 2)) {
-		tst_res(TFAIL, "ioprio increase out of range (%d)", prio - 2);
+		tst_res(TFAIL, "ioprio decrease out of range (%d)", prio - 2);
 		return;
 	}
 	prio = (prio - 2);
@@ -58,6 +50,21 @@ static void run(void)
 		ioprio_check_setting(class, prio, 1);
 }
 
+static void setup(void)
+{
+	/* Get the I/O priority for the current process */
+	TEST(sys_ioprio_get(IOPRIO_WHO_PROCESS, 0));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "ioprio_get failed");
+
+	orig_class = IOPRIO_PRIO_CLASS(TST_RET);
+	orig_prio = IOPRIO_PRIO_LEVEL(TST_RET);
+
+	tst_res(TINFO, "ioprio_get returned class %s prio %d",
+		to_class_str[orig_class], orig_prio);
+}
+
 static struct tst_test test = {
+	.setup = setup,
 	.test_all = run,
 };
-- 
2.21.0


