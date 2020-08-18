From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Aug 2020 14:10:59 +0800
Subject: [LTP] [PATCH] clock_settime03: accept ENOTSUP if
 CLOCK_REALTIME_ALARM unsupported
Message-ID: <20200818061059.14680-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

CLOCK_REALTIME_ALARM requires an RTC with alarm support, which may not be
present on a system. In that case, the kernel will return EOPNOTSUPP, which
is defined as ENOTSUP in userspace.

As CLOCK_REALTIME_ALARM is already possibly unsupported, accept that as an
error besides the EINVAL code.

For issue #712:
  https://github.com/linux-test-project/ltp/issues/712

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Viresh Kumar<viresh.kumar@linaro.org>
Cc: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/clock_settime/clock_settime03.c    | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime03.c b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
index 5b75afbe7..250d6bcc7 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime03.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
@@ -10,6 +10,7 @@
 #include "config.h"
 #include "tst_timer.h"
 #include "tst_safe_clocks.h"
+#include "lapi/common_timers.h"
 
 #define TIMER_DELTA	3
 #define ALLOWED_DELTA	(50 * 1000) /* 50 ms */
@@ -66,8 +67,13 @@ static void run(void)
 	SAFE_SIGPROCMASK(SIG_BLOCK, &set, NULL);
 
 	TEST(tst_syscall(__NR_timer_create, CLOCK_REALTIME_ALARM, &ev, &timer));
-	if (TST_RET != 0)
-		tst_brk(TBROK | TERRNO, "timer_create() failed");
+	if (TST_RET != 0) {
+		if (possibly_unsupported(CLOCK_REALTIME_ALARM) &&
+				(TST_ERR == EINVAL || TST_ERR == ENOTSUP))
+			tst_brk(TCONF | TTERRNO, "CLOCK_REALTIME_ALARM unsupported");
+		else
+			tst_brk(TBROK | TTERRNO, "timer_create() failed");
+	}
 
 	tst_ts_set_sec(&start, time);
 	tst_ts_set_nsec(&start, 0);
-- 
2.21.1

