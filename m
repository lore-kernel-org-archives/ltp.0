From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 21 Jan 2020 13:47:58 +0800
Subject: [LTP] [PATCH] syscalls/timer*: use linux git tags for timer
 testcases
Message-ID: <1579585678-2209-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I test these three cases(timer_delete01.c, timer_settime01.c, timer_settime02.c)
on arm machines, they will get unknown 524 error like timer_create01.c.
They are also regresstion test, so add linux tags about this error.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/timer_delete/timer_delete01.c   | 7 +++++++
 testcases/kernel/syscalls/timer_settime/timer_settime01.c | 7 +++++++
 testcases/kernel/syscalls/timer_settime/timer_settime02.c | 7 +++++++
 3 files changed, 21 insertions(+)

diff --git a/testcases/kernel/syscalls/timer_delete/timer_delete01.c b/testcases/kernel/syscalls/timer_delete/timer_delete01.c
index 962eb5670..6e5fc9940 100644
--- a/testcases/kernel/syscalls/timer_delete/timer_delete01.c
+++ b/testcases/kernel/syscalls/timer_delete/timer_delete01.c
@@ -12,6 +12,9 @@
  *
  *	Creates a timer for each available clock and then tries
  *	to delete them again.
+ *
+ * This is also regression test for commit:
+ * f18ddc13af98 ("alarmtimer: Use EOPNOTSUPP instead of ENOTSUPP")
  */
 
 #include <errno.h>
@@ -60,4 +63,8 @@ static void run(void)
 static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "f18ddc13af98"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime01.c b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
index 7bf00f527..da365d221 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime01.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
@@ -16,6 +16,9 @@
  * 4) Using absolute time
  *
  * All of these tests are supposed to be successful.
+ *
+ * This is also regression test for commit:
+ * f18ddc13af98 ("alarmtimer: Use EOPNOTSUPP instead of ENOTSUPP")
  */
 
 #include <stdlib.h>
@@ -121,4 +124,8 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "f18ddc13af98"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime02.c b/testcases/kernel/syscalls/timer_settime/timer_settime02.c
index 74cb33d73..bcabb7695 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime02.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime02.c
@@ -18,6 +18,9 @@
  * 4) Passing an invalid timer -> EINVAL
  * 5) Passing an invalid address for new_value -> EFAULT
  * 6) Passing an invalid address for old_value -> EFAULT
+ *
+ * This is also regression test for commit:
+ * f18ddc13af98 ("alarmtimer: Use EOPNOTSUPP instead of ENOTSUPP")
  */
 
 #include <errno.h>
@@ -116,4 +119,8 @@ static struct tst_test test = {
 	.test = run,
 	.needs_root = 1,
 	.tcnt = ARRAY_SIZE(tcases),
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "f18ddc13af98"},
+		{}
+	}
 };
-- 
2.18.0



