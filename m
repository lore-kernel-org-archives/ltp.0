From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 3 Aug 2020 11:21:54 +0800
Subject: [LTP] [PATCH] syscalls/timer_settime01: Use correct linux git tag
Message-ID: <1596424914-3762-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The last patch used the parent commit id instead of correct fix commit
id.

Sorry for the obvious mistake.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/timer_settime/timer_settime01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime01.c b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
index 74423f343..415c6290f 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime01.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
@@ -19,7 +19,7 @@
  *
  * This is also regression test for commit:
  * f18ddc13af98 ("alarmtimer: Use EOPNOTSUPP instead of ENOTSUPP")
- * d78c9300c51d ("alarmtimer: Return relative times in timer_gettime")
+ * e86fea764991 ("alarmtimer: Return relative times in timer_gettime")
  */
 
 #include <stdlib.h>
@@ -188,7 +188,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "f18ddc13af98"},
-		{"linux-git", "d78c9300c51d"},
+		{"linux-git", "e86fea764991"},
 		{}
 	}
 };
-- 
2.23.0



