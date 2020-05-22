From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 22 May 2020 12:24:08 +0530
Subject: [LTP] [PATCH V2 2/6] syscalls: settimeofday01: Set
 .restore_wallclock flag
In-Reply-To: <cover.1590130423.git.viresh.kumar@linaro.org>
References: <cover.1590130423.git.viresh.kumar@linaro.org>
Message-ID: <76bfdd0c76e433c0ff6a75fd3e29666720d7542c.1590130423.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Set the .restore_wallclock flag and get rid of some code.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../syscalls/settimeofday/settimeofday01.c      | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/settimeofday/settimeofday01.c b/testcases/kernel/syscalls/settimeofday/settimeofday01.c
index 368fdebc0c8e..7ce3dc5a47b3 100644
--- a/testcases/kernel/syscalls/settimeofday/settimeofday01.c
+++ b/testcases/kernel/syscalls/settimeofday/settimeofday01.c
@@ -16,8 +16,6 @@
 #define ACCEPTABLE_DELTA 500
 #define USEC_PER_SEC    1000000L
 
-struct timeval tv_saved;
-
 static void verify_settimeofday(void)
 {
 	suseconds_t delta;
@@ -56,21 +54,8 @@ static void verify_settimeofday(void)
 		tst_res(TFAIL, "settimeofday() fail");
 }
 
-static void setup(void)
-{
-	if (tst_syscall(__NR_gettimeofday, &tv_saved, NULL) == -1)
-		tst_brk(TBROK | TERRNO, "gettimeofday(&tv_saved, NULL) failed");
-}
-
-static void cleanup(void)
-{
-	if ((settimeofday(&tv_saved, NULL)) == -1)
-		tst_brk(TBROK | TERRNO, "settimeofday(&tv_saved, NULL) failed");
-}
-
 static struct tst_test test = {
-	.setup = setup,
-	.cleanup = cleanup,
+	.restore_wallclock = 1,
 	.test_all = verify_settimeofday,
 	.needs_root = 1,
 };
-- 
2.25.0.rc1.19.g042ed3e048af

