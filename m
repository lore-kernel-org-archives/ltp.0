From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 22 May 2020 12:24:09 +0530
Subject: [LTP] [PATCH V2 3/6] syscalls: settimeofday02: Remove time
 restoration code
In-Reply-To: <cover.1590130423.git.viresh.kumar@linaro.org>
References: <cover.1590130423.git.viresh.kumar@linaro.org>
Message-ID: <d3926ba3a6976021828a7de4be0c12a536c34ef1.1590130423.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Unless the kernel is buggy, the system time shouldn't get updated by
this test and so there is no need to have the code to restore the clock.
Remove it.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../syscalls/settimeofday/settimeofday02.c    | 21 -------------------
 1 file changed, 21 deletions(-)

diff --git a/testcases/kernel/syscalls/settimeofday/settimeofday02.c b/testcases/kernel/syscalls/settimeofday/settimeofday02.c
index 485a26b1d9c5..0fa8a147a212 100644
--- a/testcases/kernel/syscalls/settimeofday/settimeofday02.c
+++ b/testcases/kernel/syscalls/settimeofday/settimeofday02.c
@@ -12,9 +12,6 @@
 #include "tst_test.h"
 #include "lapi/syscalls.h"
 
-struct timeval tv_saved;
-static int flag;
-
 static struct tcase {
 	struct timeval tv;
 	int exp_errno;
@@ -29,12 +26,10 @@ static void verify_settimeofday(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
-	flag = 0;
 	tst_res(TINFO, "%s", tc->message);
 	TEST(settimeofday(&tc->tv, NULL));
 	if (TST_RET != -1) {
 		tst_res(TFAIL, "settimeofday() succeeded unexpectedly");
-		flag = 1;
 		return;
 	}
 
@@ -44,23 +39,7 @@ static void verify_settimeofday(unsigned int n)
 		tst_res(TPASS | TTERRNO, "Received expected errno");
 }
 
-static void setup(void)
-{
-	if (tst_syscall(__NR_gettimeofday, &tv_saved, NULL) == -1)
-		tst_brk(TBROK | TERRNO, "gettimeofday(&tv_saved, NULL) failed");
-}
-
-static void cleanup(void)
-{
-	if (!flag)
-		return;
-	if ((settimeofday(&tv_saved, NULL)) == -1)
-		tst_brk(TBROK | TERRNO, "settimeofday(&tv_saved, NULL) failed");
-}
-
 static struct tst_test test = {
-	.setup = setup,
-	.cleanup = cleanup,
 	.test = verify_settimeofday,
 	.tcnt = ARRAY_SIZE(tcases),
 	.caps = (struct tst_cap []) {
-- 
2.25.0.rc1.19.g042ed3e048af

