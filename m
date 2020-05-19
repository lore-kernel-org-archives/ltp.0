From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 19 May 2020 14:21:09 +0530
Subject: [LTP] [PATCH 2/5] syscalls: settimeofday: Use gettimeofday()
In-Reply-To: <cover.1589877853.git.viresh.kumar@linaro.org>
References: <cover.1589877853.git.viresh.kumar@linaro.org>
Message-ID: <931bddab3d92f73f07f32dd7e1770078fdc07e0e.1589877853.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use gettimeofday() instead of calling it with tst_syscall().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/settimeofday/settimeofday01.c | 6 +++---
 testcases/kernel/syscalls/settimeofday/settimeofday02.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/settimeofday/settimeofday01.c b/testcases/kernel/syscalls/settimeofday/settimeofday01.c
index 368fdebc0c8e..c599a820fc97 100644
--- a/testcases/kernel/syscalls/settimeofday/settimeofday01.c
+++ b/testcases/kernel/syscalls/settimeofday/settimeofday01.c
@@ -23,7 +23,7 @@ static void verify_settimeofday(void)
 	suseconds_t delta;
 	struct timeval tv1, tv2;
 
-	if (tst_syscall(__NR_gettimeofday, &tv1, NULL) == -1)
+	if (gettimeofday(&tv1, NULL) == -1)
 		tst_brk(TBROK | TERRNO, "gettimeofday(&tv1, NULL) failed");
 
 	tv1.tv_sec += VAL_SEC;
@@ -37,7 +37,7 @@ static void verify_settimeofday(void)
 		return;
 	}
 
-	if (tst_syscall(__NR_gettimeofday, &tv2, NULL) == -1)
+	if (gettimeofday(&tv2, NULL) == -1)
 		tst_brk(TBROK | TERRNO, "gettimeofday(&tv2, NULL) failed");
 
 	if (tv2.tv_sec > tv1.tv_sec) {
@@ -58,7 +58,7 @@ static void verify_settimeofday(void)
 
 static void setup(void)
 {
-	if (tst_syscall(__NR_gettimeofday, &tv_saved, NULL) == -1)
+	if (gettimeofday(&tv_saved, NULL) == -1)
 		tst_brk(TBROK | TERRNO, "gettimeofday(&tv_saved, NULL) failed");
 }
 
diff --git a/testcases/kernel/syscalls/settimeofday/settimeofday02.c b/testcases/kernel/syscalls/settimeofday/settimeofday02.c
index 485a26b1d9c5..0d6862eb33b1 100644
--- a/testcases/kernel/syscalls/settimeofday/settimeofday02.c
+++ b/testcases/kernel/syscalls/settimeofday/settimeofday02.c
@@ -46,7 +46,7 @@ static void verify_settimeofday(unsigned int n)
 
 static void setup(void)
 {
-	if (tst_syscall(__NR_gettimeofday, &tv_saved, NULL) == -1)
+	if (gettimeofday(&tv_saved, NULL) == -1)
 		tst_brk(TBROK | TERRNO, "gettimeofday(&tv_saved, NULL) failed");
 }
 
-- 
2.25.0.rc1.19.g042ed3e048af

