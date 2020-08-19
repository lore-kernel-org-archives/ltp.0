From: Li Wang <liwang@redhat.com>
Date: Wed, 19 Aug 2020 08:38:43 +0000
Subject: [LTP] [PATCH v2] clock_settime03: change to use CLOCK_REALTIME
Message-ID: <20200819083843.26435-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

CLOCK_REALTIME_ALARM requires an RTC with alarm support, which may not be
present on a system. In that case, the kernel will return EOPNOTSUPP, which
is defined as ENOTSUP in userspace.

Here use CLOCK_REALTIME instead of the CLOCK_REALTIME_ALARM because we do
NOT need suspend the SUT during test.

For issue #712:
  https://github.com/linux-test-project/ltp/issues/712

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Viresh Kumar<viresh.kumar@linaro.org>
Cc: Cyril Hrubis <chrubis@suse.cz>
Cc: Jan Stancek <jstancek@redhat.com>
Tested-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/clock_settime/clock_settime03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime03.c b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
index 5b75afbe7..ad6183e4c 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime03.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
@@ -65,7 +65,7 @@ static void run(void)
 	SAFE_SIGADDSET(&set, SIGABRT);
 	SAFE_SIGPROCMASK(SIG_BLOCK, &set, NULL);
 
-	TEST(tst_syscall(__NR_timer_create, CLOCK_REALTIME_ALARM, &ev, &timer));
+	TEST(tst_syscall(__NR_timer_create, CLOCK_REALTIME, &ev, &timer));
 	if (TST_RET != 0)
 		tst_brk(TBROK | TERRNO, "timer_create() failed");
 
-- 
2.21.1

