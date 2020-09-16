From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 16 Sep 2020 16:08:01 +0530
Subject: [LTP] [PATCH V2 16/17] syscalls: utimensat: Reuse struct
 time64_variants
In-Reply-To: <cover.1600252542.git.viresh.kumar@linaro.org>
References: <cover.1600252542.git.viresh.kumar@linaro.org>
Message-ID: <a6291552ca99cc5014e98f685e82291bd9a1ecb5.1600252542.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Lets reuse the common structure here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../kernel/syscalls/utimensat/utimensat01.c    | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/utimensat/utimensat01.c b/testcases/kernel/syscalls/utimensat/utimensat01.c
index e2d4fee3e433..fe490f4415e6 100644
--- a/testcases/kernel/syscalls/utimensat/utimensat01.c
+++ b/testcases/kernel/syscalls/utimensat/utimensat01.c
@@ -18,6 +18,7 @@
 #include <sys/stat.h>
 #include "lapi/fs.h"
 #include "lapi/utime.h"
+#include "time64_variants.h"
 #include "tst_timer.h"
 
 #define TEST_FILE	"test_file"
@@ -109,18 +110,13 @@ static inline int sys_utimensat_time64(int dirfd, const char *pathname,
 	return tst_syscall(__NR_utimensat_time64, dirfd, pathname, times, flags);
 }
 
-static struct test_variants {
-	int (*utimensat)(int dirfd, const char *pathname, void *times,
-			 int flags);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
+static struct time64_variants variants[] = {
 #if (__NR_utimensat != __LTP__NR_INVALID_SYSCALL)
-	{ .utimensat = sys_utimensat, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .utimensat = sys_utimensat, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_utimensat_time64 != __LTP__NR_INVALID_SYSCALL)
-	{ .utimensat = sys_utimensat_time64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .utimensat = sys_utimensat_time64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
@@ -198,7 +194,7 @@ static void change_attr(struct test_case *tc, int fd, int set)
 
 static void reset_time(char *pathname, int dfd, int flags, int i)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	struct stat sb;
 
 	memset(&ts, 0, sizeof(ts));
@@ -215,7 +211,7 @@ static void reset_time(char *pathname, int dfd, int flags, int i)
 
 static void run(unsigned int i)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	struct test_case *tc = &tcase[i];
 	int dfd = AT_FDCWD, fd = 0, atime_change, mtime_change;
 	struct mytime *mytime = tc->mytime;
@@ -237,7 +233,7 @@ static void run(unsigned int i)
 	}
 
 	if (mytime) {
-		tst_multi_set_time(tv->type, mytime);
+		tst_multi_set_time(tv->ts_type, mytime);
 		tsp = &ts;
 	} else if (tc->exp_err == EFAULT) {
 		tsp = bad_addr;
-- 
2.25.0.rc1.19.g042ed3e048af

