From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 17 Nov 2016 14:02:50 +0800
Subject: [LTP] [PATCH] syscalls/getpriority01: exclude default priority
	check for PRIO_USER.
Message-ID: <1479362570-12526-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The current user priority is various when testing,
we should not check it as default value.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/getpriority/getpriority01.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/getpriority/getpriority01.c b/testcases/kernel/syscalls/getpriority/getpriority01.c
index cca88a7..9a9a364 100644
--- a/testcases/kernel/syscalls/getpriority/getpriority01.c
+++ b/testcases/kernel/syscalls/getpriority/getpriority01.c
@@ -19,7 +19,8 @@
 
 /*
  * Verify that getpriority(2) succeeds get the scheduling priority of
- * the current process, process group or user.
+ * the current process, process group or user, the default priority
+ * of process and process group is 0.
  */
 
 #include <errno.h>
@@ -29,10 +30,11 @@
 
 static struct tcase {
 	int which;
+	int defprio_strict;
 } tcases[] = {
-	{PRIO_PROCESS},
-	{PRIO_PGRP},
-	{PRIO_USER}
+	{PRIO_PROCESS, 1},
+	{PRIO_PGRP, 1},
+	{PRIO_USER, 0}
 };
 
 static void verify_getpriority(unsigned int n)
@@ -41,7 +43,7 @@ static void verify_getpriority(unsigned int n)
 
 	TEST(getpriority(tc->which, 0));
 
-	if (TEST_RETURN != 0 || TEST_ERRNO != 0) {
+	if ((tc->defprio_strict && TEST_RETURN != 0) || TEST_ERRNO != 0) {
 		tst_res(TFAIL | TTERRNO, "getpriority(%d, 0) returned %ld",
 			tc->which, TEST_RETURN);
 		return;
-- 
1.8.4.2



