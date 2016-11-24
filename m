From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 24 Nov 2016 16:19:09 +0800
Subject: [LTP] [PATCH] syscalls/getpriority01: Check the returned prio
	values in a range.
Message-ID: <1479975549-17428-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Verify that the priority values returned by getpriority(2) are
in the range of [0, 0], [0, 0] and [-20, 0] by default for the
flags PRIO_PROCESS, PRIO_PGRP and PRIO_USER respectively.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 .../kernel/syscalls/getpriority/getpriority01.c    | 25 ++++++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/getpriority/getpriority01.c b/testcases/kernel/syscalls/getpriority/getpriority01.c
index cca88a7..6edf39d 100644
--- a/testcases/kernel/syscalls/getpriority/getpriority01.c
+++ b/testcases/kernel/syscalls/getpriority/getpriority01.c
@@ -19,7 +19,9 @@
 
 /*
  * Verify that getpriority(2) succeeds get the scheduling priority of
- * the current process, process group or user.
+ * the current process, process group or user, and the priority values
+ * are in the ranges of [0, 0], [0, 0] and [-20, 0] by default for the
+ * flags PRIO_PROCESS, PRIO_PGRP and PRIO_USER respectively.
  */
 
 #include <errno.h>
@@ -29,10 +31,12 @@
 
 static struct tcase {
 	int which;
+	int min;
+	int max;
 } tcases[] = {
-	{PRIO_PROCESS},
-	{PRIO_PGRP},
-	{PRIO_USER}
+	{PRIO_PROCESS, 0, 0},
+	{PRIO_PGRP, 0, 0},
+	{PRIO_USER, -20, 0}
 };
 
 static void verify_getpriority(unsigned int n)
@@ -41,9 +45,16 @@ static void verify_getpriority(unsigned int n)
 
 	TEST(getpriority(tc->which, 0));
 
-	if (TEST_RETURN != 0 || TEST_ERRNO != 0) {
-		tst_res(TFAIL | TTERRNO, "getpriority(%d, 0) returned %ld",
-			tc->which, TEST_RETURN);
+	if (TEST_ERRNO != 0) {
+		tst_res(TFAIL | TTERRNO, "getpriority(%d, 0) failed",
+			tc->which);
+		return;
+	}
+
+	if (TEST_RETURN < tc->min || TEST_RETURN > tc->max) {
+		tst_res(TFAIL, "getpriority(%d, 0) returned %ld, "
+			"expected in the range of [%d, %d]",
+			tc->which, TEST_RETURN, tc->min, tc->max);
 		return;
 	}
 
-- 
1.8.4.2



