From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Thu, 25 Feb 2021 19:37:22 +0800
Subject: [LTP] [PATCH v2] syscalls/timer_settime03.c: Add kconfig
 requirement of CONFIG_HIGH_RES_TIMERS=y
Message-ID: <20210225113722.29953-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test will fail when CONFIG_HIGH_RES_TIMERS is not set to y, because the return
value of timer_getoverrun is equal to expiry_time_values/interval. When
CONFIG_HIGH_RES_TIMERS is set to y, interval is equal to 1 nsec.When
CONFIG_HIGH_RES_TIMERS is not set to y, interval is equal to HZ*1000000 nsec,
and the return value of timer_getoverrun will not be greater than or equal to
{DELAYTIMER_MAX} in this testcase.
See https://nvd.nist.gov/vuln/detail/CVE-2018-12896.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
v2->v1: Add needs_kconfigs replace comment info.
 testcases/kernel/syscalls/timer_settime/timer_settime03.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime03.c b/testcases/kernel/syscalls/timer_settime/timer_settime03.c
index 4cc1f8bd8..4597bf74e 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime03.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime03.c
@@ -115,6 +115,10 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_HIGH_RES_TIMERS=y",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "78c9c4dfbf8c"},
 		{"CVE", "2018-12896"},
--
2.17.1

