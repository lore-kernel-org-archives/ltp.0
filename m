From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 31 Jul 2020 18:09:44 +0800
Subject: [LTP] [PATCH] syscalls/timer_settime01: Add linux git tag
Message-ID: <1596190184-15381-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When running this case on old kernel like 3.10.0-1136.el7.x86_64,
it will fail as below when testing CLOCK_BOOTTIME_ALARM/CLOCK_REALTIME_ALARM
clockid

timer_settime01.c:174: PASS: timer_settime(CLOCK_BOOTTIME) passed
timer_settime01.c:164: FAIL: timer_gettime(CLOCK_BOOTTIME_ALARM) reported
bad values (0: 678013000): SUCCESS (0)
timer_settime01.c:174: PASS: timer_settime(CLOCK_BOOTTIME_ALARM) passed
timer_settime01.c:164: FAIL: timer_gettime(CLOCK_REALTIME_ALARM) reported
bad values (0: 358240000): SUCCESS (0)
timer_settime01.c:174: PASS: timer_settime(CLOCK_REALTIME_ALARM) passed
timer_settime01.c:174: PASS: timer_settime(CLOCK_TAI) passed

It fails because old kernel without this kernel patch returns the wrong remaining time(
the time at which it is scheduled to expire). If the timer has already expired
or it is not currently scheduled, the it_value's members should be set to zero.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/timer_settime/timer_settime01.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime01.c b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
index 48b37d8e7..74423f343 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime01.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
@@ -19,6 +19,7 @@
  *
  * This is also regression test for commit:
  * f18ddc13af98 ("alarmtimer: Use EOPNOTSUPP instead of ENOTSUPP")
+ * d78c9300c51d ("alarmtimer: Return relative times in timer_gettime")
  */
 
 #include <stdlib.h>
@@ -187,6 +188,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "f18ddc13af98"},
+		{"linux-git", "d78c9300c51d"},
 		{}
 	}
 };
-- 
2.23.0



