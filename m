From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue,  8 Sep 2020 11:49:21 +0530
Subject: [LTP] [PATCH 08/16] syscalls: ppoll: Reuse struct time64_variants
In-Reply-To: <cover.1599545766.git.viresh.kumar@linaro.org>
References: <cover.1599545766.git.viresh.kumar@linaro.org>
Message-ID: <3d6e0cd2eca89015ccf0e9f582537f7c8b8fcb97.1599545766.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Lets reuse the common structure here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/ppoll/ppoll01.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
index e9e57e5858e6..3d2f92f2ac1d 100644
--- a/testcases/kernel/syscalls/ppoll/ppoll01.c
+++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
@@ -19,6 +19,7 @@
 #include <sys/wait.h>
 #include "lapi/syscalls.h"
 #include "ltp_signal.h"
+#include "time64_variants.h"
 #include "tst_sig_proc.h"
 #include "tst_test.h"
 #include "tst_timer.h"
@@ -174,21 +175,15 @@ static inline int sys_ppoll_time64(struct pollfd *fds, nfds_t nfds, void *tmo_p,
 			   sigsetsize);
 }
 
-static struct test_variants {
-	int (*ppoll)(struct pollfd *fds, nfds_t nfds, void *tmo_p,
-		     const sigset_t *sigmask, size_t sigsetsize);
-
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
-	{ .ppoll = libc_ppoll, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
+static struct time64_variants variants[] = {
+	{ .ppoll = libc_ppoll, .ts_type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
 
 #if (__NR_ppoll != __LTP__NR_INVALID_SYSCALL)
-	{ .ppoll = sys_ppoll, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .ppoll = sys_ppoll, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_ppoll_time64 != __LTP__NR_INVALID_SYSCALL)
-	{ .ppoll = sys_ppoll_time64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .ppoll = sys_ppoll_time64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
@@ -198,7 +193,7 @@ static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	int fd2;
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
@@ -222,7 +217,7 @@ static void setup(void)
 	fds_already_closed[0].revents = 0;
 	SAFE_CLOSE(fd2);
 
-	ts_short.type = ts_long.type = tv->type;
+	ts_short.type = ts_long.type = tv->ts_type;
 	tst_ts_set_sec(&ts_short, 0);
 	tst_ts_set_nsec(&ts_short, 20000000);
 	tst_ts_set_sec(&ts_long, 2);
@@ -237,7 +232,7 @@ static void cleanup(void)
 
 static void do_test(unsigned int i)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	pid_t pid = 0;
 	int sys_ret, sys_errno = 0, dummy;
 	struct test_case *tc = &tcase[i];
-- 
2.25.0.rc1.19.g042ed3e048af

