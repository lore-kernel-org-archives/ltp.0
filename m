From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 22 May 2020 12:24:10 +0530
Subject: [LTP] [PATCH V2 4/6] syscalls: settimeofday: Use gettimeofday()
In-Reply-To: <cover.1590130423.git.viresh.kumar@linaro.org>
References: <cover.1590130423.git.viresh.kumar@linaro.org>
Message-ID: <40fd549b487a705afa1f50f833488c185011df1f.1590130423.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Passing struct timeval to __NR_gettimeofday syscall is incompatible and
may cause issues as it must only be used with the libc gettimeofday()
syscall. Use gettimeofday() instead of calling it with tst_syscall() to
fix that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/settimeofday/settimeofday01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/settimeofday/settimeofday01.c b/testcases/kernel/syscalls/settimeofday/settimeofday01.c
index 7ce3dc5a47b3..b7f84b00fdc8 100644
--- a/testcases/kernel/syscalls/settimeofday/settimeofday01.c
+++ b/testcases/kernel/syscalls/settimeofday/settimeofday01.c
@@ -21,7 +21,7 @@ static void verify_settimeofday(void)
 	suseconds_t delta;
 	struct timeval tv1, tv2;
 
-	if (tst_syscall(__NR_gettimeofday, &tv1, NULL) == -1)
+	if (gettimeofday(&tv1, NULL) == -1)
 		tst_brk(TBROK | TERRNO, "gettimeofday(&tv1, NULL) failed");
 
 	tv1.tv_sec += VAL_SEC;
@@ -35,7 +35,7 @@ static void verify_settimeofday(void)
 		return;
 	}
 
-	if (tst_syscall(__NR_gettimeofday, &tv2, NULL) == -1)
+	if (gettimeofday(&tv2, NULL) == -1)
 		tst_brk(TBROK | TERRNO, "gettimeofday(&tv2, NULL) failed");
 
 	if (tv2.tv_sec > tv1.tv_sec) {
-- 
2.25.0.rc1.19.g042ed3e048af

