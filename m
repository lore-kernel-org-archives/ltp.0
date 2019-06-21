From: Ping Fang <pifang@redhat.com>
Date: Fri, 21 Jun 2019 17:51:34 +0800
Subject: [LTP] [PATCH] syscalls/clock_adjtime: Fix unsupported WARN
Message-ID: <20190621095134.12604-1-pifang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When clock_adjtime is not implemented, cleanup will
still try this call, then enter tst_cvres WARN handler.

tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
../../../../include/tst_safe_clocks.h:57: CONF: syscall(-1)
__NR_clock_adjtime not supported
../../../../include/tst_safe_clocks.h:57: CONF: syscall(-1)
__NR_clock_adjtime not supported
../../../../include/tst_safe_clocks.h:60: WARN: clock_adjtime02.c:211
clock_adjtime() failed -1: ENOSYS

Summary:
passed   0
failed   0
skipped  1
warnings 1

Signed-off-by: Ping Fang <pifang@redhat.com>
---
 testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c | 4 ++++
 testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
index 6eac1f25c..2c42189e0 100644
--- a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
+++ b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
@@ -58,6 +58,7 @@
 
 static long hz;
 static struct timex saved, ttxc;
+static int support = 0;
 
 struct test_case {
 	unsigned int modes;
@@ -168,6 +169,7 @@ static void setup(void)
 	int rval;
 
 	rval = SAFE_CLOCK_ADJTIME(CLOCK_REALTIME, &saved);
+	support = 1;
 
 	if (rval != TIME_OK && rval != TIME_ERROR) {
 		timex_show("SAVE_STATUS", saved);
@@ -197,6 +199,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
+	if (support == 0)
+		return;
 	saved.modes = ADJ_ALL;
 
 	/* restore clock resolution based on original status flag */
diff --git a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
index 1ce936f96..0224089e1 100644
--- a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
+++ b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
@@ -59,6 +59,7 @@
 
 static long hz;
 static struct timex saved, ttxc;
+static int support = 0;
 
 static void cleanup(void);
 
@@ -176,6 +177,7 @@ static void setup(void)
 	int rval;
 
 	rval = SAFE_CLOCK_ADJTIME(CLOCK_REALTIME, &saved);
+	support = 1;
 
 	if (rval != TIME_OK && rval != TIME_ERROR) {
 		timex_show("SAVE_STATUS", saved);
@@ -197,6 +199,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
+	if (support == 0)
+		return;
 	saved.modes = ADJ_ALL;
 
 	/* restore clock resolution based on original status flag */
-- 
2.20.1

