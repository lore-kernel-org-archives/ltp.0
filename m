From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Thu, 25 Feb 2021 16:58:05 +0800
Subject: [LTP] [PATCH] syscalss/timer_settime03.c: Add kconfig requirement
 info in file header.
Message-ID: <20210225085805.5146-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test will fail when CONFIG_HIGH_RES_TIMERS is not set to y, because the return value of
timer_getoverrun is equal to expiry_time_values/interval. When CONFIG_HIGH_RES_TIMERS is set to y,
interval is equal to 1.
When CONFIG_HIGH_RES_TIMERS is not set to y, interval is equal to HZ*1000000, and the
return value of timer_getoverrun will not be greater than or equal to {DELAYTIMER_MAX} in this
testcase. See https://nvd.nist.gov/vuln/detail/CVE-2018-12896.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/timer_settime/timer_settime03.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime03.c b/testcases/kernel/syscalls/timer_settime/timer_settime03.c
index 4cc1f8bd8..fbc3587e4 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime03.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime03.c
@@ -19,6 +19,8 @@
  *  Date:   Tue Jun 26 15:21:32 2018 +0200
  *
  *  posix-timers: Sanitize overrun handling
+ *
+ *  Kconfig requirement: CONFIG_HIGH_RES_TIMERS
  */

 #include <unistd.h>
--
2.17.1

